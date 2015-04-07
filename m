From: KES <kes-kes@yandex.ua>
Subject: Fwd: Feature request: implement '--follow' option for `git blame`
Date: Tue, 07 Apr 2015 20:26:30 +0300
Message-ID: <720501428427590@web5j.yandex.ru>
References: <4215491428322362@web26m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 19:34:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfXO4-00051d-T2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 19:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbDGReA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 13:34:00 -0400
Received: from forward18j.cmail.yandex.net ([5.255.227.237]:57420 "EHLO
	forward18j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752959AbbDGRd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 13:33:56 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2015 13:33:55 EDT
Received: from web5j.yandex.ru (web5j.yandex.ru [IPv6:2a02:6b8:0:1619::305])
	by forward18j.cmail.yandex.net (Yandex) with ESMTP id 2F73621D9A
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 20:26:31 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web5j.yandex.ru (Yandex) with ESMTP id C90722680138;
	Tue,  7 Apr 2015 20:26:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1428427590; bh=RCc2LiTT2GO8ZCbJFrjmkGs8VpQja/2Aan4v9ASpXl4=;
	h=From:To:In-Reply-To:Subject:Date;
	b=RltBk5PBuRsWNoKn30x4DD61NY7cShjiAlNSnTZGWUsR5OqfKUhFc6vAmGCsaRyPC
	 pkNmS0VgNte0w2fbeEFWo1e6aKegTf2+TWNxfeoQrc9Dw6m96kyZVzkYD94ChZ1bgH
	 B03q2Ak7tJs/QWHpfxBklV9scngRGhf7WnkGEtYQ=
Received: by web5j.yandex.ru with HTTP;
	Tue, 07 Apr 2015 20:26:30 +0300
In-Reply-To: <4215491428322362@web26m.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266928>



-------- =F0=C5=D2=C5=D3=D9=CC=C1=C5=CD=CF=C5 =D3=CF=CF=C2=DD=C5=CE=C9=C5=
  --------
06.04.2015, 15:12, "KES" <kes-kes@yandex.ua>:

=9A=9A=9A=9A$ pwd
=9A=9A=9A=9A/data/mdi2/classes

=9A=9A=9A=9A$ git blame -L22,+1 -- utils.js
=9A=9A=9A=9A99b7a802 mdi2/utils.js (user 2015-03-26 21:54:57 +0200 22) =
=9A#comment

=9A=9A=9A=9A$ git blame -L22,+1 99b7a802^ -- utils.js
=9A=9A=9A=9Afatal: no such path mdi2/classes/utils.js in 99b7a802^

As you have noticed, the file were in different directory in that commi=
t

=9A=9A=9A=9A$ git blame -L22,+1 99b7a802^ -- ../utils.js
=9A=9A=9A=9Ac5105267 (user 2007-04-10 08:00:20 +0000 22) =9A=9A=9A#comm=
ent 2

Despite on doc

=9A=9A=9A=9AThe origin of lines is automatically followed across whole-=
file renames (currently there is no option to turn
=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Athe rename-following off)

blame does not follow renames. Why?

**UPDATE:** Short answer

`git blame` follow renames but not for `git blame COMMIT^ -- <filename>=
`

But this is too hard to track file renames manually through bulk of ren=
ames and ton of history.
I think, this behaviour must be fixed to silently follow renames for `g=
it blame COMMIT^ -- <filename>`. Or, at least, `--follow` must be imple=
mented, so I can: `git blame --follow COMMIT^ -- <filename>`

The good suggestion is here:
http://stackoverflow.com/questions/29468273/why-git-blame-does-not-foll=
ow-renames
-------- =FA=C1=D7=C5=D2=DB=C5=CE=C9=C5 =D0=C5=D2=C5=D3=D9=CC=C1=C5=CD=CF=
=C7=CF =D3=CF=CF=C2=DD=C5=CE=C9=D1 --------
