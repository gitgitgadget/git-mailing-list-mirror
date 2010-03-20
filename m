From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] tag -v: use =?utf-8?B?4oCY?=
	=?utf-8?Q?git_verify-tag=E2=80=99?= without dash
Date: Sat, 20 Mar 2010 16:29:33 -0500
Message-ID: <20100320212932.GA30010@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
 <20100320051148.GA24791@progeny.tock>
 <201003201701.16820.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:28:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6Ds-0007EG-8F
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab0CTV2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 17:28:39 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:37254 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0CTV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:28:38 -0400
Received: by ywh2 with SMTP id 2so1172824ywh.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mdUkqUnXrUNApBorSh7xOn1jVBqCFOF9cQT8yTnhpBo=;
        b=xIdbb7IcY+YVP2URKzbyhvEEuAHpOBfNQw23inHHzitC/GW3YKDk6CZoIaPKOETxVp
         S9Qax+HkYt4Uy1TtGCNgZoDAx4cfBvlZBFQ3W9PHWYqH5FJNupRZj4ntYkpmXO2VrLXK
         bzhnsnkerU+hBGiLexX+pIfAiGtqhVbXPtSOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=joE7G+5gRDJKo4exe7DqdlIt2/+cEbc2lWTwkUffHx1m6SW1yYL/8sgL9oKfE29M1X
         XY/2QQGHFuzOEn0qGwS956thicd94o86qcKZXoSMkZDdnkLrk1DKOqk21kVU7kPVHP8t
         yxtfBRhJDQSl5pq1OSmXe5OlZgD8hePM6esyg=
Received: by 10.150.174.18 with SMTP id w18mr1528505ybe.87.1269120517396;
        Sat, 20 Mar 2010 14:28:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1145013iwn.0.2010.03.20.14.28.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 14:28:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201003201701.16820.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142756>

Johannes Sixt wrote:
> On Samstag, 20. M=C3=A4rz 2010, Jonathan Nieder wrote:

>> -	const char *argv_verify_tag[] =3D {"git-verify-tag",
>> +	const char *argv_verify_tag[] =3D {"git", "verify-tag",
>>  					"-v", "SHA1_HEX", NULL};
>> -	argv_verify_tag[2] =3D sha1_to_hex(sha1);
>> +	argv_verify_tag[3] =3D sha1_to_hex(sha1);
>>
>>  	if (run_command_v_opt(argv_verify_tag, 0))
>>  		return error("could not verify the tag '%s'", name);
>
> This should rather be changed to run_command_v_opt(..., RUN_GIT_CMD).=
 See=20
> other examples in the code.

Neat.  Thanks for the pointer.

> Oh, you remove this in a later patch. Then why have this patch at all=
?

If the rest of the patches go in the right direction, this one should
be dropped.  I should presented it as two alternative series instead:
one that follows the appropriate calling convention here, and one that
libifies verify_tag.

In other words, no good reason at all; thanks for pointing it out.
I=E2=80=99ll send a version of patch 4/5 that doesn=E2=80=99t depend on=
 this one in a
moment.

Jonathan
