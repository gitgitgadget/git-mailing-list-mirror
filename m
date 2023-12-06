Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QLlnE8hg"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A2D5C
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:18:59 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f3183f012so3838985a.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701890338; x=1702495138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O2AqyKkAzreWL2LfsIhJjr8x77khEa90xGriO9l0Vb0=;
        b=QLlnE8hgVj9127dj2xpiWXtm3K6BkZO9OdptZisj79Z+lQEAWtDEqEkSRq5wb3SmpA
         B1Bp8Wa2WpFVtxH57nztgtLxjzPBeL4am26WxdJ4PXn1TeLyj9ewwkhFOScTYY9ijE1f
         lkMDaPImJzvpqS/VJPouMJWeO4G+stlAFLihZE7zpP75j32wbhPyNt7yrCuwMWW+Pxcn
         ZHNNMKKk1V9cKdYzUwr8H61grU9ZAoWOWme1lRXXigKfIJIgydm7Q6L2PPDHXR322rsf
         z3KM89HZ1r99iz5b3q0PiS1Uq//I0hbGnjguVkURur6Cq9l9k0Q6wNPVrYZYJDh7ic+d
         omMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890338; x=1702495138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2AqyKkAzreWL2LfsIhJjr8x77khEa90xGriO9l0Vb0=;
        b=kNImB2IeRr4BkShx7dXRSCG0/pYmTtDk0P7MXW+eQcmZURFnM7oPtehpCPO2K7hCVp
         /ifqOYr1ewQxC76WIklkamK0MeoORXBT/zPbKu0GNM8Ex2airGkgDvpYz6e/+wZ8ayNC
         qONHfWXqo8V08zVlx7KI6opdcxwE7yELl7lVLxgpdkwxK87O6tWJFF28r1X2ZS3crSxU
         wCrMjfwykQ2M8y0ttbHhba3JiE/vOuK/Gn1zvqT5M3nnbbC7MzyZyBgj5X2LuFKvtTTI
         KygrsyzwsRsOwnhRACl2/dY7BpQ94jiuUT1mk9iguZuL66OHTAXjR8CfyuqmFaix67K3
         OW1w==
X-Gm-Message-State: AOJu0YwgdTs9pSFxTfZrk96ODEfsXChmT+Mg/cerwubVn8OYcn4Tcwjw
	snHfwy/d9XZNzlLVwSc7zraQ8jTF4FMkThLA9EY=
X-Google-Smtp-Source: AGHT+IEcPEJZblDzgFXMOjxj/kxNM1MjXClRUPfN/mNSyJ051U97sui+Z7qzd9mjK0dEZZIZ7BKT7g==
X-Received: by 2002:a05:620a:640f:b0:77e:fba3:93b8 with SMTP id pz15-20020a05620a640f00b0077efba393b8mr1450647qkn.154.1701890338400;
        Wed, 06 Dec 2023 11:18:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f25-20020a37ad19000000b0077d71262d38sm178423qkm.60.2023.12.06.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:18:58 -0800 (PST)
Date: Wed, 6 Dec 2023 14:18:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] repack: use die_for_incompatible_opt3() for
 -A/-k/--cruft
Message-ID: <ZXDJIXjKefNFhDdf@nand.local>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-3-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206115215.94467-3-l.s.r@web.de>

On Wed, Dec 06, 2023 at 12:51:56PM +0100, René Scharfe wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index edaee4dbec..c54777bbe5 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1203,19 +1203,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (delete_redundant && repository_format_precious_objects)
>  		die(_("cannot delete packs in a precious-objects repo"));
>
> -	if (keep_unreachable &&
> -	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
> -		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
> +	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
> +				  keep_unreachable, "-k/--keep-unreachable",
> +				  pack_everything & PACK_CRUFT, "--cruft");

Oof, thanks for cleaning this one up.

I had to read this hunk a couple of times to convince myself that it was
doing the right thing, but I believe it is.

> -	if (pack_everything & PACK_CRUFT) {
> +	if (pack_everything & PACK_CRUFT)
>  		pack_everything |= ALL_INTO_ONE;

And adding the ALL_INTO_ONE bit here does not effect either of the below
two checks, so moving them up is fine, too.

> -		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
> -			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-A");
> -		if (keep_unreachable)
> -			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
> -	}

Thanks,
Taylor
