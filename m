Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBA3A5433
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257185; cv=none; b=JynrAzFnvaHXmYpnsZK1zxbcqG8WzFd2zSiJQiKKiwUrzfGiDTQvfGq7y73hXqUeqgKoElmNAI9jHyCxrzMJeP7F44qp3YZ7dfZ7KtVe6nFPTM7XhG89VGxAyBwptmlohfFMOQC/B9fkonEy23MyURQAWqlVezYrGRj8l3jRkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257185; c=relaxed/simple;
	bh=Nq1donUjhedsuUGx00D3Twh/xTBKx3JtoYd5XTBJOIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XeoIWXPnqY4McDGvv/VGnrYOfPNnQJmlHzgOBPbJ+mzdbMNPoMORn/eV+qUBKJ7pjeSAHrh16zyD9TRYyCLjFehHVIk0FFGNxLFu45GN4glkZTBabp1eEuu0xv1QaDhiRdiBqZODPP1J7t8JdQqLSDJnHNLLeKQ3+y3vSvuMc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3FjXAa7; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3FjXAa7"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f38so10128025ad.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257172; x=1790861972; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yueaR8bPFHkTP7K+B1mfKU8d2pHdieB/ETbnkSX8OrM=;
        b=T3FjXAa7WKC5Eiuu6eahpXQPcF9vLyz74gi1g2+EfS/PMhiRXzl099heg55CU9NCtg
         AFxhlbNTzMEoQGwVkX5Yk+MG+mF57BWJcEFjmtVZ0PKUU9d5QvC6Tc/e+9YJbt6cxGAa
         ZRhd+ttEOexjgZfzrQo1LCdI1CYIi4i1TNV7OxCYV9c65nFbGaaeeX3Z7icVadw38E4w
         /I2LYO1CS17us/u6KqKUAZu6YjBSNhTX9BLguMtGjoeFpKNXV465oiMKll4te3ztOQuX
         0czAHH3x7fLliJJjOQFZx3XFi54/oh/8gK5ZG1KlGhNWEztvu3tHADN5DlYh1MFPb7iT
         QPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257172; x=1790861972;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yueaR8bPFHkTP7K+B1mfKU8d2pHdieB/ETbnkSX8OrM=;
        b=TOdfylhDfN8ZjIQTZTGkUI9lDNXkhdwcsgTXN5Bsbg+KZsySSv6lMXoRzrsBAjHgNr
         97OqgnjlZEE6PL4OQgybmfBjQj9tczWJa55U+RedPTVp0SE6GKpzgcOadwoU8rmOR8th
         prsYIbgEGkziXhTgKusm2Ok/xQmrHT2XC9Lg8AQxeFkgQfmJqQQGMALxT5OwtzJmoWwe
         ccb1IsBYwbL7DYkJbme5ZAYqxyFwPKEcZaPfiQytq5qlIQQhMTTWyvAQC+QaZjwbf8Zx
         gZE+SriYjBCJeVfNQD9TNRo+GHhFV8y2XFYQbZyUA0rzSZU5yOngTPv0Bxul02hEBAZP
         aBfQ==
X-Gm-Message-State: AFuF++kkKWgGiOQylvhbGqB/egVQoUEc2w+4H8SxsujDoyheQ2Y+bNWN
	904oyBEADv0lspHMBktGsEuhC6KLLWjmdX7mFi6C1Gk0mzvQhH1bSfBMCVf/iY9s4rg=
X-Gm-Gg: AYBFou23uLofPqNPv/jiAbUR4iqnpf0SzE9LiE52Fn5ZziVECdLrYD5XczXuM1oz50d
	aK3w2V1afPIXUjXzAe+KNyLLxMZYM7pL68RFVCQHXO9aznY7leTf0u6ysJu/h//s6dIbskk3MNu
	S8ee98uy9bQxKsEQjK63jjj+M9y8mfxCxpWqFP7VjeTdX4DtqrvI4wPOtaR+Fu8foAtLz454UUx
	NBoAORuqhCUA/TzUoSyUtA9jPsYEYA4d1R41r3nM1+Y/nZjupuDKKK/0YyH9MCiYZrfTZxGmIDw
	lcOxIMeS7gcRPpn8h+r0VCQZGKU7R1ZY1W6vFpqld1Fmzch4Dc9UkzRpFy/WCKLAxRlDUzJVwrz
	AkWCqi2JVKWPQ7MAFrQyXjwmRG098muLMg+knRBJZt6zjb5YTLXFa1MZn2dE9hzLDN70klsMEv3
	3UN5Pnqt1QJDQOGefdrzzwA9jAOJmIF2nUXXBgNgJ86iyHybfywyPS17Wx5M+sjpLlPvxel6eKf
	w==
X-Received: by 2002:a17:902:d98d:b0:2dd:c100:7cc3 with SMTP id d9443c01a7336-2df7dd72aa3mr24175685ad.63.1790257169717;
        Thu, 24 Sep 2026 06:39:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.188.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c3a32sm27791795ad.42.2026.09.24.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:39:28 -0700 (PDT)
Message-Id: <pull.2238.v2.git.1790257167561.gitgitgadget@gmail.com>
In-Reply-To: <pull.2238.git.1790229073946.gitgitgadget@gmail.com>
References: <pull.2238.git.1790229073946.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?St=C3=A9fan?= Driaan Turvey via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 13:39:27 +0000
Subject: [PATCH v2] git-gui: add Afrikaans translation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?St=C3=A9fan?= Driaan Turvey <stefanturvey1912@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?q?St=C3=A9fan=20Driaan=20Turvey?= <stefanturvey1912@gmail.com>

From: =?UTF-8?q?St=C3=A9fan=20Driaan=20Turvey?= <stefanturvey1912@gmail.com>

Add an Afrikaans translation of git-gui.

Register the language in po/meson.build and omit source
locations in po/af.po.

Signed-off-by: Stéfan Driaan Turvey <stefanturvey1912@gmail.com>
---
    git-gui: add Afrikaans translation
    
    Add an Afrikaans translation of git-gui.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2238%2FTopsy2003Turvey%2Fafrikaans-gui-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2238/Topsy2003Turvey/afrikaans-gui-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2238

