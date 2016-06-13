From: Stefan Tauner <stefan.tauner@gmx.at>
Subject: Un-paged commit messages in git filter-branch's commit-filter?
Date: Mon, 13 Jun 2016 08:28:18 +0200
Message-ID: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 08:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCLMh-0005Fc-Ez
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbcFMG2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 02:28:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:56210 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964840AbcFMG2s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 02:28:48 -0400
Received: from misery ([80.109.83.31]) by mail.gmx.com (mrgmx001) with ESMTPSA
 (Nemesis) id 0Lb5nF-1bsb4o2J5t-00kgLk for <git@vger.kernel.org>; Mon, 13 Jun
 2016 08:28:39 +0200
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-Provags-ID: V03:K0:53T7cH2kB8LDiDVprkLT6Ous+TJigvmF88owMCtW4pQcS1UNTqa
 heA678HehF2kIpvcCrr++nyXOEX3N0qnLPPGinL3yy94Ixxdx+elZ4p4sgI3D3lVQiHkdgJ
 dztVHQxRgFuwMVWdnfYydmqjKHEtGQdxU2wwIzGn6lcxk1Pek8/zmDPkh1xoOeTX/12LO9W
 QWlfPgpltuBCbWzAIgdqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rb6Rl+YLr9A=:ilf2+7ze4Ha68uHE4197g7
 oTLGzvX8y/P4fHrftyH+no62o2hFoQuG/majCrmpCKBjSinFsDxGeyuowDzkiKuFlXrBEJCVd
 Yf0i9Gi9CNJOmsCC8henjCsLr4pC6KtSj1VJznjbeN7CKOtHrmI8MCt8D8aJbGz+osMWCLzOq
 NQ1T1uMlem9c0Y1KBsLcIu9PVfWxVz/D4uGkp2cefPQEOZeJfq/GiOZp1jYTaLahSAQ9EoNm7
 NlOAhqaz1HVAcJrYIKV8DD3WMzgawXMwV0TXA2a1hiL54POBvLUSHU2uDzw+v5ndG0eZoETyi
 786TrjMzTxcKoICJgxP6xpDCCXClzL5NU5ZLVXPQrlZ+dRCVN8p/WgCacUEizEYaCDbZTNB0T
 86YTbr3XO0EFZ2e2IbVMj2r4AlvzvjukG2naljvyIVREb8Jjtju3oqSmwUUCgBydL38Ys402h
 cnGwCxBPaJ36ZAzXpgdFOBw4gyQdN6xwkFDqDmRTvIbQNogzVPQw3Kz8EwRjSl4DuV29zAzWI
 yipBXBghglBOIJ/lE0AXOhpuoeB7E1HtrMjRZ/XaqR3H1G54o1zkF8XIVOROLhuUp1i1CDjiN
 IGV0B6c54RlY3+4CogAHnfV9QE+JZ5A0bWVB4g6bbgcrq+MHmqJAw28CSGn8sHAZ2mHEMclvM
 qXCbfj0XNmG/s18a2arKHGJFlB9MJdu3sqN3PqgaZQdhqBMjEukWZdN5cBWmbDWX2c4BV+9Gv
 jgEvVf0NyfnA7yMLvew7tqsl6OkQ+U/LhuQRl8bHxOtPGQMnzUN6+tEhXlePaEmrCOxlbOuU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297160>

Hello,

I am trying to do a major cleanup of the repository in one of my
projects (and switch from git-svn to native git). I have developed a
commit-filter script over the last months that massages partially
dreadful commit messages into something acceptable. While I am not 100%
sure I think that upgrading git has broken it partially. AFAICT since
the update the commit-filter does not get the original message anymore
but at least the subject/first paragraph is run through a pager or
something similar:
The first line is broken into multiple lines (i.e. some line breaks are
inserted about every 72 characters where none have been before).

I have tried to run "git --no-pager filter-branch ..." to no avail. I
have briefly looked at the source but could not find any proofs...
Any hints would be appreciated. This is how I run my script:

tmpvar="$(</home/.....sh)" ; git --no-pager filter-branch -f --commit-filter "$tmpvar" --tag-name-filter cat -- HEAD

-- 
Kind regards, Stefan Tauner
