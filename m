Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D7190485
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088046; cv=none; b=BjtiQWJYODzxMBhG4ECX+uweFmBKtzUuTKkw9g5UF8L4hg7SS3vQra7UPCLv6/D7R3SoumKabgVxiEnTHVWKgLqjVTFqczVwD/znPqsBpFj0NTkGIRb6CO1fJH31XemITda+2/yhIFJlYAwfC7pwdUfd3sSkR6/huHTXrK2VtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088046; c=relaxed/simple;
	bh=vw+5hrPYrgD6W0DzgeIWlHGv28MojS4VzGsSzyHItEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROsaaU5x1wssC1KW9+AmqG8wpXpzEmyWqSHHuxPVW3GKH8vpHc/UpyhixWzwF8JXzOCgi+AznpTLtMI4EKZdSZlIukPZ3zh7aC+1isUEfhDzsFj34nL9bpcSJygvp1UU5avQ8posGKXGXDXg9L9PylZDLgtf5VIf5LVFK7t2oQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeBRKxxF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeBRKxxF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso7314975e9.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743088042; x=1743692842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mO/3XDKef3HU6uc525DsjL8Tn8ixXxa0xkpqe2lGJGQ=;
        b=IeBRKxxF1mXbZPbRzMRu3dxz+2yr2+RbenqXW8WCGO3BDLcGc3gm6NvAbwZAm3tWGR
         /OVBnghLN5+XEhSDoRTcU/pyontbxVUmeiOvsbN/RSdsferY0AboBbnVkrg+E8Q9UPh1
         yWuLLy0as4lORY6j10yIpNpM6HcC20Ya+JtnDP1IR8oiqPPAkxiLgccAJFf8YH6hDjx0
         wGC9pk+8GwcrfzvEi5qicLOsbpZV0HIrSWfiPlE2TgVepVuZABiYfKOCPlSB03KP/wsT
         QaN6wb39ITC0q0x7MveXtSbYCCs37C0fpHvamxSIEjt+VLD3seOOPTYHZu7sVKGa6cOE
         aWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743088042; x=1743692842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mO/3XDKef3HU6uc525DsjL8Tn8ixXxa0xkpqe2lGJGQ=;
        b=M4KlIoKuXs3L5TktwFFeBp2Z1yKFiXX+JiPoCS3BkzdYjjhJUjfhdnL4KbjR4F8Nkc
         Hd94XyeHLQCujFlG2hd3vOCqybX1WUxWZ4VRoiixBQLjn/W8108998xzxHlEeB9YvHWZ
         0iuW244229YAKQiC/M/QnQGxPtoAFFuDdeF2+u9iPZAX5HTH+0fZwPBTAefPiHw/ESaA
         dWxqjpXpIXx69tixXOki0rObDzx3jwsi3/GnCxxPCJ8XnrW8JML05yldn8vYqJkxklpM
         zKcnEZ5/xi+ZEMkHLd2oxRtcHfxuq2SRiG2MKjxHPqKy0yw5wgkrJhnQLPh2RIrIRz6g
         7tsA==
X-Forwarded-Encrypted: i=1; AJvYcCWHOW5+CLdQcC150j79t2CVmAOm+PdGNfzv7di0jlrETpLExFhHSvgZAoY7yainysndXTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQA8n/YuGZZhHfOb53kSllxbfMcatc5HLOIId040NKxybJeE6
	1QZ6P0Zt2xLk7kXMVoY2gaCVpMragD0gUvpL94G7cN35m03lLbwV
