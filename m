Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29720E3
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ryttAC"
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E9133
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:51:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28010522882so730450a91.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915077; x=1699519877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh9gGyv/0tNEkkhM5xXSSrUsRJVg4nV270EAJ7G3A9g=;
        b=S8ryttACk4dTSeo2BEDNUrnltlQeDOVzxzHAEtRT1GgSNmxi2oHY190gKjvFSoglgU
         CWg8P14eiyohQIm343fKaXnGQVerNmSvGcRXQcEul/MVDKUCH+6hlC8BTCRH7EO8+mNr
         rzf/TzQEUDo/IoPJobIx0z6r16aGlSmnq8NYQrlH7NrW1vFV+ccGDUSjoMdYtkuLpcc6
         KUaEYlIh3RnjU77punajzojsHon+9gjlTWCBZOxIveeiUUXotbPOLlzqnowpKr6a395s
         hoT+9JQoNZpolUyWrQprs3GukliUzijjsxhBuv4BoUCctY9AQieuvCl7JoMb/VgU0Gef
         ybjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915077; x=1699519877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eh9gGyv/0tNEkkhM5xXSSrUsRJVg4nV270EAJ7G3A9g=;
        b=pz7Jm9eDLY3prC0OL/H7pDrodvCHMei8MAjs0sg5rzURrqjmN5r4+WExY9AdHQqnOu
         SDn4PTborI162vhu69kDrMvucOQIY07oR882S84wWqa3bXLEEzn+OWY5C/ZV1cZx07Bq
         mNSuSKsBNzfov+7ojuxjTampq4Z3WMX3E5xbnl3j/o7597t/4kVKvpccH2IXZjwacZ9p
         RQQK9HulzkxSrccn4waMlG02c1qPFSP0EFdcq+i1+l9WesFJGH8LlYghgEKCxMF1kZnS
         IUVudR4I0HuZImlsHJR0ZOmzDocLulaY782FUpK3EfSWg4oJwSL0SW0rHqGvket6YFNB
         yoUQ==
X-Gm-Message-State: AOJu0YycwcnyZxxzmNuKvQXUyXzYp31oa4k6JqRRFN1cLw1N+UjFKowz
	KoSzKGM7AbVpKPYFz+InoYJYXpOFFM6sGh7rRRc6vSHl
X-Google-Smtp-Source: AGHT+IFpwC5Eag4snM/SRuXU9VkWsZpnX5pwkisnAwg721sadalhmmIzN8qEtTg9ejs355mXeL8rQz5qt+GxWYyyQts=
X-Received: by 2002:a17:90a:3c86:b0:27d:6d9c:6959 with SMTP id
 g6-20020a17090a3c8600b0027d6d9c6959mr14900979pjc.25.1698915076953; Thu, 02
 Nov 2023 01:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net> <20231101192419.794162-3-sandals@crustytoothpaste.net>
In-Reply-To: <20231101192419.794162-3-sandals@crustytoothpaste.net>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 2 Nov 2023 09:51:05 +0100
Message-ID: <CAN0heSovsnNpmVWMQJeNP2rO9zB8gFCeWuDp-f2FP0dGBCw_Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] merge-file: add an option to process object IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 20:24, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> From: "brian m. carlson" <bk2204@github.com>
>
> git merge-file knows how to merge files on the file system already.  It
> would be helpful, however, to allow it to also merge single blobs.
> Teach it an `--object-id` option which means that its arguments are
> object IDs and not files to allow it to do so.
>
> We handle the empty blob specially since read_mmblob doesn't read it
> directly and otherwise users cannot specify an empty ancestor.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>

Ok, good solution to the misleading paragraph I noticed: dropping it.

>  'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
>         [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
> -       [--[no-]diff3] <current> <base> <other>
> +       [--[no-]diff3] [--object-id] <current> <base> <other>

Ok. This is where rebasing onto the new, initial patch could possibly
have tripped up. Of course you didn't. Looks good.


Martin
