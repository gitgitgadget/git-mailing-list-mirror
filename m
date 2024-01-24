Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3DC8E1
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077983; cv=none; b=Mj2Dkhtk5nIPMu9sxO8q6qqdmmhYnUv9Herbo2+4+0ijv7XfBYFTx2FGdwc2chLO7TlGoC22CzOs5ueOFLvOeoa9/7N/oXw78xtO69TcTjR/tn6xqBqQBb1hPdHbt31v5xRKQ9nHIoRjazIGbZQA+1FwabQGHzQD7Nrw2d8z8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077983; c=relaxed/simple;
	bh=HgdDaBEGDMg+h730T7dIPYkKeQckJuihzQ+Vqn82Gjc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QLvJJ8NdoFKhFto99k60KtCWzSNSqBJEJgL2c3MQj4enfNa0oGFaaB07dFZxENF6k+9PxzJ9QY44MdKx2LMLmotJOC5iy6/3eW7RNh6Rjjq1mDsI0GXDDF0tOqKcuJgnp1rWHiM3ZMDh3DufeurixngZi9Fze6zeDN4nf4QA6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIT5ewZV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIT5ewZV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e80046264so64412005e9.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706077979; x=1706682779; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue4Plk4+CsJoWYb/Ovdvig/w2895bnZ9uqLzqafafrs=;
        b=YIT5ewZVdSPxxIzyfOaL7dPTTr9D6eIty++m1Lp531hqUQm1O1WWWcHCgD5/A5E/bT
         4Cepc3qRkaF5U1gHtraz2/OX5IF1/aWWCOdCfVnjN0SeDlkbh30fSJfvbGfgQOzWBk81
         FYFSEmn6x98ZoKWwasjPPygaM+3HqW9tuDYh6A7FUcGDhJbARSrP5rIF0ka7mVECayyE
         F6V9JZPyt3QRv+eD/I5G713n9DkG0nPE4qgwQnkYi8ZW+RzXs8hNJWQoWAkX07cAvOUj
         OgsR4eKxhIPSwWFOuq4VjiBMDkfq+Dpk1bpHEF5icJ4hkbiXhyJ8uf9OsPhSndqeD9MQ
         Xerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706077979; x=1706682779;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue4Plk4+CsJoWYb/Ovdvig/w2895bnZ9uqLzqafafrs=;
        b=Kkl8ZbeHLe8x2fw0U0NCGTnG3Bz1+xIhiYbyvK/FxHCrRwFGbJXJtTQNyngpuWSduk
         AMjXjAy9s/8IErcr9VfKO4N9vBirniHObRgnNQLnjexMfTvViXg3AE8pVy+bdadVv8Nb
         SExTY2JJMAiOwIHGmcvQE2rRClJDCFSrS/KHzZDa4BD4NNb6vdRmYks3ldDr4q3Z/okQ
         UYcR8mXFG7Tc7HTZP/Yufg9E8ovFg3B2IeuJPKzLgqywwBSwn+ePE2W8Ww9ETnEygQXK
         NdqkD0FWyWMy320WJJsaRX3VPRALToczoxo8Yh+74WwYasIBmyoIN0J3DkT44y33Buwz
         /+Ag==
X-Gm-Message-State: AOJu0YwmSEIZ2Mav42+Tqma0kX7/KiAFeV65BocIGOtb6d8BF3/gDTGJ
	w5F5R73QzJjrKiWZMCM04AUNax70TTgY6hk2hyaNH6hn7Tcb2Cc8qNU2bvlE
X-Google-Smtp-Source: AGHT+IFLymgtzAcSVOmHnoT3v5eF1NzBSCIRBYH+U0iP5AkmsXAR+Ug5InlRT8mYoBExlPYJQ6FzSw==
X-Received: by 2002:a05:600c:310f:b0:40d:861a:257c with SMTP id g15-20020a05600c310f00b0040d861a257cmr826822wmo.108.1706077978864;
        Tue, 23 Jan 2024 22:32:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000101000b00337cd6b1890sm15431600wrx.80.2024.01.23.22.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:32:58 -0800 (PST)
