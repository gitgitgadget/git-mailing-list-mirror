Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB712D20E
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681494; cv=none; b=bNhAyTwWu9x4fmv5bfS82ZsShY5AOjDn9+j6gkNkh8C6gxDgICkemoB0wcpg+DoWr5g3VFgvL2FoUr3IQwts4AlKhFAeE9sGdx1wYMcefhEe26Yj5N7LbEoMf/09GGa+xBXECeIoReh6z/UYR5MyRQRK8OAgOD1meo9HcHUEwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681494; c=relaxed/simple;
	bh=IbV7QOdx9gKxsLVznciqKs9Zha9OQ03HruOh/wnbHa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j17pSKr1bC4zSgbEWiNiplHJTsoUVnxNGl5DyXkNHyBY4lqFlGqCUMI4Y73nBUvJ2/r7LQDGaCUuYtewuO6if45SwoiNn16Ro0MOX9ATb0tR+tJM0VQekDujNXx1zRtvUaCjQvVpcyybPiKSGkhWn7GQ802TR4SscTgNhN9l1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuvO6WSE; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuvO6WSE"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-595b3644acbso165819eaf.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 15:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709681491; x=1710286291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6udObOW2cljHqfrWMoFZZWAeZs6sdJUn4rYFQOkqD8M=;
        b=IuvO6WSEnc2DrDqYf0okft43OWD8bXaolJTTX5lPgiL2aAdsVTzgXTiAvpnsxCXn2R
         J1SM2K9GxuBfslJwbSH2ha8R9nGCDyI7+J4gm0f1UCmwnK5d81SytZSDUPyuY3k4BWlh
         P3IxjV8wPJqA22SxJnbvDvkN1TO+srz0LW8BxoFKuwODqR3mzMeVBjaMeCl+6Yhg1gVo
         gvd6ZmP20JlznXg9XuEPXlphssJblpwiQHuZK1qRnyQBKBFFh8RxXYVTQ2KfvNYZgT2k
         1gbLZQd9yIziyBHYUZ2jwnd0VTFUd5T+CnNnqvWUh1q0cMt1rWzs8Nk/2GYSZodcuMW4
         Ijhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681491; x=1710286291;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6udObOW2cljHqfrWMoFZZWAeZs6sdJUn4rYFQOkqD8M=;
        b=Pz9pjCnqdSr5Zu83GJyOW+01gxLw1yBXNaqFdle3Zx47FjnSKirrcECw4l+y1d+gyh
         6JFmf73BYmQ6lL2qspsKnxCN1yvF5xK4tCp4wvQcJiWUhYMU/5S+JZLT//YsBBzGCFnw
         OoLy4ks4TijgjZ1fJQTxNibpKYjmJxJk0I7WovPz2D7TN60AYou8b4hH74DYwvHGB59L
         aOw6P2TGQgKlEtMcB6ryWAMZkfkF1lwKYUBGsqXvXPQnB9kJYEHAiAmVedThNm6UwHvb
         nXNVNroXOx36PCxf/WcFGRz+H02CD+l+ELtkTKgw5ps43bcrE6FXScrFmimfCbthSZX0
         I/Aw==
X-Gm-Message-State: AOJu0YzqvfrHneAR2g24pLQuDzZ01Oy/O0XQdMe175C4I4kFChm3RR3T
	liunJAtyUunwN3fMNXttHFYR9+JKT4ZiqKbVAac5/P/3bJ0Z52qMfXXT/aM8
X-Google-Smtp-Source: AGHT+IGa5qZFXbUXvhEo/CqZ9S0mnzbojf1BFlA7VglMvQmZWYvmwNA39/bx81J8daXFuVyE76YBqg==
X-Received: by 2002:a05:6870:3b07:b0:21f:406:8ace with SMTP id gh7-20020a0568703b0700b0021f04068acemr1626024oab.11.1709681491657;
        Tue, 05 Mar 2024 15:31:31 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ut7-20020a056870ad8700b0021e7862c59fsm3177891oab.13.2024.03.05.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:31:31 -0800 (PST)
Date: Tue, 5 Mar 2024 17:30:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] reftable/stack: register lockfiles during compaction
Message-ID: <mwhby7dxpiyrvknqe2uoli4ulygjy6hbxcxpqt3alw3dthwntr@4o24tp5jp6h7>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709549619.git.ps@pks.im>
 <45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>

On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> We do not register any of the locks we acquire when compacting the
> reftable stack via our lockfiles interfaces. These locks will thus not
> be released when Git gets killed.
> 
> Refactor the code to register locks as lockfiles.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> ...
> +	/*
> +	 * Write the new "tables.list" contents with the compacted table we
> +	 * have just written. In case the compacted table became empty we
> +	 * simply skip writing it.
> +	 */
> +	for (i = 0; i < first; i++)
> +		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
> +	if (!is_empty_table)
> +		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);

Something not really related to this patch, but I noticed and had a
question about.

If I'm understanding this correctly, when a newly compacted table is
empty, it becomes possible for a range of indexes to no longer exist 
within the stack. If this occurs in the middle of the stack, future
compaction will likely combine the tables on either side and restore the
missing index range. If the empty table was at the end of the stack,
would this effectly reset the max index to something lower for future
tables written to the stack? If so, could this lead to issues with
separate concurrent table writes?

> ...  
> diff --git a/reftable/system.h b/reftable/system.h
> index 6b74a81514..5d8b6dede5 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -12,7 +12,9 @@ license that can be found in the LICENSE file or at
>  /* This header glues the reftable library to the rest of Git */
>  
>  #include "git-compat-util.h"
> +#include "lockfile.h"
>  #include "strbuf.h"
> +#include "tempfile.h"
>  #include "hash-ll.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/

Naive question, why do we include the headers in `system.h`? I assume
this is because they are common? Are there other benefits to this
indirection?

-Justin
