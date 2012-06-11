From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: [PATCH v3] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 21:12:17 +0200
Message-ID: <edf83e30636b67d2b95bf1df8519cdcd@telesun.imag.fr>
References: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <vpqehpl4qm0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeA2N-0005ja-M8
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab2FKTMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:12:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55052 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab2FKTMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:12:22 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BJ3N5b010809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 21:03:23 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BJCH9d015408;
	Mon, 11 Jun 2012 21:12:17 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5BJCHPh016879;
	Mon, 11 Jun 2012 21:12:17 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5BJCHUL016878;
	Mon, 11 Jun 2012 21:12:17 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <vpqehpl4qm0.fsf@bauges.imag.fr>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 21:03:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BJ3N5b010809
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1340046205.99978@/JOZzuhD4cGFBEgfj8KDFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199707>

On Mon, 11 Jun 2012 21:04:39 +0200, Matthieu Moy wrote:
>> Subject: Re: [PATCH v3] add 'git credential' plumbing command
>
> I guess you mean v2.
>

Sorry is a miss typing.

> Javier.Roucher-Iglesias@ensimag.imag.fr writes:
>
>> Changes in the version2 vs version1:
>
> These should not go to the commit message, but below the --- below=20
> (and
> before the diffstat).
>
>> Adding to the next patch, version3:
>> =C2=B7 Tests files
>
> If the todo-list isn't empty, then mark your patch as "RFC".
>
>> --- /dev/null
>> +++ b/Documentation/git-credential.txt
>> @@ -0,0 +1,74 @@
>> +git-credential(7)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +git-credential - Provides and store user credentials to git
>
> Provides -> Provide
>
> I'd remove the "to git" part.
>

Changed it


> Other than that, I prefer Jeff's version sent yesterday. Any reason=20
> not
> to use it?
>
> The command still isn't listed in "man git", aka=20
> Documentation/git.txt
> (I already mentionned it)
>
>> +	if (!strcmp(op, "fill")) {
>> +		credential_fill(&c);
>> +		if (c.username)
>> +			printf("username=3D%s\n", c.username);
>> +		if (c.password)
>> +			printf("password=3D%s\n", c.password);
>> +	}
>
> See Jeff's remarks. It makes sense to output all fields here
> (protocol, path, ...).

okay for the next patch i will add (protocol, path, ..)
