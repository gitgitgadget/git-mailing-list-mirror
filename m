Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75845191F8C
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164278; cv=none; b=GAFyp9Z/JyGq5PpahqX4tRRqJAw/rPs044uwyKKGpD45RrRgsfIEwxkR3xxLKW2QFqsvE/5ldoXhi7FIeYYPlC4j+U/qzds0YzqieaN7M6w12DrpECC4BuSdxfAr6kwNtZqemdFMMBDOHmcqF/DBoQFvyTLOIU3QpmyIvnq+nJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164278; c=relaxed/simple;
	bh=RjQbAfOpbrZgha6qPKjwPyOGc8F38ZPOqJskeUpqc+c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hH31LFVk4B35WKQ/ubVSztyVj8MqY2JZsvdKB6p2n4pB3K/EteTd6ip3VEswNNfBCFXzzySgltb6WsIg4TytBd2hX+3flaT+bG06sgzBifmqBIUdum283Wa/gjpZbMLTvzvG4nxRHvIg9zXQN9X2AtJGPpz1IdrjwaSIp6pA4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBMAgqSu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBMAgqSu"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso4502851a12.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164274; x=1724769074; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaORfh1ANfJV4xaETZE0klTl+j6AuhrXzJgAmJ3IlZA=;
        b=eBMAgqSuJfB7Jt+DTxEc52kbqxf3ohGAkZw4TC250pY/WWVq4zzVwsC3yOtLZYqJtF
         uit17ObZ7MrPOhOfDrO7Rx9AdmaUDODC5Hz/nGBGaxjPriJ2PAFjgiRx2I9MNmHW+aB3
         UAbRS4K6ndl45Zyc2oWJH6JKEtJs2BMRENL7UtE78JPlddvMeaHS2n8bh4OLFCbhKDhR
         oQmAxQsFTFdo8KKc3NlehT1NkuL4AhrrEH2snlA6bxbCYwS61W8n1PxcWTUGtMxDN6LE
         m3rrF6B/Mj1pnt+ML19sDuYqr+GO67R5RbXwKGDWqSsiKziPmDjT+i60XZKNaOghV3DZ
         Bopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164274; x=1724769074;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaORfh1ANfJV4xaETZE0klTl+j6AuhrXzJgAmJ3IlZA=;
        b=T8HgkuvkcuufzTGYH2KH5lxrkSuCuyntfAmQj2onzT9SiBFBwNeIkHe098Q/C5PoV5
         FtYAtMMTxzhf9QJXfPTa/miJijrZksgKWoOB60v84sgxoCwLWD0pmxPkZAsJocniYKXb
         hNNtPF1QvPcmkWvcdsx+GvL7aRGTdE0ZlYPCCJKHCppRiQv7M1Ta9N+akScQ5VRBHIRm
         Qw0tRxZAIav2ynw0OZ/GFL+GQpPnZaX2F3l5qcLzo6pGAGYH+QzMGEwk3C/ztY1mv9ZF
         IGNeFHAc7o6Lt7k4rV6NTuJnP2juG1nzw7aFlwb1VNWp7DNcp4rZH/gzP1uw6/WSUQE3
         HD6g==
X-Gm-Message-State: AOJu0YwMP9ylvNcTwpQqPx4RbwYARfUnkDLsUV1hwpC9Dn2YEbCaIxF8
	PoGN//szisS2bijWiaUvFPDuRVOB1SjWBmf+Fzyt3vvRhCOrWo/NC8YxeQ==
X-Google-Smtp-Source: AGHT+IGJoeoZAid/Gm0buMr8VuMB5Zyzwe3IBucRIoMLVsuTbJuTPSpd3T8hltJAxxlDVSUiju4frw==
X-Received: by 2002:a05:6402:518a:b0:5bf:a7f:d20 with SMTP id 4fb4d7f45d1cf-5bf0a7f0f02mr2233785a12.12.1724164273773;
        Tue, 20 Aug 2024 07:31:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bf0110009bsm1860964a12.37.2024.08.20.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:31:13 -0700 (PDT)
Message-Id: <1e2ad9d536e075098edd913b326086a88c69ad4a.1724164270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
References: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 14:31:10 +0000
Subject: [PATCH 2/2] ci(win+VS): download the vcpkg artifacts using a
 dedicated GitHub Action
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Git for Windows project provides a GitHub Action to download and
cache Azure Pipelines artifacts (such as the `vcpkg` artifacts), hiding
gnarly internals, and also providing some robustness against network
glitches. Let's use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85e5767aae6..1ee0433acc1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -181,14 +181,10 @@ jobs:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
     - name: download vcpkg artifacts
-      shell: powershell
-      run: |
-        $urlbase = "https://dev.azure.com/git/git/_apis/build/builds"
-        $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=9&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
-        $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[0].resource.downloadUrl
-        (New-Object Net.WebClient).DownloadFile($downloadUrl, "compat.zip")
-        Expand-Archive compat.zip -DestinationPath . -Force
-        Remove-Item compat.zip
+      uses: git-for-windows/get-azure-pipelines-artifact@v0
+      with:
+        repository: git/git
+        definitionId: 9
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v2
     - name: copy dlls to root
-- 
gitgitgadget
