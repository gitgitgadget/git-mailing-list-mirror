Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10423101D4
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679044; cv=none; b=dxfg/dwL/iT9kgDjbFMzOUM1p5VNyIGblBw4N0hEq2rF9Y0yoHLR1y3fjNEs64scga+qCoD4C2oC4dR0yvUkf0KXlXk87PqH4jdJvXx/nU6wVqo0Gk5UMcbmqdLSOhDql+0dITtkWWBDUljs6f+peHk1Auul4jwr0A70NK8dKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679044; c=relaxed/simple;
	bh=MtcQUW3XeI7EN7VsxFn4IExUcIEA+2shghxMmYasuEk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kLdebYm3qRwn1i4S8RMveZ2JCwK1vuyTPPBGi7Wkj123UTKcEphlMrYuoKbMY7irKa07hEiNOk684BUa7/QEEPm9h6cdrKrZg2OWKpnRVU8AbH6Cr/8SnnkFN6ULUleTriHw4sQSrOyNKvSRb8eMv2QVHBYa6EOhhIl31zlDnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMQMIed3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMQMIed3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896f8feee14so20064496d6.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679041; x=1771283841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fZXIRRGpejch86AAlvhRIw3s1n16cUpNqxwI+Ydk95w=;
        b=GMQMIed3KsF1dmKm6RmE/TJupWnaiooehsgorJvq+Nuc7So9H36FT8Zb7Pyaeb2Fyi
         RMUuC5V8lGx7JvY9AV1JKvv5RbENnlg0ixwWb5btwTlgoo46AMw6XWH2tZteg3Z11qRz
         IaoImOXvXnK8skZHRa95yfnYpmU+8DtiuC0HbVxrkoq3na7WvXDXXwltn75rmJjoOccv
         tc8XbSRtepioqmYRVJdreqSfp42WkSDbZg+3LAxYce7mUro3gix5ENZWmsCKH6MUuBtQ
         4qbzN1IWksUmhs+jHYtyr7TtswA4EGlZs/mOwT3GSSEdiidNenqNcY/CXzxJgiPHvISR
         ovNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679041; x=1771283841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZXIRRGpejch86AAlvhRIw3s1n16cUpNqxwI+Ydk95w=;
        b=e3XePDyA3QV7hbqvjyB5NzO72QPLhWddjeNV/orUWpclO1z0HtDC5lTi9noUonB/tH
         h7ZJJGnNvH1YNvORKAPRn4YG4J9tALozQTRRO/xZCxn+tzWbRJH1q5JS9KeXv1fmy5Zu
         2/PC8gSp1TePR0qjl6Y1dXT4eTr45GHLQsR3Gf3/aDuCx5r27KCNsfutIDicvwHAMsNU
         SRigcp8idzi5eSHJEb0UfPUk8cb8AlpZlytVDOLkoM357hD+i5k5yqh5GQoFK1mZXbLO
         WmAS5gR8vlapkUdsZhkqHAGrM7ZXGWevqJyyHSANHBiimMjXTqixY/30HllyPmUqZbVe
         D83Q==
X-Gm-Message-State: AOJu0YzOLXaS4fCnJeKl/KLdEwQ8GTkFSoIJTh5pcVu6rXQNGVHzRlBF
	6pbt4KL7XUSajaNM3PZ890odNOliLN9sm0q9SfDZsgTuCHUILrPcos31X7vMwQ==
X-Gm-Gg: AZuq6aIDIiveG/BoJk//GYvJoUZYvJNhF5D7kzybVBNp5o2V+JcLr8piKd4pDpn/zft
	0fWbHtJw9hntQBUfMM5iQeCe8IOcVp2EUVjb17ogCIP3i9X4Sqa8WmERMmgKTUH90a5/twe/66a
	FnHmILlsZW6epya4wXSTyJZdodbRx+n0L9RJuus9EHMDLQrcrTR2431bz0oyMdyOpVL+PsBdk6A
	QuB4fzVYp2XnF+qDQDUWmp3gi4JFsZK+zNh24J15u/WPUNByu0NIgTGRe3Ets6+1sFAGsSZPglI
	ICkg9GNh297vhTmIM9/2VrJPRAgh2d56iYWEigVdfrlTm1dH13+5onaKirMxb5nYYOE6RW7MlPj
	4wLq/05YTNPedS0MVSLtytSF5R44uVfbgDLABPC2+c3OxyjkQUwafJ3UqigGRbwW9UFkPd2wqLc
	C6wraCG1tSqsyvZs5bRj3Zti1cpYWqNtmRmwM=
X-Received: by 2002:a05:6214:d02:b0:896:a692:cabd with SMTP id 6a1803df08f44-8970e515de6mr2627856d6.45.1770679040290;
        Mon, 09 Feb 2026 15:17:20 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf81c118csm947198385a.24.2026.02.09.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:19 -0800 (PST)
Message-Id: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:13 +0000
Subject: [PATCH 0/5] gitweb: fix broken mobile layouts across views
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
Cc: Rito <rito@ritovision.com>


Summary
=======

This patch series fixes mobile responsiveness bugs that currently break page
layouts in gitweb. The approach is adaptive rather than transformative:
preserve legacy desktop layout, add targeted mobile constraints at ≤768, and
prevent content from escaping its containers and breaking the layout.


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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2043%2Fritovision%2Fgitweb-mobile-responsive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2043/ritovision/gitweb-mobile-responsive-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2043
-- 
gitgitgadget
