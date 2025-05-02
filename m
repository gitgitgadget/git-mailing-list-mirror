Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAC6EB79
	for <git@vger.kernel.org>; Fri,  2 May 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746226139; cv=none; b=NTTtJvpCu33Dxr40VLjTwiDibabNkm1xf0+pLD9pwkxYOCQjb5kJY+hvZizJy4tFl0ujfKlfWdbUd222vLl7K8SOjX8Yki9zxqTW0vh802tA1YMsEvovvB9JUh2TYaxV/m+CMX/V9JarD6cKA/sXI54p4eOpmrkN6l0J1nkVN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746226139; c=relaxed/simple;
	bh=J31hhVlmH/4Mefly6/zYuru8S5Pn9SShAdV2XrgdHow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3gDVnjs87Xme3+RY4JlM5Y8kc1eTUWCKiWej0i61x/qxb1Zx78USTUv8DonhVkXtRGNL3uESGSzaI8GK9pGVCtPUQr4XCQAJLA6uKnzVm9wdWIXOBlxR8c8e+VSeOcx0vqXdMMOTH0Lz6Avp6XJrzqWdrnffbZy/sMlkLMIS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YjavfW9B; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YjavfW9B"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4767e969b94so56113781cf.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746226136; x=1746830936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j59Sq+DUOg16VRdmAP/HZIvqAypYRdIk8n6rqvXEaMA=;
        b=YjavfW9BrVbTp1lQrBw4YZ7ijwphBZY4fQZeytUtiB3EltfOgPlWmRH6wmhOtH/I7V
         mTvTPn/llNck4ewjb7n4Xxo3TKaMzhHMda767XEN1cCvOSPfcpN/UqS3Tzi7yZ6Rag/3
         CY6dcUL0b1TvsHa9UlhtPtmkez9P5HiWLNc1gA4zHLubD/NPdsvO559rgazUwJogBs0j
         fyJtZwkWhZGn+M3D4YCrHM81814dbtir1SCr0Hx5zlZkPwWUWSqSSzlE/2k/ZQNBmAiK
         XeZZ3FGvLTrMnbhxYGEbxUtHTlCHTXXW3td9QFYCntopZICLGzm6jYohIXwqRH29mksA
         of/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746226136; x=1746830936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j59Sq+DUOg16VRdmAP/HZIvqAypYRdIk8n6rqvXEaMA=;
        b=BYxr+E1xpu7kggNmlqKXa6gsrAJXm1WCirz5StLJn2HuZFLg/MQffYc4J/wF9XsdAL
         uTCFxYqGh529bKsnCgPEAPlB+tF3nqaJBJ+9/fkCJ7hZ9WZ/Tx12etMDQewLMwHbabME
         R0d8WZFtHVI4o6kMOcZbQugqTOnF8YYvThh2mlU2SRulrw5O6q9slPcZjCiZ7vxbPCnV
         R2SAmgIrcTYNNgcciW78rK9MSfFdkr7mtqT7lOizSH1Vy8EvZ+qRDERxBUYNtfvCSa0s
         VQYi4Vf0jTwoIuP8+BVL70/YlYCekLK1+vmeyS5ejLBlUj66h1R1vezSmdukwpWUO2/K
         yDRg==
X-Gm-Message-State: AOJu0Yx+9byry7LSSxamUqD2i8ePzHKf5UKJ5b1U53n69flY26zopbeW
	9YvR27pjdEaq9LKZZLVwftajpBV1E5eMWnNekP8LP1uW2NihwhjhBD2hg430SiI=
X-Gm-Gg: ASbGnctjRy6dgsFH+iwHQkAMEgbM0epp1Qo6aucG2I6RgNTBbkmJhnEopU4GYf2J7Rh
	oPvo/5nsF5CRRztlpNeUX2Ph1ajAVxIaNehbjLnFVE5BCCccNCTEmEo8GYV3sfzdKQYl+CdrarV
	PmJtfyE5DHco4q3A1/lqHL3gGIowbpvIaOsUETULE4jHguq5y9G4FR1BiMf/TL0NSRZPz2lCFah
	ochi3pmTFMKd4Awp10//CyX3J1tlcTMHTfqoikHUOBOTpZUL9dc6pX3lvIqDCJ+OLS/soyj19+n
	3trAOuefK6Ve/pWrryvMP4p/1+odzovaMvFytiATPfFFJSnuxcxl6emfkmBs4SpHud+Q5quNRou
	gZ/5rznz4AeDs
X-Google-Smtp-Source: AGHT+IHJ1ESSy5E7mO3ap4aBM/VEiyb29Ypn2q+bvTWltjxI8T0Iqoo+/xtI5Uf5K/igILPfkAWtIA==
X-Received: by 2002:a05:622a:4106:b0:476:add4:d2cf with SMTP id d75a77b69052e-48c31737a77mr82959761cf.16.1746226136520;
        Fri, 02 May 2025 15:48:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b960cf551sm24453061cf.3.2025.05.02.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:48:56 -0700 (PDT)
Date: Fri, 2 May 2025 18:48:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/13] pack-objects: extract should_attempt_deltas()
Message-ID: <aBVL16rCzFZGjw89@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <57c1cc20de0c80b84ad11a6546763826fe4b1a09.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57c1cc20de0c80b84ad11a6546763826fe4b1a09.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:37PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -3226,33 +3256,11 @@ static void prepare_pack(int window, int depth)
>  	for (i = 0; i < to_pack.nr_objects; i++) {
>  		struct object_entry *entry = to_pack.objects + i;
>
> -		if (DELTA(entry))
> -			/* This happens if we decided to reuse existing
> -			 * delta from a pack.  "reuse_delta &&" is implied.
> -			 */
> -			continue;
> -
> -		if (!entry->type_valid ||
> -		    oe_size_less_than(&to_pack, entry, 50))
> +		if (!should_attempt_deltas(entry))
>  			continue;
>
> -		if (entry->no_try_delta)
> -			continue;
> -
> -		if (!entry->preferred_base) {
> +		if (!entry->preferred_base)
>  			nr_deltas++;

OK, this part didn't move since nr_deltas is local to prepare_pack().
The transformation looks equivalent to me, with the only minor
difference being an inconsequential one. Before, we would increment
nr_deltas if oe_type() failed, but now we don't. This doesn't matter
since the failure mode is die(), so I think this is all OK.

Thanks,
Taylor
