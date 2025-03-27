Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C43207E19
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076390; cv=none; b=ZTOxqRongViU+KGhimTuXTDTCj5eQ6sCj9rg2xtJouD4Y/Osi27WxHTT7qWuTeieLYTwOX4+9LI1KNS39Z7QiiYJBkIRIYrdQPRhd10ql51LGXZmvcuWkjU2spgGAmsxJ7uG3bmEXr75FU57Y6qj6Hfij/+m+TKcwxIq1ICjGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076390; c=relaxed/simple;
	bh=zYHnfi1d6t9NMxLBuiklC017EzUieDSd0whbXUftK3s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pGvUntFbHJ8TPYGzMFpVIj04dWPGIixsThSMqa8BS2JJ6NDM6bx+KxWYUs9grZt8Ga7boxI/CO6KrZBIc35oWGMtw1X4yCh5cvbKrUnwvh8++JjpNw9iVWeeInQwA8Kb7ANjELh8AKlxK6nlIJgBCqF1dD9eS5f6O24bafjQXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvwELci2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvwELci2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39133f709f5so488059f8f.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076386; x=1743681186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJMSU8uGCFOwtimeLrbeVCT3+eS4p0zRNFbStHiJm0g=;
        b=BvwELci2nSi5rxl5BFWPjgdXBIzjGyaJ6/2Z51ZWh6qSjVFAoTnBeiiOkmb+J1JOZC
         2DFO1q1W8/Vt9tK/WtM1gnoW3pgET0Gns1rTD8A6dphfLna8J49bkwZt4Z37aGeTem+S
         wTBgpG5wJB/pIoSKmQZYwJpz4dEiQtnbjU+FpQ7VaQjrftgilhnym6jKhUh/N+b7bSq3
         eJ4vA9ckLDD1HrgskkMfD/jKwrdPN1ozmxyG3jmyE/zfAhhZN8mAioIhrHCWfMfqE8bL
         /AA56IWMbTEs10ItrPgiKoaMqnt45C+QRcux+DRAHrcEKUMppyzn9Fxf46veG2J8GeeL
         977A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076386; x=1743681186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJMSU8uGCFOwtimeLrbeVCT3+eS4p0zRNFbStHiJm0g=;
        b=g+jEJYX5aXkq5rwBZk2TAh+eyrgdeF7S9cBfs9CSNsKEnK/+IUItq03k1fTkJQ4002
         Kt0GI+KRef4iX0SVu77uwDcJnpKZPIMMdu85jfL21zITGOeyH5/R1PWuyqQ1DmZkNdFU
         akUMnOtKe33POyf54I5EHJEieZ2SX19fYo9R6mwJaCVpMh+ECvHCACpA3GJPMdU/o1YX
         pn4xRWVqEtD2SBYzljjgytEtqahZk0XgeLjsPLSH8Ji9/LuyS+1K8vGyFeG6ZfqqyHde
         jroL+RWesxA1mn5+YIwogmM36ZWAhM5M73JR63CJYXV8rrw++COD8N356MJGaNvd800s
         J5JQ==
X-Gm-Message-State: AOJu0YzlXBjFdiQhIBxYFQ1yT7h1GKoZvT6+TucCh0HxrLFVS0d2162U
	7ikr0fjhP3FHHi2M1Xx7KzY+ygsvqCcI2E5xYQueS9jJq679hq4A1mpkyA==
X-Gm-Gg: ASbGncv7wuq8IVsFFoSQaJvuFON3hJT4F8G4fQjefN7zJC18zVhapycnF2j7RS+oXUu
	WUgJt4xDt9VllB5lDWwBinRwcx7zSCBqa28VgKiPGN2XNgIZRjkruMpjojmfS0acp5+qpFffz17
	F5ZClaO/G2+oEXxrWIVOpe+AjXdR4twa7EkJ4a69HAjN8C2TAIAjt+casXTYkOURxvd7QLa8dlZ
	FgFm6KrKgStuQWV8dJd0HKSWT7Sx6UvznNS0KnoevskuXx4lvLmRyGhKdD7cATCdjfGZWBYW+aU
	t7KVAGFvwSskv2E1FNWXJyp+jcydt6TAXLTOVonqYH4det2iMUmfFTtT
