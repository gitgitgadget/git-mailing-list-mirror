From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git blame breaking on repository with CRLF files
Date: Mon, 10 Aug 2015 22:22:36 +0200
Message-ID: <55C9080C.6040704@web.de>
References: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
 <55C59A9B.9000808@web.de> <55C7B5EE.7060908@web.de>
 <xmqq1tfbugho.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Benkstein, Frank" <frank.benkstein@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 22:22:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOtaw-0006GI-BX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 22:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbbHJUWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 16:22:49 -0400
Received: from mout.web.de ([212.227.15.3]:54222 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611AbbHJUWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 16:22:47 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MNx4F-1ZRNlK43LP-007RWN; Mon, 10 Aug 2015 22:22:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <xmqq1tfbugho.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:NUs+JJBTxMu6lQ0TGr4B1r4gDWpd3oPTfg01ZWmI6hh74vufJY/
 gZ+AVi63S1dLOZdi831VMAVfLfHtfWIuqiwqY/N1amHYGSX2CNsHsO3e7SErOIKVnCrbZ1p
 Qgi76yJHA4SJ00K/IEAGNHTdmb5OBOscW9OGTNEYh4LHflmH/vCfYh1hdfbHCD7CwI18Wuc
 3M2hEwMkrEslsGV3tL/5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7Kj5f0JJUSo=:0yZRB+u/vsbwMQ9WdA7TCa
 ckWRNigGwSZB31VPPMJlUprhqsMXpV6rnhu9UCI2MA+PYWnZM+3+0MxHsKHqn5L0FUeSWbPnA
 buY2PqGc1+qctuboxluNao3P5rufZXD6p/Whj/3073KJmkCX61Sah3vxVZH2vtLjADt133r9i
 G8QkkD7l5iPz+7mbQOXHbvMKkqBxBzn87vIp5nL7Ri7KwgecLQdkm+u5kfICnxT/EFUmGvUV0
 3eNZ2etokxUwey30LDTjw+ABrSyjKIPVg3pa+LFCLPN+Hw94REIE9gLLgh15B082mrtKod7wP
 kBPOltuI5JY/EJcEpKFdSVdzs/Y+eyaVqlsC57kuGzYDuPlALVjm+LG3iGki6f78ZeuqzI8wp
 rewImQkATE1+0sthvfVvWon8OiOMUnIyTELrU53HuVXHwsJepbY/+/v+/Q7ZcDIbQUMMA1nqj
 E9FNjYUy10jo3XXTGN+mYiUvD/4bGt9tqt2ffjlIahfYEu0X/eMDi4+0zGLd7Evggpl1Mk4aB
 j0TuGbnqkVVTkoPfX6Wg37ht8kenbiSLYT8Ldc7KLtjaJGg0Z0BFX2OZonsEXztm2xw6s5LjJ
 +tWvoXnGjmVLNc+HCmBOtjgA8qYZfZ1Pycw0pVFFgqmbDflaJ7tZQ35wJJDivW5t95Doh4Skg
 Ww7eoSu6O35SieGry6703Lcy32h/x7HLctIdOUxG5fkbPug6hx4GXpvdHL+Za/TcFXuZuCXcY
 2RkmesVLn/0Sf9xlwgL9MQRNz1K5boLgxy8HDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275652>

On 2015-08-10 20.48, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Actually I could reproduce the following:
>> CRLF in repo, CRLF in working tree, core.autocrlf=3D true.
>=20
> What should happen in such a case?  Wouldn't autocrlf=3Dtrue want to
> strip CRLF down to LF?  Shouldn't it?=20

A problem is, that "git status" would report a file as changed,
when it have been committed with CRLF and core.autocrlf was false.

The only "change" that "git status" would trigger on would be the EOL n=
ormalization.
So if core.autocrlf would be set true later,
git status reports files as changed.....

Long story short:
Once commited with CRLF, the files will not be normalized in a modern g=
it:

=46rom convert.c:
if (crlf_action =3D=3D CRLF_GUESS) {
	/*
	 * If the file in the index has any CR in it, do not convert.
	 * This is the new safer autocrlf handling.
	 */
	if (has_cr_in_index(path))
		return 0;
}
---------------------
commit fd6cce9e89ab5ac1125a3b5f5611048ad22379e7
Author: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Date:   Wed May 19 22:43:10 2010 +0200

    Add per-repository eol normalization

    Change the semantics of the "crlf" attribute so that it enables
    end-of-line normalization when it is set, regardless of "core.autoc=
rlf".

    Add a new setting for "crlf": "auto", which enables end-of-line
    conversion but does not override the automatic text file detection.

    Add a new attribute "eol" with possible values "crlf" and "lf".  Wh=
en
    set, this attribute enables normalization and forces git to use CRL=
=46 or
    LF line endings in the working directory, respectively.

    The line ending style to be used for normalized text files in the
    working directory is set using "core.autocrlf".  When it is set to
    "true", CRLFs are used in the working directory; when set to "input=
" or
    "false", LFs are used.
-----------------
So "git status" is somewhat improved, but "git blame" is not.
(My feeling/suspicion is that has_cr_in_index() should be replaced
by has_cr_in_latest_commit() to have "git status" consistent
with "git blame", but more analyzes may be needed.)

A different approach could be to ignore the EOL differences
completely in "git blame" (when core.autocrlf is set and the file
is text, or when the "text" attribute is set).


> And if so, "blame" is correct
> to say that you are changing the line endings of all your lines, as
> what you _would_ commit if you were to commit the tracked files in
> your working tree would be different from what is in the index, no?
