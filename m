Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBB4418E7
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208080; cv=none; b=JSk1qMEoA5o45DB4VJQH91Jtforq+IZuiFazN4Z2xe9iUPcDHwj0xblurpIU8fzMPYmuaOvto9N/G4U+C7DGoAjrbj/Pg0pe+x7+3k2sunTNAIPML1kLuT6ZELsV/lTtXwe8Yv7O5lEPNJXECiVsLGQ7zukgolXZHAMZJ1m90Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208080; c=relaxed/simple;
	bh=2JwfDaXb/DmJMNHoFpELtx1YDhH+m+tCMhYkmsLY3A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEiBX4vCesqaiGCQCeFDzUFwa1hzRaa7sHR65h5YNNsBI+oNBsSOqfXao5lw0FayV7b/jQ9nEezxSygrLB0Nily5n/GQpu/xeToZugPVGaXeEGphdMDt0tUlRvCrlz3PpuE+vhv+AK1Wu/8P+eVYVg9psL2nKzIQNbPWOL/4BKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC6gqhrC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC6gqhrC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso19250335e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208076; x=1772812876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWNVEMPGlatNIhylBoZICs7XDHZY8plloV6vfFV9R/I=;
        b=UC6gqhrCyg+cW/OvItaAE59mDYLTNjZ0A/Ra+o1hBS71ZTIHUh0zTe3J+CXtNWZxEv
         OT8krq2/Ufsjko90t7yLf0iyOzDcUGJgmkZNdx9ohtASFEziVQQcyRD+jjulTqRR0WWb
         7Vh+0AZv7sBRag5GRWZqFdcDonDSubLBeQVdijcxvtwXmzbqeLcqBOfO7S0VUolAu+01
         HRSFl4vk/5bLISqMZTN35SSPy3KxjBoeZ2wXxRUYJoruygoDd9NW4NSlx1QvjJfFrKTl
         zlRedhMHAg92K3YfQ+DGGKzhT1ufYkMNpYb+hJ2LP3a/Rn+/RoOqeWcKc749I0lc2wAT
         5Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208076; x=1772812876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWNVEMPGlatNIhylBoZICs7XDHZY8plloV6vfFV9R/I=;
        b=MUz/ZryIbTYIX0jcNxXKCJKB3hhWGSbIfKzn1eky8b7l2TEx74OZGm8sb5RTPlM2qB
         qzjlh0N7YRdaeEhTsBQgjbhZpMu8q6wg4/B7cTNdFygLb22Oc/RS6C3kqUm7P+XKza/C
         BrXHJ6405SdvW1oePTWEZFr83wdzROEPU+3KIlE9j/4wAf4e6eW3BsSm1v5PWYSzY9q7
         5wlwPSIhGJGMUpUE2k9oPIEck/E+8AcdkzO6XOJdCDWkjmIEHaEzxgBldaqiKeFsh5a/
         Wg7tdZHTgjitVbPOJX6kVjUIPGnwTHm3525NQlzKiyk4RWGcU5q9+lhN914aiVWZMNIj
         KTPg==
X-Gm-Message-State: AOJu0Ywki/xs3sKL0whffSg4DrDvbT1fG2sFVbCw9k2pUyxP9ftSKqPU
	krw7a0jBz9r7T+6+tcrubJE5GQUCG57yRqbSa/zEMOvJIy9Zgzfk4Wl6naEEpQ==
X-Gm-Gg: ATEYQzwTZrmoArQMXAwETWbTQO1RNjYVaJyktrFWCNSq83J5pVUUI40jXQ9UJmDR2jg
	BvrxZDM/9OQhRBYC5zreXDTnhEn4GWLSGXcwwphXD1/uM2cOSfNv0y8tuJmiZkQ9nTCkll0ZG0c
	U1Vfyh/X1cAo1QulPgXV0dIXrYTUf5zF2EnPv9tnYIp6pI8x5Cyna4xF2ztbf+ZQgAmBOUNHdBS
	bE01Ypg1yNqTwy9qoKPMGguz84/qv10Ss7B17l6UIYIzCCtJPhjWmWif4uoHm3L4twjeZdI3S/O
	+zVNw87j7H0jGSvi0RCK/IPGywJ9xTVNU7HXoccmts9faiChMHMfXyOq4lwil7WngigapkmIOHs
	B3e1Sgb/UdQ/xsVJ9lQcn6C8PgQG5HqyTf0Azul3z1HxPZmaTyLx127Vfe3qFrvy0xfuYQKDg/q
	4xAqlYzb12lrXAiK/3HArmq0Jh8KL4+UedKOVk3KHGk9QdDQ==