Range-diff vs v1:

 1:  ce1f406d4b ! 1:  3015e1802e git-gui: add Afrikaans translation
     @@ Commit message
      
          Add an Afrikaans translation of git-gui.
      
     +    Register the language in po/meson.build and omit source
     +    locations in po/af.po.
     +
          Signed-off-by: Stéfan Driaan Turvey <stefanturvey1912@gmail.com>
      
       ## po/af.po (new) ##
     @@ po/af.po (new)
      +"Content-Transfer-Encoding: 8bit\n"
      +"Plural-Forms: nplurals=2; plural=(n != 1);\n"
      +
     -+#: git-gui.sh:793
      +#, tcl-format
      +msgid "Invalid font specified in %s:"
      +msgstr "Ongeldige lettertipe in %s gespesifiseer:"
      +
     -+#: git-gui.sh:847
      +msgid "Main Font"
      +msgstr "Hooflettertipe"
      +
     -+#: git-gui.sh:848
      +msgid "Diff/Console Font"
      +msgstr "Verskil-/konsolelettertipe"
      +
     -+#: git-gui.sh:863 git-gui.sh:879 git-gui.sh:893 git-gui.sh:922 git-gui.sh:938
      +msgid "git-gui: fatal error"
      +msgstr "git-gui: fatale fout"
      +
     -+#: git-gui.sh:864
      +msgid "Cannot find git in PATH."
      +msgstr "Kan nie git in PATH vind nie."
      +
     -+#: git-gui.sh:894
      +msgid "Cannot parse Git version string:"
      +msgstr "Kan nie die Git-weergawestring ontleed nie:"
      +
     -+#: git-gui.sh:915
      +msgid "Insufficient git version, require: "
      +msgstr "Ontoereikende git-weergawe, vereis: "
      +
     -+#: git-gui.sh:916
      +msgid "git returned:"
      +msgstr "git het teruggegee:"
      +
     -+#: git-gui.sh:1156
      +msgid "Invalid configuration:"
      +msgstr "Ongeldige konfigurasie:"
      +
     -+#: git-gui.sh:1202
      +msgid "Unusable repo/worktree:"
      +msgstr "Onbruikbare bewaarplek/werkboom:"
      +
     -+#: git-gui.sh:1210
      +msgid "Git directory not found:"
      +msgstr "Git-gids nie gevind nie:"
      +
     -+#: git-gui.sh:1236
      +msgid "No working directory"
      +msgstr "Geen werkgids nie"
      +
     -+#: git-gui.sh:1241
      +msgid "Cannot use bare repository:"
      +msgstr "Kan nie kaal bewaarplek gebruik nie:"
      +
     -+#: git-gui.sh:1429 lib/checkout_op.tcl:306
      +msgid "Refreshing file status..."
      +msgstr "Verfris tans lêerstatus..."
      +
     -+#: git-gui.sh:1462
      +msgid "Scanning for modified files ..."
      +msgstr "Soek tans na gewysigde lêers ..."
      +
     -+#: git-gui.sh:1541
      +msgid "Calling prepare-commit-msg hook..."
      +msgstr "Roep tans prepare-commit-msg-haak aan..."
      +
     -+#: git-gui.sh:1558
      +msgid "Commit declined by prepare-commit-msg hook."
      +msgstr "Vaslegging deur prepare-commit-msg-haak geweier."
      +
     -+#: git-gui.sh:1716 lib/browser.tcl:250
      +msgid "Ready."
      +msgstr "Gereed."
      +
     -+#: git-gui.sh:1879
      +#, tcl-format
      +msgid ""
      +"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
     @@ po/af.po (new)
      +"Vertoonlimiet (gui.maxfilesdisplayed = %s) bereik, nie al %s lêers word "
      +"gewys nie."
      +
     -+#: git-gui.sh:2002
      +msgid "Unmodified"
      +msgstr "Ongewysig"
      +
     -+#: git-gui.sh:2004
      +msgid "Modified, not staged"
      +msgstr "Gewysig, nie geplaas nie"
      +
     -+#: git-gui.sh:2005 git-gui.sh:2017
      +msgid "Staged for commit"
      +msgstr "Geplaas vir vaslegging"
      +
     -+#: git-gui.sh:2006 git-gui.sh:2018
      +msgid "Portions staged for commit"
      +msgstr "Gedeeltes geplaas vir vaslegging"
      +
     -+#: git-gui.sh:2007 git-gui.sh:2019
      +msgid "Staged for commit, missing"
      +msgstr "Geplaas vir vaslegging, ontbreek"
      +
     -+#: git-gui.sh:2009
      +msgid "File type changed, not staged"
      +msgstr "Lêertipe verander, nie geplaas nie"
      +
     -+#: git-gui.sh:2010 git-gui.sh:2011
      +msgid "File type changed, old type staged for commit"
      +msgstr "Lêertipe verander, ou tipe geplaas vir vaslegging"
      +
     -+#: git-gui.sh:2012
      +msgid "File type changed, staged"
      +msgstr "Lêertipe verander, geplaas"
      +
     -+#: git-gui.sh:2013
      +msgid "File type change staged, modification not staged"
      +msgstr "Lêertipeverandering geplaas, wysiging nie geplaas nie"
      +
     -+#: git-gui.sh:2014
      +msgid "File type change staged, file missing"
      +msgstr "Lêertipeverandering geplaas, lêer ontbreek"
      +
     -+#: git-gui.sh:2016
      +msgid "Untracked, not staged"
      +msgstr "Onnaspoorbaar, nie geplaas nie"
      +
     -+#: git-gui.sh:2021
      +msgid "Missing"
      +msgstr "Ontbreek"
      +
     -+#: git-gui.sh:2022
      +msgid "Staged for removal"
      +msgstr "Geplaas vir verwydering"
      +
     -+#: git-gui.sh:2023
      +msgid "Staged for removal, still present"
      +msgstr "Geplaas vir verwydering, steeds teenwoordig"
      +
     -+#: git-gui.sh:2025 git-gui.sh:2026 git-gui.sh:2027 git-gui.sh:2028
     -+#: git-gui.sh:2029 git-gui.sh:2030
      +msgid "Requires merge resolution"
      +msgstr "Vereis oplossing van saamsmelting"
      +
     -+#: git-gui.sh:2074
      +msgid "Couldn't find gitk in PATH"
      +msgstr "Kon nie gitk in PATH vind nie"
      +
     -+#: git-gui.sh:2113 git-gui.sh:2144
      +#, tcl-format
      +msgid "Starting %s... please wait..."
      +msgstr "Begin tans %s... wag asseblief..."
      +
     -+#: git-gui.sh:2128
      +msgid "Couldn't find git gui in PATH"
      +msgstr "Kon nie git gui in PATH vind nie"
      +
     -+#: git-gui.sh:2623 lib/choose_repository.tcl:43
      +msgid "Repository"
      +msgstr "Bewaarplek"
      +
     -+#: git-gui.sh:2624
      +msgid "Edit"
      +msgstr "Redigeer"
      +
     -+#: git-gui.sh:2626 lib/choose_rev.tcl:557
      +msgid "Branch"
      +msgstr "Tak"
      +
     -+#: git-gui.sh:2629 lib/choose_rev.tcl:544
      +msgid "Commit@@noun"
      +msgstr "Vaslegging"
      +
     -+#: git-gui.sh:2632 lib/merge.tcl:118 lib/merge.tcl:165
      +msgid "Merge"
      +msgstr "Saamsmelt"
      +
     -+#: git-gui.sh:2633 lib/choose_rev.tcl:553
      +msgid "Remote"
      +msgstr "Afgeleë"
      +
     -+#: git-gui.sh:2636
      +msgid "Tools"
      +msgstr "Gereedskap"
      +
     -+#: git-gui.sh:2645
      +msgid "Explore Working Copy"
      +msgstr "Verken werkkopie"
      +
     -+#: git-gui.sh:2658
      +msgid "Git Bash"
      +msgstr "Git Bash"
      +
     -+#: git-gui.sh:2668
      +msgid "Browse Current Branch's Files"
      +msgstr "Blaai deur huidige tak se lêers"
      +
     -+#: git-gui.sh:2672
      +msgid "Browse Branch Files..."
      +msgstr "Blaai deur taklêers..."
      +
     -+#: git-gui.sh:2677
      +msgid "Visualize Current Branch's History"
      +msgstr "Visualiseer huidige tak se geskiedenis"
      +
     -+#: git-gui.sh:2681
      +msgid "Visualize All Branch History"
      +msgstr "Visualiseer alle takke se geskiedenis"
      +
     -+#: git-gui.sh:2688
      +#, tcl-format
      +msgid "Browse %s's Files"
      +msgstr "Blaai deur %s se lêers"
      +
     -+#: git-gui.sh:2690
      +#, tcl-format
      +msgid "Visualize %s's History"
      +msgstr "Visualiseer %s se geskiedenis"
      +
     -+#: git-gui.sh:2695 lib/database.tcl:39
      +msgid "Database Statistics"
      +msgstr "Databasisstatistiek"
      +
     -+#: git-gui.sh:2698 lib/database.tcl:32
      +msgid "Compress Database"
      +msgstr "Pak databasis saam"
      +
     -+#: git-gui.sh:2701
      +msgid "Verify Database"
      +msgstr "Verifieer databasis"
      +
     -+#: git-gui.sh:2708 git-gui.sh:2712 git-gui.sh:2716
      +msgid "Create Desktop Icon"
      +msgstr "Skep werkskermikoon"
      +
     -+#: git-gui.sh:2724 lib/choose_repository.tcl:196 lib/choose_repository.tcl:204
      +msgid "Quit"
      +msgstr "Verlaat"
      +
     -+#: git-gui.sh:2732
      +msgid "Undo"
      +msgstr "Ontdoen"
      +
     -+#: git-gui.sh:2735
      +msgid "Redo"
      +msgstr "Herdoen"
      +
     -+#: git-gui.sh:2739 git-gui.sh:3349
      +msgid "Cut"
      +msgstr "Knip"
      +
     -+#: git-gui.sh:2742 git-gui.sh:3352 git-gui.sh:3428 git-gui.sh:3523
     -+#: lib/console.tcl:69
      +msgid "Copy"
      +msgstr "Kopieer"
      +
     -+#: git-gui.sh:2745 git-gui.sh:3355
      +msgid "Paste"
      +msgstr "Plak"
      +
     -+#: git-gui.sh:2748 git-gui.sh:3358 lib/branch_delete.tcl:28
     -+#: lib/remote_branch_delete.tcl:39
      +msgid "Delete"
      +msgstr "Skrap"
      +
     -+#: git-gui.sh:2752 git-gui.sh:3362 git-gui.sh:3527 lib/console.tcl:71
      +msgid "Select All"
      +msgstr "Kies alles"
      +
     -+#: git-gui.sh:2761
      +msgid "Create..."
      +msgstr "Skep..."
      +
     -+#: git-gui.sh:2767
      +msgid "Checkout..."
      +msgstr "Check uit..."
      +
     -+#: git-gui.sh:2773
      +msgid "Rename..."
      +msgstr "Hernoem..."
      +
     -+#: git-gui.sh:2778
      +msgid "Delete..."
      +msgstr "Skrap..."
      +
     -+#: git-gui.sh:2783
      +msgid "Reset..."
      +msgstr "Herstel..."
      +
     -+#: git-gui.sh:2793
      +msgid "Done"
      +msgstr "Klaar"
      +
     -+#: git-gui.sh:2795
      +msgid "Commit@@verb"
      +msgstr "Lê vas"
      +
     -+#: git-gui.sh:2804 git-gui.sh:3288
      +msgid "Amend Last Commit"
      +msgstr "Wysig laaste vaslegging"
      +
     -+#: git-gui.sh:2814 git-gui.sh:3249 lib/remote_branch_delete.tcl:97
      +msgid "Rescan"
      +msgstr "Herskandeer"
      +
     -+#: git-gui.sh:2820
      +msgid "Stage To Commit"
      +msgstr "Plaas vir vaslegging"
      +
     -+#: git-gui.sh:2826
      +msgid "Stage Changed Files To Commit"
      +msgstr "Plaas gewysigde lêers vir vaslegging"
      +
     -+#: git-gui.sh:2832
      +msgid "Unstage From Commit"
      +msgstr "Ontplaas uit vaslegging"
      +
     -+#: git-gui.sh:2838 lib/index.tcl:521
      +msgid "Revert Changes"
      +msgstr "Keer veranderinge om"
      +
     -+#: git-gui.sh:2846 git-gui.sh:3590 git-gui.sh:3621
      +msgid "Show Less Context"
      +msgstr "Wys minder konteks"
      +
     -+#: git-gui.sh:2850 git-gui.sh:3594 git-gui.sh:3625
      +msgid "Show More Context"
      +msgstr "Wys meer konteks"
      +
     -+#: git-gui.sh:2857 git-gui.sh:3262 git-gui.sh:3373
      +msgid "Sign Off"
      +msgstr "Teken af"
      +
     -+#: git-gui.sh:2873
      +msgid "Local Merge..."
      +msgstr "Plaaslike saamsmelting..."
      +
     -+#: git-gui.sh:2878
      +msgid "Abort Merge..."
      +msgstr "Staak saamsmelting..."
      +
     -+#: git-gui.sh:2890 git-gui.sh:2918
      +msgid "Add..."
      +msgstr "Voeg by..."
      +
     -+#: git-gui.sh:2894
      +msgid "Push..."
      +msgstr "Stoot..."
      +
     -+#: git-gui.sh:2898
      +msgid "Delete Branch..."
      +msgstr "Skrap tak..."
      +
     -+#: git-gui.sh:2908 git-gui.sh:3556
      +msgid "Options..."
      +msgstr "Opsies..."
      +
     -+#: git-gui.sh:2919
      +msgid "Remove..."
      +msgstr "Verwyder..."
      +
     -+#: git-gui.sh:2928 lib/choose_repository.tcl:57
      +msgid "Help"
      +msgstr "Hulp"
      +
     -+#: git-gui.sh:2932 git-gui.sh:2936 lib/about.tcl:14
     -+#: lib/choose_repository.tcl:51 lib/choose_repository.tcl:60
      +#, tcl-format
      +msgid "About %s"
      +msgstr "Aangaande %s"
      +
     -+#: git-gui.sh:2956
      +msgid "Online Documentation"
      +msgstr "Aanlyn dokumentasie"
      +
     -+#: git-gui.sh:2959 lib/choose_repository.tcl:54 lib/choose_repository.tcl:63
      +msgid "Show SSH Key"
      +msgstr "Wys SSH-sleutel"
      +
     -+#: git-gui.sh:2989 git-gui.sh:3130
      +msgid "usage:"
      +msgstr "gebruik:"
      +
     -+#: git-gui.sh:2993 git-gui.sh:3134
      +msgid "Usage"
      +msgstr "Gebruik"
      +
     -+#: git-gui.sh:3077
      +#, tcl-format
      +msgid "fatal: no such file '%s' in worktree"
      +msgstr "fataal: geen lêer '%s' in werkboom nie"
      +
     -+#: git-gui.sh:3087
      +#, tcl-format
      +msgid "fatal: '%s' is not a valid rev'"
      +msgstr "fataal: '%s' is nie 'n geldige revisie nie'"
      +
     -+#: git-gui.sh:3104
      +#, tcl-format
      +msgid "'%s' is not a directory in rev '%s'"
      +msgstr "'%s' is nie 'n gids in revisie '%s' nie"
      +
     -+#: git-gui.sh:3106
      +#, tcl-format
      +msgid "'%s' is not a filename in rev '%s'"
      +msgstr "'%s' is nie 'n lêernaam in revisie '%s' nie"
      +
     -+#: git-gui.sh:3146
      +msgid "Current Branch:"
      +msgstr "Huidige tak:"
      +
     -+#: git-gui.sh:3167
      +msgid "Unstaged Changes"
      +msgstr "Ongeplaasde veranderinge"
      +
     -+#: git-gui.sh:3189
      +msgid "Staged Changes (Will Commit)"
      +msgstr "Geplaasde veranderinge (sal vasgelê word)"
      +
     -+#: git-gui.sh:3255
      +msgid "Stage Changed"
      +msgstr "Plaas gewysigdes"
      +
     -+#: git-gui.sh:3274 lib/transport.tcl:137
      +msgid "Push"
      +msgstr "Stoot"
      +
     -+#: git-gui.sh:3301
      +msgid "Initial Commit Message:"
      +msgstr "Aanvanklike vasleggingsboodskap:"
      +
     -+#: git-gui.sh:3302
      +msgid "Amended Commit Message:"
      +msgstr "Gewysigde vasleggingsboodskap:"
      +
     -+#: git-gui.sh:3303
      +msgid "Amended Initial Commit Message:"
      +msgstr "Gewysigde aanvanklike vasleggingsboodskap:"
      +
     -+#: git-gui.sh:3304
      +msgid "Amended Merge Commit Message:"
      +msgstr "Gewysigde saamsmeltvasleggingsboodskap:"
      +
     -+#: git-gui.sh:3305
      +msgid "Merge Commit Message:"
      +msgstr "Saamsmeltvasleggingsboodskap:"
      +
     -+#: git-gui.sh:3306
      +msgid "Commit Message:"
      +msgstr "Vasleggingsboodskap:"
      +
     -+#: git-gui.sh:3365 git-gui.sh:3531 lib/console.tcl:73
      +msgid "Copy All"
      +msgstr "Kopieer alles"
      +
     -+#: git-gui.sh:3389 lib/blame.tcl:106
      +msgid "File:"
      +msgstr "Lêer:"
      +
     -+#: git-gui.sh:3437 lib/choose_repository.tcl:655
      +msgid "Open"
      +msgstr "Open"
      +
     -+#: git-gui.sh:3519
      +msgid "Refresh"
      +msgstr "Verfris"
      +
     -+#: git-gui.sh:3540
      +msgid "Decrease Font Size"
      +msgstr "Verklein lettergrootte"
      +
     -+#: git-gui.sh:3544
      +msgid "Increase Font Size"
      +msgstr "Vergroot lettergrootte"
      +
     -+#: git-gui.sh:3552 lib/blame.tcl:295
      +msgid "Encoding"
      +msgstr "Enkodering"
      +
     -+#: git-gui.sh:3563
      +msgid "Apply/Reverse Hunk"
      +msgstr "Pas brok toe/keer om"
      +
     -+#: git-gui.sh:3568
      +msgid "Apply/Reverse Line"
      +msgstr "Pas reël toe/keer om"
      +
     -+#: git-gui.sh:3574 git-gui.sh:3684 git-gui.sh:3695
      +msgid "Revert Hunk"
      +msgstr "Keer brok om"
      +
     -+#: git-gui.sh:3579 git-gui.sh:3691 git-gui.sh:3702
      +msgid "Revert Line"
      +msgstr "Keer reël om"
      +
     -+#: git-gui.sh:3584 git-gui.sh:3681
      +msgid "Undo Last Revert"
      +msgstr "Ontdoen laaste omkering"
      +
     -+#: git-gui.sh:3603
      +msgid "Run Merge Tool"
      +msgstr "Voer saamsmeltgereedskap uit"
      +
     -+#: git-gui.sh:3608
      +msgid "Use Remote Version"
      +msgstr "Gebruik afgeleë weergawe"
      +
     -+#: git-gui.sh:3612
      +msgid "Use Local Version"
      +msgstr "Gebruik plaaslike weergawe"
      +
     -+#: git-gui.sh:3616
      +msgid "Revert To Base"
      +msgstr "Keer terug na basis"
      +
     -+#: git-gui.sh:3634
      +msgid "Visualize These Changes In The Submodule"
      +msgstr "Visualiseer hierdie veranderinge in die submodule"
      +
     -+#: git-gui.sh:3638
      +msgid "Visualize Current Branch History In The Submodule"
      +msgstr "Visualiseer huidige tak se geskiedenis in die submodule"
      +
     -+#: git-gui.sh:3642
      +msgid "Visualize All Branch History In The Submodule"
      +msgstr "Visualiseer alle takke se geskiedenis in die submodule"
      +
     -+#: git-gui.sh:3647
      +msgid "Start git gui In The Submodule"
      +msgstr "Begin git gui in die submodule"
      +
     -+#: git-gui.sh:3683
      +msgid "Unstage Hunk From Commit"
      +msgstr "Ontplaas brok uit vaslegging"
      +
     -+#: git-gui.sh:3687
      +msgid "Unstage Lines From Commit"
      +msgstr "Ontplaas reëls uit vaslegging"
      +
     -+#: git-gui.sh:3688 git-gui.sh:3699
      +msgid "Revert Lines"
      +msgstr "Keer reëls om"
      +
     -+#: git-gui.sh:3690
      +msgid "Unstage Line From Commit"
      +msgstr "Ontplaas reël uit vaslegging"
      +
     -+#: git-gui.sh:3694
      +msgid "Stage Hunk For Commit"
      +msgstr "Plaas brok vir vaslegging"
      +
     -+#: git-gui.sh:3698
      +msgid "Stage Lines For Commit"
      +msgstr "Plaas reëls vir vaslegging"
      +
     -+#: git-gui.sh:3701
      +msgid "Stage Line For Commit"
      +msgstr "Plaas reël vir vaslegging"
      +
     -+#: git-gui.sh:3751
      +msgid "Initializing..."
      +msgstr "Inisialiseer tans..."
      +
     -+#: lib/about.tcl:26
      +msgid "git-gui - a graphical user interface for Git."
      +msgstr "git-gui - 'n grafiese gebruikerskoppelvlak vir Git."
      +
     -+#: lib/blame.tcl:74
      +#, tcl-format
      +msgid "%s (%s): File Viewer"
      +msgstr "%s (%s): Lêerbekyker"
      +
     -+#: lib/blame.tcl:80
      +msgid "Commit:"
      +msgstr "Vaslegging:"
      +
     -+#: lib/blame.tcl:281
      +msgid "Copy Commit"
      +msgstr "Kopieer vaslegging"
      +
     -+#: lib/blame.tcl:285
      +msgid "Find Text..."
      +msgstr "Soek teks..."
      +
     -+#: lib/blame.tcl:289
      +msgid "Goto Line..."
      +msgstr "Gaan na reël..."
      +
     -+#: lib/blame.tcl:298
      +msgid "Do Full Copy Detection"
      +msgstr "Doen volledige kopie-opsporing"
      +
     -+#: lib/blame.tcl:302
      +msgid "Show History Context"
      +msgstr "Wys geskiedeniskonteks"
      +
     -+#: lib/blame.tcl:305
      +msgid "Blame Parent Commit"
      +msgstr "Blameer ouervaslegging"
      +
     -+#: lib/blame.tcl:469
      +#, tcl-format
      +msgid "Reading %s..."
      +msgstr "Lees tans %s..."
      +
     -+#: lib/blame.tcl:576
      +msgid "Error"
      +msgstr "Fout"
      +
     -+#: lib/blame.tcl:597
      +msgid "Loading copy/move tracking annotations..."
      +msgstr "Laai tans kopieer-/skuifnaspooraantekeninge..."
      +
     -+#: lib/blame.tcl:614
      +msgid "lines annotated"
      +msgstr "reëls geannoteer"
      +
     -+#: lib/blame.tcl:815
      +msgid "Loading original location annotations..."
      +msgstr "Laai tans aantekeninge van oorspronklike ligging..."
      +
     -+#: lib/blame.tcl:818
      +msgid "Annotation complete."
      +msgstr "Annotering voltooi."
      +
     -+#: lib/blame.tcl:849
      +msgid "Busy"
      +msgstr "Besig"
      +
     -+#: lib/blame.tcl:850
      +msgid "Annotation process is already running."
      +msgstr "Annoteringsproses loop reeds."
      +
     -+#: lib/blame.tcl:887
      +msgid "Running thorough copy detection..."
      +msgstr "Voer tans deeglike kopie-opsporing uit..."
      +
     -+#: lib/blame.tcl:955
      +msgid "Loading annotation..."
      +msgstr "Laai tans annotering..."
      +
     -+#: lib/blame.tcl:1008
      +msgid "Author:"
      +msgstr "Outeur:"
      +
     -+#: lib/blame.tcl:1012
      +msgid "Committer:"
      +msgstr "Vaslegger:"
      +
     -+#: lib/blame.tcl:1017
      +msgid "Original File:"
      +msgstr "Oorspronklike lêer:"
      +
     -+#: lib/blame.tcl:1065
      +msgid "Cannot find HEAD commit:"
      +msgstr "Kan nie HEAD-vaslegging vind nie:"
      +
     -+#: lib/blame.tcl:1120
      +msgid "Cannot find parent commit:"
      +msgstr "Kan nie ouervaslegging vind nie:"
      +
     -+#: lib/blame.tcl:1135
      +msgid "Unable to display parent"
      +msgstr "Kan nie ouer vertoon nie"
      +
     -+#: lib/blame.tcl:1136 lib/diff.tcl:318
      +msgid "Error loading diff:"
      +msgstr "Fout met laai van verskil:"
      +
     -+#: lib/blame.tcl:1276
      +msgid "Originally By:"
      +msgstr "Oorspronklik deur:"
      +
     -+#: lib/blame.tcl:1282
      +msgid "In File:"
      +msgstr "In lêer:"
      +
     -+#: lib/blame.tcl:1287
      +msgid "Copied Or Moved Here By:"
      +msgstr "Hierheen gekopieer of geskuif deur:"
      +
     -+#: lib/branch_checkout.tcl:15
      +#, tcl-format
      +msgid "%s (%s): Checkout Branch"
      +msgstr "%s (%s): Check tak uit"
      +
     -+#: lib/branch_checkout.tcl:20
      +msgid "Checkout Branch"
      +msgstr "Check tak uit"
      +
     -+#: lib/branch_checkout.tcl:25
      +msgid "Checkout"
      +msgstr "Check uit"
      +
     -+#: lib/branch_checkout.tcl:29 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
     -+#: lib/branch_rename.tcl:32 lib/browser.tcl:289 lib/checkout_op.tcl:571
     -+#: lib/choose_font.tcl:44 lib/merge.tcl:169 lib/option.tcl:127
     -+#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
     -+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
      +msgid "Cancel"
      +msgstr "Kanselleer"
      +
     -+#: lib/branch_checkout.tcl:34 lib/browser.tcl:294 lib/tools_dlg.tcl:321
      +msgid "Revision"
      +msgstr "Revisie"
      +
     -+#: lib/branch_checkout.tcl:38 lib/branch_create.tcl:67 lib/option.tcl:298
      +msgid "Options"
      +msgstr "Opsies"
      +
     -+#: lib/branch_checkout.tcl:41 lib/branch_create.tcl:90
      +msgid "Fetch Tracking Branch"
      +msgstr "Haal volgtak"
      +
     -+#: lib/branch_checkout.tcl:46
      +msgid "Detach From Local Branch"
      +msgstr "Ontkoppel van plaaslike tak"
      +
     -+#: lib/branch_create.tcl:23
      +#, tcl-format
      +msgid "%s (%s): Create Branch"
      +msgstr "%s (%s): Skep tak"
      +
     -+#: lib/branch_create.tcl:28
      +msgid "Create New Branch"
      +msgstr "Skep nuwe tak"
      +
     -+#: lib/branch_create.tcl:33 lib/choose_repository.tcl:354
      +msgid "Create"
      +msgstr "Skep"
      +
     -+#: lib/branch_create.tcl:42
      +msgid "Branch Name"
      +msgstr "Taknaam"
      +
     -+#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
      +msgid "Name:"
      +msgstr "Naam:"
      +
     -+#: lib/branch_create.tcl:56
      +msgid "Match Tracking Branch Name"
      +msgstr "Pas by volgtak se naam"
      +
     -+#: lib/branch_create.tcl:64
      +msgid "Starting Revision"
      +msgstr "Beginrevisie"
      +
     -+#: lib/branch_create.tcl:70
      +msgid "Update Existing Branch:"
      +msgstr "Werk bestaande tak by:"
      +
     -+#: lib/branch_create.tcl:73
      +msgid "No"
      +msgstr "Nee"
      +
     -+#: lib/branch_create.tcl:78
      +msgid "Fast Forward Only"
      +msgstr "Slegs vooruitspoel"
      +
     -+#: lib/branch_create.tcl:83 lib/checkout_op.tcl:563
      +msgid "Reset"
      +msgstr "Herstel"
      +
     -+#: lib/branch_create.tcl:95
      +msgid "Checkout After Creation"
      +msgstr "Check uit na skepping"
      +
     -+#: lib/branch_create.tcl:130
      +msgid "Please select a tracking branch."
      +msgstr "Kies asseblief 'n volgtak."
      +
     -+#: lib/branch_create.tcl:139
      +#, tcl-format
      +msgid "Tracking branch %s is not a branch in the remote repository."
      +msgstr "Volgtak %s is nie 'n tak in die afgeleë bewaarplek nie."
      +
     -+#: lib/branch_create.tcl:152 lib/branch_rename.tcl:88
      +msgid "Please supply a branch name."
      +msgstr "Verskaf asseblief 'n taknaam."
      +
     -+#: lib/branch_create.tcl:163 lib/branch_rename.tcl:108
      +#, tcl-format
      +msgid "'%s' is not an acceptable branch name."
      +msgstr "'%s' is nie 'n aanvaarbare taknaam nie."
      +
     -+#: lib/branch_delete.tcl:16
      +#, tcl-format
      +msgid "%s (%s): Delete Branch"
      +msgstr "%s (%s): Skrap tak"
      +
     -+#: lib/branch_delete.tcl:21
      +msgid "Delete Local Branch"
      +msgstr "Skrap plaaslike tak"
      +
     -+#: lib/branch_delete.tcl:39
      +msgid "Local Branches"
      +msgstr "Plaaslike takke"
      +
     -+#: lib/branch_delete.tcl:51
      +msgid "Delete Only If Merged Into"
      +msgstr "Skrap slegs indien saamgesmelt in"
      +
     -+#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:116
      +msgid "Always (Do not perform merge checks)"
      +msgstr "Altyd (moenie saamsmeltkontroles uitvoer nie)"
      +
     -+#: lib/branch_delete.tcl:103
      +#, tcl-format
      +msgid "The following branches are not completely merged into %s:"
      +msgstr "Die volgende takke is nie volledig in %s saamgesmelt nie:"
      +
     -+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:214
      +msgid ""
      +"Recovering deleted branches is difficult.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Skrap die gekose takke?"
      +
     -+#: lib/branch_delete.tcl:131
      +#, tcl-format
      +msgid " - %s:"
      +msgstr " - %s:"
      +
     -+#: lib/branch_delete.tcl:141
      +#, tcl-format
      +msgid ""
      +"Failed to delete branches:\n"
     @@ po/af.po (new)
      +"Kon nie takke skrap nie:\n"
      +"%s"
      +
     -+#: lib/branch_rename.tcl:15
      +#, tcl-format
      +msgid "%s (%s): Rename Branch"
      +msgstr "%s (%s): Hernoem tak"
      +
     -+#: lib/branch_rename.tcl:23
      +msgid "Rename Branch"
      +msgstr "Hernoem tak"
      +
     -+#: lib/branch_rename.tcl:28
      +msgid "Rename"
      +msgstr "Hernoem"
      +
     -+#: lib/branch_rename.tcl:38
      +msgid "Branch:"
      +msgstr "Tak:"
      +
     -+#: lib/branch_rename.tcl:42
      +msgid "New Name:"
      +msgstr "Nuwe naam:"
      +
     -+#: lib/branch_rename.tcl:77
      +msgid "Please select a branch to rename."
      +msgstr "Kies asseblief 'n tak om te hernoem."
      +
     -+#: lib/branch_rename.tcl:98 lib/checkout_op.tcl:202
      +#, tcl-format
      +msgid "Branch '%s' already exists."
      +msgstr "Tak '%s' bestaan reeds."
      +
     -+#: lib/branch_rename.tcl:119
      +#, tcl-format
      +msgid "Failed to rename '%s'."
      +msgstr "Kon nie '%s' hernoem nie."
      +
     -+#: lib/browser.tcl:17
      +msgid "Starting..."
      +msgstr "Begin tans..."
      +
     -+#: lib/browser.tcl:27
      +#, tcl-format
      +msgid "%s (%s): File Browser"
      +msgstr "%s (%s): Lêerblaaier"
      +
     -+#: lib/browser.tcl:130 lib/browser.tcl:147
      +#, tcl-format
      +msgid "Loading %s..."
      +msgstr "Laai tans %s..."
      +
     -+#: lib/browser.tcl:191
      +msgid "[Up To Parent]"
      +msgstr "[Op na ouer]"
      +
     -+#: lib/browser.tcl:272
      +#, tcl-format
      +msgid "%s (%s): Browse Branch Files"
      +msgstr "%s (%s): Blaai deur taklêers"
      +
     -+#: lib/browser.tcl:279
      +msgid "Browse Branch Files"
      +msgstr "Blaai deur taklêers"
      +
     -+#: lib/browser.tcl:285 lib/choose_repository.tcl:369
     -+#: lib/choose_repository.tcl:456 lib/choose_repository.tcl:465
     -+#: lib/choose_repository.tcl:670
      +msgid "Browse"
      +msgstr "Blaai"
      +
     -+#: lib/checkout_op.tcl:85
      +#, tcl-format
      +msgid "Fetching %s from %s"
      +msgstr "Haal tans %s vanaf %s"
      +
     -+#: lib/checkout_op.tcl:133
      +#, tcl-format
      +msgid "fatal: Cannot resolve %s"
      +msgstr "fataal: Kan nie %s oplos nie"
      +
     -+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:29
     -+#: lib/sshkey.tcl:55
      +msgid "Close"
      +msgstr "Sluit"
      +
     -+#: lib/checkout_op.tcl:175
      +#, tcl-format
      +msgid "Branch '%s' does not exist."
      +msgstr "Tak '%s' bestaan nie."
      +
     -+#: lib/checkout_op.tcl:194
      +#, tcl-format
      +msgid "Failed to configure simplified git-pull for '%s'."
      +msgstr "Kon nie vereenvoudigde git-pull vir '%s' konfigureer nie."
      +
     -+#: lib/checkout_op.tcl:229
      +#, tcl-format
      +msgid ""
      +"Branch '%s' already exists.\n"
     @@ po/af.po (new)
      +"Dit kan nie na %s vooruitspoel nie.\n"
      +"'n Saamsmelting is nodig."
      +
     -+#: lib/checkout_op.tcl:243
      +#, tcl-format
      +msgid "Merge strategy '%s' not supported."
      +msgstr "Saamsmeltstrategie '%s' word nie ondersteun nie."
      +
     -+#: lib/checkout_op.tcl:262
      +#, tcl-format
      +msgid "Failed to update '%s'."
      +msgstr "Kon nie '%s' bywerk nie."
      +
     -+#: lib/checkout_op.tcl:274
      +msgid "Staging area (index) is already locked."
      +msgstr "Plaasarea (indeks) is reeds gesluit."
      +
     -+#: lib/checkout_op.tcl:289
      +msgid ""
      +"Last scanned state does not match repository state.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Die herskandering sal nou outomaties begin word.\n"
      +
     -+#: lib/checkout_op.tcl:345
      +#, tcl-format
      +msgid "Updating working directory to '%s'..."
      +msgstr "Werk tans werkgids by na '%s'..."
      +
     -+#: lib/checkout_op.tcl:346
      +msgid "files checked out"
      +msgstr "lêers uitgecheck"
      +
     -+#: lib/checkout_op.tcl:378
      +#, tcl-format
      +msgid "Aborted checkout of '%s' (file level merging is required)."
      +msgstr "Uitcheck van '%s' gestaak (saamsmelting op lêervlak is nodig)."
      +
     -+#: lib/checkout_op.tcl:379
      +msgid "File level merge required."
      +msgstr "Saamsmelting op lêervlak is nodig."
      +
     -+#: lib/checkout_op.tcl:383
      +#, tcl-format
      +msgid "Staying on branch '%s'."
      +msgstr "Bly op tak '%s'."
      +
     -+#: lib/checkout_op.tcl:454
      +msgid ""
      +"You are no longer on a local branch.\n"
      +"\n"
     @@ po/af.po (new)
      +"As jy op 'n tak wou wees, skep nou een wat by 'Hierdie ontkoppelde uitcheck' "
      +"begin."
      +
     -+#: lib/checkout_op.tcl:505 lib/checkout_op.tcl:509
      +#, tcl-format
      +msgid "Checked out '%s'."
      +msgstr "'%s' uitgecheck."
      +
     -+#: lib/checkout_op.tcl:527
      +#, tcl-format
      +msgid "Resetting '%s' to '%s' will lose the following commits:"
      +msgstr "Om '%s' na '%s' te herstel sal die volgende vasleggings verloor:"
      +
     -+#: lib/checkout_op.tcl:549
      +msgid "Recovering lost commits may not be easy."
      +msgstr "Dit is dalk nie maklik om verlore vasleggings te herwin nie."
      +
     -+#: lib/checkout_op.tcl:554
      +#, tcl-format
      +msgid "Reset '%s'?"
      +msgstr "Herstel '%s'?"
      +
     -+#: lib/checkout_op.tcl:559 lib/merge.tcl:161 lib/tools_dlg.tcl:336
      +msgid "Visualize"
      +msgstr "Visualiseer"
      +
     -+#: lib/checkout_op.tcl:627
      +#, tcl-format
      +msgid ""
      +"Failed to set current branch.\n"
     @@ po/af.po (new)
      +"\n"
      +"Dit moes nie gebeur het nie.  %s sal nou sluit en opgee."
      +
     -+#: lib/choose_font.tcl:40
      +msgid "Select"
      +msgstr "Kies"
      +
     -+#: lib/choose_font.tcl:54
      +msgid "Font Family"
      +msgstr "Lettertipefamilie"
      +
     -+#: lib/choose_font.tcl:75
      +msgid "Font Size"
      +msgstr "Lettergrootte"
      +
     -+#: lib/choose_font.tcl:92
      +msgid "Font Example"
      +msgstr "Lettertipevoorbeeld"
      +
     -+#: lib/choose_font.tcl:104
      +msgid ""
      +"This is example text.\n"
      +"If you like this text, it can be your font."
     @@ po/af.po (new)
      +"Dit is voorbeeldteks.\n"
      +"As jy van hierdie teks hou, kan dit jou lettertipe wees."
      +
     -+#: lib/choose_repository.tcl:35
      +msgid "Git Gui"
      +msgstr "Git Gui"
      +
     -+#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:359
      +msgid "Create New Repository"
      +msgstr "Skep nuwe bewaarplek"
      +
     -+#: lib/choose_repository.tcl:100
      +msgid "New..."
      +msgstr "Nuut..."
      +
     -+#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:443
      +msgid "Clone Existing Repository"
      +msgstr "Kloon bestaande bewaarplek"
      +
     -+#: lib/choose_repository.tcl:118
      +msgid "Clone..."
      +msgstr "Kloon..."
      +
     -+#: lib/choose_repository.tcl:125 lib/choose_repository.tcl:660
      +msgid "Open Existing Repository"
      +msgstr "Open bestaande bewaarplek"
      +
     -+#: lib/choose_repository.tcl:131
      +msgid "Open..."
      +msgstr "Open..."
      +
     -+#: lib/choose_repository.tcl:144
      +msgid "Recent Repositories"
      +msgstr "Onlangse bewaarplekke"
      +
     -+#: lib/choose_repository.tcl:154
      +msgid "Open Recent Repository:"
      +msgstr "Open onlangse bewaarplek:"
      +
     -+#: lib/choose_repository.tcl:319 lib/choose_repository.tcl:326
      +#, tcl-format
      +msgid "Failed to create repository %s:"
      +msgstr "Kon nie bewaarplek %s skep nie:"
      +
     -+#: lib/choose_repository.tcl:364
      +msgid "Directory:"
      +msgstr "Gids:"
      +
     -+#: lib/choose_repository.tcl:394 lib/choose_repository.tcl:520
     -+#: lib/choose_repository.tcl:694
      +msgid "Git Repository"
      +msgstr "Git-bewaarplek"
      +
     -+#: lib/choose_repository.tcl:420
      +#, tcl-format
      +msgid "Directory %s already exists."
      +msgstr "Gids %s bestaan reeds."
      +
     -+#: lib/choose_repository.tcl:424
      +#, tcl-format
      +msgid "File %s already exists."
      +msgstr "Lêer %s bestaan reeds."
      +
     -+#: lib/choose_repository.tcl:438
      +msgid "Clone"
      +msgstr "Kloon"
      +
     -+#: lib/choose_repository.tcl:451
      +msgid "Source Location:"
      +msgstr "Bronligging:"
      +
     -+#: lib/choose_repository.tcl:460
      +msgid "Target Directory:"
      +msgstr "Teikengids:"
      +
     -+#: lib/choose_repository.tcl:470
      +msgid "Clone Type:"
      +msgstr "Kloontipe:"
      +
     -+#: lib/choose_repository.tcl:475
      +msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
      +msgstr "Standaard (vinnig, semi-oortollig, harde skakels)"
      +
     -+#: lib/choose_repository.tcl:480
      +msgid "Full Copy (Slower, Redundant Backup)"
      +msgstr "Volledige kopie (stadiger, oortollige rugsteun)"
      +
     -+#: lib/choose_repository.tcl:485
      +msgid "Shared (Fastest, Not Recommended, No Backup)"
      +msgstr "Gedeel (vinnigste, nie aanbeveel nie, geen rugsteun nie)"
      +
     -+#: lib/choose_repository.tcl:492
      +msgid "Recursively clone submodules too"
      +msgstr "Kloon submodules ook rekursief"
      +
     -+#: lib/choose_repository.tcl:526 lib/choose_repository.tcl:700
     -+#: lib/choose_repository.tcl:708
      +#, tcl-format
      +msgid "Not a Git repository: %s"
      +msgstr "Nie 'n Git-bewaarplek nie: %s"
      +
     -+#: lib/choose_repository.tcl:573
      +msgid "Hardlinks are unavailable.  Falling back to copying."
      +msgstr "Harde skakels is nie beskikbaar nie.  Val terug op kopiëring."
      +
     -+#: lib/choose_repository.tcl:581
      +msgid "Standard only available for local repository."
      +msgstr "Standaard is slegs vir 'n plaaslike bewaarplek beskikbaar."
      +
     -+#: lib/choose_repository.tcl:585
      +msgid "Shared only available for local repository."
      +msgstr "Gedeel is slegs vir 'n plaaslike bewaarplek beskikbaar."
      +
     -+#: lib/choose_repository.tcl:592
      +#, tcl-format
      +msgid "Location %s already exists."
      +msgstr "Ligging %s bestaan reeds."
      +
     -+#: lib/choose_repository.tcl:615
      +#, tcl-format
      +msgid "Cloning from %s"
      +msgstr "Kloon tans vanaf %s"
      +
     -+#: lib/choose_repository.tcl:621 lib/choose_repository.tcl:627
      +msgid "Clone failed."
      +msgstr "Kloon het misluk."
      +
     -+#: lib/choose_repository.tcl:665
      +msgid "Repository:"
      +msgstr "Bewaarplek:"
      +
     -+#: lib/choose_repository.tcl:714
      +#, tcl-format
      +msgid "Failed to open repository %s:"
      +msgstr "Kon nie bewaarplek %s open nie:"
      +
     -+#: lib/choose_rev.tcl:52
      +msgid "This Detached Checkout"
      +msgstr "Hierdie ontkoppelde uitcheck"
      +
     -+#: lib/choose_rev.tcl:59
      +msgid "Revision Expression:"
      +msgstr "Revisie-uitdrukking:"
      +
     -+#: lib/choose_rev.tcl:71
      +msgid "Local Branch"
      +msgstr "Plaaslike tak"
      +
     -+#: lib/choose_rev.tcl:76
      +msgid "Tracking Branch"
      +msgstr "Volgtak"
      +
     -+#: lib/choose_rev.tcl:81 lib/choose_rev.tcl:534
      +msgid "Tag"
      +msgstr "Etiket"
      +
     -+#: lib/choose_rev.tcl:312
      +#, tcl-format
      +msgid "Invalid revision: %s"
      +msgstr "Ongeldige revisie: %s"
      +
     -+#: lib/choose_rev.tcl:333
      +msgid "No revision selected."
      +msgstr "Geen revisie gekies nie."
      +
     -+#: lib/choose_rev.tcl:341
      +msgid "Revision expression is empty."
      +msgstr "Revisie-uitdrukking is leeg."
      +
     -+#: lib/choose_rev.tcl:527
      +msgid "Updated"
      +msgstr "Bygewerk"
      +
     -+#: lib/choose_rev.tcl:555
      +msgid "URL"
      +msgstr "URL"
      +
     -+#: lib/commit.tcl:9
      +msgid ""
      +"There is nothing to amend.\n"
      +"\n"
     @@ po/af.po (new)
      +"U is op die punt om die eerste vaslegging te skep.  Daar is geen vaslegging "
      +"hiervoor om te wysig nie.\n"
      +
     -+#: lib/commit.tcl:18
      +msgid ""
      +"Cannot amend while merging.\n"
      +"\n"
     @@ po/af.po (new)
      +"nie.  U kan nie die vorige vaslegging wysig nie, tensy u eers die huidige "
      +"saamsmelting staak.\n"
      +
     -+#: lib/commit.tcl:56
      +msgid "Error loading commit data for amend:"
      +msgstr "Fout met die laai van vasleggingsdata om te wysig:"
      +
     -+#: lib/commit.tcl:83
      +msgid "Unable to obtain your identity:"
      +msgstr "Kan nie u identiteit bepaal nie:"
      +
     -+#: lib/commit.tcl:88
      +msgid "Invalid GIT_COMMITTER_IDENT:"
      +msgstr "Ongeldige GIT_COMMITTER_IDENT:"
      +
     -+#: lib/commit.tcl:138
      +#, tcl-format
      +msgid "warning: Tcl does not support encoding '%s'."
      +msgstr "waarskuwing: Tcl ondersteun nie enkodering '%s' nie."
      +
     -+#: lib/commit.tcl:158
      +msgid ""
      +"Last scanned state does not match repository state.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Die herskandering sal nou outomaties begin word.\n"
      +
     -+#: lib/commit.tcl:182
      +#, tcl-format
      +msgid ""
      +"Unmerged files cannot be committed.\n"
     @@ po/af.po (new)
      +"Lêer %s het saamsmeltkonflikte.  U moet dit oplos en die lêer plaas voordat "
      +"u vaslê.\n"
      +
     -+#: lib/commit.tcl:190
      +#, tcl-format
      +msgid ""
      +"Unknown file state %s detected.\n"
     @@ po/af.po (new)
      +"\n"
      +"Lêer %s kan nie deur hierdie program vasgelê word nie.\n"
      +
     -+#: lib/commit.tcl:198
      +msgid ""
      +"No changes to commit.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"U moet ten minste 1 lêer plaas voordat u kan vaslê.\n"
      +
     -+#: lib/commit.tcl:231
      +msgid "Calling pre-commit hook..."
      +msgstr "Roep pre-commit-haak aan..."
      +
     -+#: lib/commit.tcl:246
      +msgid "Commit declined by pre-commit hook."
      +msgstr "Vaslegging deur pre-commit-haak geweier."
      +
     -+#: lib/commit.tcl:265
      +msgid ""
      +"You are about to commit on a detached head. This is a potentially dangerous "
      +"thing to do because if you switch to another branch you will lose your "
     @@ po/af.po (new)
      +" \n"
      +" Wil u regtig met u vaslegging voortgaan?"
      +
     -+#: lib/commit.tcl:286
      +msgid "Calling commit-msg hook..."
      +msgstr "Roep commit-msg-haak aan..."
      +
     -+#: lib/commit.tcl:301
      +msgid "Commit declined by commit-msg hook."
      +msgstr "Vaslegging deur commit-msg-haak geweier."
      +
     -+#: lib/commit.tcl:340
      +msgid ""
      +"Please supply a commit message.\n"
      +"\n"
     @@ po/af.po (new)
      +"- Tweede reël: Leeg\n"
      +"- Oorblywende reëls: Beskryf waarom hierdie verandering goed is.\n"
      +
     -+#: lib/commit.tcl:359
      +msgid "Committing changes..."
      +msgstr "Lê veranderinge vas..."
      +
     -+#: lib/commit.tcl:377
      +msgid "write-tree failed:"
      +msgstr "write-tree het misluk:"
      +
     -+#: lib/commit.tcl:378 lib/commit.tcl:428 lib/commit.tcl:455
      +msgid "Commit failed."
      +msgstr "Vaslegging het misluk."
      +
     -+#: lib/commit.tcl:395
      +#, tcl-format
      +msgid "Commit %s appears to be corrupt"
      +msgstr "Vaslegging %s blyk korrup te wees"
      +
     -+#: lib/commit.tcl:400
      +msgid ""
      +"No changes to commit.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"'n Herskandering sal nou outomaties begin word.\n"
      +
     -+#: lib/commit.tcl:407
      +msgid "No changes to commit."
      +msgstr "Geen veranderinge om vas te lê nie."
      +
     -+#: lib/commit.tcl:427
      +msgid "commit-tree failed:"
      +msgstr "commit-tree het misluk:"
      +
     -+#: lib/commit.tcl:454
      +msgid "update-ref failed:"
      +msgstr "update-ref het misluk:"
      +
     -+#: lib/commit.tcl:548
      +#, tcl-format
      +msgid "Created commit %s: %s"
      +msgstr "Vaslegging %s geskep: %s"
      +
     -+#: lib/console.tcl:59
      +msgid "Working... please wait..."
      +msgstr "Besig... wag asseblief..."
      +
     -+#: lib/console.tcl:185
      +msgid "Success"
      +msgstr "Sukses"
      +
     -+#: lib/console.tcl:199
      +msgid "Error: Command Failed"
      +msgstr "Fout: Opdrag het misluk"
      +
     -+#: lib/database.tcl:41
      +msgid "Number of loose objects"
      +msgstr "Aantal los objekte"
      +
     -+#: lib/database.tcl:42
      +msgid "Disk space used by loose objects"
      +msgstr "Skyfspasie deur los objekte gebruik"
      +
     -+#: lib/database.tcl:43
      +msgid "Number of packed objects"
      +msgstr "Aantal gepakte objekte"
      +
     -+#: lib/database.tcl:44
      +msgid "Number of packs"
      +msgstr "Aantal pakke"
      +
     -+#: lib/database.tcl:45
      +msgid "Disk space used by packed objects"
      +msgstr "Skyfspasie deur gepakte objekte gebruik"
      +
     -+#: lib/database.tcl:46
      +msgid "Packed objects waiting for pruning"
      +msgstr "Gepakte objekte wat wag om gesnoei te word"
      +
     -+#: lib/database.tcl:47
      +msgid "Garbage files"
      +msgstr "Rommellêers"
      +
     -+#: lib/database.tcl:56 lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220
     -+#: lib/option.tcl:270
      +#, tcl-format
      +msgid "%s:"
      +msgstr "%s:"
      +
     -+#: lib/database.tcl:65
      +#, tcl-format
      +msgid "%s (%s): Database Statistics"
      +msgstr "%s (%s): Databasisstatistiek"
      +
     -+#: lib/database.tcl:71
      +msgid "Compressing the object database"
      +msgstr "Kompakteer die objekdatabasis"
      +
     -+#: lib/database.tcl:82
      +msgid "Verifying the object database with fsck-objects"
      +msgstr "Verifieer die objekdatabasis met fsck-objects"
      +
     -+#: lib/database.tcl:106
      +#, tcl-format
      +msgid ""
      +"This repository currently has approximately %i loose objects.\n"
     @@ po/af.po (new)
      +"\n"
      +"Kompakteer die databasis nou?"
      +
     -+#: lib/date.tcl:25
      +#, tcl-format
      +msgid "Invalid date from Git: %s"
      +msgstr "Ongeldige datum van Git: %s"
      +
     -+#: lib/diff.tcl:72
      +msgid ""
      +"* No differences detected; stage the file to de-list it from Unstaged "
      +"Changes.\n"
     @@ po/af.po (new)
      +"* Geen verskille bespeur nie; plaas die lêer om dit uit Ongeplaasde "
      +"Veranderinge te verwyder.\n"
      +
     -+#: lib/diff.tcl:73
      +msgid "* Click to find other files that may have the same state.\n"
      +msgstr "* Klik om ander lêers te vind wat dalk dieselfde toestand het.\n"
      +
     -+#: lib/diff.tcl:104
      +#, tcl-format
      +msgid "Loading diff of %s..."
      +msgstr "Laai verskil van %s..."
      +
     -+#: lib/diff.tcl:130
      +msgid ""
      +"LOCAL: deleted\n"
      +"REMOTE:\n"
     @@ po/af.po (new)
      +"PLAASLIK: geskrap\n"
      +"AFGELEË:\n"
      +
     -+#: lib/diff.tcl:135
      +msgid ""
      +"REMOTE: deleted\n"
      +"LOCAL:\n"
     @@ po/af.po (new)
      +"AFGELEË: geskrap\n"
      +"PLAASLIK:\n"
      +
     -+#: lib/diff.tcl:142
      +msgid "LOCAL:\n"
      +msgstr "PLAASLIK:\n"
      +
     -+#: lib/diff.tcl:145
      +msgid "REMOTE:\n"
      +msgstr "AFGELEË:\n"
      +
     -+#: lib/diff.tcl:206 lib/diff.tcl:317
      +#, tcl-format
      +msgid "Unable to display %s"
      +msgstr "Kan nie %s vertoon nie"
      +
     -+#: lib/diff.tcl:207
      +msgid "Error loading file:"
      +msgstr "Fout met die laai van lêer:"
      +
     -+#: lib/diff.tcl:213
      +msgid "Git Repository (subproject)"
      +msgstr "Git-bewaarplek (subprojek)"
      +
     -+#: lib/diff.tcl:225
      +msgid "* Binary file (not showing content)."
      +msgstr "* Binêre lêer (inhoud word nie gewys nie)."
      +
     -+#: lib/diff.tcl:230
      +#, tcl-format
      +msgid ""
      +"* Untracked file is %d bytes.\n"
     @@ po/af.po (new)
      +"* Onnaspoorbare lêer is %d grepe.\n"
      +"* Wys slegs die eerste %d grepe.\n"
      +
     -+#: lib/diff.tcl:236
      +#, tcl-format
      +msgid ""
      +"\n"
     @@ po/af.po (new)
      +"* Onnaspoorbare lêer hier deur %s afgesny.\n"
      +"* Gebruik 'n eksterne redigeerder om die hele lêer te sien.\n"
      +
     -+#: lib/diff.tcl:557
      +msgid "Failed to unstage selected hunk."
      +msgstr "Kon nie gekose brok ontplaas nie."
      +
     -+#: lib/diff.tcl:565
      +msgid "Failed to revert selected hunk."
      +msgstr "Kon nie gekose brok omkeer nie."
      +
     -+#: lib/diff.tcl:568
      +msgid "Failed to stage selected hunk."
      +msgstr "Kon nie gekose brok plaas nie."
      +
     -+#: lib/diff.tcl:661
      +msgid "Failed to unstage selected line."
      +msgstr "Kon nie gekose reël ontplaas nie."
      +
     -+#: lib/diff.tcl:670
      +msgid "Failed to revert selected line."
      +msgstr "Kon nie gekose reël omkeer nie."
      +
     -+#: lib/diff.tcl:674
      +msgid "Failed to stage selected line."
      +msgstr "Kon nie gekose reël plaas nie."
      +
     -+#: lib/diff.tcl:863
      +msgid "Failed to undo last revert."
      +msgstr "Kon nie laaste omkering ongedaan maak nie."
      +
     -+#: lib/encoding.tcl:443
      +msgid "Default"
      +msgstr "Verstek"
      +
     -+#: lib/encoding.tcl:448
      +#, tcl-format
      +msgid "System (%s)"
      +msgstr "Stelsel (%s)"
      +
     -+#: lib/encoding.tcl:459 lib/encoding.tcl:465
      +msgid "Other"
      +msgstr "Ander"
      +
     -+#: lib/error.tcl:20
      +#, tcl-format
      +msgid "%s: error"
      +msgstr "%s: fout"
      +
     -+#: lib/error.tcl:36
      +#, tcl-format
      +msgid "%s: warning"
      +msgstr "%s: waarskuwing"
      +
     -+#: lib/error.tcl:79
      +#, tcl-format
      +msgid "%s hook failed:"
      +msgstr "%s-haak het misluk:"
      +
     -+#: lib/error.tcl:95
      +msgid "You must correct the above errors before committing."
      +msgstr "U moet die bostaande foute regstel voordat u vaslê."
      +
     -+#: lib/error.tcl:115
      +#, tcl-format
      +msgid "%s (%s): error"
      +msgstr "%s (%s): fout"
      +
     -+#: lib/index.tcl:6
      +msgid "Unable to unlock the index."
      +msgstr "Kan nie die indeks ontsluit nie."
      +
     -+#: lib/index.tcl:28
      +msgid "Index Error"
      +msgstr "Indeksfout"
      +
     -+#: lib/index.tcl:30
      +msgid ""
      +"Updating the Git index failed.  A rescan will be automatically started to "
      +"resynchronize git-gui."
     @@ po/af.po (new)
      +"Bywerking van die Git-indeks het misluk.  'n Herskandering sal outomaties "
      +"begin word om git-gui te hersinchroniseer."
      +
     -+#: lib/index.tcl:41
      +msgid "Continue"
      +msgstr "Gaan voort"
      +
     -+#: lib/index.tcl:44
      +msgid "Unlock Index"
      +msgstr "Ontsluit indeks"
      +
     -+#: lib/index.tcl:75 lib/index.tcl:143 lib/index.tcl:216 lib/index.tcl:589
      +msgid "files"
      +msgstr "lêers"
      +
     -+#: lib/index.tcl:321
      +msgid "Unstaging selected files from commit"
      +msgstr "Ontplaas gekose lêers uit vaslegging"
      +
     -+#: lib/index.tcl:325
      +#, tcl-format
      +msgid "Unstaging %s from commit"
      +msgstr "Ontplaas %s uit vaslegging"
      +
     -+#: lib/index.tcl:364
      +msgid "Ready to commit."
      +msgstr "Gereed om vas te lê."
      +
     -+#: lib/index.tcl:373
      +msgid "Adding selected files"
      +msgstr "Voeg gekose lêers by"
      +
     -+#: lib/index.tcl:377
      +#, tcl-format
      +msgid "Adding %s"
      +msgstr "Voeg %s by"
      +
     -+#: lib/index.tcl:407
      +#, tcl-format
      +msgid "Stage %d untracked files?"
      +msgstr "Plaas %d onnaspoorbare lêers?"
      +
     -+#: lib/index.tcl:415
      +msgid "Adding all changed files"
      +msgstr "Voeg alle veranderde lêers by"
      +
     -+#: lib/index.tcl:503
      +#, tcl-format
      +msgid "Revert changes in file %s?"
      +msgstr "Keer veranderinge in lêer %s om?"
      +
     -+#: lib/index.tcl:508
      +#, tcl-format
      +msgid "Revert changes in these %i files?"
      +msgstr "Keer veranderinge in hierdie %i lêers om?"
      +
     -+#: lib/index.tcl:517
      +msgid "Any unstaged changes will be permanently lost by the revert."
      +msgstr ""
      +"Enige ongeplaasde veranderinge sal deur die omkering permanent verlore gaan."
      +
     -+#: lib/index.tcl:520 lib/index.tcl:564
      +msgid "Do Nothing"
      +msgstr "Doen niks"
      +
     -+#: lib/index.tcl:546
      +#, tcl-format
      +msgid "Delete untracked file %s?"
      +msgstr "Skrap onnaspoorbare lêer %s?"
      +
     -+#: lib/index.tcl:551
      +#, tcl-format
      +msgid "Delete these %i untracked files?"
      +msgstr "Skrap hierdie %i onnaspoorbare lêers?"
      +
     -+#: lib/index.tcl:561
      +msgid "Files will be permanently deleted."
      +msgstr "Lêers sal permanent geskrap word."
      +
     -+#: lib/index.tcl:565
      +msgid "Delete Files"
      +msgstr "Skrap lêers"
      +
     -+#: lib/index.tcl:588
      +msgid "Deleting"
      +msgstr "Skrap"
      +
     -+#: lib/index.tcl:667
      +msgid "Encountered errors deleting files:\n"
      +msgstr "Foute teëgekom met die skrap van lêers:\n"
      +
     -+#: lib/index.tcl:676
      +#, tcl-format
      +msgid "None of the %d selected files could be deleted."
      +msgstr "Geeneen van die %d gekose lêers kon geskrap word nie."
      +
     -+#: lib/index.tcl:681
      +#, tcl-format
      +msgid "%d of the %d selected files could not be deleted."
      +msgstr "%d van die %d gekose lêers kon nie geskrap word nie."
      +
     -+#: lib/index.tcl:728
      +msgid "Reverting selected files"
      +msgstr "Keer gekose lêers om"
      +
     -+#: lib/index.tcl:732
      +#, tcl-format
      +msgid "Reverting %s"
      +msgstr "Keer %s om"
      +
     -+#: lib/line.tcl:16
      +msgid "Goto Line:"
      +msgstr "Gaan na reël:"
      +
     -+#: lib/line.tcl:22
      +msgid "Go"
      +msgstr "Gaan"
      +
     -+#: lib/merge.tcl:13
      +msgid ""
      +"Cannot merge while amending.\n"
      +"\n"
     @@ po/af.po (new)
      +"U moet klaar wees met die wysiging van hierdie vaslegging voordat u enige "
      +"soort saamsmelting begin.\n"
      +
     -+#: lib/merge.tcl:27
      +msgid ""
      +"Last scanned state does not match repository state.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Die herskandering sal nou outomaties begin word.\n"
      +
     -+#: lib/merge.tcl:45
      +#, tcl-format
      +msgid ""
      +"You are in the middle of a conflicted merge.\n"
     @@ po/af.po (new)
      +"U moet dit oplos, die lêer plaas en vaslê om die huidige saamsmelting te "
      +"voltooi.  Eers dan kan u 'n ander saamsmelting begin.\n"
      +
     -+#: lib/merge.tcl:55
      +#, tcl-format
      +msgid ""
      +"You are in the middle of a change.\n"
     @@ po/af.po (new)
      +"U moet die huidige vaslegging voltooi voordat u 'n saamsmelting begin.  Dit "
      +"sal u help om 'n mislukte saamsmelting te staak, indien nodig.\n"
      +
     -+#: lib/merge.tcl:108
      +#, tcl-format
      +msgid "%s of %s"
      +msgstr "%s van %s"
      +
     -+#: lib/merge.tcl:117
      +#, tcl-format
      +msgid "Merging %s and %s..."
      +msgstr "Smelt %s en %s saam..."
      +
     -+#: lib/merge.tcl:128
      +msgid "Merge completed successfully."
      +msgstr "Saamsmelting suksesvol voltooi."
      +
     -+#: lib/merge.tcl:130
      +msgid "Merge failed.  Conflict resolution is required."
      +msgstr "Saamsmelting het misluk.  Konflikoplossing is nodig."
      +
     -+#: lib/merge.tcl:147
      +#, tcl-format
      +msgid "%s (%s): Merge"
      +msgstr "%s (%s): Saamsmelt"
      +
     -+#: lib/merge.tcl:155
      +#, tcl-format
      +msgid "Merge Into %s"
      +msgstr "Smelt saam in %s"
      +
     -+#: lib/merge.tcl:174
      +msgid "Revision To Merge"
      +msgstr "Revisie om saam te smelt"
      +
     -+#: lib/merge.tcl:209
      +msgid ""
      +"Cannot abort while amending.\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"U moet klaar wees met die wysiging van hierdie vaslegging.\n"
      +
     -+#: lib/merge.tcl:219
      +msgid ""
      +"Abort merge?\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Gaan voort om die huidige saamsmelting te staak?"
      +
     -+#: lib/merge.tcl:225
      +msgid ""
      +"Reset changes?\n"
      +"\n"
     @@ po/af.po (new)
      +"\n"
      +"Gaan voort om die huidige veranderinge te herstel?"
      +
     -+#: lib/merge.tcl:237
      +msgid "Aborting"
      +msgstr "Staak"
      +
     -+#: lib/merge.tcl:238
      +msgid "files reset"
      +msgstr "lêers herstel"
      +
     -+#: lib/merge.tcl:268
      +msgid "Abort failed."
      +msgstr "Staking het misluk."
      +
     -+#: lib/merge.tcl:270
      +msgid "Abort completed.  Ready."
      +msgstr "Staking voltooi.  Gereed."
      +
     -+#: lib/mergetool.tcl:8
      +msgid "Force resolution to the base version?"
      +msgstr "Dwing oplossing na die basisweergawe?"
      +
     -+#: lib/mergetool.tcl:9
      +msgid "Force resolution to this branch?"
      +msgstr "Dwing oplossing na hierdie tak?"
      +
     -+#: lib/mergetool.tcl:10
      +msgid "Force resolution to the other branch?"
      +msgstr "Dwing oplossing na die ander tak?"
      +
     -+#: lib/mergetool.tcl:14
      +#, tcl-format
      +msgid ""
      +"Note that the diff shows only conflicting changes.\n"
     @@ po/af.po (new)
      +"Hierdie bewerking kan slegs ongedaan gemaak word deur die saamsmelting weer "
      +"te begin."
      +
     -+#: lib/mergetool.tcl:45
      +#, tcl-format
      +msgid "File %s seems to have unresolved conflicts, still stage?"
      +msgstr "Lêer %s blyk onopgeloste konflikte te hê; plaas steeds?"
      +
     -+#: lib/mergetool.tcl:60
      +#, tcl-format
      +msgid "Adding resolution for %s"
      +msgstr "Voeg oplossing vir %s by"
      +
     -+#: lib/mergetool.tcl:141
      +msgid "Cannot resolve deletion or link conflicts using a tool"
      +msgstr "Kan nie skrappings- of skakelkonflikte met 'n hulpmiddel oplos nie"
      +
     -+#: lib/mergetool.tcl:146
      +msgid "Conflict file does not exist"
      +msgstr "Konfliklêer bestaan nie"
      +
     -+#: lib/mergetool.tcl:246
      +#, tcl-format
      +msgid "Not a GUI merge tool: '%s'"
      +msgstr "Nie 'n grafiese saamsmelthulpmiddel nie: '%s'"
      +
     -+#: lib/mergetool.tcl:278
      +#, tcl-format
      +msgid ""
      +"Unable to process square brackets in \"mergetool.%s.cmd\" configuration "
     @@ po/af.po (new)
      +"\n"
      +"Verwyder asseblief die vierkantige hakies."
      +
     -+#: lib/mergetool.tcl:289
      +#, tcl-format
      +msgid ""
      +"Unsupported merge tool '%s'.\n"
     @@ po/af.po (new)
      +"Om hierdie hulpmiddel te gebruik, stel \"mergetool.%s.cmd\" op soos in die "
      +"git-config-handleidingbladsy getoon."
      +
     -+#: lib/mergetool.tcl:327
      +msgid "Merge tool is already running, terminate it?"
      +msgstr "Saamsmelthulpmiddel loop reeds; beëindig dit?"
      +
     -+#: lib/mergetool.tcl:347
      +#, tcl-format
      +msgid ""
      +"Error retrieving versions:\n"
     @@ po/af.po (new)
      +"Fout met die ophaal van weergawes:\n"
      +"%s"
      +
     -+#: lib/mergetool.tcl:367
      +#, tcl-format
      +msgid ""
      +"Could not start the merge tool:\n"
     @@ po/af.po (new)
      +"\n"
      +"%s"
      +
     -+#: lib/mergetool.tcl:371
      +msgid "Running merge tool..."
      +msgstr "Voer saamsmelthulpmiddel uit..."
      +
     -+#: lib/mergetool.tcl:399 lib/mergetool.tcl:407
      +msgid "Merge tool failed."
      +msgstr "Saamsmelthulpmiddel het misluk."
      +
     -+#: lib/option.tcl:11
      +#, tcl-format
      +msgid "Invalid global encoding '%s'"
      +msgstr "Ongeldige globale enkodering '%s'"
      +
     -+#: lib/option.tcl:19
      +#, tcl-format
      +msgid "Invalid repo encoding '%s'"
      +msgstr "Ongeldige bewaarplek-enkodering '%s'"
      +
     -+#: lib/option.tcl:119
      +msgid "Restore Defaults"
      +msgstr "Herstel verstekwaardes"
      +
     -+#: lib/option.tcl:123
      +msgid "Save"
      +msgstr "Stoor"
      +
     -+#: lib/option.tcl:133
      +#, tcl-format
      +msgid "%s Repository"
      +msgstr "%s-bewaarplek"
      +
     -+#: lib/option.tcl:134
      +msgid "Global (All Repositories)"
      +msgstr "Globaal (alle bewaarplekke)"
      +
     -+#: lib/option.tcl:140
      +msgid "User Name"
      +msgstr "Gebruikersnaam"
      +
     -+#: lib/option.tcl:141
      +msgid "Email Address"
      +msgstr "E-posadres"
      +
     -+#: lib/option.tcl:143
      +msgid "Summarize Merge Commits"
      +msgstr "Som saamsmeltvasleggings op"
      +
     -+#: lib/option.tcl:144
      +msgid "Merge Verbosity"
      +msgstr "Saamsmelt-breedsprakigheid"
      +
     -+#: lib/option.tcl:145
      +msgid "Show Diffstat After Merge"
      +msgstr "Wys verskilstatistiek ná saamsmelting"
      +
     -+#: lib/option.tcl:146
      +msgid "Use Merge Tool"
      +msgstr "Gebruik saamsmelthulpmiddel"
      +
     -+#: lib/option.tcl:148
      +msgid "Trust File Modification Timestamps"
      +msgstr "Vertrou lêerwysigingstydstempels"
      +
     -+#: lib/option.tcl:149
      +msgid "Prune Tracking Branches During Fetch"
      +msgstr "Snoei volgtakke tydens haal"
      +
     -+#: lib/option.tcl:150
      +msgid "Match Tracking Branches"
      +msgstr "Pas volgtakke"
      +
     -+#: lib/option.tcl:151
      +msgid "Use Textconv For Diffs and Blames"
      +msgstr "Gebruik textconv vir verskille en blameer"
      +
     -+#: lib/option.tcl:152
      +msgid "Blame Copy Only On Changed Files"
      +msgstr "Blameer kopieë slegs in veranderde lêers"
      +
     -+#: lib/option.tcl:153
      +msgid "Maximum Length of Recent Repositories List"
      +msgstr "Maksimum lengte van lys van onlangse bewaarplekke"
      +
     -+#: lib/option.tcl:154
      +msgid "Minimum Letters To Blame Copy On"
      +msgstr "Minimum letters om kopieë te blameer"
      +
     -+#: lib/option.tcl:155
      +msgid "Blame History Context Radius (days)"
      +msgstr "Blameer-geskiedeniskonteksradius (dae)"
      +
     -+#: lib/option.tcl:156
      +msgid "Number of Diff Context Lines"
      +msgstr "Aantal verskil-konteksreëls"
      +
     -+#: lib/option.tcl:157
      +msgid "Additional Diff Parameters"
      +msgstr "Bykomende verskilparameters"
      +
     -+#: lib/option.tcl:158
      +msgid "Commit Message Text Width"
      +msgstr "Teksbreedte van vasleggingsboodskap"
      +
     -+#: lib/option.tcl:159
      +msgid "New Branch Name Template"
      +msgstr "Sjabloon vir nuwe taknaam"
      +
     -+#: lib/option.tcl:160
      +msgid "Default File Contents Encoding"
      +msgstr "Verstek-enkodering van lêerinhoud"
      +
     -+#: lib/option.tcl:161
      +msgid "Warn before committing to a detached head"
      +msgstr "Waarsku voordat op 'n ontkoppelde HEAD vasgelê word"
      +
     -+#: lib/option.tcl:162
      +msgid "Staging of untracked files"
      +msgstr "Plasing van onnaspoorbare lêers"
      +
     -+#: lib/option.tcl:163
      +msgid "Show untracked files"
      +msgstr "Wys onnaspoorbare lêers"
      +
     -+#: lib/option.tcl:164
      +msgid "Tab spacing"
      +msgstr "Oortjiespasiëring"
      +
     -+#: lib/option.tcl:210
      +msgid "Change"
      +msgstr "Verander"
      +
     -+#: lib/option.tcl:248
      +msgid "Spelling Dictionary:"
      +msgstr "Speltoetswoordeboek:"
      +
     -+#: lib/option.tcl:272
      +msgid "Change Font"
      +msgstr "Verander lettertipe"
      +
     -+#: lib/option.tcl:276
      +#, tcl-format
      +msgid "Choose %s"
      +msgstr "Kies %s"
      +
     -+#: lib/option.tcl:282
      +msgid "pt."
      +msgstr "pt."
      +
     -+#: lib/option.tcl:296
      +msgid "Preferences"
      +msgstr "Voorkeure"
      +
     -+#: lib/option.tcl:333
      +msgid "Failed to completely save options:"
      +msgstr "Kon nie opsies volledig stoor nie:"
      +
     -+#: lib/remote_add.tcl:20
      +#, tcl-format
      +msgid "%s (%s): Add Remote"
      +msgstr "%s (%s): Voeg afgeleë by"
      +
     -+#: lib/remote_add.tcl:25
      +msgid "Add New Remote"
      +msgstr "Voeg nuwe afgeleë by"
      +
     -+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
      +msgid "Add"
      +msgstr "Voeg by"
      +
     -+#: lib/remote_add.tcl:39
      +msgid "Remote Details"
      +msgstr "Afgeleë besonderhede"
      +
     -+#: lib/remote_add.tcl:50
      +msgid "Location:"
      +msgstr "Ligging:"
      +
     -+#: lib/remote_add.tcl:60
      +msgid "Further Action"
      +msgstr "Verdere aksie"
      +
     -+#: lib/remote_add.tcl:63
      +msgid "Fetch Immediately"
      +msgstr "Haal onmiddellik"
      +
     -+#: lib/remote_add.tcl:69
      +msgid "Initialize Remote Repository and Push"
      +msgstr "Inisialiseer afgeleë bewaarplek en stoot"
      +
     -+#: lib/remote_add.tcl:75
      +msgid "Do Nothing Else Now"
      +msgstr "Doen nou niks anders nie"
      +
     -+#: lib/remote_add.tcl:100
      +msgid "Please supply a remote name."
      +msgstr "Verskaf asseblief 'n afgeleë naam."
      +
     -+#: lib/remote_add.tcl:113
      +#, tcl-format
      +msgid "'%s' is not an acceptable remote name."
      +msgstr "'%s' is nie 'n aanvaarbare afgeleë naam nie."
      +
     -+#: lib/remote_add.tcl:124
      +#, tcl-format
      +msgid "Failed to add remote '%s' of location '%s'."
      +msgstr "Kon nie afgeleë '%s' met ligging '%s' byvoeg nie."
      +
     -+#: lib/remote_add.tcl:132 lib/transport.tcl:6
      +#, tcl-format
      +msgid "fetch %s"
      +msgstr "haal %s"
      +
     -+#: lib/remote_add.tcl:133
      +#, tcl-format
      +msgid "Fetching the %s"
      +msgstr "Haal %s"
      +
     -+#: lib/remote_add.tcl:156
      +#, tcl-format
      +msgid "Do not know how to initialize repository at location '%s'."
      +msgstr "Weet nie hoe om die bewaarplek by ligging '%s' te inisialiseer nie."
      +
     -+#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
     -+#: lib/transport.tcl:110
      +#, tcl-format
      +msgid "push %s"
      +msgstr "stoot %s"
      +
     -+#: lib/remote_add.tcl:163
      +#, tcl-format
      +msgid "Setting up the %s (at %s)"
      +msgstr "Stel %s op (by %s)"
      +
     -+#: lib/remote_branch_delete.tcl:29
      +#, tcl-format
      +msgid "%s (%s): Delete Branch Remotely"
      +msgstr "%s (%s): Skrap tak op afgeleë"
      +
     -+#: lib/remote_branch_delete.tcl:34
      +msgid "Delete Branch Remotely"
      +msgstr "Skrap tak op afgeleë"
      +
     -+#: lib/remote_branch_delete.tcl:48
      +msgid "From Repository"
      +msgstr "Van bewaarplek"
      +
     -+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
      +msgid "Remote:"
      +msgstr "Afgeleë:"
      +
     -+#: lib/remote_branch_delete.tcl:68 lib/transport.tcl:183
      +msgid "Arbitrary Location:"
      +msgstr "Willekeurige ligging:"
      +
     -+#: lib/remote_branch_delete.tcl:84
      +msgid "Branches"
      +msgstr "Takke"
      +
     -+#: lib/remote_branch_delete.tcl:106
      +msgid "Delete Only If"
      +msgstr "Skrap slegs indien"
      +
     -+#: lib/remote_branch_delete.tcl:108
      +msgid "Merged Into:"
      +msgstr "Saamgesmelt in:"
      +
     -+#: lib/remote_branch_delete.tcl:149
      +msgid "A branch is required for 'Merged Into'."
      +msgstr "'n Tak word vir 'Saamgesmelt in' vereis."
      +
     -+#: lib/remote_branch_delete.tcl:181
      +#, tcl-format
      +msgid ""
      +"The following branches are not completely merged into %s:\n"
     @@ po/af.po (new)
      +"\n"
      +" - %s"
      +
     -+#: lib/remote_branch_delete.tcl:186
      +#, tcl-format
      +msgid ""
      +"One or more of the merge tests failed because you have not fetched the "
     @@ po/af.po (new)
      +"Een of meer van die saamsmelttoetse het misluk omdat u nie die nodige "
      +"vasleggings gehaal het nie.  Probeer eers van %s haal."
      +
     -+#: lib/remote_branch_delete.tcl:204
      +msgid "Please select one or more branches to delete."
      +msgstr "Kies asseblief een of meer takke om te skrap."
      +
     -+#: lib/remote_branch_delete.tcl:223
      +#, tcl-format
      +msgid "Deleting branches from %s"
      +msgstr "Skrap takke van %s"
      +
     -+#: lib/remote_branch_delete.tcl:296
      +msgid "No repository selected."
      +msgstr "Geen bewaarplek gekies nie."
      +
     -+#: lib/remote_branch_delete.tcl:301
      +#, tcl-format
      +msgid "Scanning %s..."
      +msgstr "Skandeer %s..."
      +
     -+#: lib/remote.tcl:200
      +msgid "Push to"
      +msgstr "Stoot na"
      +
     -+#: lib/remote.tcl:218
      +msgid "Remove Remote"
      +msgstr "Verwyder afgeleë"
      +
     -+#: lib/remote.tcl:223
      +msgid "Prune from"
      +msgstr "Snoei van"
      +
     -+#: lib/remote.tcl:228
      +msgid "Fetch from"
      +msgstr "Haal van"
      +
     -+#: lib/remote.tcl:247 lib/remote.tcl:251 lib/remote.tcl:256 lib/remote.tcl:262
      +msgid "All"
      +msgstr "Alle"
      +
     -+#: lib/search.tcl:47
      +msgid "Find:"
      +msgstr "Vind:"
      +
     -+#: lib/search.tcl:49
      +msgid "Next"
      +msgstr "Volgende"
      +
     -+#: lib/search.tcl:50
      +msgid "Prev"
      +msgstr "Vorige"
      +
     -+#: lib/search.tcl:51
      +msgid "RegExp"
      +msgstr "RegUitdr"
      +
     -+#: lib/search.tcl:53
      +msgid "Case"
      +msgstr "Hoof/klein"
      +
     -+#: lib/shortcut.tcl:16 lib/shortcut.tcl:54 lib/shortcut.tcl:86
      +#, tcl-format
      +msgid "%s (%s): Create Desktop Icon"
      +msgstr "%s (%s): Skep werkskermikoon"
      +
     -+#: lib/shortcut.tcl:18
      +#, tcl-format
      +msgid "Replace existing shortcut: %s?"
      +msgstr "Vervang bestaande kortpad: %s?"
      +
     -+#: lib/shortcut.tcl:39 lib/shortcut.tcl:76
      +msgid "Cannot write shortcut:"
      +msgstr "Kan nie kortpad skryf nie:"
      +
     -+#: lib/shortcut.tcl:151
      +msgid "Cannot write icon:"
      +msgstr "Kan nie ikoon skryf nie:"
      +
     -+#: lib/spellcheck.tcl:56
      +msgid "Unsupported spell checker"
      +msgstr "Speltoetser word nie ondersteun nie"
      +
     -+#: lib/spellcheck.tcl:64
      +msgid "Spell checking is unavailable"
      +msgstr "Speltoetsing is nie beskikbaar nie"
      +
     -+#: lib/spellcheck.tcl:67
      +msgid "Invalid spell checking configuration"
      +msgstr "Ongeldige speltoetskonfigurasie"
      +
     -+#: lib/spellcheck.tcl:69
      +#, tcl-format
      +msgid "Reverting dictionary to %s."
      +msgstr "Stel woordeboek terug na %s."
      +
     -+#: lib/spellcheck.tcl:72
      +msgid "Spell checker silently failed on startup"
      +msgstr "Speltoetser het stilweg by opstart misluk"
      +
     -+#: lib/spellcheck.tcl:79
      +msgid "Unrecognized spell checker"
      +msgstr "Onherkende speltoetser"
      +
     -+#: lib/spellcheck.tcl:185
      +msgid "No Suggestions"
      +msgstr "Geen voorstelle nie"
      +
     -+#: lib/spellcheck.tcl:387
      +msgid "Unexpected EOF from spell checker"
      +msgstr "Onverwagte EOF van speltoetser"
      +
     -+#: lib/spellcheck.tcl:391
      +msgid "Spell Checker Failed"
      +msgstr "Speltoetser het misluk"
      +
     -+#: lib/sshkey.tcl:34
      +msgid "No keys found."
      +msgstr "Geen sleutels gevind nie."
      +
     -+#: lib/sshkey.tcl:37
      +#, tcl-format
      +msgid "Found a public key in: %s"
      +msgstr "Publieke sleutel gevind in: %s"
      +
     -+#: lib/sshkey.tcl:43
      +msgid "Generate Key"
      +msgstr "Genereer sleutel"
      +
     -+#: lib/sshkey.tcl:58
      +msgid "Copy To Clipboard"
      +msgstr "Kopieer na knipbord"
      +
     -+#: lib/sshkey.tcl:72
      +msgid "Your OpenSSH Public Key"
      +msgstr "U publieke OpenSSH-sleutel"
      +
     -+#: lib/sshkey.tcl:80
      +msgid "Generating..."
      +msgstr "Genereer..."
      +
     -+#: lib/sshkey.tcl:87
      +#, tcl-format
      +msgid ""
      +"Could not start ssh-keygen:\n"
     @@ po/af.po (new)
      +"\n"
      +"%s"
      +
     -+#: lib/sshkey.tcl:114
      +msgid "Generation failed."
      +msgstr "Generering het misluk."
      +
     -+#: lib/sshkey.tcl:121
      +msgid "Generation succeeded, but no keys found."
      +msgstr "Generering het geslaag, maar geen sleutels is gevind nie."
      +
     -+#: lib/sshkey.tcl:124
      +#, tcl-format
      +msgid "Your key is in: %s"
      +msgstr "U sleutel is in: %s"
      +
     -+#: lib/status_bar.tcl:258
      +#, tcl-format
      +msgid "%s ... %*i of %*i %s (%3i%%)"
      +msgstr "%s ... %*i van %*i %s (%3i%%)"
      +
     -+#: lib/tools_dlg.tcl:22
      +#, tcl-format
      +msgid "%s (%s): Add Tool"
      +msgstr "%s (%s): Voeg hulpmiddel by"
      +
     -+#: lib/tools_dlg.tcl:28
      +msgid "Add New Tool Command"
      +msgstr "Voeg nuwe hulpmiddelopdrag by"
      +
     -+#: lib/tools_dlg.tcl:34
      +msgid "Add globally"
      +msgstr "Voeg globaal by"
      +
     -+#: lib/tools_dlg.tcl:46
      +msgid "Tool Details"
      +msgstr "Hulpmiddelbesonderhede"
      +
     -+#: lib/tools_dlg.tcl:49
      +msgid "Use '/' separators to create a submenu tree:"
      +msgstr "Gebruik '/'-skeiers om 'n subkieslysboom te skep:"
      +
     -+#: lib/tools_dlg.tcl:60
      +msgid "Command:"
      +msgstr "Opdrag:"
      +
     -+#: lib/tools_dlg.tcl:71
      +msgid "Show a dialog before running"
      +msgstr "Wys 'n dialoog voor uitvoering"
      +
     -+#: lib/tools_dlg.tcl:77
      +msgid "Ask the user to select a revision (sets $REVISION)"
      +msgstr "Vra die gebruiker om 'n revisie te kies (stel $REVISION)"
      +
     -+#: lib/tools_dlg.tcl:82
      +msgid "Ask the user for additional arguments (sets $ARGS)"
      +msgstr "Vra die gebruiker vir bykomende argumente (stel $ARGS)"
      +
     -+#: lib/tools_dlg.tcl:89
      +msgid "Don't show the command output window"
      +msgstr "Moenie die opdraguitvoervenster wys nie"
      +
     -+#: lib/tools_dlg.tcl:94
      +msgid "Run only if a diff is selected ($FILENAME not empty)"
      +msgstr "Voer slegs uit as 'n verskil gekies is ($FILENAME nie leeg nie)"
      +
     -+#: lib/tools_dlg.tcl:118
      +msgid "Please supply a name for the tool."
      +msgstr "Verskaf asseblief 'n naam vir die hulpmiddel."
      +
     -+#: lib/tools_dlg.tcl:126
      +#, tcl-format
      +msgid "Tool '%s' already exists."
      +msgstr "Hulpmiddel '%s' bestaan reeds."
      +
     -+#: lib/tools_dlg.tcl:148
      +#, tcl-format
      +msgid ""
      +"Could not add tool:\n"
     @@ po/af.po (new)
      +"Kon nie hulpmiddel byvoeg nie:\n"
      +"%s"
      +
     -+#: lib/tools_dlg.tcl:187
      +#, tcl-format
      +msgid "%s (%s): Remove Tool"
      +msgstr "%s (%s): Verwyder hulpmiddel"
      +
     -+#: lib/tools_dlg.tcl:193
      +msgid "Remove Tool Commands"
      +msgstr "Verwyder hulpmiddelopdragte"
      +
     -+#: lib/tools_dlg.tcl:198
      +msgid "Remove"
      +msgstr "Verwyder"
      +
     -+#: lib/tools_dlg.tcl:231
      +msgid "(Blue denotes repository-local tools)"
      +msgstr "(Blou dui bewaarplek-plaaslike hulpmiddels aan)"
      +
     -+#: lib/tools_dlg.tcl:283
      +#, tcl-format
      +msgid "%s (%s):"
      +msgstr "%s (%s):"
      +
     -+#: lib/tools_dlg.tcl:292
      +#, tcl-format
      +msgid "Run Command: %s"
      +msgstr "Voer opdrag uit: %s"
      +
     -+#: lib/tools_dlg.tcl:306
      +msgid "Arguments"
      +msgstr "Argumente"
      +
     -+#: lib/tools_dlg.tcl:341
      +msgid "OK"
      +msgstr "Goed"
      +
     -+#: lib/tools.tcl:76
      +#, tcl-format
      +msgid "Running %s requires a selected file."
      +msgstr "Om %s uit te voer, moet 'n lêer gekies wees."
      +
     -+#: lib/tools.tcl:92
      +#, tcl-format
      +msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
      +msgstr "Is u seker u wil %1$s op lêer \"%2$s\" uitvoer?"
      +
     -+#: lib/tools.tcl:96
      +#, tcl-format
      +msgid "Are you sure you want to run %s?"
      +msgstr "Is u seker u wil %s uitvoer?"
      +
     -+#: lib/tools.tcl:118
      +#, tcl-format
      +msgid "Tool: %s"
      +msgstr "Hulpmiddel: %s"
      +
     -+#: lib/tools.tcl:119
      +#, tcl-format
      +msgid "Running: %s"
      +msgstr "Voer uit: %s"
      +
     -+#: lib/tools.tcl:157
      +#, tcl-format
      +msgid "Tool completed successfully: %s"
      +msgstr "Hulpmiddel suksesvol voltooi: %s"
      +
     -+#: lib/tools.tcl:159
      +#, tcl-format
      +msgid "Tool failed: %s"
      +msgstr "Hulpmiddel het misluk: %s"
      +
     -+#: lib/transport.tcl:7
      +#, tcl-format
      +msgid "Fetching new changes from %s"
      +msgstr "Haal nuwe veranderinge van %s"
      +
     -+#: lib/transport.tcl:18
      +#, tcl-format
      +msgid "remote prune %s"
      +msgstr "snoei afgeleë %s"
      +
     -+#: lib/transport.tcl:19
      +#, tcl-format
      +msgid "Pruning tracking branches deleted from %s"
      +msgstr "Snoei volgtakke wat van %s geskrap is"
      +
     -+#: lib/transport.tcl:25
      +msgid "fetch all remotes"
      +msgstr "haal alle afgeleës"
      +
     -+#: lib/transport.tcl:26
      +msgid "Fetching new changes from all remotes"
      +msgstr "Haal nuwe veranderinge van alle afgeleës"
      +
     -+#: lib/transport.tcl:40
      +msgid "remote prune all remotes"
      +msgstr "snoei alle afgeleës"
      +
     -+#: lib/transport.tcl:41
      +msgid "Pruning tracking branches deleted from all remotes"
      +msgstr "Snoei volgtakke wat van alle afgeleës geskrap is"
      +
     -+#: lib/transport.tcl:55
      +#, tcl-format
      +msgid "Pushing changes to %s"
      +msgstr "Stoot veranderinge na %s"
      +
     -+#: lib/transport.tcl:93
      +#, tcl-format
      +msgid "Mirroring to %s"
      +msgstr "Weerspieël na %s"
      +
     -+#: lib/transport.tcl:111
      +#, tcl-format
      +msgid "Pushing %s %s to %s"
      +msgstr "Stoot %s %s na %s"
      +
     -+#: lib/transport.tcl:132
      +msgid "Push Branches"
      +msgstr "Stoot takke"
      +
     -+#: lib/transport.tcl:147
      +msgid "Source Branches"
      +msgstr "Brontakke"
      +
     -+#: lib/transport.tcl:162
      +msgid "Destination Repository"
      +msgstr "Bestemmingsbewaarplek"
      +
     -+#: lib/transport.tcl:201
      +msgid "Transfer Options"
      +msgstr "Oordragopsies"
      +
     -+#: lib/transport.tcl:203
      +msgid "Force overwrite existing branch (may discard changes)"
      +msgstr "Dwing oorskrywing van bestaande tak (kan veranderinge weggooi)"
      +
     -+#: lib/transport.tcl:207
      +msgid "Use thin pack (for slow network connections)"
      +msgstr "Gebruik dun pak (vir stadige netwerkverbindings)"
      +
     -+#: lib/transport.tcl:211
      +msgid "Include tags"
      +msgstr "Sluit etikette in"
      +
     -+#: lib/transport.tcl:225
      +#, tcl-format
      +msgid "%s (%s): Push"
      +msgstr "%s (%s): Stoot"
     +
     + ## po/meson.build ##
     +@@
     + languages = [
     ++  'af',
     +   'bg',
     +   'de',
     +   'el',


 po/af.po       | 2156 ++++++++++++++++++++++++++++++++++++++++++++++++
 po/meson.build |    1 +
 2 files changed, 2157 insertions(+)
 create mode 100644 po/af.po

diff --git a/po/af.po b/po/af.po
new file mode 100644
index 0000000000..647a015293
--- /dev/null
+++ b/po/af.po
@@ -0,0 +1,2156 @@
+# Afrikaans translation of git-gui.
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git-gui package.
+#
+# Stéfan Driaan Turvey <stefanturvey1912@gmail.com>, 2026.
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2026-07-16 11:05+0200\n"
+"PO-Revision-Date: 2026-09-24 07:31+0200\n"
+"Last-Translator: Stéfan Driaan Turvey <stefanturvey1912@gmail.com>\n"
+"Language-Team: Stéfan Driaan Turvey <stefanturvey1912@gmail.com>\n"
+"Language: af\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Ongeldige lettertipe in %s gespesifiseer:"
+
+msgid "Main Font"
+msgstr "Hooflettertipe"
+
+msgid "Diff/Console Font"
+msgstr "Verskil-/konsolelettertipe"
+
+msgid "git-gui: fatal error"
+msgstr "git-gui: fatale fout"
+
+msgid "Cannot find git in PATH."
+msgstr "Kan nie git in PATH vind nie."
+
+msgid "Cannot parse Git version string:"
+msgstr "Kan nie die Git-weergawestring ontleed nie:"
+
+msgid "Insufficient git version, require: "
+msgstr "Ontoereikende git-weergawe, vereis: "
+
+msgid "git returned:"
+msgstr "git het teruggegee:"
+
+msgid "Invalid configuration:"
+msgstr "Ongeldige konfigurasie:"
+
+msgid "Unusable repo/worktree:"
+msgstr "Onbruikbare bewaarplek/werkboom:"
+
+msgid "Git directory not found:"
+msgstr "Git-gids nie gevind nie:"
+
+msgid "No working directory"
+msgstr "Geen werkgids nie"
+
+msgid "Cannot use bare repository:"
+msgstr "Kan nie kaal bewaarplek gebruik nie:"
+
+msgid "Refreshing file status..."
+msgstr "Verfris tans lêerstatus..."
+
+msgid "Scanning for modified files ..."
+msgstr "Soek tans na gewysigde lêers ..."
+
+msgid "Calling prepare-commit-msg hook..."
+msgstr "Roep tans prepare-commit-msg-haak aan..."
+
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "Vaslegging deur prepare-commit-msg-haak geweier."
+
+msgid "Ready."
+msgstr "Gereed."
+
+#, tcl-format
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
+msgstr ""
+"Vertoonlimiet (gui.maxfilesdisplayed = %s) bereik, nie al %s lêers word "
+"gewys nie."
+
+msgid "Unmodified"
+msgstr "Ongewysig"
+
+msgid "Modified, not staged"
+msgstr "Gewysig, nie geplaas nie"
+
+msgid "Staged for commit"
+msgstr "Geplaas vir vaslegging"
+
+msgid "Portions staged for commit"
+msgstr "Gedeeltes geplaas vir vaslegging"
+
+msgid "Staged for commit, missing"
+msgstr "Geplaas vir vaslegging, ontbreek"
+
+msgid "File type changed, not staged"
+msgstr "Lêertipe verander, nie geplaas nie"
+
+msgid "File type changed, old type staged for commit"
+msgstr "Lêertipe verander, ou tipe geplaas vir vaslegging"
+
+msgid "File type changed, staged"
+msgstr "Lêertipe verander, geplaas"
+
+msgid "File type change staged, modification not staged"
+msgstr "Lêertipeverandering geplaas, wysiging nie geplaas nie"
+
+msgid "File type change staged, file missing"
+msgstr "Lêertipeverandering geplaas, lêer ontbreek"
+
+msgid "Untracked, not staged"
+msgstr "Onnaspoorbaar, nie geplaas nie"
+
+msgid "Missing"
+msgstr "Ontbreek"
+
+msgid "Staged for removal"
+msgstr "Geplaas vir verwydering"
+
+msgid "Staged for removal, still present"
+msgstr "Geplaas vir verwydering, steeds teenwoordig"
+
+msgid "Requires merge resolution"
+msgstr "Vereis oplossing van saamsmelting"
+
+msgid "Couldn't find gitk in PATH"
+msgstr "Kon nie gitk in PATH vind nie"
+
+#, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "Begin tans %s... wag asseblief..."
+
+msgid "Couldn't find git gui in PATH"
+msgstr "Kon nie git gui in PATH vind nie"
+
+msgid "Repository"
+msgstr "Bewaarplek"
+
+msgid "Edit"
+msgstr "Redigeer"
+
+msgid "Branch"
+msgstr "Tak"
+
+msgid "Commit@@noun"
+msgstr "Vaslegging"
+
+msgid "Merge"
+msgstr "Saamsmelt"
+
+msgid "Remote"
+msgstr "Afgeleë"
+
+msgid "Tools"
+msgstr "Gereedskap"
+
+msgid "Explore Working Copy"
+msgstr "Verken werkkopie"
+
+msgid "Git Bash"
+msgstr "Git Bash"
+
+msgid "Browse Current Branch's Files"
+msgstr "Blaai deur huidige tak se lêers"
+
+msgid "Browse Branch Files..."
+msgstr "Blaai deur taklêers..."
+
+msgid "Visualize Current Branch's History"
+msgstr "Visualiseer huidige tak se geskiedenis"
+
+msgid "Visualize All Branch History"
+msgstr "Visualiseer alle takke se geskiedenis"
+
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Blaai deur %s se lêers"
+
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualiseer %s se geskiedenis"
+
+msgid "Database Statistics"
+msgstr "Databasisstatistiek"
+
+msgid "Compress Database"
+msgstr "Pak databasis saam"
+
+msgid "Verify Database"
+msgstr "Verifieer databasis"
+
+msgid "Create Desktop Icon"
+msgstr "Skep werkskermikoon"
+
+msgid "Quit"
+msgstr "Verlaat"
+
+msgid "Undo"
+msgstr "Ontdoen"
+
+msgid "Redo"
+msgstr "Herdoen"
+
+msgid "Cut"
+msgstr "Knip"
+
+msgid "Copy"
+msgstr "Kopieer"
+
+msgid "Paste"
+msgstr "Plak"
+
+msgid "Delete"
+msgstr "Skrap"
+
+msgid "Select All"
+msgstr "Kies alles"
+
+msgid "Create..."
+msgstr "Skep..."
+
+msgid "Checkout..."
+msgstr "Check uit..."
+
+msgid "Rename..."
+msgstr "Hernoem..."
+
+msgid "Delete..."
+msgstr "Skrap..."
+
+msgid "Reset..."
+msgstr "Herstel..."
+
+msgid "Done"
+msgstr "Klaar"
+
+msgid "Commit@@verb"
+msgstr "Lê vas"
+
+msgid "Amend Last Commit"
+msgstr "Wysig laaste vaslegging"
+
+msgid "Rescan"
+msgstr "Herskandeer"
+
+msgid "Stage To Commit"
+msgstr "Plaas vir vaslegging"
+
+msgid "Stage Changed Files To Commit"
+msgstr "Plaas gewysigde lêers vir vaslegging"
+
+msgid "Unstage From Commit"
+msgstr "Ontplaas uit vaslegging"
+
+msgid "Revert Changes"
+msgstr "Keer veranderinge om"
+
+msgid "Show Less Context"
+msgstr "Wys minder konteks"
+
+msgid "Show More Context"
+msgstr "Wys meer konteks"
+
+msgid "Sign Off"
+msgstr "Teken af"
+
+msgid "Local Merge..."
+msgstr "Plaaslike saamsmelting..."
+
+msgid "Abort Merge..."
+msgstr "Staak saamsmelting..."
+
+msgid "Add..."
+msgstr "Voeg by..."
+
+msgid "Push..."
+msgstr "Stoot..."
+
+msgid "Delete Branch..."
+msgstr "Skrap tak..."
+
+msgid "Options..."
+msgstr "Opsies..."
+
+msgid "Remove..."
+msgstr "Verwyder..."
+
+msgid "Help"
+msgstr "Hulp"
+
+#, tcl-format
+msgid "About %s"
+msgstr "Aangaande %s"
+
+msgid "Online Documentation"
+msgstr "Aanlyn dokumentasie"
+
+msgid "Show SSH Key"
+msgstr "Wys SSH-sleutel"
+
+msgid "usage:"
+msgstr "gebruik:"
+
+msgid "Usage"
+msgstr "Gebruik"
+
+#, tcl-format
+msgid "fatal: no such file '%s' in worktree"
+msgstr "fataal: geen lêer '%s' in werkboom nie"
+
+#, tcl-format
+msgid "fatal: '%s' is not a valid rev'"
+msgstr "fataal: '%s' is nie 'n geldige revisie nie'"
+
+#, tcl-format
+msgid "'%s' is not a directory in rev '%s'"
+msgstr "'%s' is nie 'n gids in revisie '%s' nie"
+
+#, tcl-format
+msgid "'%s' is not a filename in rev '%s'"
+msgstr "'%s' is nie 'n lêernaam in revisie '%s' nie"
+
+msgid "Current Branch:"
+msgstr "Huidige tak:"
+
+msgid "Unstaged Changes"
+msgstr "Ongeplaasde veranderinge"
+
+msgid "Staged Changes (Will Commit)"
+msgstr "Geplaasde veranderinge (sal vasgelê word)"
+
+msgid "Stage Changed"
+msgstr "Plaas gewysigdes"
+
+msgid "Push"
+msgstr "Stoot"
+
+msgid "Initial Commit Message:"
+msgstr "Aanvanklike vasleggingsboodskap:"
+
+msgid "Amended Commit Message:"
+msgstr "Gewysigde vasleggingsboodskap:"
+
+msgid "Amended Initial Commit Message:"
+msgstr "Gewysigde aanvanklike vasleggingsboodskap:"
+
+msgid "Amended Merge Commit Message:"
+msgstr "Gewysigde saamsmeltvasleggingsboodskap:"
+
+msgid "Merge Commit Message:"
+msgstr "Saamsmeltvasleggingsboodskap:"
+
+msgid "Commit Message:"
+msgstr "Vasleggingsboodskap:"
+
+msgid "Copy All"
+msgstr "Kopieer alles"
+
+msgid "File:"
+msgstr "Lêer:"
+
+msgid "Open"
+msgstr "Open"
+
+msgid "Refresh"
+msgstr "Verfris"
+
+msgid "Decrease Font Size"
+msgstr "Verklein lettergrootte"
+
+msgid "Increase Font Size"
+msgstr "Vergroot lettergrootte"
+
+msgid "Encoding"
+msgstr "Enkodering"
+
+msgid "Apply/Reverse Hunk"
+msgstr "Pas brok toe/keer om"
+
+msgid "Apply/Reverse Line"
+msgstr "Pas reël toe/keer om"
+
+msgid "Revert Hunk"
+msgstr "Keer brok om"
+
+msgid "Revert Line"
+msgstr "Keer reël om"
+
+msgid "Undo Last Revert"
+msgstr "Ontdoen laaste omkering"
+
+msgid "Run Merge Tool"
+msgstr "Voer saamsmeltgereedskap uit"
+
+msgid "Use Remote Version"
+msgstr "Gebruik afgeleë weergawe"
+
+msgid "Use Local Version"
+msgstr "Gebruik plaaslike weergawe"
+
+msgid "Revert To Base"
+msgstr "Keer terug na basis"
+
+msgid "Visualize These Changes In The Submodule"
+msgstr "Visualiseer hierdie veranderinge in die submodule"
+
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Visualiseer huidige tak se geskiedenis in die submodule"
+
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Visualiseer alle takke se geskiedenis in die submodule"
+
+msgid "Start git gui In The Submodule"
+msgstr "Begin git gui in die submodule"
+
+msgid "Unstage Hunk From Commit"
+msgstr "Ontplaas brok uit vaslegging"
+
+msgid "Unstage Lines From Commit"
+msgstr "Ontplaas reëls uit vaslegging"
+
+msgid "Revert Lines"
+msgstr "Keer reëls om"
+
+msgid "Unstage Line From Commit"
+msgstr "Ontplaas reël uit vaslegging"
+
+msgid "Stage Hunk For Commit"
+msgstr "Plaas brok vir vaslegging"
+
+msgid "Stage Lines For Commit"
+msgstr "Plaas reëls vir vaslegging"
+
+msgid "Stage Line For Commit"
+msgstr "Plaas reël vir vaslegging"
+
+msgid "Initializing..."
+msgstr "Inisialiseer tans..."
+
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - 'n grafiese gebruikerskoppelvlak vir Git."
+
+#, tcl-format
+msgid "%s (%s): File Viewer"
+msgstr "%s (%s): Lêerbekyker"
+
+msgid "Commit:"
+msgstr "Vaslegging:"
+
+msgid "Copy Commit"
+msgstr "Kopieer vaslegging"
+
+msgid "Find Text..."
+msgstr "Soek teks..."
+
+msgid "Goto Line..."
+msgstr "Gaan na reël..."
+
+msgid "Do Full Copy Detection"
+msgstr "Doen volledige kopie-opsporing"
+
+msgid "Show History Context"
+msgstr "Wys geskiedeniskonteks"
+
+msgid "Blame Parent Commit"
+msgstr "Blameer ouervaslegging"
+
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Lees tans %s..."
+
+msgid "Error"
+msgstr "Fout"
+
+msgid "Loading copy/move tracking annotations..."
+msgstr "Laai tans kopieer-/skuifnaspooraantekeninge..."
+
+msgid "lines annotated"
+msgstr "reëls geannoteer"
+
+msgid "Loading original location annotations..."
+msgstr "Laai tans aantekeninge van oorspronklike ligging..."
+
+msgid "Annotation complete."
+msgstr "Annotering voltooi."
+
+msgid "Busy"
+msgstr "Besig"
+
+msgid "Annotation process is already running."
+msgstr "Annoteringsproses loop reeds."
+
+msgid "Running thorough copy detection..."
+msgstr "Voer tans deeglike kopie-opsporing uit..."
+
+msgid "Loading annotation..."
+msgstr "Laai tans annotering..."
+
+msgid "Author:"
+msgstr "Outeur:"
+
+msgid "Committer:"
+msgstr "Vaslegger:"
+
+msgid "Original File:"
+msgstr "Oorspronklike lêer:"
+
+msgid "Cannot find HEAD commit:"
+msgstr "Kan nie HEAD-vaslegging vind nie:"
+
+msgid "Cannot find parent commit:"
+msgstr "Kan nie ouervaslegging vind nie:"
+
+msgid "Unable to display parent"
+msgstr "Kan nie ouer vertoon nie"
+
+msgid "Error loading diff:"
+msgstr "Fout met laai van verskil:"
+
+msgid "Originally By:"
+msgstr "Oorspronklik deur:"
+
+msgid "In File:"
+msgstr "In lêer:"
+
+msgid "Copied Or Moved Here By:"
+msgstr "Hierheen gekopieer of geskuif deur:"
+
+#, tcl-format
+msgid "%s (%s): Checkout Branch"
+msgstr "%s (%s): Check tak uit"
+
+msgid "Checkout Branch"
+msgstr "Check tak uit"
+
+msgid "Checkout"
+msgstr "Check uit"
+
+msgid "Cancel"
+msgstr "Kanselleer"
+
+msgid "Revision"
+msgstr "Revisie"
+
+msgid "Options"
+msgstr "Opsies"
+
+msgid "Fetch Tracking Branch"
+msgstr "Haal volgtak"
+
+msgid "Detach From Local Branch"
+msgstr "Ontkoppel van plaaslike tak"
+
+#, tcl-format
+msgid "%s (%s): Create Branch"
+msgstr "%s (%s): Skep tak"
+
+msgid "Create New Branch"
+msgstr "Skep nuwe tak"
+
+msgid "Create"
+msgstr "Skep"
+
+msgid "Branch Name"
+msgstr "Taknaam"
+
+msgid "Name:"
+msgstr "Naam:"
+
+msgid "Match Tracking Branch Name"
+msgstr "Pas by volgtak se naam"
+
+msgid "Starting Revision"
+msgstr "Beginrevisie"
+
+msgid "Update Existing Branch:"
+msgstr "Werk bestaande tak by:"
+
+msgid "No"
+msgstr "Nee"
+
+msgid "Fast Forward Only"
+msgstr "Slegs vooruitspoel"
+
+msgid "Reset"
+msgstr "Herstel"
+
+msgid "Checkout After Creation"
+msgstr "Check uit na skepping"
+
+msgid "Please select a tracking branch."
+msgstr "Kies asseblief 'n volgtak."
+
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Volgtak %s is nie 'n tak in die afgeleë bewaarplek nie."
+
+msgid "Please supply a branch name."
+msgstr "Verskaf asseblief 'n taknaam."
+
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' is nie 'n aanvaarbare taknaam nie."
+
+#, tcl-format
+msgid "%s (%s): Delete Branch"
+msgstr "%s (%s): Skrap tak"
+
+msgid "Delete Local Branch"
+msgstr "Skrap plaaslike tak"
+
+msgid "Local Branches"
+msgstr "Plaaslike takke"
+
+msgid "Delete Only If Merged Into"
+msgstr "Skrap slegs indien saamgesmelt in"
+
+msgid "Always (Do not perform merge checks)"
+msgstr "Altyd (moenie saamsmeltkontroles uitvoer nie)"
+
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Die volgende takke is nie volledig in %s saamgesmelt nie:"
+
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Dit is moeilik om geskrapte takke te herwin.\n"
+"\n"
+"Skrap die gekose takke?"
+
+#, tcl-format
+msgid " - %s:"
+msgstr " - %s:"
+
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Kon nie takke skrap nie:\n"
+"%s"
+
+#, tcl-format
+msgid "%s (%s): Rename Branch"
+msgstr "%s (%s): Hernoem tak"
+
+msgid "Rename Branch"
+msgstr "Hernoem tak"
+
+msgid "Rename"
+msgstr "Hernoem"
+
+msgid "Branch:"
+msgstr "Tak:"
+
+msgid "New Name:"
+msgstr "Nuwe naam:"
+
+msgid "Please select a branch to rename."
+msgstr "Kies asseblief 'n tak om te hernoem."
+
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Tak '%s' bestaan reeds."
+
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Kon nie '%s' hernoem nie."
+
+msgid "Starting..."
+msgstr "Begin tans..."
+
+#, tcl-format
+msgid "%s (%s): File Browser"
+msgstr "%s (%s): Lêerblaaier"
+
+#, tcl-format
+msgid "Loading %s..."
+msgstr "Laai tans %s..."
+
+msgid "[Up To Parent]"
+msgstr "[Op na ouer]"
+
+#, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "%s (%s): Blaai deur taklêers"
+
+msgid "Browse Branch Files"
+msgstr "Blaai deur taklêers"
+
+msgid "Browse"
+msgstr "Blaai"
+
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Haal tans %s vanaf %s"
+
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "fataal: Kan nie %s oplos nie"
+
+msgid "Close"
+msgstr "Sluit"
+
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Tak '%s' bestaan nie."
+
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Kon nie vereenvoudigde git-pull vir '%s' konfigureer nie."
+
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"Tak '%s' bestaan reeds.\n"
+"\n"
+"Dit kan nie na %s vooruitspoel nie.\n"
+"'n Saamsmelting is nodig."
+
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Saamsmeltstrategie '%s' word nie ondersteun nie."
+
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Kon nie '%s' bywerk nie."
+
+msgid "Staging area (index) is already locked."
+msgstr "Plaasarea (indeks) is reeds gesluit."
+
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Laaste geskandeerde toestand stem nie ooreen met die bewaarplek se toestand "
+"nie.\n"
+"\n"
+"'n Ander Git-program het hierdie bewaarplek sedert die laaste skandering "
+"gewysig.  'n Herskandering moet uitgevoer word voordat die huidige tak "
+"verander kan word.\n"
+"\n"
+"Die herskandering sal nou outomaties begin word.\n"
+
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "Werk tans werkgids by na '%s'..."
+
+msgid "files checked out"
+msgstr "lêers uitgecheck"
+
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "Uitcheck van '%s' gestaak (saamsmelting op lêervlak is nodig)."
+
+msgid "File level merge required."
+msgstr "Saamsmelting op lêervlak is nodig."
+
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Bly op tak '%s'."
+
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Jy is nie meer op 'n plaaslike tak nie.\n"
+"\n"
+"As jy op 'n tak wou wees, skep nou een wat by 'Hierdie ontkoppelde uitcheck' "
+"begin."
+
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "'%s' uitgecheck."
+
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "Om '%s' na '%s' te herstel sal die volgende vasleggings verloor:"
+
+msgid "Recovering lost commits may not be easy."
+msgstr "Dit is dalk nie maklik om verlore vasleggings te herwin nie."
+
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Herstel '%s'?"
+
+msgid "Visualize"
+msgstr "Visualiseer"
+
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Kon nie huidige tak stel nie.\n"
+"\n"
+"Hierdie werkgids is slegs gedeeltelik oorgeskakel.  Ons het jou lêers "
+"suksesvol bygewerk, maar kon nie 'n interne Git-lêer bywerk nie.\n"
+"\n"
+"Dit moes nie gebeur het nie.  %s sal nou sluit en opgee."
+
+msgid "Select"
+msgstr "Kies"
+
+msgid "Font Family"
+msgstr "Lettertipefamilie"
+
+msgid "Font Size"
+msgstr "Lettergrootte"
+
+msgid "Font Example"
+msgstr "Lettertipevoorbeeld"
+
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Dit is voorbeeldteks.\n"
+"As jy van hierdie teks hou, kan dit jou lettertipe wees."
+
+msgid "Git Gui"
+msgstr "Git Gui"
+
+msgid "Create New Repository"
+msgstr "Skep nuwe bewaarplek"
+
+msgid "New..."
+msgstr "Nuut..."
+
+msgid "Clone Existing Repository"
+msgstr "Kloon bestaande bewaarplek"
+
+msgid "Clone..."
+msgstr "Kloon..."
+
+msgid "Open Existing Repository"
+msgstr "Open bestaande bewaarplek"
+
+msgid "Open..."
+msgstr "Open..."
+
+msgid "Recent Repositories"
+msgstr "Onlangse bewaarplekke"
+
+msgid "Open Recent Repository:"
+msgstr "Open onlangse bewaarplek:"
+
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Kon nie bewaarplek %s skep nie:"
+
+msgid "Directory:"
+msgstr "Gids:"
+
+msgid "Git Repository"
+msgstr "Git-bewaarplek"
+
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "Gids %s bestaan reeds."
+
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Lêer %s bestaan reeds."
+
+msgid "Clone"
+msgstr "Kloon"
+
+msgid "Source Location:"
+msgstr "Bronligging:"
+
+msgid "Target Directory:"
+msgstr "Teikengids:"
+
+msgid "Clone Type:"
+msgstr "Kloontipe:"
+
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standaard (vinnig, semi-oortollig, harde skakels)"
+
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Volledige kopie (stadiger, oortollige rugsteun)"
+
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Gedeel (vinnigste, nie aanbeveel nie, geen rugsteun nie)"
+
+msgid "Recursively clone submodules too"
+msgstr "Kloon submodules ook rekursief"
+
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Nie 'n Git-bewaarplek nie: %s"
+
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Harde skakels is nie beskikbaar nie.  Val terug op kopiëring."
+
+msgid "Standard only available for local repository."
+msgstr "Standaard is slegs vir 'n plaaslike bewaarplek beskikbaar."
+
+msgid "Shared only available for local repository."
+msgstr "Gedeel is slegs vir 'n plaaslike bewaarplek beskikbaar."
+
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "Ligging %s bestaan reeds."
+
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Kloon tans vanaf %s"
+
+msgid "Clone failed."
+msgstr "Kloon het misluk."
+
+msgid "Repository:"
+msgstr "Bewaarplek:"
+
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Kon nie bewaarplek %s open nie:"
+
+msgid "This Detached Checkout"
+msgstr "Hierdie ontkoppelde uitcheck"
+
+msgid "Revision Expression:"
+msgstr "Revisie-uitdrukking:"
+
+msgid "Local Branch"
+msgstr "Plaaslike tak"
+
+msgid "Tracking Branch"
+msgstr "Volgtak"
+
+msgid "Tag"
+msgstr "Etiket"
+
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Ongeldige revisie: %s"
+
+msgid "No revision selected."
+msgstr "Geen revisie gekies nie."
+
+msgid "Revision expression is empty."
+msgstr "Revisie-uitdrukking is leeg."
+
+msgid "Updated"
+msgstr "Bygewerk"
+
+msgid "URL"
+msgstr "URL"
+
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Daar is niks om te wysig nie.\n"
+"\n"
+"U is op die punt om die eerste vaslegging te skep.  Daar is geen vaslegging "
+"hiervoor om te wysig nie.\n"
+
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Kan nie wysig tydens 'n saamsmelting nie.\n"
+"\n"
+"U is tans in die middel van 'n saamsmelting wat nog nie heeltemal voltooi is "
+"nie.  U kan nie die vorige vaslegging wysig nie, tensy u eers die huidige "
+"saamsmelting staak.\n"
+
+msgid "Error loading commit data for amend:"
+msgstr "Fout met die laai van vasleggingsdata om te wysig:"
+
+msgid "Unable to obtain your identity:"
+msgstr "Kan nie u identiteit bepaal nie:"
+
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Ongeldige GIT_COMMITTER_IDENT:"
+
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "waarskuwing: Tcl ondersteun nie enkodering '%s' nie."
+
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Die laaste geskandeerde toestand stem nie ooreen met die toestand van die "
+"bewaarplek nie.\n"
+"\n"
+"'n Ander Git-program het hierdie bewaarplek sedert die laaste skandering "
+"gewysig.  'n Herskandering moet gedoen word voordat nog 'n vaslegging geskep "
+"kan word.\n"
+"\n"
+"Die herskandering sal nou outomaties begin word.\n"
+
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Lêers wat nie saamgesmelt is nie, kan nie vasgelê word nie.\n"
+"\n"
+"Lêer %s het saamsmeltkonflikte.  U moet dit oplos en die lêer plaas voordat "
+"u vaslê.\n"
+
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Onbekende lêertoestand %s bespeur.\n"
+"\n"
+"Lêer %s kan nie deur hierdie program vasgelê word nie.\n"
+
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Geen veranderinge om vas te lê nie.\n"
+"\n"
+"U moet ten minste 1 lêer plaas voordat u kan vaslê.\n"
+
+msgid "Calling pre-commit hook..."
+msgstr "Roep pre-commit-haak aan..."
+
+msgid "Commit declined by pre-commit hook."
+msgstr "Vaslegging deur pre-commit-haak geweier."
+
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"U is op die punt om op 'n ontkoppelde HEAD vas te lê. Dit is moontlik "
+"gevaarlik, want as u na 'n ander tak oorskakel, sal u u veranderinge verloor "
+"en dit kan moeilik wees om hulle later uit die reflog te herwin. U moet "
+"waarskynlik hierdie vaslegging kanselleer en 'n nuwe tak skep om voort te "
+"gaan.\n"
+" \n"
+" Wil u regtig met u vaslegging voortgaan?"
+
+msgid "Calling commit-msg hook..."
+msgstr "Roep commit-msg-haak aan..."
+
+msgid "Commit declined by commit-msg hook."
+msgstr "Vaslegging deur commit-msg-haak geweier."
+
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Verskaf asseblief 'n vasleggingsboodskap.\n"
+"\n"
+"'n Goeie vasleggingsboodskap het die volgende formaat:\n"
+"\n"
+"- Eerste reël: Beskryf in een sin wat u gedoen het.\n"
+"- Tweede reël: Leeg\n"
+"- Oorblywende reëls: Beskryf waarom hierdie verandering goed is.\n"
+
+msgid "Committing changes..."
+msgstr "Lê veranderinge vas..."
+
+msgid "write-tree failed:"
+msgstr "write-tree het misluk:"
+
+msgid "Commit failed."
+msgstr "Vaslegging het misluk."
+
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Vaslegging %s blyk korrup te wees"
+
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Geen veranderinge om vas te lê nie.\n"
+"\n"
+"Geen lêers is deur hierdie vaslegging gewysig nie en dit was nie 'n "
+"saamsmeltvaslegging nie.\n"
+"\n"
+"'n Herskandering sal nou outomaties begin word.\n"
+
+msgid "No changes to commit."
+msgstr "Geen veranderinge om vas te lê nie."
+
+msgid "commit-tree failed:"
+msgstr "commit-tree het misluk:"
+
+msgid "update-ref failed:"
+msgstr "update-ref het misluk:"
+
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Vaslegging %s geskep: %s"
+
+msgid "Working... please wait..."
+msgstr "Besig... wag asseblief..."
+
+msgid "Success"
+msgstr "Sukses"
+
+msgid "Error: Command Failed"
+msgstr "Fout: Opdrag het misluk"
+
+msgid "Number of loose objects"
+msgstr "Aantal los objekte"
+
+msgid "Disk space used by loose objects"
+msgstr "Skyfspasie deur los objekte gebruik"
+
+msgid "Number of packed objects"
+msgstr "Aantal gepakte objekte"
+
+msgid "Number of packs"
+msgstr "Aantal pakke"
+
+msgid "Disk space used by packed objects"
+msgstr "Skyfspasie deur gepakte objekte gebruik"
+
+msgid "Packed objects waiting for pruning"
+msgstr "Gepakte objekte wat wag om gesnoei te word"
+
+msgid "Garbage files"
+msgstr "Rommellêers"
+
+#, tcl-format
+msgid "%s:"
+msgstr "%s:"
+
+#, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr "%s (%s): Databasisstatistiek"
+
+msgid "Compressing the object database"
+msgstr "Kompakteer die objekdatabasis"
+
+msgid "Verifying the object database with fsck-objects"
+msgstr "Verifieer die objekdatabasis met fsck-objects"
+
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Hierdie bewaarplek het tans ongeveer %i los objekte.\n"
+"\n"
+"Om optimale werkverrigting te behou, word sterk aanbeveel dat u die "
+"databasis kompakteer.\n"
+"\n"
+"Kompakteer die databasis nou?"
+
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Ongeldige datum van Git: %s"
+
+msgid ""
+"* No differences detected; stage the file to de-list it from Unstaged "
+"Changes.\n"
+msgstr ""
+"* Geen verskille bespeur nie; plaas die lêer om dit uit Ongeplaasde "
+"Veranderinge te verwyder.\n"
+
+msgid "* Click to find other files that may have the same state.\n"
+msgstr "* Klik om ander lêers te vind wat dalk dieselfde toestand het.\n"
+
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Laai verskil van %s..."
+
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"PLAASLIK: geskrap\n"
+"AFGELEË:\n"
+
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"AFGELEË: geskrap\n"
+"PLAASLIK:\n"
+
+msgid "LOCAL:\n"
+msgstr "PLAASLIK:\n"
+
+msgid "REMOTE:\n"
+msgstr "AFGELEË:\n"
+
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Kan nie %s vertoon nie"
+
+msgid "Error loading file:"
+msgstr "Fout met die laai van lêer:"
+
+msgid "Git Repository (subproject)"
+msgstr "Git-bewaarplek (subprojek)"
+
+msgid "* Binary file (not showing content)."
+msgstr "* Binêre lêer (inhoud word nie gewys nie)."
+
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Onnaspoorbare lêer is %d grepe.\n"
+"* Wys slegs die eerste %d grepe.\n"
+
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Onnaspoorbare lêer hier deur %s afgesny.\n"
+"* Gebruik 'n eksterne redigeerder om die hele lêer te sien.\n"
+
+msgid "Failed to unstage selected hunk."
+msgstr "Kon nie gekose brok ontplaas nie."
+
+msgid "Failed to revert selected hunk."
+msgstr "Kon nie gekose brok omkeer nie."
+
+msgid "Failed to stage selected hunk."
+msgstr "Kon nie gekose brok plaas nie."
+
+msgid "Failed to unstage selected line."
+msgstr "Kon nie gekose reël ontplaas nie."
+
+msgid "Failed to revert selected line."
+msgstr "Kon nie gekose reël omkeer nie."
+
+msgid "Failed to stage selected line."
+msgstr "Kon nie gekose reël plaas nie."
+
+msgid "Failed to undo last revert."
+msgstr "Kon nie laaste omkering ongedaan maak nie."
+
+msgid "Default"
+msgstr "Verstek"
+
+#, tcl-format
+msgid "System (%s)"
+msgstr "Stelsel (%s)"
+
+msgid "Other"
+msgstr "Ander"
+
+#, tcl-format
+msgid "%s: error"
+msgstr "%s: fout"
+
+#, tcl-format
+msgid "%s: warning"
+msgstr "%s: waarskuwing"
+
+#, tcl-format
+msgid "%s hook failed:"
+msgstr "%s-haak het misluk:"
+
+msgid "You must correct the above errors before committing."
+msgstr "U moet die bostaande foute regstel voordat u vaslê."
+
+#, tcl-format
+msgid "%s (%s): error"
+msgstr "%s (%s): fout"
+
+msgid "Unable to unlock the index."
+msgstr "Kan nie die indeks ontsluit nie."
+
+msgid "Index Error"
+msgstr "Indeksfout"
+
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+"Bywerking van die Git-indeks het misluk.  'n Herskandering sal outomaties "
+"begin word om git-gui te hersinchroniseer."
+
+msgid "Continue"
+msgstr "Gaan voort"
+
+msgid "Unlock Index"
+msgstr "Ontsluit indeks"
+
+msgid "files"
+msgstr "lêers"
+
+msgid "Unstaging selected files from commit"
+msgstr "Ontplaas gekose lêers uit vaslegging"
+
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "Ontplaas %s uit vaslegging"
+
+msgid "Ready to commit."
+msgstr "Gereed om vas te lê."
+
+msgid "Adding selected files"
+msgstr "Voeg gekose lêers by"
+
+#, tcl-format
+msgid "Adding %s"
+msgstr "Voeg %s by"
+
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "Plaas %d onnaspoorbare lêers?"
+
+msgid "Adding all changed files"
+msgstr "Voeg alle veranderde lêers by"
+
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Keer veranderinge in lêer %s om?"
+
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Keer veranderinge in hierdie %i lêers om?"
+
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Enige ongeplaasde veranderinge sal deur die omkering permanent verlore gaan."
+
+msgid "Do Nothing"
+msgstr "Doen niks"
+
+#, tcl-format
+msgid "Delete untracked file %s?"
+msgstr "Skrap onnaspoorbare lêer %s?"
+
+#, tcl-format
+msgid "Delete these %i untracked files?"
+msgstr "Skrap hierdie %i onnaspoorbare lêers?"
+
+msgid "Files will be permanently deleted."
+msgstr "Lêers sal permanent geskrap word."
+
+msgid "Delete Files"
+msgstr "Skrap lêers"
+
+msgid "Deleting"
+msgstr "Skrap"
+
+msgid "Encountered errors deleting files:\n"
+msgstr "Foute teëgekom met die skrap van lêers:\n"
+
+#, tcl-format
+msgid "None of the %d selected files could be deleted."
+msgstr "Geeneen van die %d gekose lêers kon geskrap word nie."
+
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
+msgstr "%d van die %d gekose lêers kon nie geskrap word nie."
+
+msgid "Reverting selected files"
+msgstr "Keer gekose lêers om"
+
+#, tcl-format
+msgid "Reverting %s"
+msgstr "Keer %s om"
+
+msgid "Goto Line:"
+msgstr "Gaan na reël:"
+
+msgid "Go"
+msgstr "Gaan"
+
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Kan nie saamsmelt terwyl daar gewysig word nie.\n"
+"\n"
+"U moet klaar wees met die wysiging van hierdie vaslegging voordat u enige "
+"soort saamsmelting begin.\n"
+
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Die laaste geskandeerde toestand stem nie ooreen met die toestand van die "
+"bewaarplek nie.\n"
+"\n"
+"'n Ander Git-program het hierdie bewaarplek sedert die laaste skandering "
+"gewysig.  'n Herskandering moet gedoen word voordat 'n saamsmelting gedoen "
+"kan word.\n"
+"\n"
+"Die herskandering sal nou outomaties begin word.\n"
+
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"U is in die middel van 'n saamsmelting met konflikte.\n"
+"\n"
+"Lêer %s het saamsmeltkonflikte.\n"
+"\n"
+"U moet dit oplos, die lêer plaas en vaslê om die huidige saamsmelting te "
+"voltooi.  Eers dan kan u 'n ander saamsmelting begin.\n"
+
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"U is in die middel van 'n verandering.\n"
+"\n"
+"Lêer %s is gewysig.\n"
+"\n"
+"U moet die huidige vaslegging voltooi voordat u 'n saamsmelting begin.  Dit "
+"sal u help om 'n mislukte saamsmelting te staak, indien nodig.\n"
+
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s van %s"
+
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Smelt %s en %s saam..."
+
+msgid "Merge completed successfully."
+msgstr "Saamsmelting suksesvol voltooi."
+
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Saamsmelting het misluk.  Konflikoplossing is nodig."
+
+#, tcl-format
+msgid "%s (%s): Merge"
+msgstr "%s (%s): Saamsmelt"
+
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Smelt saam in %s"
+
+msgid "Revision To Merge"
+msgstr "Revisie om saam te smelt"
+
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Kan nie staak terwyl daar gewysig word nie.\n"
+"\n"
+"U moet klaar wees met die wysiging van hierdie vaslegging.\n"
+
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Staak saamsmelting?\n"
+"\n"
+"As die huidige saamsmelting gestaak word, sal *ALLE* veranderinge wat nie "
+"vasgelê is nie, verlore gaan.\n"
+"\n"
+"Gaan voort om die huidige saamsmelting te staak?"
+
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Herstel veranderinge?\n"
+"\n"
+"As die veranderinge herstel word, sal *ALLE* veranderinge wat nie vasgelê is "
+"nie, verlore gaan.\n"
+"\n"
+"Gaan voort om die huidige veranderinge te herstel?"
+
+msgid "Aborting"
+msgstr "Staak"
+
+msgid "files reset"
+msgstr "lêers herstel"
+
+msgid "Abort failed."
+msgstr "Staking het misluk."
+
+msgid "Abort completed.  Ready."
+msgstr "Staking voltooi.  Gereed."
+
+msgid "Force resolution to the base version?"
+msgstr "Dwing oplossing na die basisweergawe?"
+
+msgid "Force resolution to this branch?"
+msgstr "Dwing oplossing na hierdie tak?"
+
+msgid "Force resolution to the other branch?"
+msgstr "Dwing oplossing na die ander tak?"
+
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Let daarop dat die verskil slegs konflikterende veranderinge wys.\n"
+"\n"
+"%s sal oorskryf word.\n"
+"\n"
+"Hierdie bewerking kan slegs ongedaan gemaak word deur die saamsmelting weer "
+"te begin."
+
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Lêer %s blyk onopgeloste konflikte te hê; plaas steeds?"
+
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Voeg oplossing vir %s by"
+
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Kan nie skrappings- of skakelkonflikte met 'n hulpmiddel oplos nie"
+
+msgid "Conflict file does not exist"
+msgstr "Konfliklêer bestaan nie"
+
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Nie 'n grafiese saamsmelthulpmiddel nie: '%s'"
+
+#, tcl-format
+msgid ""
+"Unable to process square brackets in \"mergetool.%s.cmd\" configuration "
+"option.\n"
+"\n"
+"Please remove the square brackets."
+msgstr ""
+"Kan nie vierkantige hakies in die konfigurasie-opsie \"mergetool.%s.cmd\" "
+"verwerk nie.\n"
+"\n"
+"Verwyder asseblief die vierkantige hakies."
+
+#, tcl-format
+msgid ""
+"Unsupported merge tool '%s'.\n"
+"\n"
+"To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config "
+"manual page."
+msgstr ""
+"Saamsmelthulpmiddel '%s' word nie ondersteun nie.\n"
+"\n"
+"Om hierdie hulpmiddel te gebruik, stel \"mergetool.%s.cmd\" op soos in die "
+"git-config-handleidingbladsy getoon."
+
+msgid "Merge tool is already running, terminate it?"
+msgstr "Saamsmelthulpmiddel loop reeds; beëindig dit?"
+
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Fout met die ophaal van weergawes:\n"
+"%s"
+
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"Kon nie die saamsmelthulpmiddel begin nie:\n"
+"\n"
+"%s"
+
+msgid "Running merge tool..."
+msgstr "Voer saamsmelthulpmiddel uit..."
+
+msgid "Merge tool failed."
+msgstr "Saamsmelthulpmiddel het misluk."
+
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Ongeldige globale enkodering '%s'"
+
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Ongeldige bewaarplek-enkodering '%s'"
+
+msgid "Restore Defaults"
+msgstr "Herstel verstekwaardes"
+
+msgid "Save"
+msgstr "Stoor"
+
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s-bewaarplek"
+
+msgid "Global (All Repositories)"
+msgstr "Globaal (alle bewaarplekke)"
+
+msgid "User Name"
+msgstr "Gebruikersnaam"
+
+msgid "Email Address"
+msgstr "E-posadres"
+
+msgid "Summarize Merge Commits"
+msgstr "Som saamsmeltvasleggings op"
+
+msgid "Merge Verbosity"
+msgstr "Saamsmelt-breedsprakigheid"
+
+msgid "Show Diffstat After Merge"
+msgstr "Wys verskilstatistiek ná saamsmelting"
+
+msgid "Use Merge Tool"
+msgstr "Gebruik saamsmelthulpmiddel"
+
+msgid "Trust File Modification Timestamps"
+msgstr "Vertrou lêerwysigingstydstempels"
+
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Snoei volgtakke tydens haal"
+
+msgid "Match Tracking Branches"
+msgstr "Pas volgtakke"
+
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Gebruik textconv vir verskille en blameer"
+
+msgid "Blame Copy Only On Changed Files"
+msgstr "Blameer kopieë slegs in veranderde lêers"
+
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Maksimum lengte van lys van onlangse bewaarplekke"
+
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Minimum letters om kopieë te blameer"
+
+msgid "Blame History Context Radius (days)"
+msgstr "Blameer-geskiedeniskonteksradius (dae)"
+
+msgid "Number of Diff Context Lines"
+msgstr "Aantal verskil-konteksreëls"
+
+msgid "Additional Diff Parameters"
+msgstr "Bykomende verskilparameters"
+
+msgid "Commit Message Text Width"
+msgstr "Teksbreedte van vasleggingsboodskap"
+
+msgid "New Branch Name Template"
+msgstr "Sjabloon vir nuwe taknaam"
+
+msgid "Default File Contents Encoding"
+msgstr "Verstek-enkodering van lêerinhoud"
+
+msgid "Warn before committing to a detached head"
+msgstr "Waarsku voordat op 'n ontkoppelde HEAD vasgelê word"
+
+msgid "Staging of untracked files"
+msgstr "Plasing van onnaspoorbare lêers"
+
+msgid "Show untracked files"
+msgstr "Wys onnaspoorbare lêers"
+
+msgid "Tab spacing"
+msgstr "Oortjiespasiëring"
+
+msgid "Change"
+msgstr "Verander"
+
+msgid "Spelling Dictionary:"
+msgstr "Speltoetswoordeboek:"
+
+msgid "Change Font"
+msgstr "Verander lettertipe"
+
+#, tcl-format
+msgid "Choose %s"
+msgstr "Kies %s"
+
+msgid "pt."
+msgstr "pt."
+
+msgid "Preferences"
+msgstr "Voorkeure"
+
+msgid "Failed to completely save options:"
+msgstr "Kon nie opsies volledig stoor nie:"
+
+#, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "%s (%s): Voeg afgeleë by"
+
+msgid "Add New Remote"
+msgstr "Voeg nuwe afgeleë by"
+
+msgid "Add"
+msgstr "Voeg by"
+
+msgid "Remote Details"
+msgstr "Afgeleë besonderhede"
+
+msgid "Location:"
+msgstr "Ligging:"
+
+msgid "Further Action"
+msgstr "Verdere aksie"
+
+msgid "Fetch Immediately"
+msgstr "Haal onmiddellik"
+
+msgid "Initialize Remote Repository and Push"
+msgstr "Inisialiseer afgeleë bewaarplek en stoot"
+
+msgid "Do Nothing Else Now"
+msgstr "Doen nou niks anders nie"
+
+msgid "Please supply a remote name."
+msgstr "Verskaf asseblief 'n afgeleë naam."
+
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' is nie 'n aanvaarbare afgeleë naam nie."
+
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Kon nie afgeleë '%s' met ligging '%s' byvoeg nie."
+
+#, tcl-format
+msgid "fetch %s"
+msgstr "haal %s"
+
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "Haal %s"
+
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Weet nie hoe om die bewaarplek by ligging '%s' te inisialiseer nie."
+
+#, tcl-format
+msgid "push %s"
+msgstr "stoot %s"
+
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Stel %s op (by %s)"
+
+#, tcl-format
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "%s (%s): Skrap tak op afgeleë"
+
+msgid "Delete Branch Remotely"
+msgstr "Skrap tak op afgeleë"
+
+msgid "From Repository"
+msgstr "Van bewaarplek"
+
+msgid "Remote:"
+msgstr "Afgeleë:"
+
+msgid "Arbitrary Location:"
+msgstr "Willekeurige ligging:"
+
+msgid "Branches"
+msgstr "Takke"
+
+msgid "Delete Only If"
+msgstr "Skrap slegs indien"
+
+msgid "Merged Into:"
+msgstr "Saamgesmelt in:"
+
+msgid "A branch is required for 'Merged Into'."
+msgstr "'n Tak word vir 'Saamgesmelt in' vereis."
+
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"Die volgende takke is nie heeltemal in %s saamgesmelt nie:\n"
+"\n"
+" - %s"
+
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Een of meer van die saamsmelttoetse het misluk omdat u nie die nodige "
+"vasleggings gehaal het nie.  Probeer eers van %s haal."
+
+msgid "Please select one or more branches to delete."
+msgstr "Kies asseblief een of meer takke om te skrap."
+
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Skrap takke van %s"
+
+msgid "No repository selected."
+msgstr "Geen bewaarplek gekies nie."
+
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Skandeer %s..."
+
+msgid "Push to"
+msgstr "Stoot na"
+
+msgid "Remove Remote"
+msgstr "Verwyder afgeleë"
+
+msgid "Prune from"
+msgstr "Snoei van"
+
+msgid "Fetch from"
+msgstr "Haal van"
+
+msgid "All"
+msgstr "Alle"
+
+msgid "Find:"
+msgstr "Vind:"
+
+msgid "Next"
+msgstr "Volgende"
+
+msgid "Prev"
+msgstr "Vorige"
+
+msgid "RegExp"
+msgstr "RegUitdr"
+
+msgid "Case"
+msgstr "Hoof/klein"
+
+#, tcl-format
+msgid "%s (%s): Create Desktop Icon"
+msgstr "%s (%s): Skep werkskermikoon"
+
+#, tcl-format
+msgid "Replace existing shortcut: %s?"
+msgstr "Vervang bestaande kortpad: %s?"
+
+msgid "Cannot write shortcut:"
+msgstr "Kan nie kortpad skryf nie:"
+
+msgid "Cannot write icon:"
+msgstr "Kan nie ikoon skryf nie:"
+
+msgid "Unsupported spell checker"
+msgstr "Speltoetser word nie ondersteun nie"
+
+msgid "Spell checking is unavailable"
+msgstr "Speltoetsing is nie beskikbaar nie"
+
+msgid "Invalid spell checking configuration"
+msgstr "Ongeldige speltoetskonfigurasie"
+
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "Stel woordeboek terug na %s."
+
+msgid "Spell checker silently failed on startup"
+msgstr "Speltoetser het stilweg by opstart misluk"
+
+msgid "Unrecognized spell checker"
+msgstr "Onherkende speltoetser"
+
+msgid "No Suggestions"
+msgstr "Geen voorstelle nie"
+
+msgid "Unexpected EOF from spell checker"
+msgstr "Onverwagte EOF van speltoetser"
+
+msgid "Spell Checker Failed"
+msgstr "Speltoetser het misluk"
+
+msgid "No keys found."
+msgstr "Geen sleutels gevind nie."
+
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Publieke sleutel gevind in: %s"
+
+msgid "Generate Key"
+msgstr "Genereer sleutel"
+
+msgid "Copy To Clipboard"
+msgstr "Kopieer na knipbord"
+
+msgid "Your OpenSSH Public Key"
+msgstr "U publieke OpenSSH-sleutel"
+
+msgid "Generating..."
+msgstr "Genereer..."
+
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Kon nie ssh-keygen begin nie:\n"
+"\n"
+"%s"
+
+msgid "Generation failed."
+msgstr "Generering het misluk."
+
+msgid "Generation succeeded, but no keys found."
+msgstr "Generering het geslaag, maar geen sleutels is gevind nie."
+
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "U sleutel is in: %s"
+
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i van %*i %s (%3i%%)"
+
+#, tcl-format
+msgid "%s (%s): Add Tool"
+msgstr "%s (%s): Voeg hulpmiddel by"
+
+msgid "Add New Tool Command"
+msgstr "Voeg nuwe hulpmiddelopdrag by"
+
+msgid "Add globally"
+msgstr "Voeg globaal by"
+
+msgid "Tool Details"
+msgstr "Hulpmiddelbesonderhede"
+
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Gebruik '/'-skeiers om 'n subkieslysboom te skep:"
+
+msgid "Command:"
+msgstr "Opdrag:"
+
+msgid "Show a dialog before running"
+msgstr "Wys 'n dialoog voor uitvoering"
+
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Vra die gebruiker om 'n revisie te kies (stel $REVISION)"
+
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Vra die gebruiker vir bykomende argumente (stel $ARGS)"
+
+msgid "Don't show the command output window"
+msgstr "Moenie die opdraguitvoervenster wys nie"
+
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Voer slegs uit as 'n verskil gekies is ($FILENAME nie leeg nie)"
+
+msgid "Please supply a name for the tool."
+msgstr "Verskaf asseblief 'n naam vir die hulpmiddel."
+
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Hulpmiddel '%s' bestaan reeds."
+
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Kon nie hulpmiddel byvoeg nie:\n"
+"%s"
+
+#, tcl-format
+msgid "%s (%s): Remove Tool"
+msgstr "%s (%s): Verwyder hulpmiddel"
+
+msgid "Remove Tool Commands"
+msgstr "Verwyder hulpmiddelopdragte"
+
+msgid "Remove"
+msgstr "Verwyder"
+
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Blou dui bewaarplek-plaaslike hulpmiddels aan)"
+
+#, tcl-format
+msgid "%s (%s):"
+msgstr "%s (%s):"
+
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Voer opdrag uit: %s"
+
+msgid "Arguments"
+msgstr "Argumente"
+
+msgid "OK"
+msgstr "Goed"
+
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Om %s uit te voer, moet 'n lêer gekies wees."
+
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Is u seker u wil %1$s op lêer \"%2$s\" uitvoer?"
+
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Is u seker u wil %s uitvoer?"
+
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Hulpmiddel: %s"
+
+#, tcl-format
+msgid "Running: %s"
+msgstr "Voer uit: %s"
+
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "Hulpmiddel suksesvol voltooi: %s"
+
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Hulpmiddel het misluk: %s"
+
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Haal nuwe veranderinge van %s"
+
+#, tcl-format
+msgid "remote prune %s"
+msgstr "snoei afgeleë %s"
+
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Snoei volgtakke wat van %s geskrap is"
+
+msgid "fetch all remotes"
+msgstr "haal alle afgeleës"
+
+msgid "Fetching new changes from all remotes"
+msgstr "Haal nuwe veranderinge van alle afgeleës"
+
+msgid "remote prune all remotes"
+msgstr "snoei alle afgeleës"
+
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "Snoei volgtakke wat van alle afgeleës geskrap is"
+
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Stoot veranderinge na %s"
+
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Weerspieël na %s"
+
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Stoot %s %s na %s"
+
+msgid "Push Branches"
+msgstr "Stoot takke"
+
+msgid "Source Branches"
+msgstr "Brontakke"
+
+msgid "Destination Repository"
+msgstr "Bestemmingsbewaarplek"
+
+msgid "Transfer Options"
+msgstr "Oordragopsies"
+
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "Dwing oorskrywing van bestaande tak (kan veranderinge weggooi)"
+
+msgid "Use thin pack (for slow network connections)"
+msgstr "Gebruik dun pak (vir stadige netwerkverbindings)"
+
+msgid "Include tags"
+msgstr "Sluit etikette in"
+
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr "%s (%s): Stoot"
diff --git a/po/meson.build b/po/meson.build
index 00cae74338..c408b987c6 100644
--- a/po/meson.build
+++ b/po/meson.build
@@ -1,4 +1,5 @@
 languages = [
+  'af',
   'bg',
   'de',
   'el',

base-commit: 5dcb97869546d600a114ef422a135e2e909c923c
-- 
gitgitgadget
