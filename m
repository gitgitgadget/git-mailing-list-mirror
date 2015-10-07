From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 07 Oct 2015 10:36:01 -0700
Message-ID: <xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 19:36:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjsdO-0004uy-DD
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 19:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbbJGRgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 13:36:05 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34262 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbJGRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 13:36:04 -0400
Received: by padhy16 with SMTP id hy16so27336285pad.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=e0L0VaDmJBFCbwl0L/7XRBfB4UL+nHZuki+dyoSnr5I=;
        b=QW04ddE4r7shx8FdR7yAGfuML0pF4aXEhEd+Gu4wZFX+lcWS1eSeflnrZz/ZMqmRAR
         g+D09Aqwh59NvUdo1k6S9+OfBY5bwOC6vfDRiNhwjKYHAcg1f7pqE1QJnzjKfxm+bNrU
         DEHzbN3+6cKG25AQOd4JsA5Yco0FzuIFr3NPas52DTdvPheq77WboMDm7GIPXl6LBUJq
         8K7pT2DLD6mHJXWCIXEEKMHs0y2gNIIoFscXRt5G6r4FvYYhjvADATVb3rJ5x70DFEvO
         VJMF+gf35PdprjChZbWl0X0JolFI3I9CR6lSV1J7mlIvGq2N96HXfRym9cZT+wYEtF+P
         TaPQ==
X-Received: by 10.66.165.5 with SMTP id yu5mr2327996pab.109.1444239363089;
        Wed, 07 Oct 2015 10:36:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id rm9sm19082896pab.14.2015.10.07.10.36.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 10:36:02 -0700 (PDT)
In-Reply-To: <ef5b20ed42ea20b2891fc3998a81f339@dscho.org> (Johannes
	Schindelin's message of "Tue, 06 Oct 2015 16:30:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279187>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As to the patch, I cannot speak for Junio, of course, but my
> preference would be to keep the return type. Traditionally, functions
> that can fail either die() or return an int; non-zero indicates an
> error. In this case, it seems that we do not have any condition
> (yet...) under which an error could occur. It does not seem very
> unlikely that we may eventually have such conditions, though, hence my
> preference.

Accepting Tobias's patch may have a documentation value to let the
callers know that the function does not give the caller any error
diagnosis, and it may matter a lot if this were a very frequently
used function, but that is not exactly the case here.

I do not care too deeply.
