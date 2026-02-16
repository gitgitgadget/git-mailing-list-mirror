Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6D31B812
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257215; cv=none; b=ngNZcG7/HQqZrMipRBdN3yJsATfOMRpaKGrquz/soIyGQioI6P/uoJIKatkgrOnAES6BILRfTZ5yFq3Ezq49WaKU8XKmUmfAO7ArJmBpC4T7IglcA6fzqimtXlCAstXeA0rYMz2yX4KJ/Jqcr5zxh0WLSLi54lbTqflsk0hKduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257215; c=relaxed/simple;
	bh=qGJVBbLjuiOaSqFR4QNPZ4BwNaUkXdrqz8z3IvQS4nQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fxRtuHCDhPmsJ17zGEGzcZGFhXL8lvjjghq2768E7OEhx7RdRlBr4ZyG9OQIlMLIeH/tKszbucq2aPHyoVH6a8EYro7W4OqOMuOcq0rQOpOifZ7aCPHPcJWIlE5zBizqvuGi5+/UQ+cn/QEQJ5AD3w0nT90/p6n4xAx9n1iZZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrbLExIA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrbLExIA"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a789834fso29716931cf.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257213; x=1771862013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv/U3TWfWv7fXINGG2uZelMIuHYlO05wnxIS19j+6Tw=;
        b=GrbLExIA+1JQXonaG9vO6ZNsvjb3YhsCjxIGk6ohtnFS5AYeD+U2U5bVtTAnpt00dw
         qJ7EauJWh+EcG39SNh9LbSsYYizTD1Zn1JdWAcx7hI9QyFvZGd3VmcToGH+APooRR2++
         NHhG9x70vQerGTyz/mX/P90isDZ7J0auSrN6b04ZrR3IflTT3iuczn+zbmGnXFWAufYI
         MezUeZGzO2/Aux+xBTNWKXBYRewCCcJv0A5cG6pXZma9Fgc16WlyIIDb3riwvqbMww+j
         L29mjfzw8DPb1ex/usKG5PgnthLxMx8C0uwTLYGFrLQXkMYo5D6toDWgwu2xvkIxZqiL
         Ro8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257213; x=1771862013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vv/U3TWfWv7fXINGG2uZelMIuHYlO05wnxIS19j+6Tw=;
        b=MROEkn9PX2J8rnzehSyIkvFPhtA+vJiZV0sJfqzLAg8+VzMDVy9+xudvTPhMvFrXPc
         6dtHJn1AoGy7YtxxQfuGSWeJv7dre6Qn12ni+y9yWDi3/qvQHFTfQgojRsW5zN55EwFP
         PTl6WQDFwMa0sIsRpqmVJgO9SDhIVStE8QRrHNDdv+Lxl1QGkgZ0sbYp2fRlGJeMX0Ja
         M/anat7uxIpB9MMmcIxBfcd0f+x79DGccJsSFsUTMOwwdozY3WF3jLOComHbAF6Zo6Fe
         KrTVwxj/PkXOUgiUR/7ih3MSg9QKn5C+cNZSKgouguXuvyd2xovXRaS92Hd+1Gw1CJ1L
         l/NA==
X-Gm-Message-State: AOJu0YxYuRhD1IMqq4F2Y1vtzN3QB4ZR476FTj9feG/U7dRUoKrZHfdA
	7k978+thPRqvY4L1vCOB7rlF1eIpfJ7cQ42H6q+jooZPShweH/Xd4h3yiXlD8Q==
X-Gm-Gg: AZuq6aLYMh67GAgp84wSPz+F8yePgXbc+7+xd4ZtOLLYCZSLztKqaLv66R/n+yI7f70
	TEkI7A3GYceqh7lRQz9WbstM1vvAcd08JjoPrynSwhg4alFXOYelHKcQBNOEMprz29ygP2m0b/U
	OXQKvTR/V0DR2uwscf43AeKxOZYawRXvd1scPkp923/7MVEcvaJSrdXIoghle0zBcPq9VR5Eg8C
	BR+oxpjUQJDedh9wdCSrPebhg29eHlh35TZvfe61pCK3jZkM0NTnFPJpvMll7kFH1Aou2e6F/WA
	wnuEYUEPYFofqt1m7EhwBTO44clHUBxBVYm6/GN1xvdiTejJPyE0wRbH6e16kJHU7+w0QOWJoJp
	g1lEaSpnp9B4o1bGPEIAbi5lXHbkwrg2EvDl4h7bO1/a5hflkIrG7x0AMTPG7/Pd0ceAlpOMM3i
	FVbcDiT08Z7YjdKtI0ErMcTaV/46M=
