From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Teach fetch/pull the on-demand mode and make it the
 default
Date: Wed, 23 Feb 2011 17:21:56 -0600
Message-ID: <20110223232156.GE6819@elie>
References: <4D656F25.5090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsO24-0002qD-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab1BWXWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:22:03 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39703 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab1BWXWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:22:02 -0500
Received: by vws12 with SMTP id 12so3583162vws.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HG8gSi9vZvly9jULt792fD/KCswml7cc9KfD7ceHtNM=;
        b=kP85jMs5vD1N4pn+w90+DnsYRr0We1J7hCy1QTcmSbeTQYbGN8bAWgLGuvVDTQyZX9
         t7iCv0xxtxEUGf7DcFvk/CwH/4rWsBhpiLWxWm+IbZboZWONWml/KpM7r7QApTKTiQzv
         VsCLX0r9LBMnECUNViCHrXU8quvSWk86rYTvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qiLH/9HwZReF5S398tqWdux5lvdV0GxUe7d303jyFEEoZo6ZRbg2q8R4mmjDY6cqdm
         u6t89VSI9BUKiGwQ+Ch32PXHd5zny4e3481XZtmdG6vJPmMsXa5a7zLLgj1npbiYiB29
         hiH9yeq0xk0qE0K0bIukdX7Kh8xx0T7b2o2RA=
Received: by 10.52.96.5 with SMTP id do5mr225098vdb.134.1298503321039;
        Wed, 23 Feb 2011 15:22:01 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id k39sm3850851vcr.2.2011.02.23.15.21.59
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:22:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D656F25.5090007@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167739>

Jens Lehmann wrote:

> *) The fetch is only done when the recorded submodule commit isn't
>    already present.

I like this part a lot.

> I tend to think that this is suited for 1.7.5 but don't have any
> objections against holding it back until 1.8.0 either. What do
> others think?

I see no backward-compatibility to wait for this, but I would be more
included to trust people using "git submodule update" heavily than I
do.  The "submodule update" change could cause the following to break.
Would that be disruptive?

	cd submodule
	git fetch --no-recurse-submodules
	...

	cd ..
	bin/script-to-update-submodules-that-calls-submodule-update

Thanks a lot for working on this.
Jonathan
