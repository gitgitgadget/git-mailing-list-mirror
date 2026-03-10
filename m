Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7E3C140B
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172603; cv=none; b=NSk7GYwm1ht3DMfYRb+ZPNZG8RygU9dEAcGBDwAevysuSD+mbUot4uiZIaQXdfQ0V62oJZVGD6bPa35GrBfJ0u3/E9LunNinhH9OpNnNPGBK10ux4Iy8jB/1XG1uyYTa7ziaG+mOXxzDa0wYqXzr5xL/SOzQJw1bzzT7GG9hQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172603; c=relaxed/simple;
	bh=FHh6Fo6fu9w9xkQ2el0Lg6Tlxr6ibeXLE/3ZrbCt2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyyXaedxPlXf/ybaTGF7r+u24vZ1A/FMGN2EQQRyMqb9xq4UGXvs0WHUuLHzXMkX69E98fonBbuG30eRjoSJSGaBhx3/+j0S+8Z+kBdLWf5O3RyIR/vK/ltHEKa8x0SLK2EQXOUnp3+UvW2+TCIKYlwOsTT96T+++redfQP3g4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzjAuE8S; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzjAuE8S"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439bcec8613so7321356f8f.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773172599; x=1773777399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5i7KlNDElxun79dliR2i4SpOzqx3CiIxAGqlys9a11Y=;
        b=mzjAuE8SuXsZmgeiwk4cxfgEUZY6Z2LxTDfAjn3pMWINIrcywRGWSHVI/tyqEAae45
         38Arq9gk16rJgNroCNOgY4RCdoa5GI0TwU9HKKBB5FRWaL2xBYx1vHrmGN1Hh0Xw6LaX
         qN1yTi12IxxIF77tji4G+rVFslDW87Lfaz411HfefW+AWST2q+RxbvnXjQ0cBbQdh5Ty
         U/50OpRBnsmAz5cjpN+vDn6LXXvbm4LD0KuJ5SFAUeJxsTiyw3uGzRzAotK0QOmVwNQv
         dOtD9Gh6nH6VmVxuJ7+YdupPTdlbK6kLuLBkcirCqQVlrdFRLZNOSeqoL+QECkKVVRYq
         iAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172599; x=1773777399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i7KlNDElxun79dliR2i4SpOzqx3CiIxAGqlys9a11Y=;
        b=ePEnRuJcO5d92pkCOS9sYesbQXUec4mgkumWgGhIip0wQYG8orM9QqSDbUzDvDiQQj
         lTK5177QBHyeKzwvPocspUjRhXQ2iPI4Lu/tJol+tQx6IER65NBWN5JfBz/qFX47fY6y
         H98rHfmZXA73dwalqci9nj9VcxcgIdKiVG1hV0ARLzrxIXAoCUOT45AKwp+BLKY2qubv
         e9iqHe97DTVZQj7lE3wXL8BEa28Gxy8vTQO3dP54VCwc2tLo4p+V/hW0JtcGjnDgFFVH
         rXEk3DcCnhH/5RyNRwaG8ROSI95W1ZqHn316BeXNzO40GDdPpOPWmVhXv1ooqIcVJ7tv
         IPNA==
X-Gm-Message-State: AOJu0YypD5X3fZgNvEhhaFnLcuRR0w73kMmfHwnX0RnsBnKAHjpmbwu1
	vZhk2vpB/t+Oq0FSmBSwrYQ1dJfGAChzeN0EuP1Ps+8H6Q7tWD7rDNOP
X-Gm-Gg: ATEYQzzfmQ4/96FRXgl2NAcT4NtoUDfxtnbPU9AHOtZ3epNTg2C2SnK7oOrsCvgYOpW
	UGqR6IFMuzcDwgMJxD4Xb35PZYUj7p4shjfOmrYFlUWONQ3tiCUQaRcCHqd9oIxU9nupu0OiWP2
	79i/dbpe90px+aas9wn6tk1fLSiJSdxUxJ52VvulWNrlFYR8g8XHs8UzpqOpXRnmRTFZd/TsH5r
	tjS6XxwMi8BkG8l/2Idq4cGMQTFV8Fmazwu9LcjrxdWUZPTRD4G6BacYC3LzK8XVtgUy9oH6pwQ
	8xIS8a44ohGflK83TrtSAxsEIXgAe9BNailX+iuXQzlt0up5ZUK8k+E1YBY3aCN0jk7wyAXFICn
	G3Y0cnAPogwxA4g9vAOCtV+2k4J0qdzNdGYgiFphrog1n3J2ST1A8EG4/tTFXsy2cC37wzM3Juz
	vmmbQ9qnkyzh+6pHpzMlixi8jVB1oUNa/6J4sKZikqBM0od3s=