X-Received: by 2002:ac8:5dc9:0:b0:4ff:c14d:65cc with SMTP id d75a77b69052e-506a6af0e45mr143437821cf.51.1771257212726;
        Mon, 16 Feb 2026 07:53:32 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d6f55sm150043851cf.5.2026.02.16.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:32 -0800 (PST)
Message-Id: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:26 +0000
Subject: [PATCH v2 0/5] gitweb: fix broken mobile layouts across views
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>


Summary
=======

This patch series fixes mobile responsiveness bugs that currently break page
layouts in gitweb. The approach is adaptive rather than transformative:
preserve legacy desktop layout, add targeted mobile constraints at ≤768, and
prevent content from escaping its containers and breaking the layout.

Changes since v1:

 * End-state behavior is unchanged; this reroll improves patch sequencing
   and message precision.
 * [2/5] now introduces the mobile @media (max-width: 768px) block and
   places the div.projsearch/input constraints there directly.
 * [3/5] now extends that existing media block with the remaining
   log/commit/blob/diff mobile overflow fixes, instead of moving search
   rules.
 * [3/5] commit message updated to match the patch flow and to clarify that
   overflow-wrap:anywhere on div.log_body is intentionally global.


Rationale
=========

Software development has traditionally been desktop-first and remains the
primary environment, but common contributor tasks like browsing history,
reading logs, reviewing diffs, and sharing links are increasingly done on
mobile devices while away from the workstation. This patch series aims to
support the emerging need by improving day-to-day usability for contributors
accessing gitweb on small screens.


Before and After Screenshots
============================


Projects
========

