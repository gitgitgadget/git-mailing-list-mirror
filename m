Received: from mail-vs2-f9.google.com (mail-vs2-f9.google.com [74.125.227.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195B552922
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924571; cv=pass; b=miWmnvmQDOpdVFPzi3x8jMage4ga7rEtbvhVA7tpEvJoHFVMB6lwcvgCJ5+qOMvBNtHQlMOp4EvK4c3Q7b+nU2OFnLN8hqgsnO+dDW4V8ix0DD+pfOXF4U90Xj1azvu9zUW6yhNv+Zex02qw3Q+hL29cxxa/uCMfPToyDm+XFoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924571; c=relaxed/simple;
	bh=kPVtH7hZPKyof0x59KBjeLL40/WV2pxmn7rw6RWfKmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G0X8G8S9/OnDjHjWjVBZfBoSauM3MmXIiv+suFG5koPb30Q/9iz0lmsEmnPT7xI03uUDOxpv/t2Pj+wDIfjUTUVXF9ZpxIooFZtX8W979n13zB1pe7hTq/9tpXqv+ovRgZdeSFo4EFP8kMa1IPiSv+E5AAP7/8CvAbQeCHytVk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNE8+8/z; arc=pass smtp.client-ip=74.125.227.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNE8+8/z"
Received: by mail-vs2-f9.google.com with SMTP id ada2fe7eead31-7c8b52135c5so899410137.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924569; cv=none;
        d=google.com; s=arc-20260327;
        b=KeUaD5dZVO806YqfMpG09tippwlspHg41kZz7h7LrTREfm57ZrTuy5b4A9Bw6edHwg
         +N1S3ZroTy7WP5ZFkcrl4Ldm7N2oMavw/Hl9hf1BqEgla228DtQ1c9Jy4P5Tzr5EqoPL
         NnCW7wIjR6ptbjSWMjwjtxEzWcu5bYoU3oWC2IXjiKrFqcbynT+CTpJwQniZ0NEvLNse
         Z+SGUj3Cr8p1k/cRWH3/h77OMm9wFfpc7BB4PbgMRUtVKYIRWxqHHj5DD+kXUGcqP+hd
         g8MyDh5EMBoZkaiNMlk51w9X7EghVsf79ARDkOMjr6YUL+f+CRjD7joRJ4A2CdBuw7k1
         eUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kPVtH7hZPKyof0x59KBjeLL40/WV2pxmn7rw6RWfKmw=;
        fh=EScYGoA5ve64/IUy1nagOSXunVqPNNMbTKWZUijkHFA=;
        b=sDFWBiK8O9zHVl5TvnUfBd2jxLCSRocGQfTCuA50akTZkjfzYAZ6DqXbO3JRKa75o9
         tdjvSM9qs/KA6pdyzxQecUf6U9sJw8FIzjBC7pTjdV8ZJDjRrHgep/DKoq8CjCKK+lI0
         s11x1z5xivnio5WQ8GpXQfqgMdJttGjObs7Z1IK3TDXxQohlO6wLMu/l076ksHgI9BeH
         wx3+oplrshPEEsTcCbtk7ZWHVc7O7bc/+aBqbEcbPWiEuqjU/bluNg/0sD9fypsyFyaq
         LIyMFGMDmR1+dX1mLIXzBveqy6YG8LxEif8ta9G+bIM+vg6azz6fQq/Y+nEEWQ5Fsits
         48IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924569; x=1792529369; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kPVtH7hZPKyof0x59KBjeLL40/WV2pxmn7rw6RWfKmw=;
        b=NNE8+8/ztBKohwFCmN1sTL001ALiej34Jp5+erjHRUU1rMRs/9wrh4OvhdY0lMCd8V
         em5p3wAdXlJH7/Xp+geIxFPej3bJ8xW46VptwwS8HDnAw+E9G9E6kVSiX6h/bNkWgZGE
         SKPBMcm0GgpBi4U1u3iOxg8fPLWfaAIdwNOxanpKUzEw+rzHR1Lyd68dZmqOnt/VeLsT
         hT9ER+oaY5LxCFj+ybjES0P95PDueNm7c2MAVyUn7HLNw1cH6fxrMgAYVUkjoqLNB4XW
         yAUyujDO6uHaLQFlhVzsrLpkaa0Bl21V+lo8a/e/0xYB3+x1Q5P9Fmx8SNDWjDpC0QwL
         BQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924569; x=1792529369;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPVtH7hZPKyof0x59KBjeLL40/WV2pxmn7rw6RWfKmw=;
        b=j5h1YhIe4AyoDLO7h/WoH/SUiwZcC8WEljckfQLrS4dVpUik8pg4kdvH/zTuMFynnv
         pBo+dSSj3+cU80Zkg5tr8LXW4K2U+XkeELabhJtbUQ0v/HIyaR4IipXd5CxW4m1jOnBE
         aknVz1LId9vnvHuF4h2EQi11s3AbiSShkHI2KYyZVYAdvVNUGcr/NN2hzNncPwGskre2
         RUAKIX3y8yDu25+r4NGnBeldh324Yq5P8Ssw/nGWEVHB7xLnf0q1aiixq9LpsSoXoE7A
         XjPIXUZg5m0iiaMgy68aLdfA8dV8lOKEvgxt9lNTnRgNYtljbiPS8rMZ+jpjSq0Hdiz9
         em8A==
X-Gm-Message-State: AFq9FYIXnLOqkhQkX1UHZMkdt2wP3e8PQyAoFKtUujbOFCEIiiqukK/1
	+kN7MekmXHIqgaj37JkoMv8QeavhEh5JFkZZ3Sd0ZDIlr/GC81M3dPVch1HTlZbZyLrqnaF+1jC
	QZ50OpsgXKxLXr/QPj2aHZuV1kAF+8Fm3YTzs5tohWQ==
X-Gm-Gg: AYBFou2TKpa87hNKpG9OwS/ai8uglZBkCU3aiQhLEzMf4Qa3MXnGBHUJgphcDgtdYG4
	tLA7+cIbDlKe6uPB0xbWOG6wJbFn/in6ZMiEVzQfU7F1yUi5GaLS8hBX+3qPb1aEr3c2k30XQZS
	/W4PaCG/OfNWxaktTy3bK9MbUZHmSOkXpHgwaI31O9M98jxGCw39rFY3gIo5bdWDpMFIex3QnHv
	FPwfks5K6tlCvZH8uavR1x2HXe9/l9f2RTR+JquLnt4irWWj/+1PK1VTE8LxlNNgsD4HUoCo07K
	YNC+yoV4wSF41DUs88Gc2UXilEG37WKk/G3FjxrXsmiHTn9aLI+ncIBCTtoUyOl6Ipqw27ym/Pl
	GaoPRj1T8nNg=
X-Received: by 2002:a05:6102:1499:b0:7c3:198d:58b5 with SMTP id
 ada2fe7eead31-7cb372ddf1amr3720086137.15.1791924568713; Tue, 13 Oct 2026
 13:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joy <cryptocurrencydiva@gmail.com>
Date: Tue, 13 Oct 2026 21:48:57 +0100
X-Gm-Features: AclHuK9cF6xkbtAinymOxXqVWKjM9GPCQbykOQ2gjQNfbzLh3obXmAIdcBVD2IQ
Message-ID: <CAKA8Uu3P11QcSZA9_cseCXQRG2-AhQDm8NicQ8cVDysOxzrcoA@mail.gmail.com>
Subject: [Outreachy] Introduction and MyFirstContribution - Joy Gundu
To: git@vger.kernel.org, christian.couder@gmail.com, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

My name is Joy Gundu (she/her/his), and I am excited to introduce
myself as an Outreachy applicant for the Git project.

I have gone through the Outreachy eligibility requirements and I
confirm that I meet all required criteria.

As part of getting started with the community and the project
codebase, I have taken the following steps:
- Cloned the Git repository.
- Successfully built Git from source with the DEVELOPER=1 flag enabled
using GitHub Codespaces.
- I have completed the MyFirstContribution tutorial as part of my
onboarding. For this practice exercise, I implemented a custom toy
builtin command called git psuh in C.

Find here a summary of what I worked on:
1. Added the core command implementation in builtin/psuh.c and wired
it into builtin.h, git.c, and command-list.txt.
2. Updated the Makefile and .gitignore to support building and
cleaning the new command.
3. Wrote automated shell tests in t/t9999-psuh.sh.
4. Created AsciiDoc documentation in Documentation/git-psuh.adoc.
5. Formatted, signed, and verified a clean patch file.

I am very excited to be here and look forward to contributing more to
the Git project.

Best regards,
Joy Gundu

Best regards,
Joy Gundu
