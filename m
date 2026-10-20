Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792534347;
	b=pCbbXtvwQ4Bhkv7GBeVNLjrd5YOrpyFNvxnX7vg8AkYt9ED5KFz9qLz1RYwXPjbKBKtM
	 wTrGJkDC/JdmpCPsReSKbtkgOWzWY0WgHyauO9FeTGMFdEvpKerAs/vzDLhc/cyC8mL+u
	 LxKH4y+8cnkBzcddo0Up5UHSOl0Vr3gl/lF0yUMCJnymgao5T81q0pyv84ff0R8KTVUQ1
	 j7hugncKmY96hyW0HX2Yf0IlqKMCgaK3BeV88s+NRMSd+WqGbQtvpgZMyCLnW6BE061+d
	 Z97HNsigRKB1Xi+6yde1JEzMlqqYgpmRxoILq/vncdZMYjnrc9eed1jUBoW+M/NotCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Yus5Y0YjkZJq58fQooGgX0DZDi/IKhS622KL46uks4k=;
	b=CeIiIvwuF2FxytcyZw/a17I8oAHbMdXu6aE5rywZ4vU9E6s3rw7hIm8dmegjz7zoVKMT
	 bt7pTxQEJHuHpvcTSCje4/nfmRTBYMy4X4CYPU0Aa35gtQmfbd5trgvOuU0a9YMJBKWxQ
	 f7DIwuqQdeoxCmqwRZyzUC5wR4FIFTkgp7/fNUTH6iL30Qd6jWVm3SnKOHv4fbbKC9MZh
	 CUZjtLIq3Ya3VvKM8YiQzNJ1jOoTRUy2gTkIGjzAKj2ovMY63VNUocEpnR3lnYV0C47Li
	 wBFh4D+ZTqhO4HifuAHpn71GxLz6MVC8P0r1z2Sp6M8yAO0fGsWw7VXSVpGMMhA8Xjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pynntTZu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6B606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pynntTZu
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d7e06dbcccso29920eaf.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792534346; cv=none;
        d=google.com; s=arc-20260327;
        b=OX8GzvEb7WSBgXR9JqGT4ZyAZoXshoxPbxjx8exLPjbii+QTW4oJIWCsHPg6cEe9sB
         ikOIj7YjpB1M4GJ6flZ07TDQjQVlJjEMG0JtBC1YDiDFG/+alp1bsltQJ/GTEE3BW1qZ
         ad7ycP0N0yvtpnb3cMQ5mAIRg5A+1LM4Mq5MzRDaP4qGH+c4EJZ7Zs9PQSjV8PHLh9G+
         yfmUxlRnvR1QLUl+uO6r0NOhUFFCLF00tNjBmeYK0/k04UV7A9OLHSCGciNpEsygVtFP
         jRa5k1j+/vkVwDJpOqpk/f0HFl80S7+Z9ZdJMnm5Kalzpw4B0ZOBIs4YKp/mTyhAbNUP
         psqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Yus5Y0YjkZJq58fQooGgX0DZDi/IKhS622KL46uks4k=;
        fh=fGSJMDFrkkEDNS6+QfBczVJpie+hBE0ZP2ZqquOXZKM=;
        b=Wsji9xyc6DJWkY1WPBuBi+EUaqTSE17ts2VOn6Q3BpjQBTr04jfZjNZVyK4Gg2CnyG
         ZTSHRyKnNrdD+sij9vbmPODEj9sYZhX3Xm/n92nvfLLIkUHpZEdLjj7Xw9++InXnpotH
         rZU+nHcEeldIrTcyp53NABQiXW12+VrGT0p9bZ6SyFh1rKPL8ssKOngB1RLAxEvOu9UM
         KwkJMpx4oTNqeKSAXMsSJtQzC0nmfC/B+YXw9L5G7usY6SWDnnr+ah2PF0QP9T9OL242
         IaSpsOgTHNwrsfWQYbhNZVXbioEeBZlOs/bIQX+2+gVmkwOuN8k6ewyXXqXs2djlPJ+Z
         7frA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792534346; x=1793139146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yus5Y0YjkZJq58fQooGgX0DZDi/IKhS622KL46uks4k=;
        b=pynntTZuMpZ2E7MpngbIrqiBb7Pk/ojXESxP3comsbOs2QccfJVWlCubp4RJfi+Gf7
         lmPpeytjidv+ug66VD9IOlYiR7wMC+acnjD9ZZxvIJ5cNvdye2wzG2ZsoiCE6nAToulI
         RTwhpJZf1pTRZW6p6wlTpCQ3WFJqtCKS+G8xn2+SEIiwwpTbenuvcYmpNIXYc6yc+l/p
         jNxlAXJQ3e6yL4tqFV9y9ZN3gWPe3JEd3dn0Bt3FwKu0nxfWUd2HZ/82mcuBRrXR2fab
         QuDYdDQtzPdU01IsNY1VkHwNgWyYrjd6OoeZ7BZqyl3HzuXcFC6CcB1zySuWjaCIivSh
         qtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534346; x=1793139146;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yus5Y0YjkZJq58fQooGgX0DZDi/IKhS622KL46uks4k=;
        b=hl3u1EoM9TZfLh9zv4yPl8pp96ZkqToBQV0+/D7bHxtOSx/sKPsbOQzip9dLW1J8As
         5pIGjn0rXHj13eWS/Phr2o+kHojiVnqFVctvrpR/87ar7wLSpbHHhCSM7zMmeFa0h0CW
         Hp2tCqiuyJrcJrtHwC+dx2BRCmFOQ7cg9a3v50CjTe/FHATThbk2z78R3dWeAMP1jyja
         zQGAO79mZdIJ/6RGDSt9bk2EtPRdqPcNPNVwWljZiKjYiALKXfzACYi0r9WNs2z2YVYY
         /N/SfGAD3WZostKTNh88d9HTIzUSn1hqMyXJkIFk0gS9PmgJLIMWc2FQLSo9jq/frbuK
         EiVQ==
