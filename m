Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CE86338
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734055; cv=none; b=gW1Vv3/9QgzP81/suPlNLCWVOgqfy9nvx+pufxekOYnP8xxlDbw0MsH2F+5ATlqFON25Ae10LSM5omDu+C/ZVHac1MzTcI8XDRUgt+E0lLfrWAUx8acMbIosqOPLCB+9+vueyJp/+xBbPKlRfNdKRJQjgqG1LljFSZCEg8QMqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734055; c=relaxed/simple;
	bh=PmKeSA+qEPewDmQ1JvR02kNh2r8ma8+WnXeAVfynGvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=A5f1b81BvzHLLaZBQpcV68xX5bE636WK6zTRINLhyDCGuKaghcf4jq983P7cKXdsRRZERowSY0J+Qz/Yk1Hn5EbzIXI1E6Tfcc1xytnNQ9+vIUW+H8LQUUlbJYZdelcUnDv2oNIxa+EGubg4uf1KA/XKVTx2enaSIQMai+xZifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J17cYM9f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J17cYM9f"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af0dc229478so690382466b.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734052; x=1754338852; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niBSJk1ez2g9vNFvxij5hY8J/NBcoz5Xfp569y8pu+o=;
        b=J17cYM9f9Nz/amH48mnwePgoC7NSap/W+UzKpXFV32zio3l/TSCuxMPi35n9CO0MbG
         Jr2w4lZ72yng3Y0EcT99Q3EH7OeiFWAQBj8WJowzjsudKyX3HQxCVVoJvU00oDfMYK7L
         +7ySW9uONAnqOTqqihfO7+qAd4pHPf/OVkgyw4/Cp032o32XYSGJ9LjYbyNIZFMNL4Wl
         4OYyFdPdG3iYxQD0AtRB4NTXnNPMyUpmAHmNvc1/IBsjTuQ7P1fhpbV1kq5wngXBnkAp
         lQJp7oM9HX5RFs7zt6aYv2Z//eFwjmksY8Nn1CYVnBLvchfh5D+e7yd4/AiasONcgH2N
         2dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734052; x=1754338852;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=niBSJk1ez2g9vNFvxij5hY8J/NBcoz5Xfp569y8pu+o=;
        b=gs8hDPFbdJQlh28VMiJ4ilENWIqRW3lXIhDJgLofyyQDlKG3f2eXbmd0/Z9C2p9QX8
         YMUYwZM5UQ9ZKtEYWGnvQhY5DLDKltt+nVZHTae8hVxPxjy81M4L0MGkmiXolIdMaH74
         grFYz/RIi9EJKD73XN5KfupkZewjF6L5MBDffdvGNyI7z1PKqLYcmR4wC69e7xM/ZMBy
         1+gYAeAa2Rlhmg7ZpB1w+nXpTstsk/DFr2qsKx5ByS1feahTlNC21rGYOWhQ6ymruwno
         xCKGzuwQErv0TrFNmWYIRM7y6QkuhmSjCqUM0emA5FviyM3eIvMy4WE5kbSErIwK8Mo9
         QD1g==
X-Gm-Message-State: AOJu0YwTzfIYFRXXU8gSDsQCmk2E6kAlWwd5NzbNnCiLPGWFyDO887Ym
	zr7EEqJNqlxk629iq6Tr+b4d95hU8LLBhICgB0Oj79WSNg8ZVP4OefVxhP4fr3Gw
X-Gm-Gg: ASbGncu8kEG1aqHv15M9+i1oV4CXjOdFiuG5CpIwSaYB/BucbWnVyD0GXsM31u0xPW8
	QYbYNkEgl0YLB3wXZHAVTEADaVGs7zzfegkEqdU70b5M4SZ32eZrkLxME1cV64Xq6DhVGzzdx5s
	XBXFLqdv4ThF0ovNWvLHtWUL84p+KThYfAh/Q5XaV8VU69yrTYnkmwsIunRVXSxxMC0PUDqZe9d
	KoUtKlZ/atCjF0ZOROOC3WCRjmpgXq/MEKDp9lSfrEaJKH6+TzNy6lFfsgEiJwSG9GCBFEJu6tl
	cJeub15k8CRNJkvHJGhEjOui5psIMupWJ84kdoh+5a3rvZb0xbJ5Ywbw+DxRLOnIkT8Qxfi6qrJ
	DjSmnlT4kwLP0Z8SQrQKJSp1i63hBP5DPKuczGxA=
