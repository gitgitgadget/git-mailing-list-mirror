From: David Barr <davidbarr@google.com>
Subject: Re: [RFC/PATCH 1/3] protobuf: minimal implementation for compact
 in-memory structures
Date: Fri, 24 Jun 2011 07:39:42 -0700
Message-ID: <BANLkTimov2ZFYZjU4=CXPE8yjH8cMs3HCg@mail.gmail.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
	<1308728011-14136-2-git-send-email-davidbarr@google.com>
	<7voc1p64ap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 16:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa7Y5-0006ea-S5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 16:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451Ab1FXOjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 10:39:51 -0400
Received: from smtp-out.google.com ([216.239.44.51]:8957 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759387Ab1FXOjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 10:39:46 -0400
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p5OEdjb0009681
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:39:45 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308926385; bh=uVHnpmG+O/sGdg+lLqnE4fPB3Eg=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=ulQVsomMq8clp2DKBRqRFh3yRYtnno+lb77oEDHidHW97Ao4SgJ5v8M7BA7WbfdQh
	 F5m0zlMdE73RBLoCW6iXA==
Received: from yxp4 (yxp4.prod.google.com [10.190.4.196])
	by kpbe16.cbf.corp.google.com with ESMTP id p5OEdiJt017994
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:39:44 -0700
Received: by yxp4 with SMTP id 4so821019yxp.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aw6cGgzn7YKPhrr5bH3sLOfca8EpFuoFHZ1UNAFbaMw=;
        b=MF49oXAH0tcQ+zj2VNoomoaXh3syViFavUZfaPeMcXqj+3l5mvvkrjt39WcIHU62Gw
         BAjR60AVcrD9syqDYPnA==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bjT/F1ASWmHlpwvvzQCfC+eJEy81FOskQL/G1lBYBmsDUuSYWXXkmeEpQlGEk4+ED0
         nQZXrQicbBdOgfRlXxVg==
Received: by 10.100.252.3 with SMTP id z3mr61201anh.69.1308926382375; Fri, 24
 Jun 2011 07:39:42 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Fri, 24 Jun 2011 07:39:42 -0700 (PDT)
In-Reply-To: <7voc1p64ap.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176307>

Junio,

Sorry for the repeat, accidentally sent as HTML, rejected by the list.

On Thursday, June 23, 2011, Junio C Hamano wrote:
David Barr <davidbarr@google.com> writes:

> One struct to capture all types, just 4 methods: decode_message,
> encode_message, sizeof_message, hash_field.

Adding to the review from yesterday, hash_field() looked quite out of
place. If you are going to implement a hash table that holds protobuf
objects in a separate file/module, I would imagine the function belongs
there, not here.

I agree completely, another artifact of refactoring from experimental code.

--
David Barr