X-Gm-Message-State: AFq9FYIEZ8SzWcaEnjYBTQk8XpWdImxK+WKAW+UPFskv3DEiPRgvlQ5G
	kHMh6Nn+h9phvsCgD9gc7iQpVGYKvfEUGfCklYsU2lSUhUonN4iiz+bwEXBBQyh2pi8iYiusoZA
	P3eVFY6NVk5Z2hhCxO1U2s5kwK/20CbeSYQ==
X-Gm-Gg: AYBFou34A7M9LsE8QUysVARR27vaMhDZnqrUpp05Q8X0dyyY9575UFKXkwdpO49mOyJ
	AttyM77PWPpWqx4K4YjF2vpXqmYsdYAg2BQ9UlSKraNdFJ6EjLhch50QjcgpUvkxp8hni2U+GJZ
	/7qw8mytMagvTfxqwLBdP3/WnFdkWYkCAsalxZwIRg/QhdptHCi+H4VFcPnGAmS/vQreN69bl4k
	rQq+INQaJewVfsXf2SetXs1aTdjPk4+K0gEPSrTRebTBFmPLOYFZDsypaZ75hLWNQJ+K6qjYC8Z
	MZyMPwrsLn5tbTSVswe+OakE0Lgc0u6M2GBUtGAiJF0FfAcKmn/Tt2W+pZBy8riS5JUDLORjHfP
	xNIOkmrC8Xup+mB8X/LI/YUeEvBEq4nTn++nSly0bEfWu0BVlDop2DA5E9dijK8F94ZS5cpYrdA
	==
X-Received: by 2002:a05:6820:1994:b0:702:ebe6:8009 with SMTP id
 006d021491bc7-70941a50572mr153318eaf.89.1792534346372; Tue, 20 Oct 2026
 15:12:26 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Tanga Joris <tangajoris@gmail.com>
Date: Wed, 21 Oct 2026 01:11:50 +0300
X-Gm-Features: AclHuK_zxZZWrb4nqrS1c4o3Z7v1EcjIANNmKCYKbLjkccwq8ZtAMMqGhTMNKEw
Message-ID: <CAKrRMNruH+eN9CVrdwfg563ceQp8bQwCDBkV7ex0h_=X3eOBdg@mail.gmail.com>
Subject: [Outreachy] Introduction: Tanga Joris, option parsing project
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Resending in Plain text

Hi everyone,

My name is Tanga Joris. I'm a software engineer based in
Nairobi, Kenya and I am about to graduate from university:)

I'm an Outreachy applicant for the December 2026 round, and I'd like
to work on the project "Improve how command arguments and options
are scanned and parsed". I am really sorry for starting late; I hope
you are okay with that.

I've been interested in version control for a long time, and I've run
into parsing problems in my own projects. In a CLI tool I built, a
global --addr flag only works before the subcommand: "kiln run --addr
x" fails because the subcommand's flag set doesn't know about it. I
later noticed Git has the same rule, for example "git remote -v" has
to come before the subcommand, and that got me curious about how Git
scans and parses its arguments.

For my microproject, I'd like to convert the " ... and %d more."
message in builtin/checkout.c (suggest_reattach()) from _() to Q_().
So far I haven't found anyone working on it in the archive, but please
let me know if someone already is.

Thanks,
Tanga
