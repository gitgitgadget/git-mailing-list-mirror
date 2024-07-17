Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D211836C2
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246271; cv=none; b=LUlfjZFl93lHwJXyiQqnsdek7RGpy58bKlqa9BIBRFNAVIA7eZXTneTUw4v1a+T0dyP753C8REPCjTJYgcKCvGa076OmEHaX94kYTNbOpSYN9CWg0RTusTiOOKW/L7V488VYrzIPw/WUBBFZvYCWBYpEqZJzhzmW5m97bY7HIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246271; c=relaxed/simple;
	bh=xP+pWEJak37dv+2Ny3NNaKXQQfgQDkCwVrC75aCE00U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HhLLuaTk/h79J4NcXCAK4MtEwA6B5q5sv1enY8Nxg7nGrFDbtwiLzYkJJEqfjE8+/errK0nrmSiWznrABhGGUziRM4dLImAQvob+kcPQMUu6RFmQ95pjr2WYH8nGegZe2dCUKIgI7wXYHsITcEyd7u1nIjlLHEX6IBCEg2OKBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7afyu3e; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7afyu3e"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a3d1a378so71284f8f.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721246268; x=1721851068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giRWkxzMzKVJT0nElbJ8xLdLCzOx3kk3+2KcHMH7b9M=;
        b=Z7afyu3e1iDEuiF8UYytVetATfS455jZsjWviH6ae/+RIbzvxfrDPI51PXgEnsmGwn
         mDlE3uHsmg1NqLEKd2UqdnTHK3D0JFqweN/dpKbemgpu43BgMlXpSkleXsmlac0IgPqz
         g5a5TIO1a2Jql1pDvBmwtrH8xNG4aPGnsi/2IeZx/Mxn+r585Dpz3/ZTcDsHKEdrnTWU
         6mHemI6Iio64weedlD/3ZqkGbEdx+PnsudRt6fZZ9oZWIYMAWKuDcP6WhOT8EWcxnN7m
         IOuoKWZ65X9YjNa124w+/Q6naqb8JyOYgQVNk0gsjbCKS1l5GCNXT+pbixGihHBrl2ff
         3eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246268; x=1721851068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giRWkxzMzKVJT0nElbJ8xLdLCzOx3kk3+2KcHMH7b9M=;
        b=tyBuJ/cO72z8FtdXX7MYrsu8SdUYJFq++HjCcF9otdPlb450skkirtAkUMBgy5Q8ir
         /t+nbrZSY+pMAoxYv6iaUwFsQYOyumnJC9vcktegSPM/reSCCx63qQ6nlyfqH7J0Ffdy
         sN9jSbubnHWB0MwWvxIF3tqx0GLHmTxsU/9F2G/AgcYZmPvsdfepzbHTJgO5tRS7ZkI5
         bIUn/yJ+3RCMykkoKNH45qf2GTyB3clULC7KvCILy/GcGugPlCo6wL/ih96gz13x2u81
         Z9ZMuWmlkUBHAsTCRvHYxZdAH12/aMZgVEJuhIFZJDKknvZPRg7aePsTdZ0cFJYae92Y
         FKIg==
X-Gm-Message-State: AOJu0Yw/0qxax2W4qLSeCpZtG/2A+l5x59IPl9oFADNfA0ERV0boLzaH
	M+wL3Fah90hxwSYEvsC68eVUsvvdvzlA5SzvBwnMy8tZK2fHp6X/p/suiQ==
X-Google-Smtp-Source: AGHT+IEvjSuIMd3pOuyiZ/GH425Emsy7s/JztvIa2b3okgOfidmd43PiOx+mO5LLVLXPXWXWlFm8fQ==
X-Received: by 2002:a5d:528a:0:b0:366:ec30:adcd with SMTP id ffacd0b85a97d-368315f2017mr2635154f8f.7.1721246267746;
        Wed, 17 Jul 2024 12:57:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7813199sm8954085e9.42.2024.07.17.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:57:47 -0700 (PDT)
Message-Id: <27bee8de47b34e8049ad922178bddc16dd2a7274.1721246266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jul 2024 19:57:44 +0000
Subject: [PATCH 1/2] git-svn: add public property `svn:global-ignores`
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