Before projects-BEFORE
[https://github.com/user-attachments/assets/0742999e-99b7-46df-9a40-4283fd861e86]

After projects-AFTER
[https://github.com/user-attachments/assets/5926be36-626e-4fd4-9aee-91d87557693b]


Log
===

Before log-BEFORE
[https://github.com/user-attachments/assets/6f64ffea-0975-4d67-a1b4-35b471986ab0]

After Note: certain inputs contain non-breaking/escaped spaces (e.g., NBSP),
so the renderer treats the surrounding text as a single long continous
string. Under constrained widths this can present as “mid-word” wrapping,
but it is the correct handling of long strings; addressing that is a
content-normalization concern, not a layout concern. log-AFTER
[https://github.com/user-attachments/assets/f8852e95-4f31-4337-9b21-6d94232b1be7]


Commitdiff
==========

Before commitdiff-BEFORE
[https://github.com/user-attachments/assets/8bf8a9a7-8cab-4ba8-a7de-166410a5c52e]

After (Pre-scroll) commitdiff-AFTER-prescroll
[https://github.com/user-attachments/assets/fa00f6fa-fc20-4391-9066-a489f0625af5]

After (Post-scroll) Scrolling the tables to reveal the contents to the right
commitdiff-AFTER-postScroll
[https://github.com/user-attachments/assets/74ae24e0-e279-4582-8fa2-1634fe3133ec]


Commit & Footer
===============

Before Also notice the footer text wrapping down outside the footer
background along with the two buttons commit-BEFORE
[https://github.com/user-attachments/assets/1ec00258-fb71-44e9-8e8e-beaaab6cfd13]

After (Pre-scroll) commit-AFTER-prescroll
[https://github.com/user-attachments/assets/78ac7f13-9e1f-403c-9ae9-b37d82d4aa4e]

After (Post-scroll) Scrolling the table to reveal the contents to the right
commit-AFTER-postScroll
[https://github.com/user-attachments/assets/8650f835-cdc3-4b11-ae1e-1229fc88e352]


Tree
====

Before tree-BEFORE
[https://github.com/user-attachments/assets/35a5db37-0450-4eee-91de-777259a49214]

After (Pre-scroll) tree-AFTER-prescroll
[https://github.com/user-attachments/assets/d993f3be-65df-48db-af38-4a3d13158f20]

After (Post-scroll) Scrolling the table to reveal the contents to the right

tree-AFTER-postScroll
[https://github.com/user-attachments/assets/1faa3184-0d63-455d-a341-c01ecf741be2]

Rito Rhymes (5):
  gitweb: add viewport meta tag for mobile devices
  gitweb: prevent project search bar from overflowing on mobile
  gitweb: fix mobile page overflow across log/commit/blob/diff views
  gitweb: fix mobile footer overflow by wrapping text and clearing
    floats
  gitweb: let page header grow on mobile for long wrapped project names

 gitweb/gitweb.perl       |  1 +
 gitweb/static/gitweb.css | 74 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)


base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2043%2Fritovision%2Fgitweb-mobile-responsive-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2043/ritovision/gitweb-mobile-responsive-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2043

Range-diff vs v1:

 1:  ff85e97cee = 1:  ff85e97cee gitweb: add viewport meta tag for mobile devices
 2:  bec6b10d50 < -:  ---------- gitweb: prevent project search bar from overflowing on mobile
 -:  ---------- > 2:  6383e1f7a9 gitweb: prevent project search bar from overflowing on mobile
 3:  7b785b6064 ! 3:  0ebad7bbc3 gitweb: fix mobile page overflow across log/commit/blob/diff views
     @@ Commit message
          overflow horizontally due to desktop-oriented paddings and fixed-width
          preformatted content.
      
     -    Add a shared mobile media query to rebalance those layouts: reduce or clear
     -    paddings in log/commit sections, keep header/search content within the
     -    viewport, and allow horizontal scrolling for preformatted blob/diff content
     -    instead of forcing page-wide overflow.
     +    Extend the existing mobile media query to rebalance those layouts: reduce
     +    or clear paddings in log/commit sections, and allow horizontal scrolling
     +    for preformatted blob/diff content instead of forcing page-wide overflow.
     +
     +    All layout adjustments in this patch are mobile-scoped, except one global
     +    safeguard: set overflow-wrap:anywhere on div.log_body. Log content can
     +    contain escaped or non-breaking text that behaves like a single long token
     +    and can overflow at any viewport width, including desktop.
      
          Signed-off-by: Rito Rhymes <rito@ritovision.com>
      
     @@ gitweb/static/gitweb.css: div.title_text {
       }
       
       span.age {
     -@@ gitweb/static/gitweb.css: div.search {
     - div.projsearch {
     - 	text-align: center;
     - 	margin: 20px 0px;
     --	padding: 0 8px;
     --	box-sizing: border-box;
     --}
     --
     --div.projsearch input[type="text"] {
     --	max-width: 100%;
     --	box-sizing: border-box;
     - }
     - 
     - div.projsearch form {
      @@ gitweb/static/gitweb.css: div.remote {
     - .kwb    { color:#830000; }
     - .kwc    { color:#000000; font-weight:bold; }
       .kwd    { color:#010181; }
     -+
     -+@media (max-width: 768px) {
     + 
     + @media (max-width: 768px) {
      +	div.page_body {
      +		overflow-x: auto;
      +		-webkit-overflow-scrolling: touch;
     @@ gitweb/static/gitweb.css: div.remote {
      +		min-width: max-content;
      +	}
      +
     -+	div.projsearch {
     -+		padding: 0 8px;
     -+		box-sizing: border-box;
     -+	}
     -+
     -+	div.projsearch input[type="text"] {
     -+		max-width: 100%;
     -+		box-sizing: border-box;
     -+	}
     + 	div.projsearch {
     + 		padding: 0 8px;
     + 		box-sizing: border-box;
     +@@ gitweb/static/gitweb.css: div.remote {
     + 		max-width: 100%;
     + 		box-sizing: border-box;
     + 	}
      +
      +	div.title_text {
      +		overflow-x: auto;
     @@ gitweb/static/gitweb.css: div.remote {
      +		padding: 0 8px;
      +		white-space: pre;
      +	}
     -+}
     + }
 4:  87cfeb81fe = 4:  bbc94eee8d gitweb: fix mobile footer overflow by wrapping text and clearing floats
 5:  8d5f2ed15b = 5:  95ded55c31 gitweb: let page header grow on mobile for long wrapped project names

-- 
gitgitgadget
