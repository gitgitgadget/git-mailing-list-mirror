From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix
 to output file names
Date: Sun, 14 Jun 2009 12:46:45 -0700
Message-ID: <4A3553A5.3060209@gmail.com>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>	<1244963400-1739-1-git-send-email-pclouds@gmail.com>	<4A34B4ED.6060301@gmail.com> <7vd497qjhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 21:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvfY-00047f-PD
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763655AbZFNTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758002AbZFNTqs
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:46:48 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:63750 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763511AbZFNTqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:46:47 -0400
Received: by pzk17 with SMTP id 17so1539116pzk.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jQh5c2CrFLm9Bog1qgohHuKe+FWnvuuW5nboRW36ZXA=;
        b=CL5ndg+2iwaM9hCSeJcyusV7V+TJBhBBCru8trOcLtmQIMtLxwsCmJndXmkw3aze7B
         2lVF6VhJqsIRfYhOiHdn4Tjtm5oCKN6HbM3THy6guFyzCgPSuI4igDNCmi72KgxMoBlA
         v07vGYDk1n7oee9PBy9VOKzZ4gjRkKGxjyyws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=r0G70fL4oDfNayrDtCcWRg93gTGmU59LZ2YdoG5f95h6u2DfK3O6qZxkUK66ltVo5H
         Ug3K1+pIfYlBeEu6q8LdRNBvhn+GNkphpFbtDiAE0OrgIEc1AbhioBcXUmU3f/0F41+u
         Hf0yi7Fs3G4HB1Af+f78S3Ij4WLDnUxUbi3sE=
Received: by 10.142.135.16 with SMTP id i16mr2602947wfd.86.1245008808254;
        Sun, 14 Jun 2009 12:46:48 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm3831990wff.9.2009.06.14.12.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 12:46:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vd497qjhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121555>

Junio C Hamano wrote:
> Isn't the point of the exercise to come up with something like:
>
>       frotz-0001-first-patch-in-frotz-topic.patch
>       frotz-0002-second-patch-in-frotz-topic.patch
>       frotz-0003-third-patch-in-frotz-topic.patch
>
>       nitfol-0001-first-patch-in-nitfol-topic.patch
>       nitfol-0002-second-patch-in-nitfol-topic.patch
>
> with two invocations of format-patch, and when they are dropped in the
> same directory, the patches from the same series clump together?

Ok. Maybe spelling out the full example in the commit message would be
clearer.

>
> I personally do not think this is worth the additional code (you can
> easily run with --outdir=frotz and then with --outdir=nitfol and obtain
> frotz/000?-*.patch and nitfol/000?-*.patch to get the same clumping) but
> if the convention is to use dash instead of slash, the patch will save one
> step from users.

I agree. How is it any harder to do 'git send-email frotz' instead of
'git send-email frotz-*.patch'? The only advantage I see is you get
attachment filenames with a prefix.
