Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE51FECA5
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782331; cv=none; b=q+zrQOiY6+2FoUC4j1kbX1lV91xjWnFsciPr/64LfMN4+jWntVPx6YjOR39bcGCcJA+OIsGkEylfnSSoOp34gHCMnO6gJ59jFvEoQbZuj7A0ngSOBgwzwHDkb6gNPiVsDUy3QrtJMc8spSdwU5tPXxhLuMuqW2MWGhHmFGwSsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782331; c=relaxed/simple;
	bh=zLEy0k3O+aNw5poixXx1yw8dMl3r6V0ccnIQ2LThzwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDWkvMM1QAp8jxEN8eSSfn5uTKaCr+rHss2y+MVYCOSCn2ynPjzwiLBNzmJm3nBmtaCdfFoHO8i7G2TAJVEMlUHKh9ihwrRmHCskHceTnWl1mDRx+YHzEPxLb0UhU1OWMNBviXPTokqw0Dy68DlzKoytBElZuaveIIDoZsX8HTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alVLK5y9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alVLK5y9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913b539aabso1332420f8f.2
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743782327; x=1744387127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BlFhcaLTxi3hzq3CFHio+ZUPQ5H9R8d9OACWtV7g6X4=;
        b=alVLK5y9sC8tk3F5v689PH35PFrKmL3zGa9nkI6lFUnhw4Qizxjl7ft8L8N+kgNl6p
         kN4IO0RppNDF/sG7n+9+ZDf3NDuzQ+eVF0BVPCBKjAH9/D9/CLdbxDNZYTdkZ+KNHdWp
         1m7pAtU+Z3uRvT02zR9X8/QY4tV3yvOZ069MuBrH+ddQoSLGTdOBYGfKDuZSkd8QikDV
         iK9QxTHHfp7Y+K+TRO9aj5RCJZUymG/UzyC+dbdfWR1+Qj09ZSQZagMMhTTJidHV2+VR
         n8UWFW9Wkv4TR1OnO1gP9Ts19CSvpbPZ0Do/eo7wFfkjVfHaIMV9wMnUDDH9HTUbyby2
         ghCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743782328; x=1744387128;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlFhcaLTxi3hzq3CFHio+ZUPQ5H9R8d9OACWtV7g6X4=;
        b=GtV76pdYyDm1mczyEtaC38Tj8jG9xxNOOE6Oj+/uG6fqNaHd9CFPFfjCa2cyMrgyUD
         mWqoKHmxfRaY/v2nQztllMODthEwa9RJAPvVu/sw6TVwDfuxz1jtZ/njpw+WXqoYRrVD
         513uBmvxvJrR7+JUaQnnFJ0bhjiAZMZsM5ZGOW1MnWbOEzG4yjFrY6gZwnn9dXLYwt8m
         Gki+gfXJ9XBqugJIaptR4nEq2bEwwUtgHDFFuKzyMjwHuUw0vZDiVDmwpPEIsbvba8uk
         ZXYubyMOrltSkFB+awDD8pp8Vsc+d0nzFmKP1gANaxfDkQhJ6jiN61UcWB088RUTcU3m
         xQUw==
X-Forwarded-Encrypted: i=1; AJvYcCXOp8GigRDUOUOJX5rbMdFCcYyKfut05HK056k9MAd3B6obbEB+0QZubiVuh4VjtBKgi+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVjDXgIwNA9JSYRbvpewcMeB8lMp2/SzGbqyCqQYIPUYIqpbc
	Zr6C5/hMc07RMqpHvGpUI81fMix2Zeo2lbUb2rcB+02k9hUB3LiAqWliGg==
X-Gm-Gg: ASbGnctZv3zePeDJ2287jwiVq2P4I2ndzbF6MUNWubiSVyO4gcLmnCe8cVV67tSdqO9
	oib26RYkWNQUfBCIQ2c2zjWr9002Sjd/b0E7XgGcrStuzb9VHLaDvxattVKbC5+8djlel0QcoVJ
	gm4ft1Z/EvLYinZA5pWWDXzCQ4uRwDLzJg9qkm0Ak/61YTa2xbW1bgh5+79IIBBLQWmkiWlEftb
	KfzCyTtafxwT6p0DhblXNAKyXbKqXpIWyaFWxLMAh0E1F4ts9B0QCQnh6O2JoyHifzlrASz4c+9
	BV6l6/kLmDNceoF09R2K5xMzkn8FEkZ4+4baviaBFfcxDC3cojwfsQSaLdUCbihhmFkfR6UZeGU
	EgZxGvW2nWSZwhlHV3KBg
