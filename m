Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427D81724
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267565; cv=none; b=JZiKRZR9mZSQmMnBT/fOT81JiG1WR8jsV0V5eNiU29hNRF192lTQQr4ulrR1XQwXN4QrVAOir6mqpVKr9+n6BwQL1g1Jmuqs2l0qFClXVLxyJtxDmpHZd6QV5KFw3qEAlrEKHL8Wot82G6Nm0NXUpnB/hfMUv0qTzsCDO2GCb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267565; c=relaxed/simple;
	bh=irJ1QDhyDpRu0ufBYIzKzrmA1rDFaJPvJVHQg2FahDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFUxcaYbhUmYj0GcEZrqzanlalK7WkQZN2HkFeucQyW6sg6+LcHmqoR68baOrXoEl4yWR6kBQwRdGzftecTaW4OP4UKVmECuYqDCTwNb5flrlbxNuWCmGQ4hRWeFnckuIr9Ij1maP66F6pI9xF25vTzhlLobTuPIh027ck9XyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3FSsYAR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3FSsYAR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so1250200a12.3
        for <git@vger.kernel.org>; Mon, 26 May 2025 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748267563; x=1748872363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMiIOI06enoBY5DooD0cXWYtt4Cbrx33MB66yZpwAbk=;
        b=U3FSsYARm22gyOnoq1oUJviLcafZB1hti8A1/Yx1otRoP+aA0hPQY5eB+nWzimqSzq
         VjN+jbp064JCw4WMW0MJIuUl90to0Nyl1S9sIHkFvw5I91OHd/pp0HtwIHT+5caFFS+v
         gbF8U5FhNm03tMsIwvXrD9NGepdjlYQWVWhgQcfOhtz/5ZksuGOziQZyTRAW+xZzb0RK
         VqRO+l3YqA+WjXNsIj1EJIwlYYbj9WR6DUT43b4TqveN9/ae3K7jn5RH+1NGRVeXsUjk
         GRdO2KKbXenLoqiDHX0v2KMhB6HWFVMW/QQB3og62zNdEKY+qSd/telqzBV/8chZnyUN
         fvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267563; x=1748872363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMiIOI06enoBY5DooD0cXWYtt4Cbrx33MB66yZpwAbk=;
        b=IjZ7mAODQpeNAHXqLcLxZGfFAiPu08Q9n7m0XPckfrPoAEd3HRk2el2sWYomzIPBkF
         Xr1W90USLdOpBv19IpQv03OB4uk3B/U2iFbWjF3BsTOOg9em1W57+GdJKVoW7khx9D19
         D2tH2CJAerv7qdMtRNkT/7IMBuiYaFcIUn4cfkCPKE0JNtDNDPE61uhg1OkmsFX+IO7P
         zmaxSL1QigMhxDOFyoPYiTLtyzZqKJv0N3JgPgGkqaJIyaQDtS02p5B2cSlQiRRTRnsb
         zWfQq5Cxj+sDSIqgTs0tj0COYieG4wrQhAYEuc5R3tNzsPx+syYe8OvrN/MT62EvDAfb
         u7hw==
X-Gm-Message-State: AOJu0Yws4DC2FF6kwax2geQ+2juTnEIb3JQoSt8M5gZ7J5xRpWFTw8wS
	ptU2/i0ZdutFK90TMIyKMwSOXxiW62ZDdcewWgXLO/JLNlBBA+vGhg+d
X-Gm-Gg: ASbGncuYeHG0zZ5buzyuNs89VnyzK1XXBLDxDJeTw1kpXLcafXfoIcWR3kkbAlfbSs2
	yt17FBdITLfV1p07HoK4R+tsuqpWMEdhOsgkAoG71iQFaD0dyJyd1/Ub2KK8hXgGC42LPpHOqdE
	3zZqc5NXMWE/Z79lCZockHRmKVF4bj94jQSKJYsGTZ8CdqBvDDr6z/MGZLB2MfTyHazQZAlFCHI
	hJO1sg5V/dO8FWmISCjSLKco9AGPNBJXU5WD5R3Yhg7PLwq70E/LHHHKnaBuGNtJ/uNblFLvvlL
	0YkzyWrPEZfgk0lGEmlb2eZVpN26RDdWxW+tdGfetwclXsU=
X-Google-Smtp-Source: AGHT+IHnDVqstCzk4bajpiidyp9AE8mx5srBsahcvXI5tP0PdP9kn19C8YiCG1Co3Ol5bVUnxlVJjQ==
X-Received: by 2002:a17:90b:33cc:b0:30c:4b1d:330 with SMTP id 98e67ed59e1d1-311103c048emr14707577a91.27.1748267563145;
        Mon, 26 May 2025 06:52:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31198443104sm582287a91.13.2025.05.26.06.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:52:42 -0700 (PDT)
Date: Mon, 26 May 2025 21:52:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter
 from add_entry
Message-ID: <aDRyL57_jkyNjaGQ@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDU46MmoGPB60b@ArchLinux>
 <aCrbIbB8DDw0eeae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrbIbB8DDw0eeae@pks.im>

On Mon, May 19, 2025 at 09:17:53AM +0200, Patrick Steinhardt wrote:
> On Sun, May 18, 2025 at 11:57:07PM +0800, shejialuo wrote:
> > In "add_entry", we accept "insert_at" parameter which must be either -1
> > (auto) or between 0 and `list->nr` inclusive. Any other value is
> > invalid. When caller specify any invalid "insert_at" value, we won't
> > check the range and move the element, which would definitely cause the
> > trouble.
> 
> Maybe "which may easily cause an out-of-bounds write" instead of vague
> "trouble"?
> 

Make sense. I will improve this in the next version.

Thanks,
Jialuo
