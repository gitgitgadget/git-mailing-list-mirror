From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL
 handling code
Date: Mon, 2 May 2016 13:29:15 +0200
Message-ID: <57273A0B.5050409@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-3-git-send-email-mh@glandium.org> <5726DE16.3030402@web.de>
 <20160502083133.GA20929@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon May 02 13:29:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axC31-0005m2-Ra
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 13:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbcEBL3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 07:29:43 -0400
Received: from mout.web.de ([212.227.15.3]:62294 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbcEBL3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 07:29:43 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M40zy-1bne2B2rSs-00rZT6; Mon, 02 May 2016 13:29:17
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160502083133.GA20929@glandium.org>
X-Provags-ID: V03:K0:CjoaPBA8oyOTBhLEPWmSEFe5xPb4Z7v9kpLzv/SPHeqBxw+8nuY
 Sp0Lv1GLuxfmwIzVF55UFEB2rFKCddiSN9eKTLs7+i2KyppAdMtJ9h4FxY4MnoomGhRZB2r
 7RkuU6bOM2DhlIInyKIcziQlkQrasmfzNVspfwvpz70iApMtOA+VbSuXsV+yhi0/BXdKNEe
 AvMwpQ7JUDmxYxUH9XeqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bo70s92xV/k=:1+4h3S6yQMyDqy8qtTCMfW
 W8WR/xLokqBHMvn/1qxQBjEydSD87q1uKcA8tkg9onsaT3MluXD0X4AlfStakSyDU29xe+a2P
 EQu8LL2tYPTF0d0dTehCNH4sr1Q47iq4Owfv9nHDzncjMUUEC3VRkUihQawY+ZIkD6m7BZw06
 ufnwznXJeHXChQ5J8IfNHtmoPoXIJalct8dAfSg1LnIEA/uc0qbOZIyNfzBsYvVhbJjvkvVpE
 uWH54jjA8+xA1d8Ug2RsllPyXLx3zCdiu8ST87jBVJ5+t9TmcxTLpLlw6pXWx6fP3izTEKmVs
 prvebyVenUbahW08KY4cIJLfbu6ugjsGO7mRlpOP7nHxFvGcCwV2aTLM0nmptzqVCW45B3qzT
 zJvwcDDaCXx3A+e9tXr/X74g7Wnpbq+/+/8SYU2WtjbCGjYkO1kpyAc3K4gRveOqmNt4/jeXb
 fc3INCPtBHXDoOEcz3TSW4N9X+E6UnDUKY8EQO2WfXp/Wzrndar1jk7BWG3T+oKYJ1CuvpOIq
 8DJj/2x4WGBHG008BB6Y1QNAyF4XKwY+rL7v6FsC5cTpZyTP5Edx1u6deCoqFfDxytRTOkbOc
 ai1vYPWbGKZulYvKgenFF8mdScmiMKnyESxvbc1IPCVrwkiVnu97hJuTEx7HuwmtlVNEpLQwt
 NmKyp0HGnu2D1ByMNpYwzdfWjoHo0HeAtmxSaixCLJGxL/g2uPG+Nv1VlVCc4e6ITGsEJZCDV
 76RapDmubJWf5XIZZPh0bHSqO/0VBSfCJPZUYSx6/iVq3cwCGTl2GVVg1oIXc4LcGQfK/4UW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293234>

On 05/02/2016 10:31 AM, Mike Hommey wrote:
> On Mon, May 02, 2016 at 06:56:54AM +0200, Torsten B=F6gershausen wrot=
e:
>> On 05/01/2016 08:02 AM, Mike Hommey wrote:
>>> +	if (flags & CONNECT_DIAG_URL) {
>>>    		printf("Diag: url=3D%s\n", url ? url : "NULL");
>>>    		printf("Diag: protocol=3D%s\n", prot_name(protocol));
>>>    		printf("Diag: hostandport=3D%s\n", hostandport ? hostandport :=
 "NULL");
>>> +		printf("Diag: userandhost=3D%s\n", host ? host : "NULL");
>>> +		printf("Diag: port=3D%s\n", port ? port : "NONE");
>>>    		printf("Diag: path=3D%s\n", path ? path : "NULL");
>>>    		conn =3D NULL;
>> Does it make sense  to write the host twice?
>> If things are cleaned up, would something like this make sense ?
>>
>> 		printf("Diag: url=3D%s\n", url ? url : "NULL");
>>   		printf("Diag: protocol=3D%s\n", prot_name(protocol));
>> 		printf("Diag: user=3D%s\n", user ? user : "NULL");
>>   		printf("Diag: host=3D%s\n", host ? host : "NULL");
>> 		printf("Diag: port=3D%s\n", port ? port : "NONE");
>>   		printf("Diag: path=3D%s\n", path ? path : "NULL");
>
> That's what I'm converging towards, in the end. There is one thing th=
at
> needs hostandport, though: the git protocol host header. But I don't
> really like that parse_connect_url would return user, host, port, *an=
d*
> hostandport. How about "reconstructing" hostandport in that case, add=
ing
> square brackets when the host contains colons?
>
> BTW, the git protocol currently doesn't reject urls with users and
> doesn't seem to handle them properly either. My changes would fix thi=
s
> by separating user and host at the parse_connect_url level, but the
> question then is what to do when there is a user part? die()?
>
> Mike
>
That is what happening:
git clone git://xx@git.kernel.org/pub/scm/git/git.git
Cloning into 'git'...
fatal: Unable to look up xx@git.kernel.org (port 9418) (Name or service=
=20
not known)

And that may explain, why we have different handling of ssh vs git:
The URL-scheme for git:// simply doesn't specify a user name at all.

git://host:[port]/path/to/repo
Knowing that, the "@" will be feed into the name resolver,
and that's OK.