X-Google-Smtp-Source: AGHT+IGhfo4WhtCHIP1zEWq8dBgcM20R3kJLiFjayZBtsX1bDNHJxNGbAbKZSiWLeeIWnhmxD2vrvA==
X-Received: by 2002:a05:6000:1889:b0:39c:140c:25e with SMTP id ffacd0b85a97d-39cb359817emr3568654f8f.24.1743782327371;
        Fri, 04 Apr 2025 08:58:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:62f:ecbf:b34f:cbe9? ([2a0a:ef40:700:a501:62f:ecbf:b34f:cbe9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16313edsm52723815e9.6.2025.04.04.08.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 08:58:46 -0700 (PDT)
Message-ID: <2fbecc76-c3d9-4a8e-9326-5b83db1ceb26@gmail.com>
Date: Fri, 4 Apr 2025 16:58:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] blame: print unblamable and ignored commits in
 porcelain mode
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com,
 toon@iotcl.com, Patrick Steinhardt <ps@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250403160326.120124-1-karthik.188@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-GB-large
In-Reply-To: <20250403160326.120124-1-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 03/04/2025 17:03, Karthik Nayak wrote:
> The 'git-blame(1)' command allows users to ignore specific revisions via
> the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
> flags are often combined with the 'blame.markIgnoredLines' and
> 'blame.markUnblamableLines' config options. These config options prefix
> ignored and unblamable lines with a '?' and '*', respectively.
> 
> However, this option was never extended to the porcelain mode of
> 'git-blame(1)'. Since the documentation does not indicate this
> exclusion, it is a bug.
> 
> Fix this by printing 'ignored' and 'unblamable' respectively for the
> options when using the porcelain modes.

This looks good to me

Best Wishes

Phillip

> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Toon Claes <toon@iotcl.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Changes in v5:
> - Fix the test to be more portable by not using '\n' in 'sed'.
> - Link to v4: https://lore.kernel.org/all/20250330204339.191382-1-karthik.188@gmail.com/
> 
> Changes in v4:
> - Remove extra newline in 'puts'. Modify the test to compare the
>    entire output, the earlier test missed the extraneous newline.
> - Link to v3:
> https://lore.kernel.org/r/20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com
> 
> Changes in v3:
> - Use double-qoutes in the test to ensure correct variable dereference.
> - Fix incorrect test name.
> - Rename the function from 'emit_per_line_details()' to
>    'emit_porcelain_per_line_details()' to be more descriptive.
> - Ues 'puts()' instead of 'printf()'.
> - Link to v2:
> https://lore.kernel.org/r/20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com
> 
> Changes in v2:
> - Instead of printing the markers before the SHA in porcelain
>    mode and breaking scripts and backward compatability, let's
>    instead add a newline printing 'unblamable' or 'ignored'.
>    This is printed per line in both the porcelain modes.
> - Link to v1:
> https://lore.kernel.org/r/20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com
> ---
> Range-diff versus v4:
> 
> 1:  5250fb436e ! 1:  43bc55bffe blame: print unblamable and ignored commits in porcelain mode
>      @@ Commit message
>       
>           Helped-by: Patrick Steinhardt <ps@pks.im>
>           Helped-by: Toon Claes <toon@iotcl.com>
>      +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>           Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>       
>        ## Documentation/blame-options.adoc ##
>      @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_unblamable_lines '
>        
>       +for opt in --porcelain --line-porcelain
>       +do
>      -+	test_expect_success "mark_unblamable_lines with $opt" '
>      ++	test_expect_success "mark_unblamable_lines with $opt" "
>       +		sha=$(git rev-parse Y) &&
>       +
>       +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
>      -+		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
>      -+		cp expect raw &&
>      -+		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
>      ++		cat > sedscript <<- 'EOF' &&
>      ++		/^	y3/i\\
>      ++		unblamable
>      ++		/^	y4/i\\
>      ++		unblamable
>      ++		EOF
>      ++		sed -f sedscript raw >expect &&
>       +
>       +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
>       +		test_cmp expect actual
>      -+	'
>      ++	"
>       +done
>       +
>        # Commit Z will touch the first two lines.  Y touched all four.
>      @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_ignored_lines '
>        
>       +for opt in --porcelain --line-porcelain
>       +do
>      -+	test_expect_success "mark_ignored_lines with $opt" '
>      ++	test_expect_success "mark_ignored_lines with $opt" "
>       +		sha=$(git rev-parse Y) &&
>       +
>       +		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
>      -+		sed -e "s/^\tline-one-Z/ignored\n&/" raw >expect &&
>      -+		cp expect raw &&
>      -+		sed -e "s/^\tline-two-Z/ignored\n&/" raw >expect &&
>      ++		cat > sedscript <<- 'EOF' &&
>      ++		/^	line-one-Z/i\\
>      ++		ignored
>      ++		/^	line-two-Z/i\\
>      ++		ignored
>      ++		EOF
>      ++		sed -f sedscript raw >expect &&
>       +
>       +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
>       +		test_cmp expect actual
>      -+	'
>      ++	"
>       +done
>       +
>        # For ignored revs that added 'unblamable' lines and more recent commits changed
> 
> ---
>   Documentation/blame-options.adoc |  3 ++-
>   Documentation/git-blame.adoc     |  9 ++++----
>   builtin/blame.c                  | 15 +++++++++++++
>   t/t8013-blame-ignore-revs.sh     | 38 ++++++++++++++++++++++++++++++++
>   4 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
> index aa77406d4e..19ea187238 100644
> --- a/Documentation/blame-options.adoc
> +++ b/Documentation/blame-options.adoc
> @@ -125,7 +125,8 @@ take effect.
>   	another commit will be marked with a `?` in the blame output.  If the
>   	`blame.markUnblamableLines` config option is set, then those lines touched
>   	by an ignored commit that we could not attribute to another revision are
> -	marked with a '*'.
> +	marked with a '*'. In the porcelain modes, we print 'ignored' and
> +	'unblamable' on a newline respectively.
>   
>   --ignore-revs-file <file>::
>   	Ignore revisions listed in `file`, which must be in the same format as an
> diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
> index f75ed44790..e438d28625 100644
> --- a/Documentation/git-blame.adoc
> +++ b/Documentation/git-blame.adoc
> @@ -135,10 +135,11 @@ header elements later.
>   The porcelain format generally suppresses commit information that has
>   already been seen. For example, two lines that are blamed to the same
>   commit will both be shown, but the details for that commit will be shown
> -only once. This is more efficient, but may require more state be kept by
> -the reader. The `--line-porcelain` option can be used to output full
> -commit information for each line, allowing simpler (but less efficient)
> -usage like:
> +only once. Information which is specific to individual lines will not be
> +grouped together, like revs to be marked 'ignored' or 'unblamable'. This
> +is more efficient, but may require more state be kept by the reader. The
> +`--line-porcelain` option can be used to output full commit information
> +for each line, allowing simpler (but less efficient) usage like:
>   
>   	# count the number of lines attributed to each author
>   	git blame --line-porcelain file |
> diff --git a/builtin/blame.c b/builtin/blame.c
> index c470654c7e..9436f70aec 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
>   		write_filename_info(suspect);
>   }
>   
> +/*
> + * Information which needs to be printed per-line goes here. Any
> + * information which can be clubbed on a commit/file level, should
> + * be printed via 'emit_one_suspect_detail()'.
> + */
> +static void emit_porcelain_per_line_details(struct blame_entry *ent)
> +{
> +	if (mark_unblamable_lines && ent->unblamable)
> +		puts("unblamable");
> +	if (mark_ignored_lines && ent->ignored)
> +		puts("ignored");
> +}
> +
>   static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>   			   int opt)
>   {
> @@ -367,6 +380,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>   	       ent->lno + 1,
>   	       ent->num_lines);
>   	emit_porcelain_details(suspect, repeat);
> +	emit_porcelain_per_line_details(ent);
>   
>   	cp = blame_nth_line(sb, ent->lno);
>   	for (cnt = 0; cnt < ent->num_lines; cnt++) {
> @@ -377,6 +391,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>   			       ent->lno + 1 + cnt);
>   			if (repeat)
>   				emit_porcelain_details(suspect, 1);
> +			emit_porcelain_per_line_details(ent);
>   		}
>   		putchar('\t');
>   		do {
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 370b768149..cace00ae8d 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -158,6 +158,25 @@ test_expect_success mark_unblamable_lines '
>   	test_cmp expect actual
>   '
>   
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success "mark_unblamable_lines with $opt" "
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
> +		cat > sedscript <<- 'EOF' &&
> +		/^	y3/i\\
> +		unblamable
> +		/^	y4/i\\
> +		unblamable
> +		EOF
> +		sed -f sedscript raw >expect &&
> +
> +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
> +		test_cmp expect actual
> +	"
> +done
> +
>   # Commit Z will touch the first two lines.  Y touched all four.
>   # 	A--B--X--Y--Z
>   # The blame output when ignoring Z should be:
> @@ -191,6 +210,25 @@ test_expect_success mark_ignored_lines '
>   	! test_cmp expect actual
>   '
>   
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success "mark_ignored_lines with $opt" "
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
> +		cat > sedscript <<- 'EOF' &&
> +		/^	line-one-Z/i\\
> +		ignored
> +		/^	line-two-Z/i\\
> +		ignored
> +		EOF
> +		sed -f sedscript raw >expect &&
> +
> +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
> +		test_cmp expect actual
> +	"
> +done
> +
>   # For ignored revs that added 'unblamable' lines and more recent commits changed
>   # the blamable lines, mark the unblamable lines with a
>   # '*'

