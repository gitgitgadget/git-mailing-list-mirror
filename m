Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83415747D
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743443125; cv=none; b=WwNVfmW3lZXN0WLVL8r0NB3PXKfs8H/FwGHf5hWQuUi5ni/k/Xj//TRSWXDdJ6VyU9lR2/udW7loEbkzIVMdO1Vxzxh1xXgl9LeZRTnQMFJyl5zpty0NF+1anJKn7TdVXXkPSXKQNljTO11dRMC8gzq/FugU1nZtQLUjj8ILu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743443125; c=relaxed/simple;
	bh=z3QPDf/ECRQFHBgpc+TXzL3fqrs4JLhSaaXi9/LDlJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf+ByD147V4xkFYcp4pux64CiREouljDhc8C96NPckqgHWMwqP3mUFoIhRrDG55G1Be8+ohMcc1uKqUXjUdH+7n5bG5CJvx2ws5CDgsm4j+3Uvr5dN8liutkMD6vGdkGG81vxwebOaMzjd+bw9123s8IuOXEWAGwuSWDNFYf6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdgIG8iY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdgIG8iY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so38823255e9.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743443122; x=1744047922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bd1BcTNwVrs3eFgwrR9eb/XqKAr0dYuB0CeG6x+AMXY=;
        b=AdgIG8iY8qA2+4QOn4dPuFp5Wu2urg8rWu/RdNF2M6SdvVSI8WRdsBEWd7Gg0kM8mg
         AEkmPvsK+41R5qm6qL4KF3X763V6DL0O16uWH9rYNS4uR+EX2qfyJfi9x7NnIO65EGFN
         aFL/riQ+/sVMvo0CLTzRBeCbF/KyLGypGu6rFu4Ai2h9rGVCSlaLAc3MJPJzWKKcdFzp
         0ROh/Fu7zjFTFk7q73AXoxaoLeKDd7DdoHZZo62iU3d/pJoeGFGmDJAEmMdo3+Kn5o7V
         I2q97n1I7FRAZt/Xz/EHDDlUN1GdSlc0gYFJ3PgsZKjPvhf6/WFypu2uaCZi7azh7cCh
         81Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743443122; x=1744047922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd1BcTNwVrs3eFgwrR9eb/XqKAr0dYuB0CeG6x+AMXY=;
        b=Vm4gSuvtEQfjjzigS97rcbULADf4HqHNmFnjWYIsxNaejRg3P0qbo1aHwq8FY4aL8r
         NCK4XTPp6KY6bR/LffUMCCotUpgTjB0LeLmJpyogHvmilmWvLLXjdAz6pZtiwhSdAnen
         lgS5HMCcYjrL/dTAAkP00dtF9ihHAACkwfdPkRSzlVj57/XMgaKB7YtkZhiZzE9jeQaB
         CxNHCE1NxLEnVwF/CU74lfIMI8fzAe5gvLnvP9TPknV9ecTZQtw6WYXIBkNSPfYM9RK+
         dlS48sQeu4ejra2A5T7IXN/jsWj5bB3tFlqtowGq0/kDfOtH1OodmIKna/FaBpA8/B8+
         UR7w==
X-Forwarded-Encrypted: i=1; AJvYcCV7vclqz3wPmxLUKh5XoYAijK19cmmOST07UjQlchdiB/2QTTBfGlZ3K/oLjqBQAYxGbj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnbz8brLqtb4JkligGwsFFyYSC8nSaySGNe2ZXwfUxIH7SWdv
	h9FHeT663kVva0wrlyxX2mP6rpcCkU4KE9pxw+6Y8Jzh1b06oBEM
X-Gm-Gg: ASbGncsi+3cIQC+/R6JywPMfgCsxdNjYFtAqfURHEQXl57w9Hj1jS8bFYf471Wy8IY4
	63XJXgkfooE6SMPlvVlfmgx+EO20VIFQTeX8WAOOtSB5d9g9YB0rXeb6GggPtc3VGFk6n/veNrT
	DGPZph8vpBU3p+Fk8J/OwCrt3vC9iUw2ZS76SouDYRlNVdjYsCJGpcdgLBobxLF6JJyfsib5SnU
	rCO8dKJA4L6Z+acH8nTU3nCYsBeP1fVsWHLXICXAqiNkuKASeD7npt9JHGd2M+JycspjdWILI6t
	rLvmdafK7H3IbAl6zcUq4bgaqrYPZ3+JiXvrjSNfjSHGDxd0b7tGRbRxzSIXRDznniEbOY1jLRo
	=
X-Google-Smtp-Source: AGHT+IE7a1I1mTqLQDvl4iq/CM0HKrO7KimPvfFqT8qQLnxCdH9M40jSDEub4oe/Ejf0+3OxNFObcQ==
X-Received: by 2002:a05:600c:5129:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-43dfa5f7d6fmr64359005e9.16.1743443121982;
        Mon, 31 Mar 2025 10:45:21 -0700 (PDT)
Received: from localhost (78-131-14-102.pool.digikabel.hu. [78.131.14.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d91439d11sm82948425e9.0.2025.03.31.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:45:21 -0700 (PDT)
Date: Mon, 31 Mar 2025 19:45:20 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
Subject: Re: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
Message-ID: <Z+rUsCW0zEb8kAK8@szeder.dev>
References: <Z+piTsfJdx4BG2oI@szeder.dev>
 <20250331125608.92419-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250331125608.92419-1-jn.avila@free.fr>

On Mon, Mar 31, 2025 at 02:55:51PM +0200, Jean-Noël Avila wrote:
> The processing of triple dot notation is tricky because it can be
> mis-interpreted as an ellipsis. The special processing of the ellipsis
> is now complete and takes into account the case of
> `git-mv <source>... <dest>`
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/asciidoctor-extensions.rb.in | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
> index 2494f17a51..f2be66c4ad 100644
> --- a/Documentation/asciidoctor-extensions.rb.in
> +++ b/Documentation/asciidoctor-extensions.rb.in
> @@ -49,7 +49,7 @@ module Git
>  
>        def process parent, reader, attrs
>          outlines = reader.lines.map do |l|
> -          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
> +          l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
>             .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
>             .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
>             .gsub(']', ']{empty}')
> @@ -72,6 +72,7 @@ module Git
>            %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
>          elsif type == :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
> +                        .gsub(/^\.\.\.?$/, '<literal>\0</literal>\2')
>                .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
>          else
> @@ -100,6 +101,7 @@ module Git
>        def convert_inline_quoted node
>          if node.type == :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
> +            .gsub(/^\.\.\.?$/, '<code>\0</code>')
>                .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
>  

Thanks.  I can confirm that this patch addresses the issue I reported
with the manpage of 'git diff' (though I think the commit message
could go into a bit more detail as to what problem this patch attempts
to solve and how).

Alas, the issue caused by 'diff-generate-patch.adoc' in the manpages
of diff-files, diff-index, log, etc. is still present.
