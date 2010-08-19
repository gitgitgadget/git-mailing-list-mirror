From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: define out variables only used under RE_ENABLE_I18N
Date: Thu, 19 Aug 2010 20:31:47 +0000
Message-ID: <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
	<1282242601-2630-1-git-send-email-avarab@gmail.com>
	<7vtymq74mp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 22:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBmQ-0005XX-CK
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0HSUbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 16:31:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42118 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab0HSUbt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 16:31:49 -0400
Received: by fxm13 with SMTP id 13so1385391fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Swc4eVrzFYfhW8QBZL2NATT0DTA95EeFHNK2xa7P7m4=;
        b=D3NxpDp+qHLWymQmbKAep0mU3T0+0pKEmhK3e0UFw9BVOcIVOYIFWGuhmDgAkNH1SU
         PeZDlr27O/hvVQvqAWvUrtJwbIEuvLh/YHr0n68uU2Jn6GVEJAX3hX6KCYakfHkZBSoq
         PO/pvphPRVmLaXeQSVkPt3RFl21XN8rYKplVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oLr3AZs3Ok2uNb5/i3ARNE0fU2+F+fyb8BFzJqBZOgKYHgMJ8KtAtvWVxmIAymVX9V
         4BlZiIX3CQxXeRFMu8KET3j5ljhmyv0YMk4NRqYiZcEdo91QFTBC4TEgf6iIKUN/a/YA
         XC6lrI23DbZ7BZznHXxtJcvjSIDpXYc1hp7es=
Received: by 10.223.98.66 with SMTP id p2mr366406fan.18.1282249908007; Thu, 19
 Aug 2010 13:31:48 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 13:31:47 -0700 (PDT)
In-Reply-To: <7vtymq74mp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153957>

On Thu, Aug 19, 2010 at 20:02, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Wrap variables that were only used RE_ENABLE_I18N in `#ifdef
>> RE_ENABLE_I18N`. This eliminates compiler warnings when compiling wi=
th
>> NO_REGEX=3DYesPlease.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>
> Hmm, this unfortunately is not enough for me to compile it locally.
>
> In file included from compat/regex/regex.c:77:
> compat/regex/regcomp.c: In function 're_compile_pattern':
> compat/regex/regcomp.c:237: error: old-style function definition
> compat/regex/regcomp.c: In function 're_set_syntax':
> compat/regex/regcomp.c:276: error: old-style function definition
> compat/regex/regcomp.c: In function 're_compile_fastmap':
> compat/regex/regcomp.c:289: error: old-style function definition
> compat/regex/regcomp.c: In function 'regcomp':
> compat/regex/regcomp.c:491: error: old-style function definition
> compat/regex/regcomp.c: In function 'regfree':
> compat/regex/regcomp.c:655: error: old-style function definition
> In file included from compat/regex/regex.c:78:
> compat/regex/regexec.c: In function 'regexec':
> compat/regex/regexec.c:227: error: old-style function definition
> compat/regex/regexec.c: In function 're_match':
> compat/regex/regexec.c:311: error: old-style function definition
> compat/regex/regexec.c: In function 're_search':
> compat/regex/regexec.c:324: error: old-style function definition
> compat/regex/regexec.c: In function 're_match_2':
> compat/regex/regexec.c:337: error: old-style function definition
> compat/regex/regexec.c: In function 're_search_2':
> compat/regex/regexec.c:351: error: old-style function definition
> compat/regex/regexec.c: In function 're_search_2_stub':
> compat/regex/regexec.c:366: error: old-style function definition
> compat/regex/regexec.c: In function 're_search_stub':
> compat/regex/regexec.c:410: error: old-style function definition
> compat/regex/regexec.c: In function 're_copy_regs':
> compat/regex/regexec.c:497: error: old-style function definition
> compat/regex/regexec.c: In function 're_set_registers':
> compat/regex/regexec.c:578: error: old-style function definition
> compat/regex/regexec.c: In function 're_search_internal':
> compat/regex/regexec.c:631: error: old-style function definition
> compat/regex/regexec.c: In function 'prune_impossible_nodes':
> compat/regex/regexec.c:952: error: old-style function definition
> make: *** [compat/regex/regex.o] Error 1
>
> The fix should be straightforward, and I think it should be squashed =
with
> the header ANSIfication you sent earlier.

That's odd. The old regex library only used k&r style function
declerations *except* for regerror, and only then because a variable
name conflicted with a Windows typedef.

Could you compile the old compat/regex library on the same system?
What compiler/version/flags are these?
