From: Misha Penkov <misha.penkov@gmail.com>
Subject: Re: Potential bug: truncated diff output
Date: Thu, 16 Jan 2014 16:06:23 +0900
Message-ID: <CAAyYaWop5ZqXTi2wr+mGBXc4vRpPuoH8Y4rs88+ktV7DL2yjYA@mail.gmail.com>
References: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
	<52D78244.7020406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 16 08:07:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3h25-00009G-5g
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 08:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaAPHGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 02:06:25 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:46503 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaAPHGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 02:06:24 -0500
Received: by mail-ob0-f181.google.com with SMTP id uy5so2283526obc.26
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oLmhtrTjBfBKI/EuhL5V8aWUAO+5uy+btTqDOWAuOZA=;
        b=wJh0+FFh1Dps+PW0800xYtMhoNYov30NQT+4VUWe51TO277RR4PvedxDd9UChmiutH
         MOmwmS5Uo6qBtVYEq7d8r/BLO2ifCgjItVbZ3rh0xsRodr6wWLIvWdg5YF8NC74vv9bU
         ip/hhuTN7k3Ors/7cuBe8Kvpl1BV2tUz4BYaELsDJ68s6upgLvnoP/urJ3uDgjjii00d
         udM5LgyA0aG0JHBUA0H/E4yFUumg4DnB1QlLL/lHna7il9grMQG/M7f/FcSw82ToN0Za
         n1m3KxlYpnqK/hnHRPXWWaCiVz5+NqaE9mB6LFwjrGKxydtQ0YUcaRkMkCBu3uPqQBOn
         HZ+w==
X-Received: by 10.182.114.132 with SMTP id jg4mr5631668obb.29.1389855983599;
 Wed, 15 Jan 2014 23:06:23 -0800 (PST)
Received: by 10.60.64.98 with HTTP; Wed, 15 Jan 2014 23:06:23 -0800 (PST)
In-Reply-To: <52D78244.7020406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240508>

Ah, I see. Thank you.

Michael

On 16 January 2014 15:55, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 1/16/2014 7:19, schrieb Misha Penkov:
>> I have a file in a git repo. It has changed during the last two
>> commits. I want to see the changes made in these two commits. The
>> following command should work:
>>
>>     git diff HEAD^^
>>
>> but that doesn't get me the expected results. Read on for details.
>>
>> Last commit: I changed some stuff towards the end of the file, for
>> example, around line 3145. Here's the full diff (it's here for
>> reference, don't bother reading all of it):
>>
>>     $git diff HEAD^ HEAD ieicej.cls
>>     diff --git a/ieicej.cls b/ieicej.cls
>>     index ecf8beb..01debd9 100644
>>     ...
>>     @@ -3145,11 +3145,11 @@
>>        \kern 2.715\p@}
>>
>>      \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
>>     -  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}=
$}}
>>     +  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$}}
>>
>>      \newcommand\@makefntext[1]{\parindent1zw
>>       \noindent\hbox{\kern-.5zw
>>     -  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\h=
box to 1zw{\hss =EF=BC=9A\hss}}#1}
>>     +  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hbox to 1z=
w{\hss =EF=BC=9A\hss}}#1}
>>
>>      \def\thefootnote{\@arabic\c@footnote}
>>      \def\thempfootnote{\@fnsymbol\c@mpfootnote}
>
> Here, you revert the change...
>
>> Here's the second-last commit. I changed some things around line 171=
4.
>> Full commit diff (again, for reference only):
>>
>>     $git diff -p HEAD^^ HEAD^ ieicej.cls
>>     diff --git a/ieicej.cls b/ieicej.cls
>>     index 1c3b947..ecf8beb 100644
>>     ...
>>     @@ -3135,11 +3145,11 @@
>>        \kern 2.715\p@}
>>
>>      \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
>>     -  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$}}
>>     +  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}=
$}}
>>
>>      \newcommand\@makefntext[1]{\parindent1zw
>>       \noindent\hbox{\kern-.5zw
>>     -  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hbox to 1z=
w{\hss =EF=BC=9A\hss}}#1}
>>     +  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\h=
box to 1zw{\hss =EF=BC=9A\hss}}#1}
>>
>>      \def\thefootnote{\@arabic\c@footnote}
>>      \def\thempfootnote{\@fnsymbol\c@mpfootnote}
>
> ... that you made here.
>
> Unsurprisingly, the net effect is no change in that area -- and git d=
iff
> tells you exactly that.
>
> -- Hannes
