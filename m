Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60728332EBC
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903286; cv=none; b=dhwPI0Fi+THrqUWDZQZ6JsKGtyfeRR5xZa+nMOG2ntkQ/6obU5g5UMWV/Y/36M11TU0s3fbyBr1Es3x9aC8BWGSbMbAdtSDnGOgOYkPKsIc9+gcm/ZnVWO7Oy1DwcJnEi4duNNVrFRax6mBgI1CzDkezbZoEoJEaHmi0EHERuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903286; c=relaxed/simple;
	bh=taIpBNCsqotBwxESuiAT+OfvCioFLhtMDllPJU3H4MM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mzli3wGmJ+UGIr/J6LuB8aA2ntX+gaPgwcHnFgawwQ7PKZih24yqSCQ1Iu0Hd7gMe94H8XrDROJuO10mrPvhSs5+LmYELZIbSl1FKZeN0j6CY0JFMOe9NkG+LbQwH/QEKnrRCm8ijwEZC3FS1pH+Y/rzoAUJGYDoPk3x+K5hSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiEqy/jw; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiEqy/jw"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be26842fd5so2288064eec.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772903284; x=1773508084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EeTGcJm21aJiEv8i9g9nULI1F9UMZfT9nhmV0ZNSHHE=;
        b=SiEqy/jw5gIhp/OGzZ53/DSPGb3jPZb1fCAf9IvdWosz3DrAE6H4pz4A2f6zKRMuOs
         qf/f1OpRMsbzQ36GyEP3DCaeG+rtn+cv4RL1SwY1epCMPuoGycqfT/1nz/6VP25QlIAL
         7A+NtNRQ1JmKumsogV8qQoNJIwnEQBfwKSk1AjPG8446sOvMimaq6nVRk1xgg4dCzMY/
         CF08XJJ0/8L2cUhbsFFVBHpMVW8vRmEC3NBgyCh5Clomgn0uROk7ybN3qUgr+WZkUSi7
         47KFXz5xMKP4XAh5SbboYZoswmpMrgAl3IAjx4TOedqJNiei/Qwy3eHzbMja5/Bng1Xf
         PB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772903284; x=1773508084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeTGcJm21aJiEv8i9g9nULI1F9UMZfT9nhmV0ZNSHHE=;
        b=LBxTCnAvMAIqIJr/1a7BmrT1x171qFiYP4yg7a1+xPzp7DY5QtzQb6AarZ7cVlo4Pr
         bv6abHSpw5A/gPBBycNbY9lejkDq2qeJh7NMTOvYaHlFvKg4THtKlSTDCESMCbLzHk6Q
         8FNGQy6rTYId0G7Rk2ZVA4v4qzOmzUUwPykm2p1FsK8vryGaB3kFFvZq+QTfuIGKjt//
         v0YsArljNzpBF/OemOjb4FSb7mbnXG3cmXVKtPLsWT//TZ7V+svPPLkvD8RCBLYzOP/S
         3g7ReLQGheaAUDQrSI27uXGkJfW9D6LOaIlPd3JP0ceMPiX2V6np1M2Y6WmzqYMHdyde
         6kug==
X-Gm-Message-State: AOJu0Yzm10/09hqImvkS1Lwq6bb6wnvf3mhPNW84GLmrmsNyQvwYjntB
	n1ZmfcxqVuCR3ToXKmch04oineUho7NvEUHQ+1gLh2HFtUxjK2jUqmmKqucobg==
X-Gm-Gg: ATEYQzy2YNaNR4Otza2lQcauHm+KhaUlFzTwNI0nUQay82y1FymDMo2gVTefH+w7pO9
	4QEoTWeDzvl8DJFP3y3NsJNTfrbEdCFEKLGoV9B9GrQ0aPD2dgH5sADfqm1sSWxKmx5ncGaNRcO
	IXJr8OChEANbfAyRw5yFcmGkNLi/VkjLAPXYohflP3uIy+oZx0zgzjvukIt05PKU8TQw8rRv+UP
	gS+OcBvb0pvLHvaJ/C3ix7PhChreJiP9LZAaPAdIXJrnJeQvl5sEK8LJjR5hDi00yQqGwVxBHtz
	frvWyFf4xhc1zMK3pblACHsaDiS4B/OOsVoUOXuaTEdJ49aaxYDSr6NZ9qKZR2uX92LJsOfiTjz
	OzfWWYyXqJAbjUMkEigTevmZ96lMmj5TgZPWJj/2bk3DVYgaTv5iiogBh2z/0ZqLYwSkP64tDZX
	nqaGnom7uiXFbNeDNPX2S3ZpEI
X-Received: by 2002:a05:693c:629b:b0:2be:2263:152e with SMTP id 5a478bee46e88-2be3e18f4cfmr2662357eec.2.1772903283582;
        Sat, 07 Mar 2026 09:08:03 -0800 (PST)
Received: from [127.0.0.1] ([128.24.161.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807714sm4536752eec.1.2026.03.07.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:08:02 -0800 (PST)
Message-Id: <pull.2225.git.git.1772903281929.gitgitgadget@gmail.com>
From: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 17:08:01 +0000
Subject: [PATCH] doc: make it easier to find custom command information
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
Cc: Junio C Hamano <gitster@pobox.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>

From: Omri Sarig <omri.sarig13@gmail.com>

Git supports creating additional commands through aliases, and through
placement of executables with a "git-" prefix in the PATH.

This information was not easy enough to find - users will look for this
information around the command description, but the documentation
exists in other locations.

Update the "GIT COMMANDS" section to reference the relevant sections,
making it easier for to find this information.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
    doc: Make it easier to find custom command information
    
    Hi,
    
    Following the discussion on
    https://lore.kernel.org/git/xmqqh5qwdaeh.fsf@gitster.g/#related, I've
    added the suggested documentation.
    
    The only change I made is updating linkgit:gitconfig[1] to be
    linkgit:git-config[1], which I believe is the correct form for that.
    
    With Kind Regards, Omri

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2225%2Fomrisarig13%2Fbreadcrumb-custom-commands-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2225/omrisarig13/breadcrumb-custom-commands-v1
Pull-Request: https://github.com/git/git/pull/2225

 Documentation/git.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 66442735ea..4e800c409e 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -235,7 +235,10 @@ GIT COMMANDS
 ------------
 
 We divide Git into high level ("porcelain") commands and low level
-("plumbing") commands.
+("plumbing") commands.  For defining command aliases, see
+linkgit:git-config[1] and look for descriptions of `alias.*`.
+For installing custom "git" subcommands, see the description for
+the 'PATH' environment variable in this manual.
 
 High-level commands (porcelain)
 -------------------------------

base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
gitgitgadget
