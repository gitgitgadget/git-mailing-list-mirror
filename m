From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered by path
Date: Thu, 15 Dec 2011 21:33:01 +0000
Message-ID: <877h1xzfjm.fsf@fox.patthoyts.tk>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
	<CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
	<alpine.DEB.1.00.1112151023280.2615@bonsai2>
	<CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Git <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:33:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIvO-000278-OU
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759510Ab1LOVdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:33:06 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:13124 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab1LOVdF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 16:33:05 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111215213302.DYQD27013.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Thu, 15 Dec 2011 21:33:02 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RbIvG-0007B5-GH; Thu, 15 Dec 2011 21:33:02 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B029F20A82; Thu, 15 Dec 2011 21:33:01 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
	(Martin von Zweigbergk's message of "Thu, 15 Dec 2011 11:42:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=KpAh3GZeS6gA:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=FP58Ms26AAAA:8 a=TSbVqHtbAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=Rf460ibiAAAA:8 a=qt9NyTCInrm-CXDTAREA:9 a=CjuIK1q_8ugA:10 a=U62fhAwekXMA:10 a=MSl-tDqOz04A:10 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187239>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

[resending as my earlier post got bounced from vger]

>Hi,
>
>On Thu, Dec 15, 2011 at 1:24 AM, Johannes Schindelin
><Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Wed, 14 Dec 2011, David Aguilar wrote:
>>
>>> On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts
>>> <patthoyts@users.sourceforge.net> wrote:
>>> > Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to files
>>> > under the given directory but the file list is left empty. This is because
>>> > the path_filter function fails to match the filenames which are relative
>>> > to the working tree to the filter which is filessytem relative.
>>> > This solves the problem by making both names fully qualified filesystem
>>> > paths before performing the comparison.
>
>How is this related to my patches from April? See
>http://thread.gmane.org/gmane.comp.version-control.git/170853. It's
>clearly not the same problem, but will the patches conflict? Will some
>of mine be unnecessary?
>
>> Thanks for reminding me that I did not yet apply and push. Did so now.
>
>What do you mean by this? Push to where?
>git://git.kernel.org/pub/scm/gitk/gitk.git is still down.
>

This is for msysGit.

>Paul and Junio, the patches I sent in April are still not in git.git,
>are they? Can we use another repo until the kernel.org one is up? More
>than eight months to get a patch (or eight) merged is way too long,
>IMO.

I'm not sure how this might relate to your patches. I've got a version
merged on top of the last version of the gitk report that I have which
includes those and it seems fine. As stated I did this work against
git-core as the gitk repository continues to be unavailable. However as
I have a pretty current snapshot  I have pushed this to github to provide
some visibility of things I know are not present within git-core. See
http://github.com/patthoyts/gitk.git

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
