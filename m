Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A938C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiCATuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiCATtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:49:19 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946259380
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:47:51 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4K7STB6YWcz5tlB;
        Tue,  1 Mar 2022 20:47:42 +0100 (CET)
Message-ID: <5df2c9ce-b243-0173-befb-e13a6a74e387@kdbg.org>
Date:   Tue, 1 Mar 2022 20:47:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.22 um 16:54 schrieb Jaydeep P Das:
> diff --git a/t/t4018/kotlin-nested-fun b/t/t4018/kotlin-nested-fun
> new file mode 100644
> index 0000000000..12186858cb
> --- /dev/null
> +++ b/t/t4018/kotlin-nested-fun
> @@ -0,0 +1,9 @@
> +class LEFT{
> +	class CENTER{
> +		fun RIGHT(  a:Int){
> +			//comment
> +			//comment
> +			ChangeMe
> +		}
> +	}
> +}

Nice move to include a test with an indented key phrase. The t4018 test
cases all look fine. I don't speek Kotlin, though, so...

> diff --git a/t/t4034/kotlin/expect b/t/t4034/kotlin/expect
> new file mode 100644
> index 0000000000..80eea3e386
> --- /dev/null
> +++ b/t/t4034/kotlin/expect
> @@ -0,0 +1,33 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index e8a199a..e6ebebb 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,16 +1,16 @@<RESET>
> +println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<RED>0xabcdef<RESET><GREEN>) (0xaybcdef)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
> +[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
> +!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> shl <RED>b a<RESET><GREEN>y x<RESET> shr <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
> +<RED>a and b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x xnd y<RESET>
> +<GREEN>x<RESET>^<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> or <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>&&<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>||<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>,y
> diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
> new file mode 100644
> index 0000000000..e6ebebb5e9
> --- /dev/null
> +++ b/t/t4034/kotlin/post
> @@ -0,0 +1,16 @@
> +println("Hello World?")
> +(1) (-1e10) (0xaybcdef) 'y'
> +[x] x->y x.y
> +!x x.inv() x*y x&y
> +x*y x/y x%y
> +x+y x-y
> +x shl y x shr y
> +x<y x<=y x>y x>=y
> +x==y x!=y x===y
> +x xnd y
> +x^y
> +x or y
> +x&&y
> +x||y
> +x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
> +x,y
> diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
> new file mode 100644
> index 0000000000..e8a199adb0
> --- /dev/null
> +++ b/t/t4034/kotlin/pre
> @@ -0,0 +1,16 @@
> +println("Hello World!\n")
> +1 -1e10 0xabcdef 'x'
> +[a] a->b a.b
> +!a a.inv() a*b a&b
> +a*b a/b a%b
> +a+b a-b
> +a shl b a shr b
> +a<b a<=b a>b a>=b
> +a==b a!=b a===b
> +a and b
> +a^b
> +a or b
> +a&&b
> +a||b
> +a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
> +a,y

I know you just copied an existing test case. But actually, it misses
the important parts of the word regex patterns. In particular, it only
tests that a change of a to x is found, but does not test that the
operators are not split into individual characters. Please have a look
at my series 1cf93847c1ed~..386076ec92c7 and in particular 1cf93847c1ed
to see what you actually want to test. For example, you could test a
change from a+=b to a-=b, i.e., that operators += and -= are not split
into +, -, and =.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..f23f098f19 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,13 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*[ \t]*)$",

I would guess that the trailing [ \t]* is pointless and always empty,
because it is covered by the preceding .*, so you can remove it.

> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"

The first part intends to match integers and floatingpoint numbers. Word
regex can be loose. This one, however, is too loose. For example, it
treats  -e+2 as a single token, but that is actually a whole expression
consisting of several tokens and is not unlikely to occur in real code.
See also 350b87cd6585.

I am pretty sure that, e.g., -1 and +2.5 are both two tokens each, i.e.,
the sign is not part of the number token.

Also, it looks like 3.0e5 is a floating point number; is 3.0E5 not?

> +	 "|[-+*/<>%&^|=!]="
> +	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
