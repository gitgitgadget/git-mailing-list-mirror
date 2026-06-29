Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667882F8E93
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755861; cv=none; b=cFedg6iIabC7lB5NUsD5E+Si+YxXV6NUyRUwjM5YSNehl0DqvhhfPmhU/zph4mvMgepytZhC9JVmI55rM6Q9bJEDZcQ8g8CCfyHYgwEQusnP/edWWyBYJIGx/IzbokArz66LBH4+QleE+Ud+lhcxQj9AbtqH7g8Rj33PldaHWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755861; c=relaxed/simple;
	bh=PDUXFBJdS7w+GuSSP1HETSOuOYLmaG9bVEXGrDJSDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs6e9xCT3WVv7cX25WmaDEnNDL7Y0/rAjwKf/44eN+NCl9RTDRuVHjt+S3+yNJixJzRQ+lR0n04/rEk7ePGbtSSR5nLhJyjNW/kLAhHXIXtmBENYoUVgiiTAKxV7oYGEsP9pqGz8f209NlNxf7tut79AdXueA5CKLGhEq4ypJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppV1Fawe; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppV1Fawe"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so1121224eec.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782755859; x=1783360659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJCWocpYEkozlLLmo2iidsxGGHaA7DxzFF6+3Hk4AVA=;
        b=ppV1Fawea2zLpwScu5xyapP3b5UDx7ylAUEul705VAeQ8zQLtmUj3p/bE3mMC0g3Fs
         QBm8iAoNAGMEuiHmrdNKTUnMnDSYJrKMCBiTBeq9oQnHuqGXSAJd9A4jm98S4etNwJvp
         Q0PmU37MYdm7Eq9YUh07IedYBq7RiNaZIt+YhYHkoLmpcHTHJCfwksX7Viw4neIz7Vrt
         3NS0262kzrAboKQaBJW6O2b5BI8YrrpvqvtWCxEK/r0ftbH4AfLAx+O8UP4ZnSwhQXez
         XrWCa7iWUAh8vvDGvE/sEh9ZyIjU6iSVIqGk+wW4rnaq4qrRR20Rt0U7dDpPr7S4/ly6
         ygoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755859; x=1783360659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJCWocpYEkozlLLmo2iidsxGGHaA7DxzFF6+3Hk4AVA=;
        b=LwS0SQGuznlU+jNTAmbrho+aLBSruse26chRzJkWjNm1ldwqIWeYYIbxDgh6hJ9F+J
         qb4+FwI5aDLY74x6NEyki0c/hrhPoJ/nqjnwWEhRKJ7sHva1aHzIK456TpF0xNFfwYdp
         kdxnJBhmtOUh3btQbmFFyl8JCnN742+xOJ9zNWOHIp2L7O3m7hYYAhicV4UrYx9+Kz03
         ya3r70jtrFLqlf2Fgx4BPCtwWujjFymgxM+AYntZJh6Z6qZ6SuB1DTnF645P9dEP4dO1
         w8wWSqNBm6zt/XNnZGoihW+dW7rJwrObLYwoT7Vco6rYHaBJe2oUGkD4z5TTAOrcesXW
         3Ftg==
X-Gm-Message-State: AOJu0YzZeHM9TJtf0QKijBW0NDbBp+qIYUGTRMFw3H/PKlhOuKXwfmhX
	NTITsMXCef2z/UCoykXDSsgZun1V7ih9e0GKbd3zPJ1jyN/Gla4q97cF
X-Gm-Gg: AfdE7clRllFHizVi9eEybVYr6LG4nGstjtRYAgjd8BU2QOLpYqT+G9/8BXW61zjhjRu
	/YT5f9GD397aL0eiKhi4Fwtm/yPseoDn8+qvN4MMclBreytfrc2C6/hxhoF/ZUIuMsgQ2ednpO/
	aOHufaMbZPcGTGQeEMKXlBDRfY8qS73247tYXEVjHby1IIQXwhKBsVhtQMFK6W6gQ3r286bk2Ex
	g7kSLYP9EehEhPirE81CMblg0kOaAN5wmndkMqFIxeqJVWG6xakraGCYR5RkDc4CZJdUSfmRu2J
	wUZfQFNY+oxPacLAsFOjbA5PDt+65I3lsGdS7IJiInbaLsw5EwIncIY8DyGiqi7O1cmCvXi/Adj
	+gMyjCk2+yoGEUq82JZCmbMxV3wMfp7pwmuitLXPzaFaMP44TMY8vj9b/ZwhgqtBeFYYYcfUNK/
	RAybuYhQ==
X-Received: by 2002:a05:7300:c8d:b0:30c:ab4d:da36 with SMTP id 5a478bee46e88-30ee1436f6emr341240eec.40.1782755859413;
        Mon, 29 Jun 2026 10:57:39 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4c691dsm45728678eec.5.2026.06.29.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:57:39 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:57:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb: drop `whence` field from object info
Message-ID: <akKxwkg0jbnkL1XW@denethor>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-5-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-5-8d1877b790ac@pks.im>

On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> In the preceding commits we have migrated all callers to derive their
> information of how a specific object is stored to use the new object
> info source instead, and hence the field is now unused. Drop it.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb.h b/odb.h
> index 330a55879e..e0d05eaf87 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -311,13 +311,6 @@ struct object_info {
>  	 * or multiple times in the same source.
>  	 */
>  	struct object_info_source *sourcep;
> -
> -	/* Response */
> -	enum {
> -		OI_CACHED,
> -		OI_LOOSE,
> -		OI_PACKED,
> -	} whence;
>  };

Nice. This patch also looks good.

-Justin
