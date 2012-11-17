From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Sat, 17 Nov 2012 12:46:27 +0100
Message-ID: <CAMP44s3FFEGJDa6cnwVY0aJkoU_-OdvDPD0gPQtrUqdY2JCpWw@mail.gmail.com>
References: <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
	<20121116212224.GA12052@goldbirke>
	<CAMP44s3pi0iDOho_qYZEutebDNDveWWv6wEAs-C1bs1A_yL+Sg@mail.gmail.com>
	<20121117105605.GB12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 12:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgrB-0003H1-NH
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab2KQLq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:46:28 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60584 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2KQLq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 06:46:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3602266obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VLboHlw77cXoCOKDOw3WvWEzx/0Mez2z/CegvuElvD4=;
        b=yNbx3ZtcEVvCPxhrU1/ezUtK3GkgPtiLzBf+k2nVjrwAIE9EjXycEG6ewcHpJRDqpg
         Ula0jCxeJjHw4FC+5Q8JedNqhw+43V9smsc64ve9FpbfvSac2KKnd7kWtw1vkaUobXCB
         B8obt/BHGHrPcu/4pnQCDa8cV2vpWB+R18lhsM8J6C19o2SjcOFj7x8TeUpnXycqLkWx
         jL17bUuEQm9nPgx08vetfIVB3Dh4nvXgxMx2gZ8TlTqloeouB4jiYrpG4LVe01YCRgp6
         OxOmEMpi7clkRJzZxwQLW2MV+kbVwWRSv6+LsFtNNs8O0Z5gE3Dqb3uo2LmtI6E3Z3fW
         Mo/A==
Received: by 10.60.14.101 with SMTP id o5mr3705682oec.85.1353152787189; Sat,
 17 Nov 2012 03:46:27 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 03:46:27 -0800 (PST)
In-Reply-To: <20121117105605.GB12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209951>

On Sat, Nov 17, 2012 at 11:56 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Fri, Nov 16, 2012 at 10:46:16PM +0100, Felipe Contreras wrote:

>> But even in that case, if push comes to shoves, this zsh wrapper can
>> ultimately read COMPREPLY and figure things backwards, as even more
>> previous versions did:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/189310
>
> Even better.  I was just going to propose that zsh's completion could
> just read the contents of COMPREPLY at the end of _git() and _gitk(),
> because this way no zsh-induced helper functions and changes would be
> needed to the completion script at all.

I would rather modify the __gitcomp function. Parsing COMPREPLY is too
cumbersome.

> However, running the completion script with Bash would also prevent
> possible issues caused by incompatibilities between the two shells
> mentioned below.

It could, but it doesn't now.

>> >> This is the equivalent of what Marc is doing, except that zsh has=
 no
>> >> problems running bash's code. Note there's a difference with zsh'=
s
>> >> emulation bash (or rather bourne shell, or k shell), and zsh's
>> >> emulation of bash's _completion_. The former is fine, the later i=
s
>> >> not.
>> >
>> > There are a couple of constructs supported by Bash but not by zsh,
>> > which we usually try to avoid.
>>
>> Yes, and is that a big deal?
>
> Not that big, but I wanted to point out that it's not "fine" either.
> Just a slight maintenance burden, because we have to pay attention no=
t
> to use such constructs.

Do we have to pay attention?

I say when we encounter one of such maintenance burden issues _then_
we think about it. In the meantime for all we know sourcing bash's
script from zsh is fine.

--=20
=46elipe Contreras
