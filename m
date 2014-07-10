From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 22:06:58 +0200
Message-ID: <CAOvwQ4jYkjscTXW5x+Ee=U_Ju0Pjpkkd0wQXiKvoiP3CGhUGXw@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 22:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Kd7-0000Oi-2z
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbaGJUHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:07:40 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60039 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbaGJUHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:07:38 -0400
Received: by mail-ob0-f169.google.com with SMTP id nu7so111886obb.14
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=FGOCo4OTEEUyVls2nnco2LkvDw8BeqI0cQEZ52vmeeY=;
        b=dHoR77CSAYMkl5f/Tf3q4taOVM5u7Gnblu/PMQxX9fXNU9Vdgas8S2c385lQWhb5dn
         9XsBGy5D07FdyqBH2OwgspPnXxaxjrzqXDeuZRwV+lhxR0mNeLDBhWae3ea0D376Lwuu
         swZAH+X/CqbU6U45P2OklQdpdL9VwDtgXnZ0jGrcfa5RnlltLUnn8xY0ujEW84IfcDRX
         e6hE4OdFMdXUN1frhi9JTGPXJjIBb7aC81wl9DKlmijFuND+GNq+/EhJ/0maeTnJONGq
         XHhgA6zk/wlJSYlvkzfjA/FEYP2m75QnWar0pX+HV8uYxm07S2jo9dltqACGdKKIAmdB
         f2Kg==
X-Received: by 10.182.200.132 with SMTP id js4mr55779982obc.3.1405022858212;
 Thu, 10 Jul 2014 13:07:38 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 13:06:58 -0700 (PDT)
In-Reply-To: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253205>

On Thu, Jul 10, 2014 at 9:59 PM, Tuncer Ayaz wrote:
> The changes in 745224e0 don't seem to build here with gcc-4.9 on
> linux x64_64. Any idea what's wrong?

s/x64_64/x86_64/

Should have written amd64 to avoid the typo :).

>     CC credential-store.o
> In file included from /usr/lib/.../xmmintrin.h:31:0,
>                  from /usr/lib/.../emmintrin.h:31,
>                  from git-compat-util.h:708,
>                  from cache.h:4,
>                  from credential-store.c:1:
> /usr/lib/.../mmintrin.h: In function '_mm_cvtsi32_si64':
> /usr/lib/.../mmintrin.h:64:3: error: can't convert between vector
> values of different size
>    return (__m64) __builtin_ia32_vec_init_v2si (__i, 0);
>    ^
> /usr/lib/.../mmintrin.h: In function '_mm_cvtsi64_si32':
> /usr/lib/.../mmintrin.h:107:10: error: incompatible type for argument
> 1 of '__builtin_ia32_vec_ext_v2si'
>    return __builtin_ia32_vec_ext_v2si ((__v2si)__i, 0);
>           ^
>
> [...]
>
> In file included from /usr/lib/.../emmintrin.h:31:0,
>                  from git-compat-util.h:708,
>                  from cache.h:4,
>                  from credential-store.c:1:
> /usr/lib/.../xmmintrin.h: In function '_mm_add_ss':
> /usr/lib/.../xmmintrin.h:127:19: error: incompatible type for argument
> 1 of '__builtin_ia32_addss'
>    return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
>                    ^
> /usr/lib/.../xmmintrin.h:127:3: note: expected '__vector(4) float' but
> argument is of type '__m128'
>    return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
>    ^
> /usr/lib/.../xmmintrin.h:127:19: error: incompatible type for argument
> 2 of '__builtin_ia32_addss'
>    return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
>
>                    ^
>
> [...]
>
> /usr/lib/.../emmintrin.h:1455:3: error: incompatible type for argument
> 2 of '__builtin_ia32_movntpd'
>    __builtin_ia32_movntpd (__A, (__v2df)__B);
>    ^
> /usr/lib/.../emmintrin.h:1455:3: note: expected '__vector(2) double'
> but argument is of type '__m128d'
> Makefile:1983: recipe for target 'credential-store.o' failed
> make: *** [credential-store.o] Error 1