Message-ID: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:32:55 +0000
Subject: [PATCH v2 0/2] Replace atoi() with strtol_i_updated()
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
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hello,

This patch series replaces atoi() with an updated version of strtol_i()
called strtol_i_updated (Credits: Junio C Hamano). The reasoning behind this
is to improve error handling by not allowing non-numerical characters in the
hunk header (which might happen in case of a corrupt patch, although
rarely).

There is still a change to be made, as Junio says: "A corrupt patch may be
getting a nonsense patch-ID with the current code and hopefully is not
matching other patches that are not corrupt, but with such a change, a
corrupt patch may not be getting any patch-ID and a loop that computes
patch-ID for many files and try to match them up might need to be rewritten
to take the new failure case into account." I'm not sure where this change
needs to me made (maybe get_one_patchid()?). It would be great if anyone
could point me to the correct place.

Thanks, Mohit Marathe

Mohit Marathe (2):
  git-compat-util: add strtol_i_updated()
  patch-id: replace `atoi()` with `strtol_i_updated()`

 builtin/patch-id.c |  8 ++++++--
 git-compat-util.h  | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1646

Range-diff vs v1:

 1:  4e2b03cdd4f ! 1:  60ea85a701a git-compat-util: add strtol_i2
     @@ Metadata
      Author: Mohit Marathe <mohitmarathe23@gmail.com>
      
       ## Commit message ##
     -    git-compat-util: add strtol_i2
     +    git-compat-util: add strtol_i_updated()
      
     -    This function is an updated version of strtol_i function. It will
     +    This function is an updated version of strtol_i() function. It will
          give more control to handle parsing of the characters after the
          integer and better error handling while parsing numbers.
      
     @@ git-compat-util.h: static inline int strtol_i(char const *s, int base, int *resu
       	return 0;
       }
       
     -+#define strtol_i(s,b,r) strtol_i2((s), (b), (r), NULL)
     -+static inline int strtol_i2(char const *s, int base, int *result, char **endp)
     ++#define strtol_i(s,b,r) strtol_i_updated((s), (b), (r), NULL)
     ++static inline int strtol_i_updated(char const *s, int base, int *result, char **endp)
      +{
      +	long ul;
      +	char *dummy = NULL;
 2:  1ece724b1ca ! 2:  f3a03d68211 patch-id: replace `atoi()` with `strtol_i2()`
     @@ Metadata
      Author: Mohit Marathe <mohitmarathe23@gmail.com>
      
       ## Commit message ##
     -    patch-id: replace `atoi()` with `strtol_i2()`
     +    patch-id: replace `atoi()` with `strtol_i_updated()`
      
          The change is made to improve the error-handling capabilities
          during the conversion of string representations to integers.
     -    The `strtol_i2(` function offers a more robust mechanism for
     +    The `strtol_i_updated(` function offers a more robust mechanism for
          converting strings to integers by providing enhanced error
     -    detection. Unlike `atoi(`, `strtol_i2(` allows the code to
     +    detection. Unlike `atoi(`, `strtol_i_updated(` allows the code to
          differentiate between a valid conversion and an invalid one,
          offering better resilience against potential issues such as
          reading hunk header of a corrupted patch.
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
       	if (q[n] == ',') {
       		q += n + 1;
      -		*p_before = atoi(q);
     -+		if (strtol_i2(q, 10, p_before, &endp) != 0)
     ++		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
      +			return 0;
       		n = strspn(q, digits);
       	} else {
       		*p_before = 1;
     - 	}
     - 
     --	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
     -+	if (q[n] != ' ' || q[n+1] != '+')
     - 		return 0;
     - 
     - 	r = q + n + 2;
     +@@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, int *p_after)
       	n = strspn(r, digits);
       	if (r[n] == ',') {
       		r += n + 1;
      -		*p_after = atoi(r);
     --		n = strspn(r, digits);
     -+		if (strtol_i2(r, 10, p_after, &endp) != 0)
     ++		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
      +			return 0;
     + 		n = strspn(r, digits);
       	} else {
       		*p_after = 1;
     - 	}
     --	if (n == 0)
     --		return 0;
     --
     - 	return 1;
     - }
     - 

-- 
gitgitgadget
