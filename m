Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEED18DF9D
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379325; cv=none; b=XNo3/ITuwd3DGtTHM4aG6hlUPwSoFM0Q7gvvkpAOZpLlxV7uQT3z5BMiaAjl+FOJeoM7VKkgUXFjQeq9A8ZkgG/UnLkqhFHBaohcy6zDWZpPe0xD9yyNbT+znpb+trepc+wDR2pZWGMvSUm2FmHTH/PyGkPRujw+9UsmU4zHyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379325; c=relaxed/simple;
	bh=JK6Ql2AVHpdEpYXk7kwavnYuqWbxW7F+KF+v0XnHVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyepekDhYL6g5rwcJBh2XKgIWY34TVopz81OSYdRTjaGGDUfbyE9O7cWL3TXTYJdkjTR9ig6j8dJfjaa3xmthj5SEzlqmvAg0c2tvFlRsMMCyV1W/viwguRmYhKvpNRaOBejhtKlMiIZKbNX0w7GU67XxCdxW+5ajosrnweD0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j87XgT4Z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j87XgT4Z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c667b28c82so199338eaf.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722379323; x=1722984123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVP9kdwUnJx2S92vJoCUOBlf2ktBVBaPzaT2B5It7h4=;
        b=j87XgT4Zn2cW4XwxlTcHTRbqOsiNlOoaOpc7tl57VZZnYZIEm7R8C9HH3aXonR//05
         Wbwq1R1rm66xTubWQPTBiT+Px4svxNSULkvSlkhQ/QfZLlt3mER43YPJ/w7KSZEL23PC
         fRPfUHs0JnUCHlK8LTu3EGuU3xdfJJ/UPEM1rbNxdoiWKFwr2zy7gnsa9S0mKcq57XMY
         IEwTtxTwD7PT+SvmiCY1Rt5KZIOH6LXUT6Yd0zQsMIjrX2IDZwRkBX118Huo+I6O+oks
         n7E7oAy2qaXJjK4skKQxSJHhWhmDqQCHHnjBlYE0tLvr5focy/z1wsRZod3smzfYgNqv
         sS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379323; x=1722984123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVP9kdwUnJx2S92vJoCUOBlf2ktBVBaPzaT2B5It7h4=;
        b=pTITLjVs+VJsoaazkW3A30O1VbLsICYW5/eEro0ICaN81ArXPDAtTZ2+yUMJHBjotR
         GH4aMzAhw4DwEm//yEKpaivy65JHKuf/XGDYLYAgQOw9jlmi4CkwRFw+u5Z4yfVFfb2q
         o/ND7hvceuXUJ892xvO8ybcehNODrx6HYR9V+LP4WjXE1rd1awldQo7dVNPKrsbUdzun
         KmVQAmWrUdiSf8AZ9oKVCrBh8m/O8Alsxb/ZWEkrDY6nOQjjdcfrWRnaaJzCfmOFktv0
         PEJ56O+20ebnJSlsJTYLfyVwt53Vonl+WWnaw8yQRi0oxWFLABc23vsbSs6rqklTQChh
         dRhQ==
X-Gm-Message-State: AOJu0YyQxriwJ1cL3Q+oeOoSnubS5iFYacCPwXzYReDBzvou5YHGgDGy
	AZUeL71w6flMdIkw2S+GGRELCaDyfTfMGYzdckGWJm3bahb6JJzdDKV4fw==
X-Google-Smtp-Source: AGHT+IG0+H8Vfs7dv7Y+VF/+7LqisbY1hZG/RP4Efgxlt5wTP5vjyWeK4v9nCvBgDa9eTCu+MMpoYw==
X-Received: by 2002:a05:6820:1688:b0:5d6:510:6acd with SMTP id 006d021491bc7-5d605dc6f69mr1515596eaf.2.1722379323208;
        Tue, 30 Jul 2024 15:42:03 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5da7cf5fasm867503eaf.41.2024.07.30.15.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:42:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:41:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] t98xx: fix Perforce tests with p4d r23 and newer
Message-ID: <aw2i5dz2tflrosz3enetxelnal6utk4g7kq7yos3jyssloysng@j2nqbxotdujg>
References: <cover.1721740612.git.ps@pks.im>
 <f40f62f257de38c3a38e942eb9ca1d2109c2b059.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40f62f257de38c3a38e942eb9ca1d2109c2b059.1721740612.git.ps@pks.im>

On 24/07/23 04:05PM, Patrick Steinhardt wrote:
> Some of the tests in t98xx modify the Perforce depot in ways that the
> tool wouldn't normally allow. This is done to test behaviour of git-p4
> in certain edge cases that we have observed in the wild, but which
> should in theory not be possible.

If in theory these edge cases being tested should not be possible, that
sounds like a bug and maybe in newer versions of p4 that is no longer
relevant? Does it make sense to even support these rather intimate test
cases going forward? Maybe we could instead skip these tests for newer
versions?

