From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 12:56:24 -0700
Message-ID: <20130321195624.GH29311@google.com>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
 <7vboadevpk.fsf@alter.siamese.dyndns.org>
 <7vmwtwa5xa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlbc-0002La-VS
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab3CUT4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:56:30 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41542 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3CUT43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:56:29 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so2505144pbc.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9rCEdK1DvqfoXO9ZBkAFTdrViBudZYI7QG4pXVu9ecI=;
        b=k0upG2H5jBh56mOcLAzZRhiYh/RjAPGVS97HC80oEqu14cVvV696cfu9+liB6ija2n
         8gj9D64b6wE1zkANGrtnRNHdOfBWhhYp1NpuenC+vQm1025exDdHzikwGGM3au6daFRu
         +etEJvBCfQ6hnU89KAy7x2Wc19si7BV4RAPTUgdn0h78h8bg/NswuKExRdVlWBfQjRXM
         f6kn4QkdYh2hGaS4pGlscUYm+GpGpYSoRXaiQmGdTH/x1241oIi2OL1PFy+7NlpdaohC
         hHq5mrjAT7YZOwX/9qIlr1R9psQ5mMoTzgtvP0aPBTCf8hntvH7Lz8s897zAvKIlbENN
         /qQw==
X-Received: by 10.68.194.8 with SMTP id hs8mr16471203pbc.44.1363895789003;
        Thu, 21 Mar 2013 12:56:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id xs10sm7656153pac.8.2013.03.21.12.56.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 12:56:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmwtwa5xa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218752>

Junio C Hamano wrote:

> +Consequently a request `git merge --ff-only v1.2.3` to merge such a
> +tag would fail.
> +
> +When you want to just integrate with the work leading to the commit
> +that happens to be tagged, e.g. synchronizing with an upstream
> +release point, you may not want to make an unnecessary merge commit
> +especially when you do not have any work on your own.  In such a
> +case, you can "unwrap" the tag yourself before feeding it to `git
> +merge`, e.g.
> +
> +---
> +git fetch origin
> +git merge [--ff-only] v1.2.3^0
> +---

Nice and clear, but doesn't this contradict b5c9f1c1b0ed (merge: do
not create a signed tag merge under --ff-only option, 2012-02-05)?
