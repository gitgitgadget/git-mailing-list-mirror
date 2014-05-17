From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [GIT GUI PATCH] git-gui: use vcompare when comparing the git version
Date: Sat, 17 May 2014 13:23:03 +0100
Message-ID: <87k39kbnmg.fsf@fox.patthoyts.tk>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>
	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>
	<5373200D.7020108@web.de>
	<xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>
	<xmqqk39ohvyp.fsf@gitster.dls.corp.google.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Chris Packham <judge.packham@gmail.com>,
	GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 14:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlde6-0002QI-Tg
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 14:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbaEQMXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 08:23:15 -0400
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:46708
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbaEQMXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 08:23:12 -0400
Received: from fox.patthoyts.tk ([82.34.175.55])
	by know-smtprelay-1-imp with bizsmtp
	id 30P31o0111C56nm010P355; Sat, 17 May 2014 13:23:03 +0100
X-Originating-IP: [82.34.175.55]
X-Spam: 0
X-Authority: v=2.1 cv=APkb3eKN c=1 sm=1 tr=0 a=g1XlTrwDEGH9N8TSFs8Bjw==:117
 a=g1XlTrwDEGH9N8TSFs8Bjw==:17 a=qRKFtABOsx0A:10 a=M90_9NKyvDEA:10
 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=FP58Ms26AAAA:8 a=ybZZDoGAAAAA:8
 a=Rf460ibiAAAA:8 a=1P_drueGfx4E5ckt2WEA:9 a=HAhOExdm9pR_JmRw:21
 a=6Nlx7UKWKagc2s0W:21 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=5KVauyKsRKMA:10
 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 285A320969; Sat, 17 May 2014 13:23:03 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <xmqqk39ohvyp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 May 2014 14:49:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249464>

Junio C Hamano <gitster@pobox.com> writes:

>Junio C Hamano <gitster@pobox.com> writes:
>
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Junio, I believe this issue needs to be fixed before 2.0 final. Otherwise
>>> git gui will not work inside submodules anymore due to the major version
>>> number change from 1 to 2. I'd like to hear Pat's opinion on this; even
>>> though I think my patch is less risky (as it doesn't change behavior for
>>> pre-2 versions), he might like Chris' proposal better.
>>
>> Thanks; I share the same feeling.
>
>So after checking git://repo.or.cz/git-gui.git/ and seeing that I am
>not missing any commit from there, I tentatively created a fork of
>it, applied your patch and merged it somewhere on 'pu' that is close
>to 'next'.  We may want to fast-track it to 2.0 without waiting for
>an Ack from Pat but let's give him one more day to respond.
>

The analysis about the major version number being significant is
correct. By default vsatisfies assumes that a major version number
change means all lesser versions are incompatible. However, you can
prevent that assumption using an unlimited check by appending a - (minus
sign) to the version to yield an open ended range. Or by giving another
range. So the only change required is to append a minus.

  package vsatisfies $::_git_version 1.7.0-

will suffice.

  package vsatisfies $::_git_version 1.7.0 2.0.0

would work but would cause failures when we arrive at git 3.0

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
