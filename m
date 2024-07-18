Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420013DDAD
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335663; cv=none; b=Lo/GPF0upiOyZPqu12HLJQbPKv6gaXyvk0TyNoV1Z7JAmERufqjfMfNBQzZ1wWdlL0rQ4af1Wk+etn6A6SH6Mkaye8TMydH2/GqpC6qgnvoo5uwc1dZVFoih9X28piV1EWJBlmEg9dTgD935YdUYBSIASIFn2VXxtbACvJLWfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335663; c=relaxed/simple;
	bh=exqNXh8Hk86doeRfwVdefaEQsQngqrKm/z7NMUk4ff8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FGXv5gUCAMKhSLvLw9eQgD0lUOpB28lO8GZQIlThY7A3vRUY8bUYtFVydrhrFY7uasDWI/g+K0fWIrH48yOevvAMAInWa8SC0SaB/EMxM1A54bHHaHhKJBvxEdocDWme2mjnD2rYLDxrM7tsYVXplq1EKcFSyN/NtBKsZpUNmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDw4VfpE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDw4VfpE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso6269695e9.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721335660; x=1721940460; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVH6vXku8VfPoVRonziqxPHn4t7VnDc7lwurJTAIF34=;
        b=MDw4VfpEZ4PJrBcjiIPNMBK7VQcrBfg/4Sz9LGSHorIkq+lLk/w0Ybt1z/hrl77MsZ
         LBFRAXz6ZXZWea2PU/iqWgJKMQR1sknrHkWGTumUYXJZV8Kr9L87SMNKWNpqKFCCdMZJ
         ARrN93EX9DFi65zGm6mcr5HgfweFVraO1KZBTjPlYbnI+qIVFHC8dfQSvSxzs9Nbn4P7
         ac70Udx4xxDsiCarYXjUEVmVeQ8k72kDcW1X1UR+HGlzJGEpX9acvNvzMrtEfpaOk4Cx
         GvYxKzvdwDrEC5TLnx5fWfv4d2LqA407bD8Jdbd0IuITwA/n7ms9R6T4OzZa02cg4yTU
         o5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721335660; x=1721940460;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVH6vXku8VfPoVRonziqxPHn4t7VnDc7lwurJTAIF34=;
        b=cYq3JW3aUBfOq6mfA22rSEdmkFUyEuG4w+jnx8dryKjdNxd+1YGQDW+pilEwrXQOYK
         Z+xbZ7PLD6L3UNVl1tOvVxUJqEu5e3wfpXkxD0rXRcy0deMj5GD2GJ/0lfpCcxBa4Lil
         Yi7rcGJHxf+gPpOI7lzk6N4CO/g2sbIMkGswP0KfCA0tXpzDtm54ZbFW1p5/3jKqpuHh
         VLNuEAUNQTO+nxxYbELSHju8KGHN1uDY+BPAV6M9EWWnpHRTH1G933/Jt97Y6Fwp7+x5
         ekGHDc9IQWJygkY+yFBSElP/mUgJ0440iexDv2TX+sHDTDDzAR0FV/Hr+VDN+HR543CR
         zSRg==
X-Gm-Message-State: AOJu0YzdzXQ5WLD2Gf8BDEStEulb5JosZCNLy7xd2u3minttK3imhnT4
	FIhcyeCen5JAURbOk7LCmVsWGYz1Mqml6ArqSoT5ZJ7gjkqU/9lqSBcPzA==
X-Google-Smtp-Source: AGHT+IFfy2DQX9oj/AhI85KSAift0Yqj5vSQ+6nn7XDOZ7RxbCa9Zm63b0OnsYdVmj2oc68MpuByaA==
X-Received: by 2002:adf:fd42:0:b0:368:420e:b790 with SMTP id ffacd0b85a97d-368420eb890mr3263992f8f.14.1721335659504;
        Thu, 18 Jul 2024 13:47:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692998csm995385e9.32.2024.07.18.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:47:39 -0700 (PDT)
Message-Id: <002750ea47a09d2f26c9c7b040c6730bc3f62b10.1721335657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
	<pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 20:47:36 +0000
Subject: [PATCH v2 1/2] git-svn: add public property `svn:global-ignores`
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
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <agalvin@comqi.com>

From: Alex Galvin <agalvin@comqi.com>

Subversion 1.8 added a new property `svn:global-ignores`. It
contains a list of patterns used to determine what files should
be ignored. If Git-SVN is going to ignore these files as well, it
is important that we do not skip over directories that have this
property set.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 7721708ce5d..b0913ca1b63 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -763,7 +763,7 @@ sub prop_walk {
 		# this needs to be updated.
 		++$interesting_props if /^svn:(?:ignore|keywords|executable
 		                                 |eol-style|mime-type
-						 |externals|needs-lock)$/x;
+						 |externals|needs-lock|global-ignores)$/x;
 	}
 	&$sub($self, $p, $props) if $interesting_props;
 
-- 
gitgitgadget

