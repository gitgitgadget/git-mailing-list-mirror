From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Fri, 15 May 2015 11:01:17 +0200
Message-ID: <20150515110117.Horde.HyhfKlrEun2r-3mHUG3GSA1@webmail.informatik.kit.edu>
References: <5553B61D.7050204@gmail.com>
 <1431640110-8484-1-git-send-email-szeder@ira.uka.de>
 <CAHGBnuN-sw8Q_boB2SSNKTQP6M4jifiketFWJ23bknAdCVw_Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 11:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtBUs-0008Fl-DI
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 11:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbEOJBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 05:01:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44067 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749AbbEOJB2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 05:01:28 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YtBUh-0000b6-CY; Fri, 15 May 2015 11:01:23 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YtBUb-0007il-Fo; Fri, 15 May 2015 11:01:17 +0200
Received: from x590d8b91.dyn.telefonica.de (x590d8b91.dyn.telefonica.de
 [89.13.139.145]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 15 May 2015 11:01:17 +0200
In-Reply-To: <CAHGBnuN-sw8Q_boB2SSNKTQP6M4jifiketFWJ23bknAdCVw_Uw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1431680483.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269136>


Quoting Sebastian Schuberth <sschuberth@gmail.com>:

> On Thu, May 14, 2015 at 11:48 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>
>>> for directory in "$(env | grep -E
>>> '^PROGRAM(FILES(\(X86\))?|W6432)=3D' | cut -d '=3D' -f 2 | sort -u)=
"
>>> do
>>>     test -n "$directory" &&
>>>     test -x "$directory/$winmerge_exe" &&
>>>     echo "$directory/$winmerge_exe" &&
>>>     break
>>> done
>>
>> This ain't gonna work, because the output of the pipe won't be split
>> because of the quotes around the command substitution, so $directory=
 will
>> hold everything.  Simply loosing those quotes is not good either, be=
cause
>
> That's what I thought at first, too, but simply trying it out proved
> me wrong (again, in both MSYS1/2):
>
> $ for d in "$(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=3D' | c=
ut
> -d '=3D' -f 2- | sort -u)"; do echo "$d"; done
> C:\Program Files
> C:\Program Files (x86)
>
> Note that the path, although they are containing spaces, are on
> separate lines.

Yeah, exactly the behavior I described in the part you quoted.
Although it looks good, it's not what you want.
Putting 'echo "** $d **"' in the loop gives me:

** C:\Program Files
C:\Program Files (x86) **

(1.9.5 MSysGit)


G=C3=A1bor
