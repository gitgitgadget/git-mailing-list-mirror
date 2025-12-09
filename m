Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472F2D73B8
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302600; cv=none; b=EamqcsJI11LCYXfiTvhGChlA8rZU0JiICYHnWkYGYJLE0xjCMj9b1kZ2L2rAgqoShwA+7o2w3qu94Vo3zWAqosqylk5C3UEBDv0iMvamB5m1G+LZ7cQQB/1mEajnMDmM1AMvT6N7ydFJckvnF/Q3p3AwmLSIjbNlXQ8fA/OnBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302600; c=relaxed/simple;
	bh=mMjtT72LPLfxTjEXEGAcd+DekbP/0/h/qTB9cTmNh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsbiYjrNNu/v0rNJF2r4eS9aQAj5QPmmV6GFPsxlnMVcFIxE42SpA82lBa+Hnava9lbsTu4ai8TLfu4NkZnGEZlrWIkBu0ad/T5FZJn2p03kNBD+1ngWjXkLhkVsZtCWPEHg+Oj4XOb5eTYKwizbX7iHLZIZdRI7xP3y7eZUw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl+oKXMc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+oKXMc"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c7533dbd87so5161569a34.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 09:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765302598; x=1765907398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMjtT72LPLfxTjEXEGAcd+DekbP/0/h/qTB9cTmNh/I=;
        b=Wl+oKXMchn7mtZMndIAmDT8VnHob36M3orQcRn3z6i+AjRVDF9pjl7fPxXVjeNrCTB
         Rfo4c9vS9KpAO8/VwkfAg3y0SQ0/P8pzTrlKzotSvSvmixOi+uDrtdZIzM5FxeyDXPDi
         4al3ZW0Q7+WyWqXImvTPtj6enk9RTlyim4fh0Ycr53n9nKJBLq1vBD/z+JJyH9wsiTC8
         pHLBNnCSdcx7raUn/gvMi24kbsvlVc3Cm7bvZ+Y1UHpHHOCzSJ9riFHIJfz2QX8b1LMs
         PR0vzGlm9MGGGwVLrQU4+9YB9VUWj1KM4X/4/3Zv43kePxQ+9MFnW/c8C+N8w01y78WW
         x24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765302598; x=1765907398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMjtT72LPLfxTjEXEGAcd+DekbP/0/h/qTB9cTmNh/I=;
        b=lMiCQfrhiK4YmRv4ZBPPVtD1NGt35XTj0PmrUEKb+V9HyCoPglKKVgmaiF6rfIgavt
         dmdmGbpL453GmN21NQE8/mbsjLl4Dp8eCG9TAg4lkR+9amES9ZLS6fzgg8dQZIijB6Fs
         Sas1lfP+4tdxoU0wqo4Evt0d6ZiEuRPEDto0HEyNsA95gd3RM1I/BjLwLx+B+2mGMql2
         k4oxKkV7FaPU0bespFZhyodJ/YRRG9twwD0qi/y05W7wsKpFsKkeBEib8o34l2mM5o/D
         SMloCE7kUFy89s5Ta/gIyR9gkD8W6lEfy5hap+a+NmHE/kBrNsvr5M+jNe5ee/CqJar+
         Xdzg==
X-Gm-Message-State: AOJu0YzI/IAoT64OkJslDHL72CHsU3Pe9T5dV8+/0yxTTh0hbB1mAlHx
	jyLtDLfKVuNvzv47SKqOvl4sccOiRoYkAzMLlNsYVZ82tyfQk9n5rIqKf4oRLA==
X-Gm-Gg: ASbGncvW1gIpFumYMgJnGjFldEuW8W5CVrh8h+nzEC/O6EUHm+F1pTJLs3XBl7Z714h
	Lh/RegP+3J54XyOKrRfUfipvjb7uHPTOtN7oa5JpsKxzsAuA614DHk88zaARkbrd3aTf7OVCCKt
	dOMKIhu8+dqv2dYuKOIl8+6/zl1zvOdFXz+wcG1kGB6fpe2i80IAm15EUh5TVepwfkDLjJrUJxe
	ROxyA/mfVGkaS0lor0Fo0EzCSfTdYyuGtOwTyHf5eig3nO1NFBF5/KY6p0C6NLXohPtiMicRepA
	4QUZnkZnF9Fjcb2cNtW0szHEkZ6q9fqWbKLyLGa979pwCzh7+uhd9gDEoD10M9sZlRz26d7HIgM
	XSjTbiohwhzkre9X3w3HInNqPbKDxqeMYG3ZR34fngLZUXW1Bw38P2m9m5nNfKMDnDAwaS8kgnx
	SU5iYglt3HeXlYaG0=
X-Google-Smtp-Source: AGHT+IHplKOQjcIwsxnq0ISL77yT4UaseAcFAb7Leg1K4EmQ54X23RMsJZXSTEdLfWFLV9Ni3qCPQg==
X-Received: by 2002:a05:6830:4429:b0:7c7:59ce:d195 with SMTP id 46e09a7af769-7c97076efdfmr5108645a34.6.1765302598051;
        Tue, 09 Dec 2025 09:49:58 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac8418esm12429633a34.16.2025.12.09.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:49:57 -0800 (PST)
Date: Tue, 9 Dec 2025 11:49:55 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] odb: read alternates via sources
Message-ID: <gmhqd5nkhpk5wqjnfrn6blnxo2owvfgomfbi652fi462nf3tny@eyhy6glagywx>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-7-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-7-e7ebb8b18c03@pks.im>

On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> Adapt how we read alternates so that the interface is structured around
> the object database source we're reading from. This will eventually
> allow us to abstract away this behaviour with pluggable object databases
> so that every format can have its own mechanism for listing alternates.

Ok so IIUC, the idea here is that eventually we want each source to be
able to define it's own way to parse its alternates. This is needed
because with pluggable ODBs a given ODB source maynot even use the
filesystem and thus any alternates it may define would need to be parsed
in a different manner. I suppose some future ODB source types may not
even want to support child alternates.

Question: the interface of odb_source_read_alternates() still expects
parsed alternates to be written to the output strvec. The sources don't
get added to the ODB source list until odb_add_source() is invoked on
the source. Does this mean odb_add_source() will have to be able to
handle various different types of ODB sources? If so, will these be
differentiated by some sort of URI?

The patch itself here looks good.

-Justin
