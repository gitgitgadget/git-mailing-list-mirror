Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DAD2FB
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739755460; cv=none; b=uX7aAQOpP9A+EKLdZdO39uqSjtY7RQuWZ8eW75ExF2Dmzpx+H8otmG+k0+xBluiyfM4gwIUrPqMIbeFF16Bx4K/tH11NRY2Q5gogwEzdE0AWnrSVp7fUVXHnTckRU6ou3WjQHto1qh5NusyMtLW+VHfh1inNBRvYYbXpUoH5UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739755460; c=relaxed/simple;
	bh=DsClFoWUAL0MRNsBciSmFKRWAUpWOr7JkjO7YDwDLYE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=XrUhfyLdPL7V6776rEL0gx/T3Q1CGN/Rj8azRKpu2EhDpR88rjU6UCSgBQVlOGDif6Kf1yTNdK80nphrB7hqLKrwJBNd2EJy/3ZDg34Of4bGujr7ujTq/eQ2pZDm20xaAkKL/MNcRE7QjeMonIVi0Z2c7w3t8CPfl/HcHa5+Fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilKNIVfa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilKNIVfa"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c095b5365eso34981885a.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 17:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739755456; x=1740360256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IBrXYlIBpiQTqa0gH0BeZvAXFJjYO7h+BI8oL1FTCAk=;
        b=ilKNIVfauWYLO4EPwQ7S0Eloo+tPQbhe1ph4QIxf/2gtwOqAYaaeIscyPuGNa/HoRU
         P5brLoWZB8p6BTbDv+RU1q8GpBa7wXSWdZ/f/dmqPzzEe02G7+FMXOFYxAqWu9X0FI0x
         ByZF7TVAJ5ZVw8ukM5q0elTmsioW9N2XPAP5VQKZ2F+FcnFO7B1hBuVz1/vf3Vo3r4BX
         BYDeSbU3hpZ62PmR1/Jvk6h5IPs13NYb2fB5LqOouaIXPhtipN/hLrZVh7V3Y4T0PjJp
         v+67aAwVX3hcVzZJLZxBPPrxvWM2qLORqnfgQaB7aYU+rE2pRTl4HPLHHloWHJPZFUhJ
         ruAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739755456; x=1740360256;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBrXYlIBpiQTqa0gH0BeZvAXFJjYO7h+BI8oL1FTCAk=;
        b=PRNBEb1ES8E9fGqOuwsROoGFF2lA6/5UFCBzXxI+z67aBV6QJ8XgtRuTb/nvwkTZMu
         w+o0aMWmtsQh8lvUBDR74wYJXLaHAND5vRNsOw3/75/hrljQwDUXnOvz6zRr0wMNptFI
         TZis6/pewCvawJ8Gq4ex85NGpRTKDqsdnNRbRpStwqaiMR2ZGsiJXmqIqh3Op455pEKO
         YCi7nMNnPEt1/Lu7bxzIQZaUkP/Lz3B1UzJN7fH+bgpGgVKi0B5eCt+dSVwNlWgqkr25
         6pOXdtgnfOp6qJpChcYkA0ZOAww5Y74JH1iMqlMlSZ9ZBRXpUhmYQ6To2aJPl33nMaoJ
         wZgQ==
X-Gm-Message-State: AOJu0Yx59fqaJqxhiazXhlDBTVTv2pq0djhAS98rbejkkTCL1Y17xyWH
	1Ke6TfolXACX7VXDpEH+skqm4xZePLi4o+7eZoF7zYddXsL4CSqneg4Y6g==
X-Gm-Gg: ASbGncsC0dd3rniucZhk0smdRRA9XLW8irl7VEg0atfyEgs6ZuzrWVtDXD9XUc3hAL2
	laWCH0TFJH04H9rWIi2NbiDFxzGcvCAVZ1d5KLN2etWdeQ+ro3TxT4GKSywtTqNBVnwO+jj7EFB
	/r9UY7Vph5pmh9CGTtGJJT+1Rxyjy6uPudgiryoqDAj10QXYNORGLGBlg51LcOwC4dW3OEM3Dwi
	ZXxf20yE8lKoi5XEcYdH/jyieILbE6Y9HVBUFNXZzsWOV5grtgBxF3ez53XOnzF2/lDO2SnMy7P
	xPx5O8i1Ji0nQ0OJcb+7qSyiRIEXs9DLYVz3/sIlDWo3N3YXgW0WY0s4GZwLrdsr1eb8F002
