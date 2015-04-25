From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] t0027: Add repoMIX and LF_nul
Date: Sat, 25 Apr 2015 23:43:55 +0200
Message-ID: <553C0A9B.7060407@web.de>
References: <553B3871.6050904@web.de> <xmqqegn817pr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 23:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym7ry-0006Qy-PK
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 23:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbbDYVoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 17:44:10 -0400
Received: from mout.web.de ([212.227.15.3]:57289 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbbDYVoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 17:44:09 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Le4fk-1Z50c52XLo-00prfn; Sat, 25 Apr 2015 23:43:57
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqegn817pr.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:OAmlT+zJJ5Q+qJ8JpUxP8WoWS6tjbyRTobUaHTNqGk/HgmvpMy6
 eBD7bgygTaSrQwgpBZajCsJ1fVA8vhT8/WL5e7vPz5zeHqo0Zjvd9sz3sSM1LGlrbfMOx8+
 k+YA8d5jspOE6tKkel6bLeUJ0+MKHf6KPXhzKuMlO5Ql3K4cgUiKuFuCMX/jFnvNaKs6xJI
 XwmpN1hxSd+ZcZ7gB7lhA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267802>

On 2015-04-25 18.41, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> "new safer autocrlf handling":
>>   Check if eols in a file are converted at commit, when the file has
>>   CR (or CLLF) in the repo (technically speaking in the index).
>=20
> s/CLLF/CRLF/?  (no need to resend for this; I'll locally amend)
>=20
>>   Add a test-file repoMIX with mixed line-endings.
>>   When converting LF->CRLF or CRLF->LF: check the warnings
>>
>> checkout_files():
>>   Checking out CRLF_nul and checking for eol coversion does not
>>   make much sense (CRLF will stay CRLF).
>=20
> Hmph, would it still make sense to make sure that CRLF will stay CRLF
> so that future changes to break this expectation can be caught?  Not
> that such a breakage is likely...

Thanks for amending.

We have the file CRLF (and CRLFmixLF), where we check that CRLF stays C=
RLF and is not
converted into CRLFLF.

The LF_nul is to test the "auto text detection":
It should not be converted into CRLF_nul in "auto mode",
but should be converted when declared as "text" in .gitattributes.