X-Google-Smtp-Source: AGHT+IEdf8SGziqLAn2Z7SyLXV0XrXXfISxZZCxxXwU/lzTaDN5fr5nyfrLjwZhxLolgipEWkeG5NA==
X-Received: by 2002:a5d:5885:0:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-39ad17525b2mr3448854f8f.25.1743076384847;
        Thu, 27 Mar 2025 04:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9956b4sm19512738f8f.7.2025.03.27.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:04 -0700 (PDT)
Message-Id: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:53 +0000
Subject: [PATCH v3 00/10] Avoid the comma operator
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator
[https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
rarely used in C anymore, and typically indicates a typo. Just like in these
instances, where a semicolon was meant to be used, as there is no need to
discard the first statement's result here.

Changes since v2:

 * Made the sed construct in detect-compiler portable (thanks, Eric
   Sunshine!)
 * The majority of the feedback disagreed with the more compact format in
   diff-delta.c, so I changed it to the long format (thanks, Phillip Wood!)
 * The more succinct and safer, but less readable, cast in the loop
   condition of the dowild() function was replaced with the goto-based
   alternative I had mentioned as a possibility in the commit message
   (thanks, Phillip Wood!)
 * I adjusted the style of my compat/regex/ patch to the surrounding code's.
 * The -Wcomma option is now used in Meson-based clang builds, too (thanks,
   Patrick Steinhardt!)

Changes since v1:

 * Use -Wcomma when compiling with clang and with DEVELOPER=1.
 * Address the remaining instances pointed out by clang (and by Phillip).

Johannes Schindelin (10):
  remote-curl: avoid using the comma operator unnecessarily
  rebase: avoid using the comma operator unnecessarily
  kwset: avoid using the comma operator unnecessarily
  clar: avoid using the comma operator unnecessarily
  xdiff: avoid using the comma operator unnecessarily
  diff-delta: avoid using the comma operator
  wildmatch: avoid using of the comma operator
  compat/regex: explicitly mark intentional use of the comma operator
  clang: warn when the comma operator is used
  detect-compiler: detect clang even if it found CUDA

 builtin/rebase.c              |  2 +-
 compat/regex/regex_internal.c |  5 +++-
 compat/regex/regexec.c        |  2 +-
 config.mak.dev                |  4 +++
 detect-compiler               |  2 +-
 diff-delta.c                  | 38 +++++++++++++++---------
 kwset.c                       | 54 +++++++++++++++++++----------------
 meson.build                   |  1 +
 remote-curl.c                 |  4 +--
 t/unit-tests/clar/clar/fs.h   | 10 +++++--
 wildmatch.c                   |  7 +++--
 xdiff/xdiffi.c                | 12 +++++---
 12 files changed, 89 insertions(+), 52 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1889%2Fdscho%2Fcomma-operator-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1889/dscho/comma-operator-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1889

Range-diff vs v2:

  1:  913c7a0d296 =  1:  913c7a0d296 remote-curl: avoid using the comma operator unnecessarily
  2:  37ff88b8275 =  2:  37ff88b8275 rebase: avoid using the comma operator unnecessarily
  3:  f601f4e74a5 =  3:  f601f4e74a5 kwset: avoid using the comma operator unnecessarily
  4:  f60ebe376e1 =  4:  f60ebe376e1 clar: avoid using the comma operator unnecessarily
  5:  7239078413f =  5:  7239078413f xdiff: avoid using the comma operator unnecessarily
  6:  5e0e8325620 !  6:  045d695d73e diff-delta: explicitly mark intentional use of the comma operator
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    diff-delta: explicitly mark intentional use of the comma operator
     +    diff-delta: avoid using the comma operator
      
          The comma operator is a somewhat obscure C feature that is often used by
          mistake and can even cause unintentional code flow. That is why the
     @@ Commit message
          Intentional uses include situations where one wants to avoid curly
          brackets around multiple statements that need to be guarded by a
          condition. This is the case here, as the repetitive nature of the
     -    statements is easier to see for a human reader this way.
     +    statements is easier to see for a human reader this way. At least in my
     +    opinion.
      
     -    To mark this usage as intentional, the return value of the statement
     -    before the comma needs to be cast to `void`, which we do here.
     +    However, opinions on this differ wildly, take 10 people and you have 10
     +    different preferences.
      
     +    On the Git mailing list, it seems that the consensus is to use the long
     +    form instead, so let's do just that.
     +
     +    Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## diff-delta.c ##
      @@ diff-delta.c: create_delta(const struct delta_index *index,
     + 			op = out + outpos++;
       			i = 0x80;
       
     - 			if (moff & 0x000000ff)
     +-			if (moff & 0x000000ff)
      -				out[outpos++] = moff >> 0,  i |= 0x01;
     -+				(void)(out[outpos++] = moff >> 0),  i |= 0x01;
     - 			if (moff & 0x0000ff00)
     +-			if (moff & 0x0000ff00)
      -				out[outpos++] = moff >> 8,  i |= 0x02;
     -+				(void)(out[outpos++] = moff >> 8),  i |= 0x02;
     - 			if (moff & 0x00ff0000)
     +-			if (moff & 0x00ff0000)
      -				out[outpos++] = moff >> 16, i |= 0x04;
     -+				(void)(out[outpos++] = moff >> 16), i |= 0x04;
     - 			if (moff & 0xff000000)
     +-			if (moff & 0xff000000)
      -				out[outpos++] = moff >> 24, i |= 0x08;
     -+				(void)(out[outpos++] = moff >> 24), i |= 0x08;
     - 
     - 			if (msize & 0x00ff)
     +-
     +-			if (msize & 0x00ff)
      -				out[outpos++] = msize >> 0, i |= 0x10;
     -+				(void)(out[outpos++] = msize >> 0), i |= 0x10;
     - 			if (msize & 0xff00)
     +-			if (msize & 0xff00)
      -				out[outpos++] = msize >> 8, i |= 0x20;
     -+				(void)(out[outpos++] = msize >> 8), i |= 0x20;
     ++			if (moff & 0x000000ff) {
     ++				out[outpos++] = moff >> 0;
     ++				i |= 0x01;
     ++			}
     ++			if (moff & 0x0000ff00) {
     ++				out[outpos++] = moff >> 8;
     ++				i |= 0x02;
     ++			}
     ++			if (moff & 0x00ff0000) {
     ++				out[outpos++] = moff >> 16;
     ++				i |= 0x04;
     ++			}
     ++			if (moff & 0xff000000) {
     ++				out[outpos++] = moff >> 24;
     ++				i |= 0x08;
     ++			}
     ++
     ++			if (msize & 0x00ff) {
     ++				out[outpos++] = msize >> 0;
     ++				i |= 0x10;
     ++			}
     ++			if (msize & 0xff00) {
     ++				out[outpos++] = msize >> 8;
     ++				i |= 0x20;
     ++			}
       
       			*op = i;
       
  7:  9a6de12b807 !  7:  1d0ce59cb68 wildmatch: explicitly mark intentional use of the comma operator
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    wildmatch: explicitly mark intentional use of the comma operator
     +    wildmatch: avoid using of the comma operator
      
          The comma operator is a somewhat obscure C feature that is often used by
          mistake and can even cause unintentional code flow. That is why the
          `-Wcomma` option of clang was introduced: To identify unintentional uses
          of the comma operator.
      
     -    To mark such a usage as intentional, the value needs to be cast to
     -    `void`, which we do here.
     -
          In this instance, the usage is intentional because it allows storing the
          value of the current character as `prev_ch` before making the next
          character the current one, all of which happens in the loop condition
          that lets the loop stop at a closing bracket.
      
     -    The alternative to using the comma operator would be to move those
     +    However, it is hard to read.
     +
     +    The chosen alternative to using the comma operator is to move those
          assignments from the condition into the loop body; In this particular
     -    case that would require the assignments to either be duplicated or to
     -    introduce and use a `goto` target before the assignments, though,
     -    because the loop body contains a `continue` for the case where a
     -    character class is found that starts with `[:` but does not end in `:]`
     -    (and the assignments should occur even when that code path is taken).
     +    case that requires special care because the loop body contains a
     +    `continue` for the case where a character class is found that starts
     +    with `[:` but does not end in `:]` (and the assignments should occur
     +    even when that code path is taken), which needs to be turned into a
     +    `goto`.
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## wildmatch.c ##
     +@@ wildmatch.c: static int dowild(const uchar *p, const uchar *text, unsigned int flags)
     + 						p_ch = '[';
     + 						if (t_ch == p_ch)
     + 							matched = 1;
     +-						continue;
     ++						goto next;
     + 					}
     + 					if (CC_EQ(s,i, "alnum")) {
     + 						if (ISALNUM(t_ch))
      @@ wildmatch.c: static int dowild(const uchar *p, const uchar *text, unsigned int flags)
       					p_ch = 0; /* This makes "prev_ch" get set to 0. */
       				} else if (t_ch == p_ch)
       					matched = 1;
      -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
     -+			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
     ++next:
     ++				prev_ch = p_ch;
     ++				p_ch = *++p;
     ++			} while (p_ch != ']');
       			if (matched == negated ||
       			    ((flags & WM_PATHNAME) && t_ch == '/'))
       				return WM_NOMATCH;
  8:  dc626f36df3 !  8:  b8405f3d237 compat/regex: explicitly mark intentional use of the comma operator
     @@ Commit message
      
       ## compat/regex/regex_internal.c ##
      @@ compat/regex/regex_internal.c: re_node_set_merge (re_node_set *dest, const re_node_set *src)
     -   for (sbase = dest->nelem + 2 * src->nelem,
              is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
           {
     --      if (dest->elems[id] == src->elems[is])
     +       if (dest->elems[id] == src->elems[is])
      -	is--, id--;
     --      else if (dest->elems[id] < src->elems[is])
     -+      if (dest->elems[id] == src->elems[is]) {
     -+	is--;
     -+	id--;
     -+      } else if (dest->elems[id] < src->elems[is])
     ++	{
     ++	  is--;
     ++	  id--;
     ++	}
     +       else if (dest->elems[id] < src->elems[is])
       	dest->elems[--sbase] = src->elems[is--];
             else /* if (dest->elems[id] > src->elems[is]) */
     - 	--id;
      
       ## compat/regex/regexec.c ##
      @@ compat/regex/regexec.c: sift_states_bkref (const re_match_context_t *mctx, re_sift_context_t *sctx,
  9:  91f86c3aba9 !  9:  6b6cd556465 clang: warn when the comma operator is used
     @@ Commit message
          warn about code using the comma operator (because it is typically
          unintentional and wants to use the semicolon instead).
      
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.dev ##
     @@ config.mak.dev: DEVELOPER_CFLAGS += -Wvla
       ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
       DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
       endif
     +
     + ## meson.build ##
     +@@ meson.build: libgit_dependencies = [ ]
     + # Makefile.
     + if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
     +   foreach cflag : [
     ++    '-Wcomma',
     +     '-Wdeclaration-after-statement',
     +     '-Wformat-security',
     +     '-Wold-style-definition',
 10:  2f6f31240fe ! 10:  77f1dcaca1c detect-compiler: detect clang even if it found CUDA
     @@ Commit message
          Let's unconfuse the script by letting it parse the first matching line
          and ignore the rest.
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## detect-compiler ##
     @@ detect-compiler: CC="$*"
       # FreeBSD clang version 3.4.1 (tags/RELEASE...)
       get_version_line() {
      -	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
     -+	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q}'
     ++	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q;}'
       }
       
       get_family() {

-- 
gitgitgadget