> Naturally, modifying the depot on disk directly is quite intimate with
> the tool and thus prone to breakage when Perforce updates the way that
> data is stored. And indeed, those tests are broken nowadays with r23 of
> Perforce. While a file revision was previously stored as plain file
> "depot/file,v", it is now stored in a directory "depot/file,d" with
> compression.

s/plain/a plain/

This sounds like a bit of a maintenance headache, especially if there
are not many eyes on it to begin with. I guess this ties in with other
discussion from this thread about whether and of git-p4 should remain in
the codebase.

> Adapt those tests to handle both old- and new-style depot layouts.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9800-git-p4-basic.sh                    | 13 +++++++++++--
>  t/t9802-git-p4-filetype.sh                 | 15 ++++++++++++---
>  t/t9825-git-p4-handle-utf16-without-bom.sh | 18 +++++++++++++++---
>  3 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 53af8e34ac..4e95622670 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -297,8 +297,17 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
>  # p4 changes, files, or describe; just in p4 print.  If P4CLIENT is unset, the
>  # message will include "Librarian checkout".
>  test_expect_success 'exit gracefully for p4 server errors' '
> -	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,v" &&
> -	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
> +	case "$(echo "$db"/depot/file1*)" in
> +	*,v)
> +		test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,v" &&
> +		mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden;;
> +	*,d)
> +		path="$(echo "$db"/depot/file1,d/*.gz)" &&
> +		test_when_finished "mv \"$path\",hidden \"$path\"" &&
> +		mv "$path" "$path",hidden;;
> +	*)
> +		BUG "unhandled p4d layout";;
> +	esac &&

I'm not familiar with Perforce, but the test looks like it is simply
appending ",hidden" to the file name. I assume this to trigger some
error. 

We are simply extending the test to also perform the same rename if,
instead of `depot/file1,f`, a newer version uses `depot/file1,d`.

Makes sense to me, but without surrounding context its rather difficult
to understand that the "case" statement here pertains to different
Perforce versions that may be used. It might be nice to have a comment
explaining this.

>  	test_when_finished cleanup_git &&
>  	test_expect_code 1 git p4 clone --dest="$git" //depot@1 >out 2>err &&
>  	test_grep "Error from p4 print" err
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index bb236cd2b5..557e11b16c 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -301,9 +301,18 @@ test_expect_success SYMLINKS 'empty symlink target' '
>  		#     @@
>  		#
>  		cd "$db/depot" &&
> -		sed "/@target1/{; s/target1/@/; n; d; }" \
> -		    empty-symlink,v >empty-symlink,v.tmp &&
> -		mv empty-symlink,v.tmp empty-symlink,v
> +		case "$(echo empty-symlink*)" in
> +		empty-symlink,v)
> +			sed "/@target1/{; s/target1/@/; n; d; }" \
> +			    empty-symlink,v >empty-symlink,v.tmp &&
> +			mv empty-symlink,v.tmp empty-symlink,v;;
> +		empty-symlink,d)
> +			path="empty-symlink,d/$(ls empty-symlink,d/ | tail -n1)" &&
> +			rm "$path" &&
> +			gzip </dev/null >"$path";;
> +		*)
> +			BUG "unhandled p4d layout";;
> +		esac

Looks like for this test, for previous Perforce versions we were making
a symlink point to nothing. For newer versions of Perforce, we seem to
accomplish the same think by creating an empty compressed file.

Seems reasonable to me.

>  	) &&
>  	(
>  		# Make sure symlink really is empty.  Asking
> diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
> index f049ff8229..8e34f72198 100755
> --- a/t/t9825-git-p4-handle-utf16-without-bom.sh
> +++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
> @@ -22,9 +22,21 @@ test_expect_success 'init depot with UTF-16 encoded file and artificially remove
>  		cd db &&
>  		p4d -jc &&
>  		# P4D automatically adds a BOM. Remove it here to make the file invalid.
> -		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
> -		mv depot/file1,v.new depot/file1,v &&
> -		printf "@$UTF16@" >>depot/file1,v &&
> +		case "$(echo depot/file1*)" in
> +		depot/file1,v)
> +			sed -e "\$d" depot/file1,v >depot/file1,v.new &&
> +			mv depot/file1,v.new depot/file1,v &&
> +			printf "@$UTF16@" >>depot/file1,v;;
> +		depot/file1,d)
> +			path="$(echo depot/file1,d/*.gz)" &&
> +			gunzip -c "$path" >"$path.unzipped" &&
> +			sed -e "\$d" "$path.unzipped" >"$path.new" &&
> +			printf "$UTF16" >>"$path.new" &&
> +			gzip -c "$path.new" >"$path" &&
> +			rm "$path.unzipped" "$path.new";;
> +		*)
> +			BUG "unhandled p4d layout";;
> +		esac &&

Looks like the same deal here. For the new version we are modifying some
file, but first have to uncompress it and then recompress it after it is
modified. Again seems reasonable.

Thanks
-Justin

>  		p4d -jrF checkpoint.1
>  	)
>  '
> -- 
> 2.46.0.rc1.dirty
> 


