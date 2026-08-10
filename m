Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D97403B13
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389392; cv=none; b=f+A6xMZj3AngOPvRVqWIMM8JLcA9tlBQLFt+erVp9lOf3z7cLCPtyNVK1LJ2dVt8IceJDxK+Lal6rrGWyjFr6zJx8LK7tAYRKiFo5LnzEZACHIbI/BEsv0FN88oHvDGpWbk2XBnWiZb9jSP+DPqfchb4ulP6B0iC9HxxMiJ1Eww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389392; c=relaxed/simple;
	bh=Z1tZZYgwOlQ1eiWReG22tPtNoejHG4uBS8ov2TLHCNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRiZTP0Kn2pGP1mrrtc9b9BvI6ibZWPImNdjSdph1ZW5l4iueHPuHK+zTVERwTNbck22PvMpivPKQ/JMEk9/S6qphFvRM7YWhl9t8UNsl7Sh7AeXsvvInl7xelGNf/8w46eygsAF2knFLctByOJ9lrTuUydzOitZMrYXLk6ulkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBYBl8DK; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBYBl8DK"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso2354024a34.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389390; x=1786994190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98v8fS6nFYymsNuMSGV0DPitNB0vZOHFWQCv3dcZ16o=;
        b=YBYBl8DKbBLdUW682JzrShh/BHCS9YEyYU+31mpYElB+KwMZfRrYGqDFTqWpdal7Br
         cbmA9BPeedECux3rfwIKb4N0zGTF/SUu6FEbJml1XUGKp8Rju9t8BrX3EtsVkpEDGPVx
         R1IyiqWYH6I7RrMhcqectAYCeLH/Y/GezCE7XsSmnWLoIv5VxwPF4amKlqIWlW3G+f6R
         xchHqVDTc0/XJTN7rjOOCryi1U5Tc/W3IlxgRbHQznUIMe6ZqVWh/FGYMcFPvPthHmHY
         37CSrTNVL6lqFDDrv9jRYwT9oKrlDtNT4MMSksTVoPmMRJz6e1Juva86w8hI0qF15iOe
         EUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389390; x=1786994190;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98v8fS6nFYymsNuMSGV0DPitNB0vZOHFWQCv3dcZ16o=;
        b=BZtegnzfbxak9YteHRqGoJwXPRPaORXC9skOpZWU1QsgvkE8nJqZWy6TbuBLKjRygE
         O+YvcSeXPffl0NeNsmFVFJMxvJdgN5KK8wUyveQRnk9x0a0oQCsQtiGKoGz3oFpLZySg
         NexUfSF1Z5+WN6tfI27aY4+Ef+aGQFTLE9XP857s1OxBaW1IhnMGt7QJ179zB4nRYeyW
         q1c16wnt+gO9DKcPawi8PwWcI+i15DTIUg7HLwn9hM/W79PTa5w04MZFKPMRTE5IiXI8
         lfUJ2h2MQeXkFrcBy9tzxinckIkeZJiKz4SaWstGsP5OUpF2sFZAik73lmeJh2c+BRLe
         VXAQ==
X-Gm-Message-State: AOJu0YwHXoB76tvRCW/wHapOSVlnZ1/WsF1BGnOr3qp6woYtq3MfH99m
	SP2E1yiXcCH1eAOYM5IC89Q3zAvO5xDl0ICj6jylUAl9dweuSxl4WYKJ
X-Gm-Gg: AR+sD10yAicwf1B2AAW2MK1cXIpnfybsli3YF0KPelwdOVxwFkjf1UMp2JTcUggGXuw
	BFOMcrcUAKy4jF52YekAE1V/mKFfZOFbM+TTKfhcwQYg6owlKFOrH+/QYEUfUCGGou86TwKZ3WB
	FVbCU3Cd6uIZZklt5r4e/BzGTZku2uY2fGzlihU9aIcAHTObJe8QnvxK3V3WvNiUusR1F24Xyf/
	BxtB3g4/JMns2Ajd01DFXOQlxGHouK524Kv6X1sBVtIvFIfDT7mWvtHMCj0HE7ZS9rKkAxc0GyE
	CChCq0zd/d+1uI3pYQq19dc4C1BHEUPCmwBA5BRZO50WuB5XH9SIM+f7LKnCCddmVNulncUIu9d
	Mzm7ip+UwTViFo2H//MKBGqKdccpSdDvkwdCS3TjmEJht+N4p/8Tj32Sgxj0EATMdCEiHlq6PI6
	Rhh+W6o/ynIyJhLB17CjbejjuaICE+IbPRUbcPx0aAQT3WlVKtMClmDRY=
X-Received: by 2002:a05:6830:7306:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7f39a940fe4mr2561741a34.9.1786389390100;
        Mon, 10 Aug 2026 12:16:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm8498745a34.8.2026.08.10.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:16:29 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:16:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 3/7] builtin/receive-pack: read unpack limit config
 lazily
Message-ID: <anoi42_kmpc13Axd@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-4-jltobler@gmail.com>
 <xmqqzeyt6ets.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzeyt6ets.fsf@gitster.g>

On 26/08/10 10:54AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +static int get_unpack_limit(struct repository *repo)
> > +{
> > +	static int limit = -1;
> > +
> > +	if (limit < 0) {
> > +		int receive_limit = -1;
> > +		int transfer_limit = -1;
> > +
> > +		repo_config_get_int(repo, "receive.unpacklimit",
> > +				    &receive_limit);
> > +		repo_config_get_int(repo, "transfer.unpacklimit",
> > +				    &transfer_limit);
> > +
> > +		if (receive_limit >= 0)
> > +			limit = receive_limit;
> > +		else if (transfer_limit >= 0)
> > +			limit = transfer_limit;
> > +		else
> > +			limit = 100;
> > +	}
> > +
> > +	return limit;
> > +}
> 
> I am not sure whether this is progress.
> 
> A function that defines a 'static int' internally and sets it only
> once is akin to using a global variable.  I wonder whether it would
> be too much work to add a new member to either 'repo->settings' or
> 'repo->config_values' to make the setting truly per-repository.

Ya, as Patrick mentioned in [1], making it static probably isn't even
really required because in practice we just check the unpack limit once.
For now, it may just be sufficient to fetch the unpack limit value on
demand.

-Justin

[1]: <anlegs6zfUysbx0C@pks.im>