X-Google-Smtp-Source: AGHT+IHiJLwLKwCi/4RzZGUyMXk5hWNQ7JeoqpvwmUK2uW4mf2Na63QtZXZKEsLoHGqywMWQvfXDSQ==
X-Received: by 2002:a17:907:7fa1:b0:add:fe17:e970 with SMTP id a640c23a62f3a-af61c6b8ec0mr1426546166b.14.1753734051790;
        Mon, 28 Jul 2025 13:20:51 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/5] ref-filter: small cleanups and fixes
Date: Mon, 28 Jul 2025 22:20:45 +0200
Message-Id: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3bh2gC/22NQQrCMBBFr1Jm7UgSjUFX3kO6CMm0HUzTkmhQS
 u9uLLhz+R789xfIlJgyXJoFEhXOPMUKateAG2zsCdlXBiWUFkZJvEfMow0BXSAbn3NGK2RH2iu
 jTx7qbk7U8Wtr3trKA+fHlN7bRZFf+6sd/9SKRIHCGdHps/R0oGs/Wg57N43Qruv6AX8MrceyA
 AAA
X-Change-ID: 20250721-kn-small-cleanups-a01fe5d2756d
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=PmKeSA+qEPewDmQ1JvR02kNh2r8ma8+WnXeAVfynGvM=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGiH26Gigo2NZDd9tjvRIQz0nQO0QgpxxGugPUujRj/zrYBPw
 4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9uhAAoJED7VnySORox/rWQL/R8z
 3psSNuk6dKVlYKiVXyAwTWxYUa4y7RH4iJ0R5Mu8eMqYUZyFXfAjAGmBC15cJ4k/UIRWcKojIc0
 doVYDSw1JIxSJJJwJ8eB44f67Guw07fRig9iDhFjwQJxnehkrLJFyedfYK2GsAUZXWragFzMGO8
 1lavhI9hCAwyirg/6J12OiE7BcNkFAuk1LdQCdJ6dfyFyvICe6pXvXYrNiNx0C7QIocYUjkO6oX
 3G7BEQ8TERp178F0NeAuCcD9WtNPgFGaxrrzRwvOcpoaBqY2ZjPRRfwxIqyZjScDqNpFVJiGiq9
 tvbljI62tYGWNiL4dYMN8dVq8IlG9hvaiBmIe8RvW+pG6x/DzleY93HL8WidTeRhb9wzWjxeBqj
 i2QIceCgzjMu6dQI+csaAyIRTre4nBguAAgjAfFoJ6rwe0FO1cQ/iOF8rkW5P63Tr3021/QFZe9
 2QnjPk5sph3fo9eUkdRaJQndK0zkfvrwfygU8BG39anRXEQRrTsiYrK0IGDg==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series contains a few of the small fixes and comments which I've
gathered from reviews of my earlier series [1] to add the
'--start-after' flag to 'git-for-each-ref(1)'.

Individually each patch doesn't hold too much weight on its own, but
together these small improvements add up. That said, if these patches
are too small for the noise generated, we could simply drop it or
combine some commits together.

This is based on top of 3f2a94875d (The twelfth batch, 2025-07-21) with
'kn/for-each-ref-skip' merged in.

[1]: https://lore.kernel.org/r/20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- In Patch 2/5, fix a whitespace issue and convert 'git-for-each-ref(1)'
  documentation to use the new synopsis block.
- Link to v1: https://lore.kernel.org/r/20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com

---
 Documentation/git-for-each-ref.adoc | 13 +++++++------
 builtin/for-each-ref.c              |  2 +-
 ref-filter.c                        |  5 +++--
 refs/ref-cache.c                    |  5 +++--
 t/t6302-for-each-ref-filter.sh      | 19 +++++++++++++++++++
 5 files changed, 33 insertions(+), 11 deletions(-)

Karthik Nayak (5):
      ref-cache: use 'size_t' instead of int for length
      for-each-ref: fix documentation argument ordering
      for-each-ref: reword the documentation for '--start-after'
      t6302: add test combining '--start-after' with '--exclude'
      ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX instead of '1'

Range-diff versus v1:

1:  449473efe6 = 1:  cb34545b3a ref-cache: use 'size_t' instead of int for length
2:  b5aec572bc < -:  ---------- for-each-ref: fix documentation argument ordering
-:  ---------- > 2:  3fab0eda31 for-each-ref: fix documentation argument ordering
3:  005a35a4b3 = 3:  49e5aa69f2 for-each-ref: reword the documentation for '--start-after'
4:  162f5de259 = 4:  93babd3e71 t6302: add test combining '--start-after' with '--exclude'
5:  3eb8591385 = 5:  ce90149919 ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX instead of '1'


base-commit: 15fcbd8f16a2c119a5319b0657e52fe0f387df46
change-id: 20250721-kn-small-cleanups-a01fe5d2756d

Thanks
- Karthik