X-Received: by 2002:a05:600c:5308:b0:483:c490:8c0 with SMTP id 5b1f17b1804b1-483c9bdb6d6mr47144075e9.11.1772208074089;
        Fri, 27 Feb 2026 08:01:14 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84023sm117355415e9.12.2026.02.27.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:01:10 -0800 (PST)
Date: Fri, 27 Feb 2026 17:01:07 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 0/2] diff: handle UTF-8 chars in prefix when
 calculating diffstat width
Message-ID: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>

This patch aims to fix a bug where the calculation of the diffstat width
incorrectly uses the strlen() of line_prefix instead of its actual
display width.

This patch addresses the NEEDSWORK item added by ce8529b2 (diff: leave
NEEDWORK notes in show_stats() function, 2022-10-21).

V2 DIFF:
* Changed references from "ANSI char" to "UTF-8 char"
* Compacted the 2 test scripts in a single script, that I placed in the
  already existing test file t4052, which "tests --stat output for
  various commands"
* Added many of the changes suggested to me by Junio C Hamano [1], in
  order to make the test easier to read and to debug
* Added a descriptive comment for the test script, and a more complete
  commit message to describe the goal of the test

[1]: https://lore.kernel.org/git/xmqqikbmk86b.fsf@gitster.g/

LorenzoPegorari (2):
  diff: handle UTF-8 chars in prefix when calculating diffstat width
  t4052: add test for diffstat width when prefix contains UTF-8 chars

 diff.c                 | 12 ++++--------
 t/b                    |  0
 t/t4052-stat-output.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)
 create mode 100644 t/b

Range-diff against v1:
1:  a798eda511 ! 1:  9e8161a700 diff: handle ANSI chars in prefix when calculating diffstat width
    @@ Metadata
     Author: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## Commit message ##
    -    diff: handle ANSI chars in prefix when calculating diffstat width
    +    diff: handle UTF-8 chars in prefix when calculating diffstat width
     
         The diffstat width is calculated by taking the terminal width and
    -    incorrectly subtracting the strlen() of line_prefix, instead of the
    -    actual display width of line_prefix (which may contain ANSI chars).
    +    incorrectly subtracting the `strlen()` of `line_prefix`, instead of the
    +    actual display width of `line_prefix`, which may contain UTF-8
    +    characters (e.g., ANSI-colored strings in `log --graph --stat`).
     
    -    Utilize the display width instead, obtained via utf8_strnwidth() with
    -    the flag to skip ANSI chars.
    +    Utilize the display width instead, obtained via `utf8_strnwidth()` with
    +    the flag `skip_ansi`.
     
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
    @@ diff.c: static void show_stats(struct diffstat_t *data, struct diff_options *opt
      
      	/*
     -	 * We have width = stat_width or term_columns() columns total.
    -+	 * We have width = stat_width or term_columns() columns total
    -+	 * minus the length of line_prefix skipping ANSI chars to get the
    -+	 * display width (e.g., to skip ANSI-colored strings in "log --graph").
    ++	 * We have width = stat_width or term_columns() columns total minus the
    ++	 * length of line_prefix skipping UTF-8 chars to get the display width
    ++	 * (e.g., to skip ANSI-colored strings in "log --graph --stat").
      	 * We want a maximum of min(max_len, stat_name_width) for the name part.
      	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
      	 * We also need 1 for " " and 4 + decimal_width(max_change)
2:  ce25150593 < -:  ---------- t4074: add test for diffstat width when prefix contains ANSI chars
-:  ---------- > 2:  984fa10d72 t4052: add test for diffstat width when prefix contains UTF-8 chars
-- 
2.43.0

