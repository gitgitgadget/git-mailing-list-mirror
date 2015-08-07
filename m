From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Windows 7 - long/short and upper/lower filename
Date: Fri, 07 Aug 2015 16:03:21 +0200
Organization: gmx
Message-ID: <466225b8050e58deaf5ffa4ad41d64b9@www.dscho.org>
References: <55BFDAB0.8010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jos=C3=A9Quintas?= <jmcquintas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 16:03:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNiFA-0008UD-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 16:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbbHGOD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2015 10:03:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:57029 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136AbbHGODY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 10:03:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LdYxu-1YxgoV2oGA-00ioF8; Fri, 07 Aug 2015 16:03:21
 +0200
In-Reply-To: <55BFDAB0.8010306@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:aSpCFSq2+HjrX4O+68eSNOy9NpwPdsNEIwRFuES1gi2pGOVu1+r
 Crxx29R+5/ycGujqVbNSpasknpqu//hv5slryiH/LFn76oMfcHThj8zeOSfxfrIPK5bFNe1
 OHK6C2Pok/dT3wW4Y1R0gSDtsCnQo06hlel1khcApQAIoRzgOZu/NTNN5j/lrc4MaYF9C7/
 cyRqTobZxz99NP15+lfQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ANdRVDoUXxs=:1nt/ig4ZhVMDs5aOIJzAw3
 HF7yFO2gpwp8dsLH3eDQH2WqEqOCJh0qHcBRcXWElawYpozqZ0eJiKqvyBCizC93GFrzw2DHd
 mwB09hk2QQe5oqRTLHNzkgre9ZydTMz3V4SWz5IvsCwASQUgXvaui52qgLcMXjdWpdvnNTa14
 S4nSOjgtEHQveXUM+63ZEyRXTtg9QByL9mkA2sz7RibzU4rV+Mkf237MrxkDab4gvjSWN8stM
 GEMU200QvQhhGOp1q+9ybq/frCgsQEIzsDTE9XcsUemXgmYnRMvbhWoxgkQ8EQL04XmB4g2aB
 U2wFc3fCMEH3CjIrL+QZgGS9l+kxKz3AY+rKbk7VxyHwdyPKnQRoH1arxU72HhPRNOtm54lUa
 SPUCUOikY3tRV+LTuG4YgM3H1QlhTu0xXZzVF/uj3QG9c/vRccLzx7swsypvi1W4GArmAk5Hs
 kGPl1SxADZ5uxG2PVtcVWPbd08imRjV+qnXblShnEW9bAisyEROqz/UkkVSFjF0gB24fnhgj8
 7+5lUb6GGfVR9TFDbUjKYLISbZ3EoIanZvqVISqd66YepafNAH7zOXDNs69QjZVZqVREpUg7x
 9aDoYOVsiaH6891Akkm9rjcp8gaizydcjwOM90K5W+Nog5fgIFgzmXkZpT+3osFrXn9xggvWg
 PmxSIzg22eq0CLI+kS2mkUeck1bbj80vJsQUtzRnYcQtRhr/KsmX4H8LtolRtYL3aqBATD37Q
 OwIg7OI84Yqyq1qQo03SVzA0S4iM1uadPTWf0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275467>

Hi,

On 2015-08-03 23:18, Jos=C3=A9Quintas wrote:
> I am using Windows 7 64 bits.

=2E.. and Git version... ?

> I have a filename called ze_xmlfun.prg
> Last week gitgui shows 2 changed files: ZE_XML~1.PRG and ze_xmlfun.pr=
g
> At momment I can't update this file, because get a error.
> Try delete file, update one name each time, but same error.
> Seems that a unique file is considered as 2 files, and this causes er=
ror.

This is no longer allowed in the most recent Git for Windows 1.x versio=
ns, for exactly the reason you mentioned: the short name is actually re=
ferring to the same file as the long name. Therefore, short names will =
be refused.

Unfortunately, you will have to fix this issue in your repository yours=
elf. It will most likely entail something like `git rm --cached ZE_XML~=
1.PRG && git commit -s -m "Remove bogus file"`

> When do a search in history, upper/lower case must be the same as in =
git
> control.
> If upper/lower is changed, is considered a new file.
> How to configure git to work allways using lower case on Windows?

There is no such configuration. If you have a file with an undesired fi=
le name, you have to rename it. You can use `git mv` for that.

If the file name differs only in case, you will have to do a little dan=
ce like `git mv MYFILE myfile.bak && git mv myfile.bak myfile`

> Is there a plugin or a tool to make this, to new files and to update =
in
> git repository?

No, not unless you write one.

> Note: gitgui is a gui tool for git, ok, but once it uses git, may be
> this feature/change need to be made in git.

If you have an idea how to incorporate this into Git's source code, it =
would be a splendid idea to contribute that change to this mailing list=
=2E

Ciao,
Johannes