X-Gm-Gg: ASbGncv9/MOIYdn/WCcr8xr9pWgJERzznIiURLBJrkA817USACTyg63rriDykKBK3c9
	hbPwqKHys5k3gz6eZfXh3wVKcTsTTbDHjYxb36wqx/UsSSvA4Wx9qSFaVnWosEB7s0eZOHfUHYG
	+nH+CtBhlB4Hj8FLnkC5Ymcy2ftrqXh/hEqvJsanpA4wO8VnshEVYXn6708VbxTpSgg2tc7xklY
	KDInO/db7VctbeBHes8QF+3PaATiAf4P2WOjse7nGRyeT2/AxAwaTb+Xp0J9Ehgb/gwz0ISDCIc
	PmrC9vLWTxLqYhDLVx31lMI8W+9JrJlZXZof+/ukIaF0wE4jLiXqYDQ1DrCEMnb3BM3+PPF3GmS
	IkUqCZa1mGp7zOzbi8yZH
X-Google-Smtp-Source: AGHT+IEXozZchmbQpNx53nJLZbuhgKTx3f0PxDEw9Bs0K1YdTJX2PErtTnmeKNyeZ61Ot9/TiL5IHw==
X-Received: by 2002:a7b:c4d4:0:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43d8e633e4dmr3473065e9.5.1743088041319;
        Thu, 27 Mar 2025 08:07:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82a041d4sm42753685e9.0.2025.03.27.08.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 08:07:20 -0700 (PDT)
Message-ID: <504e63df-77d2-4cd0-bdcc-bd9949d34ce5@gmail.com>
Date: Thu, 27 Mar 2025 15:07:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/10] Avoid the comma operator
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Chris Torek <chris.torek@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 27/03/2025 11:52, Johannes Schindelin via GitGitGadget wrote:
> 
> Changes since v2:
> 
>   * Made the sed construct in detect-compiler portable (thanks, Eric
>     Sunshine!)
>   * The majority of the feedback disagreed with the more compact format in
>     diff-delta.c, so I changed it to the long format (thanks, Phillip Wood!)
>   * The more succinct and safer, but less readable, cast in the loop
>     condition of the dowild() function was replaced with the goto-based
>     alternative I had mentioned as a possibility in the commit message
>     (thanks, Phillip Wood!)
>   * I adjusted the style of my compat/regex/ patch to the surrounding code's.
>   * The -Wcomma option is now used in Meson-based clang builds, too (thanks,
>     Patrick Steinhardt!)

The range-diff below looks good to me, thanks for making our code base 
clearer.

Best Wishes

Phillip

