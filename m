Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA118035
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914466; cv=none; b=Wqq5TLE0heP/9U7GKJQy/lGL7MbVYS7IzLgvq1U1/gE7eUlm32AunZS/USkCH25xqtLTO5FkN2hKROP3ilgKCfn8s6VGO85wc27Qt0KLivPxliSDemZXfUegSWFYQLsUn0JvC35AqDvURpZWME2oNYm+YNWRutYfqs4KS+LTLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914466; c=relaxed/simple;
	bh=v+WnqyzZ/FecyXony6U3ZQphqihPzx2EnMcDzq1chl0=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=Q5BfYLUbukDl2YyvFCVTYLFhAsGB9tDw1ndFqM2A6iY2MR2KO7n9nb2fGkpIEP/YxuPzc9sVDlJTWyCnUmaVY2Ll4JRaNddblsOolDnZRUuRbw39pUVdUcknui471kYb6p3n475vIFPy2fx4Lhw/pgv2HjnqMtU3ZtOyjgrZxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b=S66a63Sc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b="S66a63Sc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728914461; x=1729519261; i=lolligerhans@gmx.de;
	bh=OBngpEz1akzWK4BhMM4x+CS+nylxgleezq+L7CfdJCc=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=S66a63ScXMOT5SdZ6xFSMi0WqFpcSHp77AqQLe/PgB1Lk+hsx1yeY9ag8ASebiUS
	 6oYwMyA9SHQPdK+SeOUK1qlhul99UUjg2Vq1tD41GNPFwdPeJO5HA6r/YZWD4hcJR
	 oRG740KrQLLLpKG/ghG/gr1u2z9jw6N/3xdrFExIHgwYEGzNhZmnMx1OaUGTvMFjr
	 NRF95ORa/WuFsCHVUlHE9K6xMSs3Kf6+XAE9JPamPUwUYvYh6VwUP8mi2ZfmPtO2d
	 PyApSP+8rCLIlEas1u02pKZEPsP03fbjfGWg4I+AnVVfzGE4ijI3b0BS0sTkbA4RP
	 SaXUeSWNov1qCzdlug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [92.200.132.118] ([92.200.132.118]) by msvc-mesg-gmx105 (via
 HTTP); Mon, 14 Oct 2024 16:01:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-1a7c1cfa-3f79-4430-bf3d-776c526c242b-1728914461526@msvc-mesg-gmx102>
From: lolligerhans@gmx.de
To: git@vger.kernel.org
Subject: Bug: diff --color-moved={zebra,blocks,dimmed-zebra} fails to
 identify some individual moved line
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Mon, 14 Oct 2024 16:01:01 +0200
X-Priority: 3
X-Provags-ID: V03:K1:Yl3Ab9vhm0qXmAarCAQa3uN/xEPLtQFOw8yzLocKOZnw/H/KDPr1l09UeAZMGGJ3B8NMa
 1fHi+S0cO+GrwkX6N58yJNg0zvbY3ZRxzv5LSIre7277WrS12nYHdIvNVV7Ru0kvyn5hSPSK4/2X
 bXzRs13LT5FDU8G06yzzLPy6CmACizkWhP5FR1sP2CJwxGtdC2k+5j2BzkIL+mdMmGNUOCKRgDsC
 xYpRa9OK2+jkBBrSLzdH8NL4Xrlt/7sCD/i/8jV8H+2i+tail0JADrQuQgYViH5Xly06BlC4Yg2A
 5Q=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0SXm/cIMjWg=;qdsIx9jrMsxUYb3xgo8EWWl1UE+
 x/4Wc6Z6LNGbCMcPB2lHMcG569qNyL7rYD/8tly7xpXqG9xkpwTIFcOHR9BjpIb//u8tmHuog
 UzhdM4oQBVVl99r67T+f7paQcSJF5KSQ6+r5ZJ6NMcWEhVqJERI/txhqFvRfC9JMilLigJbmP
 eX0q8F3nFsilDzbYBfvTgBunHiNOKqIbb0hWfqBBuLnQNaTEPwauZp33NOaclNj6Rs0YXqVoV
 TAiab+UevS0zkkX0VKzFBM5bBeUwoaAnJvc+u8k+ADqXcZBS2fVor2tO/738q/gNrSy/dbFp+
 yqq2kMW2sXiG4NawkvJNCJk5N8OsAJR4vtgpuaFeG/9yNiGS6GGatn92XI+GGIxYyNsjqTwoK
 aEyGcsvo0ueQ75+hS+pJGJ8PgQIWsbToLfdV/UM9dHa4UM7wUIrOJU1F5z4RzFl9TM5xsu+k7
 D3LBce3MdRldeRRbvy72LGypXGWPeJT75jW/xcl6pW8CH0S10kUKuXPO7iSQBPOyOPE6taTa6
 hfdbBVpV2Ort2HTZ/PSYP7BVl+Ye6Pc5pe8RMMq8m442LkhSAWt92DxwmNwA2aqGeCG1Z16d+
 mb1i64wzAHtJcRNC3ikGwscN1aWZMf/ATPgTviBYH/k/2BmGwQNhf2ZttbdmnSefOOkAWpBJg
 9Y2zCitzleEcohXonoX01AbPfjO5VAqj15WK6gKq4w==

