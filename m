From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-archive loses path info when opened with Winzip?
Date: Mon, 31 Mar 2008 22:09:13 +0200
Message-ID: <47F144E9.2040709@dawes.za.net>
References: <47F0D215.1060700@dawes.za.net> <47F13FCE.1010502@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgQM1-0004ab-Ix
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 22:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYCaUK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 16:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYCaUK6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 16:10:58 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:60398 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751682AbYCaUK5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 16:10:57 -0400
Received: from [192.168.201.100] (dsl-243-66-181.telkomadsl.co.za [41.243.66.181])
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id 46A85E251F;
	Mon, 31 Mar 2008 13:10:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <47F13FCE.1010502@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78601>

Ren=E9 Scharfe wrote:
> Rogan Dawes schrieb:
>> Hi folks,
>>
>> I have noticed something strange with "git-archive"-created tarballs=
=2E It
>> seems that Winzip has trouble parsing the paths for certain files
>> correctly.
>>
>> The symptom is that Winzip shows some files as having been created a=
t
>> the "top level" of the zip, without any path at all, while the rest =
of
>> the files are within their correct directory structure.
>>
>> I have attached a screenshot of a gitweb-created snapshot opened in
>> Winzip 9.0 SR1 (build 6224), but it apparently happens in other (mor=
e
>> recent) versions of Winzip as well.
>=20
> Oh, well.
>=20
> Each file in a tar archive has at least a 512-byte header.  This head=
er
> contains a name field, 100 bytes long.  When it became clear that it
> would be nice to support file names longer than 100 characters, anoth=
er
> 155 bytes in the header was designated as a prefix field (see tar.h).

[snip]
> In any case, there are better options:
>=20
>   - Don't use long file names (just kidding :).
>   - Use a tar extractor that understands the prefix field, e.g. 7-Zip=
=2E
>   - Use zip (but beware of its 65535 bytes name length limit! ;).
>   - File a bug report with WinZip.
>=20
> Ren=E9
>=20

Hi Ren=E9,

Thanks for the detailed explanation. I guess I should file a bug report=
=20
with WinZip, although that won't solve the problem for most of the=20
population.

My best bet seems to be to provide the option to create Zip files rathe=
r=20
than tarballs (i.e. upgrade my gitweb.cgi to something more recent).

Regards,

Rogan
