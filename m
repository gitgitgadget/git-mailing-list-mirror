From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git blame breaking on repository with CRLF files
Date: Sat, 8 Aug 2015 07:58:51 +0200
Message-ID: <55C59A9B.9000808@web.de>
References: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Benkstein, Frank" <frank.benkstein@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 07:59:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNxA1-0004Gc-3U
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 07:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbbHHF7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2015 01:59:05 -0400
Received: from mout.web.de ([212.227.15.4]:50650 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbbHHF7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 01:59:03 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Mbhiv-1Z53OY3fFN-00J4kj; Sat, 08 Aug 2015 07:58:59
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
X-Provags-ID: V03:K0:SIZu9WTvZIfjsR9RiDNvfu7jCEwi2Ojzrpevx4iRblpJtYH6MiB
 apwLGPc+5RAwBUITGQKY3zm9cxRxKuJ0xky2yoMMqWMMC0BchSW6rh7Upntr5+kfyxFb15z
 q9/cPGeO3tYP8ieRufkncPQZoKbPg0qfas0gNTFluG2RBs9t36jEFngGCAO1oyBXaRTZfY0
 UM+qqKzUkmt2UGFIrJW9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PeP8xP26CXo=:j7esCjfvJMkXB2SAKg4bDb
 cb5H41puwpKYCgp0lQJLJJHXXum6fj3A2K+DYiYtyMnuu1Ej5ij6GR2x/ETOJRzlfkBv4qiMg
 tPHXsUYLtjW1nRjtrPYwqapqVKe7xdoeuwZ4I3lfBjAr1Maj0bKAx4OWCT6f0JprJhqCOAI4l
 iwZ93mU4DRNLCm5GqwIDLUxWmoEMJuwOKVEg8wXGyDWjnORUFB65DlMKEAU1OZl+snXqy08CY
 GPrSry7GWNzp3uTZncRaiJB0+p/jJHzys/fpJAkRfkW3oB8WYCnQg6ZEv4CfwW/zsnNHrOvaZ
 HP7q9/er3rzsCBQCNVklssz44anOhsIcEF907v2GsdWEWbbzCyeoEGpZYCRrT/FrfpWS6VCOR
 cVagEkMwTnOZXKUh4rTHRWNssfSpJB1MrQHxE8JTLgTkgfYLifl66/vUobkRiEGxqGd5U9Czz
 HZjE5cSDiYkmSghjrMT3H9Hm9eo+x1K6Ld399oSc4GRd+eWM0aPvZPdYHtujmB9u1X6TyHzdL
 KlAsteF+6Y076QyT6Z87RILa6Ki1LQ8mcuegf+cMBPphpW+CEKjBk+bQff7fIseHc7MN7nLJ9
 f2JXZXoIBOFYtULTImyNpQeR621oV/twq/mvZdkSxfdPRGsR/pO9Io8mz+wmDAW4j+oSdL3kr
 Sep4zuRHEKJWVd3+COVsTGJRlyHDMztQZO1ijerHqAHc5Gc5O4X/3sOLhY0DhBi6Rf1XSoSMt
 QLzLz36Gd4WkyJS+1QqaHdTRv3hc4IPRheRjuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275505>

On 2015-08-07 18.32, Benkstein, Frank wrote:
> Hello,
>=20
> I am working working on Linux and am examining code in a git reposito=
ry I do
> not know much about.  I am only looking at files, not changing anythi=
ng.  On
> some files in the repository I get "00000000 (Not Committed Yet" for =
all lines
> when running "git blame".  I checked with "git status", "git reset", =
"git
> clean" that the files are indeed in the repository and unmodified.  I=
 noticed
> that this only happens with git v2.5.0.  With git v2.4.0 it looks cor=
rect, i.e.
> the output has proper commit ids, Author names and dates..  With "git=
 bisect" I
> tracked this down to the following commit:
>=20
>  commit 4bf256d67a85bed1e175ecc2706322eafe4489ca (HEAD, refs/bisect/b=
ad)
>  Author: Torsten B=C3=B6gershausen <tboegi@web.de>
>  Date:   Sun May 3 18:38:01 2015 +0200
>=20
>      blame: CRLF in the working tree and LF in the repo
>=20
> Digging further, it seems that most files in the repository are check=
ed in with
> CRLF line endings.  In my working tree these are checked out as LF
Do I understand it right that you have files in the repo with CRLF ?
And these files are checked out with LF in the working tree ?
Are the files marked with .gitattributes ?
Or does the file have mixed line endings ?

(Unless I missed something: Git never strips CRLF into LF at checkout,
so I wonder how you ended up in this situation)

Is there a way to reproduce it?

 - which
> seems to be the exact opposite situation of what the commit is trying=
 to
> address.  When I set "core.autocrlf" to "false" I also get the correc=
t behavior
> of "git blame" - this is a workaround as long as I do not have to act=
ually
> modify anything.
>=20
> Best regards,
> Frank.
