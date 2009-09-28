From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Mon, 28 Sep 2009 19:50:18 +1000
Message-ID: <d2e97e800909280250j4e432deeo230cbc622b6e690a@mail.gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 
	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 
	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 
	<4AB89B7F.3050902@gmail.com> <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com> 
	<4AC05BA5.4050106@viscovery.net> <d2e97e800909280047l5da52ffdxd86589cda4542f46@mail.gmail.com> 
	<4AC06F65.1020301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 11:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsCvO-000893-4J
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 11:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbZI1Juf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbZI1Juf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 05:50:35 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:50671 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZI1Jue convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 05:50:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so4669008and.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oa5waJXXZmIdGufbrqqt8DRAWegkqMpO/AE+t0ShS8k=;
        b=JFa969ham3RnPSCF/FH438IacJmWVG2bPUD8HnXyMHF1L4WtXyEPxZplPCgeZ3kFkI
         W7hazmc0haWdcQ3uTq1QXBvM+ffC15fVM8H2T4vI1bwXj3umfYRSN72LVF11o1wFLlZQ
         XdWxxw6cF9J6D9xQZJo2dLoL+1n9b6iby8C30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WNLdAIEBGk5M9S2LK17a5JyJX9TJBEe9jnpL99EMV8SCy0i028+4fri0zgnMPW1lsg
         b8yhmMseo+ac7zMupBnaAWGsOhlqDQQF9nMxCv5WZgnwFxyPgcd6jmYEupN/m4kH0Ta6
         4yxkVhN8wBtUtwW1zelKcuZnBPPD1AJ05btJ0=
Received: by 10.100.81.1 with SMTP id e1mr2731145anb.73.1254131438064; Mon, 28 
	Sep 2009 02:50:38 -0700 (PDT)
In-Reply-To: <4AC06F65.1020301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129240>

2009/9/28 Johannes Sixt <j.sixt@viscovery.net>:
> Michael Wookey schrieb:
>> 2009/9/28 Johannes Sixt <j.sixt@viscovery.net>:
>>> Michael Wookey schrieb:
>>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>>> Michael Wookey said the following on 22.09.2009 11:17:
>>>>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>>>>> Michael, how are you trying to compile git? With the IDE or the
>>>>>>> GNU Make? Which version of MSVC? If you use the IDE, can you ma=
ke
>>>>>>> sure it doesn't contain the UNICODE define in the compiler
>>>>>>> section of the properties of the projects?
>>>>>> I'm using the VS 2008 Professional IDE (the solution doesn't ope=
n
>>>>>> in VS 2005). I made no changes to the build settings. In the
>>>>>> Preprocessor section of the project, UNICODE is defined.
>>>>> Were these projects generated with the Vcproj generator in
>>>>> contrib/buildsystem, with the Qmake generator, or the projects fr=
om Frank's
>>>>> repo?
>>>> The project was generated from the vcproj generator in
>>>> contrib/buildsystem from git.git/master.
>>> What's the status of this?
>>
>> I was hoping that this gets included into git.git because it fixes a
>> real issue with MSVC builds. Since Junio is away, perhaps Shawn can
>> take the patch into his interim tree?
>>
>> BTW - would you mind giving this patch an ack?
>
> As I said, the patch looks fine. However, in the commit message you s=
ay:
>
> =C2=A0MSVC builds define UNICODE which results in the "WIDE" variatio=
n of
> =C2=A0Win32 API's being used.
>
> But since Marius has built the code without your patch, this justific=
ation
> must be incomplete. I won't give a formal Ack until this is clarified=
=2E
>
> Please work with Marius to figure out why your build uses UNICODE whi=
le
> Marius's doesn't.

Well, the command line builds have always worked fine. The definition
of UNICODE was limited to building in the IDE. That detail was
unfortunately missing from the original commit message.

It seems that the project file that is generated by Vcproj.pm
(inadvertently?) defines UNICODE. Perhaps the patch below is better
than my original workaround. If you think so, I'll create a formal
patch.

[ sorry if the patch wraps ]

diff --git a/contrib/buildsystems/Generators/Vcproj.pm
b/contrib/buildsystems/Generators/Vcproj.pm
index 00ec0c1..a648756 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -173,7 +173,7 @@ sub createLibProject {
                                Optimization=3D"0"
                                InlineFunctionExpansion=3D"1"
                                AdditionalIncludeDirectories=3D"$includ=
es"
-
PreprocessorDefinitions=3D"UNICODE,WIN32,_DEBUG,$defines"
+                               PreprocessorDefinitions=3D"WIN32,_DEBUG=
,$defines"
                                MinimalRebuild=3D"true"
                                RuntimeLibrary=3D"1"
                                UsePrecompiledHeader=3D"0"
