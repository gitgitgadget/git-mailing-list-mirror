From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Sat, 21 Mar 2015 09:46:12 +0100
Message-ID: <20150321094612.Horde.fk34YSFwRX2Ew3gKIdyzPw5@webmail.informatik.kit.edu>
References: <CAHWMk2aq7dW5nBW1f8T4TWfRC70hp-6kR5P79m_E4zccuy53aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Cody Taylor <cody.taylor@maternityneighborhood.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 09:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZF3A-0002v7-4e
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 09:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbbCUIq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 04:46:27 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36988 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177AbbCUIqX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 04:46:23 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YZF2w-0002RE-Ir; Sat, 21 Mar 2015 09:46:18 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YZF2q-0004mI-OS; Sat, 21 Mar 2015 09:46:12 +0100
Received: from x590d9b30.dyn.telefonica.de (x590d9b30.dyn.telefonica.de
 [89.13.155.48]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 21 Mar 2015 09:46:12 +0100
In-Reply-To: <CAHWMk2aq7dW5nBW1f8T4TWfRC70hp-6kR5P79m_E4zccuy53aA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1426927578.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266016>


Quoting Cody Taylor <cody.taylor@maternityneighborhood.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>> Somehow I had a hard time making sense out of "when the current work=
ing
>> directory was not a parent of the untracked file".  Perhaps "when th=
e
>> untracked files are outside of the current working directory" would =
be
>> easier to grok?
>
> That description doesn't cover all cases.

I'm not sure I understand.
I think we both say the same, though from different views: you =20
describe what cwd is not relative to the untracked file in the =20
problematic case, while I describe where the untracked file is =20
relative to cwd in the same case.

> Scenario #1: Let's say there is an untracked file at `$ROOT/file`.
> When your CWD is `$ROOT/`, all is well. If you cd to `$ROOT/src/` the
> ls-files command failed to find the untracked file.

After cd to '$ROOT/src' the untracked file '$ROOT/file' is outside =20
cwd, which matches my description and is what your patch covers.

> Scenario #2: Let's say there is an untracked file at `$ROOT/src/file`=
=2E
> The ls-files command would find the file if the CWD is `$ROOT/` or
> `$ROOT/src/`, but not if the CWD is `$ROOT/bin/` or
> `$ROOT/src/folder/`.

Again, after cd to '$ROOT/bin' the untracked file '$ROOT/src/file' is =20
outside cwd, so my description and your patch cover it.

> Your description may be easier to understand, but I don't agree it's =
=20
> accurate.

Well, I think it's accurate, but now I doubt that it's easier to unders=
tand :)


G=C3=A1bor
