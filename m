From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Fix memory corruption when .gitignore does not end by \n
Date: Thu, 21 Jan 2010 06:08:37 +0000
Message-ID: <57518fd11001202208x3dfd68f6p793f77cb85534923@mail.gmail.com>
References: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com> 
	<1263996556-9712-1-git-send-email-pclouds@gmail.com> <7v3a20367d.fsf@alter.siamese.dyndns.org> 
	<fcaeb9bf1001201738x5cd374c2o280ec42d6d65c0f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 07:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXqEA-0004xH-KI
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 07:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0AUGJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2010 01:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499Ab0AUGJE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 01:09:04 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:53656 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab0AUGJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 01:09:03 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44553)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NXqE5-0003Ta-2f
	for git@vger.kernel.org; Thu, 21 Jan 2010 01:09:05 -0500
Received: by ewy19 with SMTP id 19so1989575ewy.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 22:08:57 -0800 (PST)
Received: by 10.216.89.200 with SMTP id c50mr371131wef.137.1264054137190; Wed, 
	20 Jan 2010 22:08:57 -0800 (PST)
In-Reply-To: <fcaeb9bf1001201738x5cd374c2o280ec42d6d65c0f7@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137631>

2010/1/21 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On 1/21/10, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>> =C2=A0> =C2=A0This patch causes a crash for me. Not sure if it does =
for anybody else.
>>
>>
>> I am puzzled. =C2=A0What do you mean by this? =C2=A0If this patch ma=
kes the code
>> =C2=A0crash, then it is not a fix. =C2=A0Is this meant as "Jonathan,=
 can you try this
>> =C2=A0patch and tell me what happens, so that I can diagnose the iss=
ue better?"
>> =C2=A0patch?
>
> I mean the t3001 patch in comment part, which removes \n at the end o=
f
> .gitignore and crashes the unmodified git.
>
> IOW I found a problem and this patch (not the t3001 one) should fix
> it. Not sure if this causes Jonathan problem though.
>
>> =C2=A0Is it better/safer to revert the entire nd/sparse topic from t=
he master in
>> =C2=A0the meantime before we know what is going on?
>
> I would wait for Jonathan response. If this is not the cause, probabl=
y
> safer to revert it.
> --
> Duy
>

Think it's all fixed after applying this patch - at least, I can no
longer reproduce the crash, whereas I was able to make it fail ~90% of
the time before.
