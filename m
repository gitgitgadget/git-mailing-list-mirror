From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 01:01:11 -0500
Message-ID: <9e4733910711092201n5aaeeb7cvfd0e76e43170d481@mail.gmail.com>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
	 <fh337a$ggp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjPN-0004vv-PS
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXKJGBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXKJGBO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:01:14 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:29263 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXKJGBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 01:01:13 -0500
Received: by ro-out-1112.google.com with SMTP id p4so462143roc
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 22:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nNwPcL5+DwH/TiI/VjYzlAsuDutey6PHpTfT2cL3gVk=;
        b=OetZEnPT5a98CYZ2FAwHQ37KSWKknkzgMBvgEcEcW6H69qtoOYZYtB6vkpW+cB2OOp4UV/1OxxIvVqQYevBfqrcOy195nSHvhX6gqTCh/RgU14orQ1fc4a+MNyZV1kmlTPIB20kDmk98b3hdKzqrYrN1PRRR6DmgEDS/diVyhfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V9rOV+skXP9DzKZlP5X1zaS0UG9aGCXP4fx1QkgJMY42aY2JjhN1y7XwTTZtskkRnBJZbTudGi4jddn7p/xh9133tYol/U80P9hBiWENDVy2nH0m4LV/GlAH5+KJ0L2DH86WqCEE3UgI4/+3o2nblnhgnHk/Bvk3zfYb7SRp3t8=
Received: by 10.114.25.3 with SMTP id 3mr527088way.1194674471704;
        Fri, 09 Nov 2007 22:01:11 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 22:01:11 -0800 (PST)
In-Reply-To: <fh337a$ggp$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64306>

On 11/9/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
>
> > At http://git.digispeaker.com/ the 'last change' column is not getting updated.
> >
> > mpc5200b.git
> >       DigiSpeaker for Freescale MPC5200B.
> >       Jon Smirl
> >       5 weeks ago
> >       summary | shortlog | log | tree
> >
> > It still says 5 weeks ago, but if I click on the project last change is today.
> >
> > What controls this? I tried running update-server-info
>
> What does
>
>   git for-each-ref --format="%(refname):%09%(committer)" --sort=-committerdate
>       refs/heads

[daedalus]$ git for-each-ref --format="%(refname):%09%(committer)"
--sort=-committerdate refs/heads
refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194585780 -0500

>
> return? Does adding --count select proper branch, with proper update
> date?

Is it looking for master, and just picking the first branch instead?

>
> Which gitweb version is this?

<!-- git web interface version 1.5.3.5.605.g79fa-dirty, (C) 2005-2006,
Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke -->
<!-- git core binaries version 1.5.3.5.605.g79fa-dirty -->

>
> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
