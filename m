Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0197C0A5
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407427; cv=none; b=JefkLPTKYVrcqeOQ7EEC1ykXY0dkQ/Q3qQbkkjosd49R0fi+oPP2LNs4N4vhJV9FqzuF2e4pvYJOpzSK2z9a6detEfHN1Wm31KFwVuT+tuhhWsT2gDNTD/JplaUXcPufZLsd579CtO8HFDiYAIHb/vAPhJo1IKYFaYGDn/0ee90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407427; c=relaxed/simple;
	bh=14XBSxA8j3pGG/IFVZylIFBlv6XfOwS92GKAbaUk/bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kzoa2ON6G62IV0xKCvXjmZyKf4JAQzt+USnkfg76q8WNFWLCWkyua/5qufkdU6+/rP61esg394iHp1isG3UVFaQ+pI4H1yvEEwNcc1hTp9gpxziMAabg4ETOSPstSUIw4gefKS9P5OkseI1qrlnAQ7l9HF/ODbg042t7IQHeE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huAZOFwl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huAZOFwl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511234430a4so4043091e87.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 07:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707407423; x=1708012223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i3/aBJBznbi5nVYsHNmvKU9gX47mQM4Mcd2nHcrtwzQ=;
        b=huAZOFwlaK67DCtbowNTE2wDKbQPmyA2PKAOZpFPdC251e2pPlrlz/xdLaFLoXL2Kk
         rlDOCFblqaZrF7tH15jWEqZDSQK9eLtcT+z0QJXrELbDMitcgmnB+6t+b80W+GjFDRuO
         aRFTYtDdHlf/KQVkxAk9IRdV9pGssKOUXGO1tSchmfrdDzQXdo7BSkZEHohh2Dj7HV1M
         TibTxsMx4IGopkfX++I9kKrHCwRD6/YNdh8nkAJ2zRcL6LH3Cs3Cn+SFRxq4DaFUUlDX
         hcnpnzBmXzpNkNuNJ3uvOqhC49wPAIJjRnGhua60hO0tkpOGWxuF7IosNnDd1oLDCKzX
         lspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407423; x=1708012223;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3/aBJBznbi5nVYsHNmvKU9gX47mQM4Mcd2nHcrtwzQ=;
        b=esd6C9L6CWNRpzFxkI7nWEM8KQzvgg2HVPyjZfEzlVeBzlPmz1uECJ610t3i3M9unf
         2X3AGvG00YttbVzzRCnSB3tSnshTDDGnfqxfkizQAFyOm5+zsKhHNlQ1C8BUYIf3dusq
         nE6aTyf0siwpEr2nJ5itx0cPEnCb52+OcJeL/X3EKSToeGcycJXoim/RXBt3+A2BfFlQ
         Jbw6yWjTkwSCHVDzIrzT9Lcuo2D5bAWMld6LFCR0eaIOXIaQ7lsUEgg+t8F4pnFBN87z
         6DGqX/GkxoOQxUpTD7x6pZ82lU+eOau/5T4RbFyVPdaXuCTAEg2iNwULEPSo8+wVgH2j
         FriQ==
X-Gm-Message-State: AOJu0YyNbU4dCoA/tGllzrFQ0T00g4LsbWQnKHvc1Ctgt8LsGfHxEDd9
	XK0q44ylnzTQjtsdYFWmqAYv3Mo2WKKh8ipOHj4FfD/N6Ek+BbDB
X-Google-Smtp-Source: AGHT+IFrWS4srbVpCB68Ns8f/8LTxP20thDUM+WsvX8dwWflK2tv94PAOPdOxsOppIC+69MzDW2jJA==
X-Received: by 2002:a05:651c:1a28:b0:2d0:c322:7638 with SMTP id by40-20020a05651c1a2800b002d0c3227638mr5856524ljb.39.1707407422972;
        Thu, 08 Feb 2024 07:50:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMuNnzourYUzyyMyqdbEWRoZCHDfBtrJ27S4AmUCq4VbYzw0V8Z35zNYTZDtjBrJcLBCNEPpChLu6qTcksl0a8aICt
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0033b525dbc70sm2667150wrb.79.2024.02.08.07.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:50:22 -0800 (PST)
Message-ID: <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
Date: Thu, 8 Feb 2024 15:50:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: Commit fails when no global email address is set even though
 --author is used
Content-Language: en-US
To: Marcus Tillmanns <Marcus.Tillmanns@qt.io>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcus

On 08/02/2024 15:26, Marcus Tillmanns wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> * Set your machines hostname to a name that does not contain "." (e.g. "ihavenodotinmyhostname")
> * Make sure you have no name or email configured in your global git config
> * Create a new repository and "git add" a file
> * Run: git commit -m "Test" --author "My Name <my@email.com>"
> 
> What did you expect to happen? (Expected behavior)
> 
> A commit should be created with author name "My Name", and author email "my@email.com"
> 
> What happened instead? (Actual behavior)
> 
> An error is thrown, complaining about not being able to determine the email address

This is expected as "git commit" needs an identity to use for the 
committer as well as for the author. To set the committer you can use 
the GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL environment variables if 
you don't have the relevant config set and git cannot extract a domain 
from your hostname.

Best Wishes

Phillip