> Range-diff vs v2:
> 
>    1:  913c7a0d296 =  1:  913c7a0d296 remote-curl: avoid using the comma operator unnecessarily
>    2:  37ff88b8275 =  2:  37ff88b8275 rebase: avoid using the comma operator unnecessarily
>    3:  f601f4e74a5 =  3:  f601f4e74a5 kwset: avoid using the comma operator unnecessarily
>    4:  f60ebe376e1 =  4:  f60ebe376e1 clar: avoid using the comma operator unnecessarily
>    5:  7239078413f =  5:  7239078413f xdiff: avoid using the comma operator unnecessarily
>    6:  5e0e8325620 !  6:  045d695d73e diff-delta: explicitly mark intentional use of the comma operator
>       @@ Metadata
>        Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        
>         ## Commit message ##
>       -    diff-delta: explicitly mark intentional use of the comma operator
>       +    diff-delta: avoid using the comma operator
>        
>            The comma operator is a somewhat obscure C feature that is often used by
>            mistake and can even cause unintentional code flow. That is why the
>       @@ Commit message
>            Intentional uses include situations where one wants to avoid curly
>            brackets around multiple statements that need to be guarded by a
>            condition. This is the case here, as the repetitive nature of the
>       -    statements is easier to see for a human reader this way.
>       +    statements is easier to see for a human reader this way. At least in my
>       +    opinion.
>        
>       -    To mark this usage as intentional, the return value of the statement
>       -    before the comma needs to be cast to `void`, which we do here.
>       +    However, opinions on this differ wildly, take 10 people and you have 10
>       +    different preferences.
>        
>       +    On the Git mailing list, it seems that the consensus is to use the long
>       +    form instead, so let's do just that.
>       +
>       +    Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## diff-delta.c ##
>        @@ diff-delta.c: create_delta(const struct delta_index *index,
>       + 			op = out + outpos++;
>         			i = 0x80;
>         
>       - 			if (moff & 0x000000ff)
>       +-			if (moff & 0x000000ff)
>        -				out[outpos++] = moff >> 0,  i |= 0x01;
>       -+				(void)(out[outpos++] = moff >> 0),  i |= 0x01;
>       - 			if (moff & 0x0000ff00)
>       +-			if (moff & 0x0000ff00)
>        -				out[outpos++] = moff >> 8,  i |= 0x02;
>       -+				(void)(out[outpos++] = moff >> 8),  i |= 0x02;
>       - 			if (moff & 0x00ff0000)
>       +-			if (moff & 0x00ff0000)
>        -				out[outpos++] = moff >> 16, i |= 0x04;
>       -+				(void)(out[outpos++] = moff >> 16), i |= 0x04;
>       - 			if (moff & 0xff000000)
>       +-			if (moff & 0xff000000)
>        -				out[outpos++] = moff >> 24, i |= 0x08;
>       -+				(void)(out[outpos++] = moff >> 24), i |= 0x08;
>       -
>       - 			if (msize & 0x00ff)
>       +-
>       +-			if (msize & 0x00ff)
>        -				out[outpos++] = msize >> 0, i |= 0x10;
>       -+				(void)(out[outpos++] = msize >> 0), i |= 0x10;
>       - 			if (msize & 0xff00)
>       +-			if (msize & 0xff00)
>        -				out[outpos++] = msize >> 8, i |= 0x20;
>       -+				(void)(out[outpos++] = msize >> 8), i |= 0x20;
>       ++			if (moff & 0x000000ff) {
>       ++				out[outpos++] = moff >> 0;
>       ++				i |= 0x01;
>       ++			}
>       ++			if (moff & 0x0000ff00) {
>       ++				out[outpos++] = moff >> 8;
>       ++				i |= 0x02;
>       ++			}
>       ++			if (moff & 0x00ff0000) {
>       ++				out[outpos++] = moff >> 16;
>       ++				i |= 0x04;
>       ++			}
>       ++			if (moff & 0xff000000) {
>       ++				out[outpos++] = moff >> 24;
>       ++				i |= 0x08;
>       ++			}
>       ++
>       ++			if (msize & 0x00ff) {
>       ++				out[outpos++] = msize >> 0;
>       ++				i |= 0x10;
>       ++			}
>       ++			if (msize & 0xff00) {
>       ++				out[outpos++] = msize >> 8;
>       ++				i |= 0x20;
>       ++			}
>         
>         			*op = i;
>         
>    7:  9a6de12b807 !  7:  1d0ce59cb68 wildmatch: explicitly mark intentional use of the comma operator
>       @@ Metadata
>        Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        
>         ## Commit message ##
>       -    wildmatch: explicitly mark intentional use of the comma operator
>       +    wildmatch: avoid using of the comma operator
>        
>            The comma operator is a somewhat obscure C feature that is often used by
>            mistake and can even cause unintentional code flow. That is why the
>            `-Wcomma` option of clang was introduced: To identify unintentional uses
>            of the comma operator.
>        
>       -    To mark such a usage as intentional, the value needs to be cast to
>       -    `void`, which we do here.
>       -
>            In this instance, the usage is intentional because it allows storing the
>            value of the current character as `prev_ch` before making the next
>            character the current one, all of which happens in the loop condition
>            that lets the loop stop at a closing bracket.
>        
>       -    The alternative to using the comma operator would be to move those
>       +    However, it is hard to read.
>       +
>       +    The chosen alternative to using the comma operator is to move those
>            assignments from the condition into the loop body; In this particular
>       -    case that would require the assignments to either be duplicated or to
>       -    introduce and use a `goto` target before the assignments, though,
>       -    because the loop body contains a `continue` for the case where a
>       -    character class is found that starts with `[:` but does not end in `:]`
>       -    (and the assignments should occur even when that code path is taken).
>       +    case that requires special care because the loop body contains a
>       +    `continue` for the case where a character class is found that starts
>       +    with `[:` but does not end in `:]` (and the assignments should occur
>       +    even when that code path is taken), which needs to be turned into a
>       +    `goto`.
>        
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## wildmatch.c ##
>       +@@ wildmatch.c: static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>       + 						p_ch = '[';
>       + 						if (t_ch == p_ch)
>       + 							matched = 1;
>       +-						continue;
>       ++						goto next;
>       + 					}
>       + 					if (CC_EQ(s,i, "alnum")) {
>       + 						if (ISALNUM(t_ch))
>        @@ wildmatch.c: static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>         					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>         				} else if (t_ch == p_ch)
>         					matched = 1;
>        -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
>       -+			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
>       ++next:
>       ++				prev_ch = p_ch;
>       ++				p_ch = *++p;
>       ++			} while (p_ch != ']');
>         			if (matched == negated ||
>         			    ((flags & WM_PATHNAME) && t_ch == '/'))
>         				return WM_NOMATCH;
>    8:  dc626f36df3 !  8:  b8405f3d237 compat/regex: explicitly mark intentional use of the comma operator
>       @@ Commit message
>        
>         ## compat/regex/regex_internal.c ##
>        @@ compat/regex/regex_internal.c: re_node_set_merge (re_node_set *dest, const re_node_set *src)
>       -   for (sbase = dest->nelem + 2 * src->nelem,
>                is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
>             {
>       --      if (dest->elems[id] == src->elems[is])
>       +       if (dest->elems[id] == src->elems[is])
>        -	is--, id--;
>       --      else if (dest->elems[id] < src->elems[is])
>       -+      if (dest->elems[id] == src->elems[is]) {
>       -+	is--;
>       -+	id--;
>       -+      } else if (dest->elems[id] < src->elems[is])
>       ++	{
>       ++	  is--;
>       ++	  id--;
>       ++	}
>       +       else if (dest->elems[id] < src->elems[is])
>         	dest->elems[--sbase] = src->elems[is--];
>               else /* if (dest->elems[id] > src->elems[is]) */
>       - 	--id;
>        
>         ## compat/regex/regexec.c ##
>        @@ compat/regex/regexec.c: sift_states_bkref (const re_match_context_t *mctx, re_sift_context_t *sctx,
>    9:  91f86c3aba9 !  9:  6b6cd556465 clang: warn when the comma operator is used
>       @@ Commit message
>            warn about code using the comma operator (because it is typically
>            unintentional and wants to use the semicolon instead).
>        
>       +    Helped-by: Patrick Steinhardt <ps@pks.im>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## config.mak.dev ##
>       @@ config.mak.dev: DEVELOPER_CFLAGS += -Wvla
>         ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
>         DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
>         endif
>       +
>       + ## meson.build ##
>       +@@ meson.build: libgit_dependencies = [ ]
>       + # Makefile.
>       + if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
>       +   foreach cflag : [
>       ++    '-Wcomma',
>       +     '-Wdeclaration-after-statement',
>       +     '-Wformat-security',
>       +     '-Wold-style-definition',
>   10:  2f6f31240fe ! 10:  77f1dcaca1c detect-compiler: detect clang even if it found CUDA
>       @@ Commit message
>            Let's unconfuse the script by letting it parse the first matching line
>            and ignore the rest.
>        
>       +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## detect-compiler ##
>       @@ detect-compiler: CC="$*"
>         # FreeBSD clang version 3.4.1 (tags/RELEASE...)
>         get_version_line() {
>        -	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
>       -+	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q}'
>       ++	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q;}'
>         }
>         
>         get_family() {
> 