X-Received: by 2002:a05:6000:2386:b0:439:b811:11de with SMTP id ffacd0b85a97d-439f81bd4aemr298385f8f.7.1773172598813;
        Tue, 10 Mar 2026 12:56:38 -0700 (PDT)
Received: from localhost (78-131-14-0.pool.digikabel.hu. [78.131.14.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81f143asm369034f8f.23.2026.03.10.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:56:38 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:56:07 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/10] hook: move unsorted_string_list_remove() to
 string-list.[ch]
Message-ID: <abB3V4BcYDgMJo0x@szeder.dev>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309005416.2760030-2-adrian.ratiu@collabora.com>

On Mon, Mar 09, 2026 at 02:54:07AM +0200, Adrian Ratiu wrote:
> Move the convenience wrapper from hook to string-list since
> it's a more suitable place. Add a doc comment to the header.

unsorted_string_list_remove() in string-list has a 'free_util'
parameter that didn't exist in its original version in 'hook.c', but
it's not mentioned in the commit message.
Furthermore, none of the function's callsites are adjusted to the new
parameter, and the build fails with:

  hook.c: In function ‘hook_config_lookup_all’:
  hook.c:151:33: error: too few arguments to function ‘unsorted_string_list_remove’
    151 |                                 unsorted_string_list_remove(e->value, hook_name);
        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from hook.h:5,
                   from hook.c:5:
  string-list.h:273:6: note: declared here
    273 | void unsorted_string_list_remove(struct string_list *list, const char *str,
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hook.c:163:25: error: too few arguments to function ‘unsorted_string_list_remove’
    163 |                         unsorted_string_list_remove(hooks, hook_name);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  string-list.h:273:6: note: declared here
    273 | void unsorted_string_list_remove(struct string_list *list, const char *str,
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hook.c:180:25: error: too few arguments to function ‘unsorted_string_list_remove’
    180 |                         unsorted_string_list_remove(&data->disabled_hooks,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  string-list.h:273:6: note: declared here
    273 | void unsorted_string_list_remove(struct string_list *list, const char *str,
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  make: *** [Makefile:2917: hook.o] Error 1


> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  hook.c        | 8 --------
>  string-list.c | 9 +++++++++
>  string-list.h | 8 ++++++++
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/hook.c b/hook.c
> index 2c8252b2c4..313a6b9937 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -110,14 +110,6 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>  	string_list_append(hook_list, hook_path)->util = h;
>  }
>  
> -static void unsorted_string_list_remove(struct string_list *list,
> -					const char *str)
> -{
> -	struct string_list_item *item = unsorted_string_list_lookup(list, str);
> -	if (item)
> -		unsorted_string_list_delete_item(list, item - list->items, 0);
> -}
> -
>  /*
>   * Callback struct to collect all hook.* keys in a single config pass.
>   * commands: friendly-name to command map.
> diff --git a/string-list.c b/string-list.c
> index fffa2ad4b6..d260b873c8 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -281,6 +281,15 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>  	list->nr--;
>  }
>  
> +void unsorted_string_list_remove(struct string_list *list, const char *str,
> +				 int free_util)
> +{
> +	struct string_list_item *item = unsorted_string_list_lookup(list, str);
> +	if (item)
> +		unsorted_string_list_delete_item(list, item - list->items,
> +						 free_util);
> +}
> +
>  /*
>   * append a substring [p..end] to list; return number of things it
>   * appended to the list.
> diff --git a/string-list.h b/string-list.h
> index 3ad862a187..b86ee7c099 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -265,6 +265,14 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>   */
>  void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
>  
> +/**
> + * Remove the first item matching `str` from an unsorted string_list.
> + * No-op if `str` is not found. If `free_util` is non-zero, the `util`
> + * pointer of the removed item is freed before deletion.
> + */
> +void unsorted_string_list_remove(struct string_list *list, const char *str,
> +				 int free_util);
> +
>  /**
>   * Split string into substrings on characters in `delim` and append the
>   * substrings to `list`.  The input string is not modified.
> -- 
> 2.52.0.732.gb351b5166d.dirty
> 
