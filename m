Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CB1A7268
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679185; cv=none; b=l9spr0c/Q0/YN3fqf0XfIKcvLFH9flzm/DTLVXC1NkcJIyeFIMFw6ZLy3lcEFNgII86vGwYP5WaiIeuEA902ynUfv26sG6Iriy0mWH/Rv7HWK5XjnQAEJ7AlHeqlVH3UJSOegNgaxCHprTM4lefJ0H9heSgaFDVoE/kKKUGLQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679185; c=relaxed/simple;
	bh=GYRv40mbrwBDDmFG4Ej6/2ZAzj3XC/fVr8fXUJ8zEhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0NhD34IaYXm9VBxU0mTnv/MOjmAguNh82LEzAAYEZiEEQ/tEHWWZl4N5IEcQ1JWwW5/nBRy8M67S7kl/i/uePetLOoiwDx/ZDiJQYlW7JPHN7c9yQbpwgFv5F7g46OPPpsGmsnGJKULfvjUEIO7ZJYuJTg4yZiMVwCweETA01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D50xEeO9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D50xEeO9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so69966765e9.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679183; x=1730283983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYRv40mbrwBDDmFG4Ej6/2ZAzj3XC/fVr8fXUJ8zEhI=;
        b=D50xEeO95F5oqnFa5ylWv6r2VUjLW8Eni+U3UBbNebXe7g8QZP7HPELmuY0991GdKW
         liGe9aAni2SagCamTVwdrtzuchOvO1K66t4ls0xqaUNHD2uvYwRjIIbyBxFUQy9GMGE+
         hSeCOUP9VNvyhqDk+Dwg8iaymkQByn6jLXMoC37knTNu8IBlBJt5mIUanwDqMUnpL6i/
         CMihGF3xxfqnNCo8D+9m530FnmyWUIHhcM5YruBhfYst9uXtu863PmhworqhnDU/qCcu
         BxGHoS4ptGxpCA8lsI/4jQvEc1vd1e9cJcwp1Wqc7b8BKvEu8cSVnNSLCsCwOBBsu8iC
         TV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679183; x=1730283983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRv40mbrwBDDmFG4Ej6/2ZAzj3XC/fVr8fXUJ8zEhI=;
        b=mvUZ2sMu2Qx4J1gk1O5EAkAVeagyi6HbVbrBkOicsyeltuzsTrmWJvn86q/UScGDdk
         SF1dwNDvB4YLiLFY6vp77ZKDYdgrVDnsMscOd/KM8FpIZE+SB545to3PNFVwBqZjO0TW
         h7hjCO2NzPAu2LzL+TfFHN5dusQoZERPMFVcLn7BH+TFS6Fwb3FbO9b5M+GWL/PQkVJp
         IWZQ1TajvNUB48c424KY6R8oH/ExC3iI6EDZgsAKuTKJeBCldxVqcRHHjbOBS3G6gyVa
         aeBkBbxR65MqmpXqKh2nxvbllDRxQnu+5C2tqpHXqK2B7Cgh66ubWr7z/Fzu8Dr4gttd
         Mpog==
X-Gm-Message-State: AOJu0YybDWK95OOdZd2Y1peJYJu4x11YFdksc2zySRNXFDpsuExaLSwB
	T9M2+5yu9b3G0QTu1opgIpUClVihyWG3Oi2lBn8QgvcziasUm2Ef6MoOyA==
X-Google-Smtp-Source: AGHT+IEqV5bZInItl2jDXdmh5BBnJ8iZbJtbBU55O6+O9zwzJuwSNZGc322j+dVWYGfQg7dY0DNeyQ==
X-Received: by 2002:a05:600c:4ed4:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4318415f81emr19099255e9.16.1729679182468;
        Wed, 23 Oct 2024 03:26:22 -0700 (PDT)
Received: from void.void ([141.226.9.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bdb7b6sm12250345e9.11.2024.10.23.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:26:22 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:26:20 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t1016: clean up style
Message-ID: <ZxjPTDYQGg-IvNuL@void.void>
References: <20241022110730.7655-1-algonell@gmail.com>
 <ZxfUngQKdGZq2dWf@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxfUngQKdGZq2dWf@nand.local>

On Tue, Oct 22, 2024 at 12:36:46PM -0400, Taylor Blau wrote:
> Thanks. In the future, it's preferred to send subsequent rounds in a
> reply to the initial round so that the discussion all happens in the
> same thread.

Noted, thank you.
