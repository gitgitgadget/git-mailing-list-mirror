From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Wed, 6 Feb 2013 10:03:00 -0500
Message-ID: <201302061503.r16F30UA016375@freeze.ariadne.com>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
	<7vtxpqslpm.fsf@alter.siamese.dyndns.org> <vpqmwvia2n7.fsf@grenoble-inp.fr>
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36X2-0006bJ-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab3BFPDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:03:07 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:37415
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168Ab3BFPDE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:03:04 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id wzaY1k0030cZkys55332fF; Wed, 06 Feb 2013 15:03:02 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id x3311k01B1KKtkw3W33218; Wed, 06 Feb 2013 15:03:02 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r16F30kb016376;
	Wed, 6 Feb 2013 10:03:01 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r16F30UA016375;
	Wed, 6 Feb 2013 10:03:00 -0500
In-reply-to: <vpqmwvia2n7.fsf@grenoble-inp.fr> (Matthieu.Moy@grenoble-inp.fr)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1360162982;
	bh=A5JDwsN+8GrFtuYdcJuDVm8NtiTPbXB+vrB5BMnKy28=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=kKUZiA+0eHpyeOHXq0lF67/QrfU3x39o4+cSKLshn7+21rd1X8qTckHzHUW8Te563
	 FSl4OCGdwXFS/7OpvqOYW1cRMnS7+A1lOsrHPWYI/dJHsL1PmVnI5dFaRGjLPkEAQS
	 F+7TaVlVRT3aNqOmTtJY0QY/nveC2uSR3noWZEOaUo7rnlcf3D9MnZjw7K8mSKEEUP
	 x/1sIbfbuPImbo0054Gadk2ZgQbGzVeRWsOx0ar6gHhRv5Kt7AtGNTfkkDgMfc24QU
	 J8VfgTF9GZP0NdvOAmgTYYQBz0gsFpPiwV/Xj8pF4nHBf1m4LCezNm73EaT/Uu83iW
	 Lly4Sblojdk2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215580>

> From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> 
> In any case, I can't reproduce with 1.8.1.2.526.gf51a757: I don't get
> undless output. On the other hand, I get a slightly misformatted output:
> 
> *   commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 2c1e6a36f4b712e914fac994463da7d0fdb2bc6d)
> |\  Merge: 2c1e6a3 33e70e7
> | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> | | Date:   Tue Feb 5 22:05:33 2013 +0100
> | | 
> | |     Commit S
> | | 
> | | diff --git a/file b/file
> | | index 6bb4d3e..afd2e75 100644
> | | --- a/file
> | | +++ b/file
> | | @@ -1,4 +1,5 @@
> | |  1
> | |  1a
> | |  2
> | | +2a
> | |  3
> | | 
> commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
> | | Merge: 2c1e6a3 33e70e7
> | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> | | Date:   Tue Feb 5 22:05:33 2013 +0100
> 
> The second "commit" line (diff with second parent) doesn't have the
> "| |" prefix, I don't think this is intentional.

The second "commit" line should start with "| * ":

> | | 
> | * commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
> | | Merge: 2c1e6a3 33e70e7
> | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> | | Date:   Tue Feb 5 22:05:33 2013 +0100

Dale
