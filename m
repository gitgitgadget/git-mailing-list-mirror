Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915A91F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeAVLtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:49:32 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:40300 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeAVLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:49:31 -0500
Received: by mail-pf0-f178.google.com with SMTP id i66so6896853pfd.7
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j92GzH4JpVYbrXr54b806qrFB6gboNWKUImMdDhSCEI=;
        b=qOwRxoL94Ze1h/ULE6XH8UnbWCyqZplRJnHjrmvnruVEuPe4eue61mV1oxwlVyF43U
         +ldKhcHrNHjnB72CNuZEHXL/eVByLgme3bHx8NjCBzRpY8KoNYSUjYnCfmToNMbpRybd
         iE97atwRS0UHC5+VvCgeGyM4McQJwUj0tHEhUjjiK03SXUVRVKzR7ZJCLydru47QRje0
         1rwuCZgHlKrZ9macPaTou5c9gvgITGCa6TXmIbbXVOZZ+twl3goqVfzDOhNvcGhujMAx
         vMYbCrVziYR+0SnH4qcRYxT65fIXxWEZrBNixXzx10S21hv3LzFM2sLPuTKONaalj312
         6Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j92GzH4JpVYbrXr54b806qrFB6gboNWKUImMdDhSCEI=;
        b=l+sFWLo5pV7IsNiA6r+c5NSAVuaFFno8wP0fnEHWECy1YY9wjoJyDU0v4kRhOEQ0ZZ
         V57puYf5fQ011eF4K+rojNdD3mCF1qy7a8qkPGYV8wHROyPYFxPRQPKCnolWhNjODxKw
         CzsOkLEDXbjUEzCLYC3Bkr6QZlCCCShUUza1m4ZtEynGPRd0yJTcsxrQyY8IOGyLEpDC
         /md+1JdWnczxms/VnLeoe8XBnPahZ5tvJRr/aa7fZkvOjIXcVEeFEmrdI7fprxZz8rM1
         MXxztVG8uoJ3Cp8TchPZQ/xFb51LpqeD4npgrMgeb0dT57EJJDqvdr9ojZ6/wWwEdLzT
         /71g==
X-Gm-Message-State: AKwxytcACGge9Txnz1Mm+1VMJOz45DtQgWtRSfxzLm85HdbOJtjROj8Z
        nB76U5DS/Ik2JE598UDbBYY=
X-Google-Smtp-Source: AH8x226uMnoN62DrzBxdJS1n252dYijmRO2vVN6m5LJmH30OWVn6M+on0nDHfsLP8JRG0q3wDJc1jg==
X-Received: by 10.101.90.202 with SMTP id d10mr6989818pgt.366.1516621771174;
        Mon, 22 Jan 2018 03:49:31 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id a64sm312575pfg.89.2018.01.22.03.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:49:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:49:26 +0700
Date:   Mon, 22 Jan 2018 18:49:26 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 05/14] sha1_file: convert hash_sha1_file to object_id
Message-ID: <20180122114925.GA5980@ash>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <757646a6b42e8a0ceb50665a1fe6f588227d9873.1516617960.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757646a6b42e8a0ceb50665a1fe6f588227d9873.1516617960.git.patryk.obara@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 12:04:28PM +0100, Patryk Obara wrote:
> @@ -969,7 +969,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
>  
>  		/* step 4: substitute */
>  		strbuf_addstr(buf, "Id: ");
> -		strbuf_add(buf, sha1_to_hex(sha1), 40);
> +		strbuf_add(buf, sha1_to_hex(oid.hash), GIT_SHA1_HEXSZ);

oid_to_hex()?

--
Duy
