Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADF3438BD
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069463; cv=none; b=mjrxhefvMtube9Pf8UebEMcWXrRAKSTGo8MepVr7AmqYxc+PUStPUueY+/rpAB4KhYtNBDtSt2CZdp4iCHfuxDdCAgZLrSaLhU7jw4DzS1lhaddhExcBygG7D4o6dROhshyt0vUow1yT3R5NXAP/jGrLLy/qEEasA1IBTr2U4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069463; c=relaxed/simple;
	bh=Mbcvc8QpARrXqysVh7ltwPDA4JZBv0/VfK8w6dizYEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5XK/jSRGV0gQC5yVUwl8xS14WFR+m7h7TSTn9BK4tH494OUB91v1jqz6Gk0L4ao/UMn3VQmMDY2Xim4RgWBQ/lIav5GglRQcxYUlsbvroPY81Ma8/Giv1hGWducxLojTUQrMTQNS9IeikDFn8llrkg8QdzjTxXOhRLIrKo3AHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOljzAzr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOljzAzr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c733f15aso43164185e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069461; x=1784674261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b19UP9nedjE5KCIEMaWDRrIWrZi6CWGK0+H1sVw2EW8=;
        b=DOljzAzr5TOpPOcSZhO8Uk4I0seEV++9/i4wANYdXkUeDF03ZErLiyi5ai8KzjBtYC
         2O/FSeKIes9fljZ004v+qJb7TcESDVh6IcXp+DiyArkGa8+KjT5NXNrIqtFtvtpNPJ79
         v3Ym0XxHymHj/oaCz9Qj2AJNt2hgSx0HB2DItoKWAY2oZ99G9BCyYMDTlFDHtXztW7xx
         A3PQTkICrAfUKFTvsT3cEEeiGi6EmdWckf9XTWqy+lUa5af8Cb4JwnUVfaOBWvGR8Ytc
         iRmlG3/0HvnMkWOT8L6YtfO67gyxErcWNFePTs1hZYX0xgBKe57Xglo1PEj8zR4QzpHx
         94OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069461; x=1784674261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b19UP9nedjE5KCIEMaWDRrIWrZi6CWGK0+H1sVw2EW8=;
        b=cwYmx6js0S2T4m/SinWnGz7QmFQtrHCCJX+LBdBFqySNRSyw//yw47f4ZoBx5MB+Tt
         vzCAFNS36E7liY54EepCfkDOOg+HWZMNh/CnkA8rg+LeIHFW5HpWF66eSb/hW/7nZySP
         NDomknUHGTnj/3PPCbP/uGldoYqmEKx5Z5lJLok7cP2G2eBsSFt5uN4kv0NwYAr6Rrvp
         Cc4X8Qk/z2YW+NcUwT3+UJRxuQECle/SMpAPC/U7H7GsBHtTMdNm2Mvk+Qr/m5Zzh0Um
         j5RqPtZauZKrycEDv8jaJVRQA57juQJdZw9ITXotdBGPd61ed2A4VaLTTfqBUIf3qguq
         uLvw==
X-Forwarded-Encrypted: i=1; AHgh+RrcI32Ghh1N2rz4n7duBW3O+oHo0GPGX9u3pY9ojq2Eeo3r6uLdJkOAFB9F0s0SOsO4MIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7aypqog+0qFQ2pLWETkzUrUQDnK1KVoAtqUQcEbsCQ99X/fk
	UkpHWHJKW0LejNWDJL+Gxkz4iX3F+tDaLRA/FZy/pnNDjzpxnu6NwSFn
X-Gm-Gg: AfdE7clYGuudn84wezGUhVqOwNwnpPosmyK8QdNfmmCMUcJyzjaeqlFJGUITE6Ruxw5
	s70ufbG28tb1fcNn2YnpyQPcGvnTs45nzQtMnfEAFam+7TxJfrrZi+HrNiexLCQf2jmKN4DuY7T
	4R7oSEZhZl3AtRNyoVYelDH0zlqT++FDZwLrTJRvV2NPeawsmLw07gR7SdWYSD9e/mM08Xu1Gkr
	08YWYLc9h/EE8ydpcSAquoIkCn1AKRt1N7oPwaB6K+3wzo11rA72ihEYN6BNRvqgqPbfw3in7qX
	8E8Pb5kgKSL7tXvItu5H/tD/L+6cOs44w9Tn/WQWA6QAdaJ4FxLqWUaxV3+yc5ktsyovDyWE96C
	k7Tfqu5UKnH+qJb5BUE8hmDEtf17Pz+j+tFP30E/+UxtC8bcvNdHeLWFzVqyWFCPkysqGBt6CXc
	Vu5kXIrDVTCzu2iZWc
X-Received: by 2002:a05:600c:4fc4:b0:493:9cb3:53fc with SMTP id 5b1f17b1804b1-495389d2bb0mr46552425e9.11.1784069460515;
        Tue, 14 Jul 2026 15:51:00 -0700 (PDT)
Received: from titov.fritz.box ([178.175.129.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm121778475e9.3.2026.07.14.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:51:00 -0700 (PDT)
From: Andrei Rybak <rybak.a.v@gmail.com>
To: phillip.wood123@gmail.com
Cc: farid.m.zakaria@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	oswald.buddenhagen@gmx.de,
	phillip.wood@dunelm.org.uk,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 02/10] sequencer: move definition of is_final_fixup()
Date: Wed, 15 Jul 2026 00:50:56 +0200
Message-ID: <20260714225056.2285055-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <02670f57e7d81d4ff7341fecff3ef04b9fdc0102.1783948637.git.phillip.wood@dunelm.org.uk>
References: <02670f57e7d81d4ff7341fecff3ef04b9fdc0102.1783948637.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move this function earlier in the file in preparation for adding a
> new caller in a later commit.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 57855b0066a..32a09b6e87d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4627,21 +4627,6 @@ static int do_update_refs(struct repository *r, int quiet)
>  	strbuf_release(&update_msg);
>  	strbuf_release(&error_msg);
>  	return res;
> -}
> -
> -static int is_final_fixup(struct todo_list *todo_list)
> -{
> -	int i = todo_list->current;
> -
> -	if (!is_fixup(todo_list->items[i].command))
> -		return 0;
> -
> -	while (++i < todo_list->nr)
> -		if (is_fixup(todo_list->items[i].command))
> -			return 0;
> -		else if (!is_noop(todo_list->items[i].command))
> -			break;
> -	return 1;
>  }
>  
>  static enum todo_command peek_command(struct todo_list *todo_list, int offset)
> @@ -4925,6 +4910,21 @@ static int reread_todo_if_changed(struct repository *r,

4910 is greater than 4627, the function is_final_fixup() seems to have been
moved _later_ in the file.  But the commit message says "Move this function
earlier in the file".  Am I missing something?

>  	strbuf_release(&buf);
>  
>  	return 0;
> +}
> +
> +static int is_final_fixup(struct todo_list *todo_list)
> +{
> +	int i = todo_list->current;
> +
> +	if (!is_fixup(todo_list->items[i].command))
> +		return 0;
> +
> +	while (++i < todo_list->nr)
> +		if (is_fixup(todo_list->items[i].command))
> +			return 0;
> +		else if (!is_noop(todo_list->items[i].command))
> +			break;
> +	return 1;
>  }
>  
>  static const char rescheduled_advice[] =
> -- 
> 2.54.0.200.gfd8d68259e3