: ' What did you do before the bug happened? (Steps to reproduce your issue)
    I diff-d after moving lines.
    Reproduce:
        This entire report can be run verbatim as a bash script. The executed
        code is at the end.
            - 1. Execute: Copy-paste the suggested command to hide ~/.gitconfig
            - 2. Execute: Produces example diff
            - 3. Execute: Copy-paste the suggested command(s) to unhide and
                          clean up.

What did you expect to happen? (Expected behavior)
    All (!) moved-only lines are colour coded cyan-purple.

What happened instead? (Actual behavior)
    Some (the first?) individual moved lines are colour coded (treated?) as if
    the line changed (red-green).
    In a commit with only one moved line, it is coloured as changed.

Whats different between what you expected and what actually happened?
    The distinct colouration for moved lines is lacking in the actual
    behaviour.

Anything else you want to add:
    Running "script.sh show" will use "git show" instead of "git diff". Same
    problem.

    Moved mode "plain" behaves as expected.

    Skimming "git log -p next" suggests that "--color-moved" did not change on
    "next" nor recently.

[System Info]
    git version 2.47.0
    shell-path: /bin/sh
    libc info: glibc: 2.39

[Enabled Hooks]
    None

----------------------------------------------------------------
Script to reproduce
----------------------------------------------------------------';

#!/usr/bin/env bash

trap 'echo 1>&2 "Error: $BASH_SOURCE:$LINENO $BASH_COMMAND";' ERR

function diff_now() {
  declare mode
  echo -e "==================== [${1:-""}] ===================="
  for mode in plain blocks zebra dimmed-zebra; do
  echo -e "\t----- (${mode}) -----";
    git "${2:-"diff"}" --color-moved="${mode}";
  done
  echo
}

clear || true;
if [[ -f ~/.gitconfig ]]; then
  echo 'mv -v ~/.gitconfig ~/.gitconfig.save';
  exit 0;
else
  echo 'mv -v ~/.gitconfig.save ~/.gitconfig';
fi
mkdir color_moved || { echo 'rm -rf color_moved'; exit 0; };
cd color_moved &&
git --version &&
git init &&
git config --local user.email "you@example.com" &&
git config --local user.name "Your Name" &&
cat <<-EOF >file.txt &&
	Is this even a line?
	The first line number 1
	The second line number 2
	The third line number 3
	The fourth line number 4
	The fifth line number 5
	The sixth line number 6
	The seventh line number 7
	The eighth line number 8
	The ninth line number 9
	The tenth line number 10
	The eleventh line number 11
	The twelfth line number 12
	The thirteenth line number 13
	The fourteenth line number 14
	The fifteenth line number 15
EOF
git add . &&
git commit -m "Initial commit" &&

cat <<-EOF >file.txt &&
	The first line number 1
	The second line number 2
	The ninth line number 9
	The tenth line number 10
	The eleventh line number 11
	The sixth line number 6
	The seventh line number 7
	The eighth line number 8
	The third line number 3
	The fourth line number 4
	The fifth line number 5
	Is this even a line?
	The twelfth line number 12
	The thirteenth line number 13
	The fourteenth line number 14
	The fifteenth line number 15
EOF
diff_now "Can identify moved lines in blocks (but not the single line)" "${1}" &&
git add . &&
git commit -m "Moved multiple blocks and a single line" &&

cat <<-EOF >file.txt &&
	The first line number 1
	The second line number 2
	The ninth line number 9
	The tenth line number 10
	Is this even a line?
	The eleventh line number 11
	The sixth line number 6
	The seventh line number 7
	The fourteenth line number 14
	The eighth line number 8
	The third line number 3
	The fourth line number 4
	The fifth line number 5
	The twelfth line number 12
	The thirteenth line number 13
	The fifteenth line number 15
EOF
diff_now "Cannot identify a single moved line" "${1}" &&
git add . &&
git commit -m "Moved only a single line" &&

echo;
echo "[OK]";
echo;
echo 'mv -v ~/.gitconfig.save ~/.gitconfig';
exit 0;