X-Google-Smtp-Source: AGHT+IF1yAdsMzp8YNZ5a8tBf9qSxpBngMD+r5jFbFTPSqyab9LhO//6CykdQ2UDsnQy6LrGamX98A==
X-Received: by 2002:a05:620a:45a8:b0:7c0:7c8b:f30e with SMTP id af79cd13be357-7c08a9a152cmr1021870485a.15.1739755456521;
        Sun, 16 Feb 2025 17:24:16 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:fec2:7085:7ce5:711c? ([2600:4041:5b0d:f100:fec2:7085:7ce5:711c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09e95b68fsm61878385a.12.2025.02.16.17.24.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 17:24:16 -0800 (PST)
Message-ID: <b59b75a1ad77f59cc8d81e2dd5cc9607e53b50af.camel@gmail.com>
Subject: Crash on empty pickaxe argument
From: Jared Van Bortel <cebtenzzre@gmail.com>
To: git@vger.kernel.org
Date: Sun, 16 Feb 2025 20:24:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I fat-fingered my enter key today and noticed this crash:

$ git --version
git version 2.48.1
$ mkdir foo && cd foo
$ git init
<snip>
$ git commit --allow-empty -m "foo"
[master (root-commit) ed4e080] foo
$ git log -S ""
BUG: diffcore-pickaxe.c:241: should have needle under -G or -S
[1]    65421 IOT instruction (core dumped)  git log -S ""
$ git log -G ""
BUG: diffcore-pickaxe.c:241: should have needle under -G or -S
[1]    65457 IOT instruction (core dumped)  git log -G ""


Well, it says BUG right there. It probably shouldn't crash. Relevant
backtrace for -S:

#3  0x00007ffff7ce7582 in __GI_abort () at abort.c:73
#4  0x00005555558689aa in BUG_vfl (file=3D<optimized out>, line=3D<optimize=
d out>, fmt=3D0x5555558ed498 "should have needle under -G or -S", params=3D=
0x7fffffffbf70)
    at /usr/src/debug/git/git-2.48.1/usage.c:318
#5  BUG_fl (file=3D<optimized out>, line=3D<optimized out>, fmt=3D0x5555558=
ed498 "should have needle under -G or -S") at /usr/src/debug/git/git-2.48.1=
/usage.c:335
#6  0x000055555571527f in diffcore_pickaxe (o=3D0x7fffffffca90) at /usr/src=
/debug/git/git-2.48.1/diffcore-pickaxe.c:241
#7  diffcore_std (options=3D0x7fffffffca90) at /usr/src/debug/git/git-2.48.=
1/diff.c:7079
#8  0x00005555558b2788 in log_tree_diff_flush.isra.0 (opt=3D0x7fffffffc4d0)=
 at /usr/src/debug/git/git-2.48.1/log-tree.c:929
#9  0x000055555574b2e4 in log_tree_diff (opt=3D0x7fffffffc4d0, commit=3D0x5=
555559b7b80, log=3D0x7fffffffc300) at /usr/src/debug/git/git-2.48.1/log-tre=
e.c:1120
#10 log_tree_commit (opt=3D0x7fffffffc4d0, commit=3D0x5555559b7b80) at /usr=
/src/debug/git/git-2.48.1/log-tree.c:1188
#11 0x00005555555e68c8 in cmd_log_walk_no_free (rev=3D<optimized out>) at b=
uiltin/log.c:528
#12 cmd_log_walk_no_free (rev=3Drev@entry=3D0x7fffffffc4d0) at builtin/log.=
c:506
#13 0x00005555555e74bf in cmd_log_walk (rev=3D0x7fffffffc4d0) at builtin/lo=
g.c:569
#14 cmd_log (argc=3D3, argv=3D0x5555559b0790, prefix=3D0x0, repo=3D<optimiz=
ed out>) at builtin/log.c:950
#15 0x000055555555e56c in run_builtin (p=3D0x555555977f40 <commands.lto_pri=
v+1440>, argc=3D<optimized out>, argv=3D<optimized out>, repo=3D0x555555986=
d40 <the_repo.lto_priv>)
    at /usr/src/debug/git/git-2.48.1/git.c:480
#16 handle_builtin (args=3Dargs@entry=3D0x7fffffffd4a0) at /usr/src/debug/g=
it/git-2.48.1/git.c:740
#17 0x000055555555ec34 in run_argv (args=3D0x7fffffffd4a0) at /usr/src/debu=
g/git/git-2.48.1/git.c:807
#18 0x00005555555598a1 in cmd_main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>) at /usr/src/debug/git/git-2.48.1/git.c:947
#19 main (argc=3D<optimized out>, argv=3D<optimized out>) at /usr/src/debug=
/git/git-2.48.1/common-main.c:64


Thanks,
Jared
