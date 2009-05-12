From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 17:40:47 +0100
Message-ID: <e2b179460905120940u2d87a591kefbdf659e1badd0c@mail.gmail.com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3v33-00024k-Se
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbZELQks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbZELQks
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:40:48 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:53462 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbZELQkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:40:47 -0400
Received: by mail-bw0-f222.google.com with SMTP id 22so83478bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lJDtfQ9ZLvWrr6TOv4iPbpaA4ySYeZRcthyIOmnJLyM=;
        b=M05GYggWN3loEaA1h9AbkGFgPcxPq0h0Htnp1dlh8+cLRoc4WfOmEqTfJ9dsD5H8NE
         luNwbaMbc3vSERxY/mbt+rlWlu0Zmm7B++VD18ChRGNGvVZmFP94wEzOyfH4vhpIPOeg
         Os9VAQ8cdSOq9bCh6P60H2y1zAuNdN08qJJhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fJ/AhwCCli630MiR74/b2AMxNe+w0gOrfuPvZRWX6xq4ZB8iZdTMVItjGfHN6h34j0
         EUxYUNInoAbfBY7cKifO48c4FTGA6PszBPWADNZxKPkIfRuJ86+vuMiqs73sxp4xk9CE
         +FCKzbf61ZFci7ZUuy7nsWCmsptgTRWGzE5cI=
Received: by 10.223.110.4 with SMTP id l4mr5005817fap.47.1242146447778; Tue, 
	12 May 2009 09:40:47 -0700 (PDT)
In-Reply-To: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118923>

2009/5/12 Jon Brisbin <jon.brisbin@npcinternational.com>:
> Our development manager was evaluating transitioning our AS400 department to
> IBM Rational for the RPG programmers, who currently use SEU for all their
> editing and source code control.

+1 everything Shawn and Andreas said, but there are other practical
issues beyond developer mindset.

(see http://article.gmane.org/gmane.comp.version-control.git/117755
for my context)

I'm not familiar with the AS400 or SEU but do developers currently
have a complete copy of the tree to themselves, or do they only check
out the files they're editing?

I'm not sure what Rational Developer is likely to want to do in terms
of getting the edited files back to the AS400 (assuming it supports
that directly). Are you planning to run (j)git on the AS400 or have
another step to get the code from a central git repo back to the
AS400(s)?

Is any deployment done to a test server? Is there a release process
you need to integrate with?

Our devs expect their changes to go live at midnight after they
'release' them. Are there similar assumptions for you?

They also expect to see everyone else's changes (to all the source
files they're *not* working on) as soon as they go live, without
having to pull them. Madness, sure, but it's the kind of madness they
happen to want.

Previously, no-one would have had to worry about merging / integrating
(unless locks were broken). Someone (possibly everyone) now has to do
this.

Unless developers have an AS400 at home, or a very funky emulator on
their laptop, many of the distributed benefits of git are probably
going to be of no use to you.

You probably need to address what concrete benefits remain and see if
you *want* to try and sell them.

Local / feature branches, ease of moving work and history between
developers, speed, repository size, repository resilience, usable
tags, immutable history... All of those might still apply as wins in a
centralised / minimal-merging environment.

You may also want to find out if IBM can point you at a reference site
for Clearcase (presumably?) on the AS400 in conjunction with Rational
Developer on pcs. It may be so bad and so different to what they have
now, that you can push git (with a bit of scripting around it) as
actually more similar to their current workflow. 8-)

Mike
