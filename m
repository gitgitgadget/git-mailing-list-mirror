From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 07/10] convert: unify the "auto" handling of CRLF
Date: Tue, 26 Apr 2016 18:33:22 +0200
Message-ID: <41d4d5c6-f964-8d3f-0e07-fd98b2f6b71e@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461603397-30873-1-git-send-email-tboegi@web.de>
 <xmqqtwipjx9f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Apr 26 18:33:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5vm-0007D2-4O
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbcDZQdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 12:33:42 -0400
Received: from mout.web.de ([212.227.15.14]:53370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbcDZQdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:33:41 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LtXDY-1btYqa0Yku-010xJI; Tue, 26 Apr 2016 18:33:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqtwipjx9f.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Icx6+HoPHNgL1bjxhuj1iYHaWn2Dcg8frAP25fGjdI4txTGLnJ5
 s9TG0CFQEBnyvfBxzWIPOHZ6gb/CmgfEXl6p8vR/Xtyl2sb9WRrRknj0kyLS2bIl+p7qAef
 dBxvmNfVHdYO+hEIVosS9O+Zrol3bRXrs6cqJhg4BWpqh01sDLp9+CGGa6+/6/T9zt8shYk
 /M2WevyosFEmvNi9QKM8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FbDicsuEyCI=:NTrjfJwWGs07PmKtZ/f2SM
 P3Z6ihWGPZX5e9paugnxCAV45y0sAQsBZFwJGd/UlDnLRneDZBNSiHYW5EK4YOQvw//X5XR7I
 EhHd0ESImQegQ7pE3KDae/l8WiPWT5C1wwzYBG15256491N5SDSunS4/M8cvG52f4SCOXSGC4
 YXsHPIMegmqpdpGAiwo1V35D2BeplcXPOAjb+86H7zuE0kL1bTBjXQYWbZgxTA1/b1mpYlv9g
 30w4aBgZfL1k9bGbI1Yx/yoEKThNhnWZwD+ZDpUtjCqfIV1N8oWmfAcLwyxEcbbUWwQGKk37I
 9a1SmtEM6Cs/X3aScxx6WWAEuuJsBDhxhCqhbWzSh5sHJySAhaJlJj4aPtm2+VSOdhbi2yLot
 XtZIbBGsdxxoVDqQ151PJp1UKjKw58OGl4QnWu0e9r1CmaR7FpzrfWLTagP9isW2M5CEubcL7
 nF15ghBTPAbGPdpOKADhGSpz/YrqJAqTmqEL/N3T8QSx3BpmbQiBzeNdKCKyiWfM005zVAU1C
 YmIBZk2BOvoQv2VNYzIlTYY5CbRBAciTXi3IvAum5rVw3E1tORzkBES4Xuc1xMKcoz3ZnU68I
 l/eY1oy1k74pR8R4YysPlAmEvX+lzgojbu30QKbj2fJxsmVEMyT8Cg/1v9ULR0KEPQ+UkPoxs
 naMLQsB3S96egkaeSH5kJoAKArhD1L1Mr+BtTK/VGAriQSMQjNB2EHdA4Yr/hot2JkFR7y/+V
 vxb3sCbRF/3jE6VBjZ0rJnfulSl84vEV2shZw5HI3m49z0fupXpbnJ0uS0xZpXmq+IiOZRf1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292614>

On 25.04.16 21:37, Junio C Hamano wrote:
> tboegi@web.de writes:
Thanks for review.
Some comments are inline, and a suggestion to a new commit message at t=
he end.
[]
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 4a27ad4..9caf6ae 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -389,13 +389,13 @@ file with mixed line endings would be reported=
 by the `core.safecrlf`
>>  mechanism.
>> =20
>>  core.autocrlf::
>> -	Setting this variable to "true" is almost the same as setting
>> -	the `text` attribute to "auto" on all files except that text
>> -	files are not guaranteed to be normalized: files that contain
>> -	`CRLF` in the repository will not be touched.  Use this
>> -	setting if you want to have `CRLF` line endings in your
>> -	working directory even though the repository does not have
>> -	normalized line endings.  This variable can be set to 'input',
>> +	Setting this variable to "true" is the same as setting
>> +	the `text` attribute to "auto" on all files and core.eol to "crlf"=
=2E
>> +	Set to true if you want to have `CRLF` line endings in your
>> +	working directory and the repository has LF line endings.
>> +	Text files are guaranteed not to be normalized: files that contain
>> +	`CRLF` in the repository will not be touched.
>=20
> This is not a new problem but the last sentence and a half look
> bad.  Telling readers "X is not guaranteed to happen" is not all
> that useful--telling them what happens is.  Also the use of colon
> there is probably ungrammatical.

>=20
> 	Set to true if you want to have CRLF line endings in your
> 	working directory and LF line endings in the repository.
> 	Text files that contain CRLF in the repository will not get
> 	their end-of-line converted.
>=20
> perhaps?
OK, but may be=20
s/end-of-line/line endings/
----------
Set to true if you want to have CRLF line endings in your
working directory and LF line endings in the repository.
Text files that contain CRLF in the repository will not get
their line endings converted.


>=20
>> diff --git a/convert.h b/convert.h
>> index ccf436b..81b6cdf 100644
>> --- a/convert.h
>> +++ b/convert.h
>> @@ -7,7 +7,8 @@
>>  enum safe_crlf {
>>  	SAFE_CRLF_FALSE =3D 0,
>>  	SAFE_CRLF_FAIL =3D 1,
>> -	SAFE_CRLF_WARN =3D 2
>> +	SAFE_CRLF_WARN =3D 2,
>> +	SAFE_CRLF_RENORMALIZE =3D 4
>=20
> Are these bits in a word?  If not where did 3 go?
We use an enum, sometimes mixed with an int, so my brain automatically
changed it into a bit field.
"3" is probably better.
>=20
>> diff --git a/convert.c b/convert.c
>> index 24ab095..3782172 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -227,7 +227,9 @@ static enum eol output_eol(enum crlf_action crlf=
_action)
>>  		return EOL_LF;
>>  	case CRLF_UNDEFINED:
>>  	case CRLF_AUTO_CRLF:
>> +		return EOL_CRLF;
>=20
> Hmph, do we want UNDEFINED case to return EOL_CRLF here?
>=20
>>  	case CRLF_AUTO_INPUT:
>> +		return EOL_LF;
One of the compilers claimed that UNDEFINED was not handled in switch-c=
ase.
A Warning may be better ?=20
>>  	case CRLF_TEXT:
>>  	case CRLF_AUTO:
>>  		/* fall through */
>=20
How about this as the commit message:
--------------------------------------

convert: unify the "auto" handling of CRLF

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Before this change,
$ echo "* text=3Dauto" >.gitattributes
$ echo "* eol=3Dcrlf" >>.gitattributes
would have the same effect as
$ echo "* text" >.gitattributes
$ git config core.eol crlf

The 'eol' attribute had higher priority than 'text=3Dauto'. Binary
files may had been corrupted, and this is not what users expect to happ=
en.

Make the 'eol' attribute to work together with 'text=3Dauto'.

With this change

$ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
has the same effect as
$ git config core.autocrlf true

and

$ echo "* text=3Dauto eol=3Dlf" >.gitattributes
has the same effect as
$ git config core.autocrlf input
