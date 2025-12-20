Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E04D8CE
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258200; cv=none; b=RPF5nOVv98x3XugvkN8Sb1Vu4b3L9l31EnrR7DyX7906JX44YJbDbu14bn0QUkUmcXKG2IN1lhnSC66AMgvI/cxlomsDeawQznS39Ko7xC/+z+K9ZN+tNkSRzqK051z8HX9MkdZkWvVcvZEWEdJrwgWSWsZCcZyh+yBWuaa5RgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258200; c=relaxed/simple;
	bh=BngH07ePa9GeQFbcjp1ax6D8XAPFSsiAsB/4XS27SGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=uGxqCfrGz3Z0oKKj48RCHiGVDKIMlCkNge0q0oYPtaxyL/daPuj52tt0PvGsp5Tw2EjJUxtf4TF5pwqJZFaUsQu9Bvve5UaHLyqBUtRLsaa4VyuuTz44IdLHHTjFF0dTeT4M07yHVHV0rDFeO7aATawB7q0QbCv3nuY2PIX43fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSDXo7XK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSDXo7XK"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed66b5abf7so38374531cf.1
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258197; x=1766862997; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngBNauNrNZTe1TfwL8GBZhWwkmx7MHKXzNom28N5iCk=;
        b=gSDXo7XK18TJE1Q/QqmAeTyev4UuiDniBmgCQkiTw8BBsggbzWwe//U6+Kbtui2KRA
         jC3Nby7xSiABqQbyFHCVN8if38c3gWWRJMHyZ442438l0oMI4+1fzK1nr6N+wFKgk6yV
         lhOCVHWwWLZibO6nbI1phkXkxDRnBwZ1fWdtVLHEVe6xhojOkznyd6l3xmvjbGvYqndo
         dqGdrGrO//Owus62hy2J6F9t9pnzEq8BZD7wY5KwFRtpQMFaSqahUpR58gTV+Y431mpa
         0nCBQzQlnpLsbwz08FS8DDEaZLic2dCvFJT6Ln01CXvtuS2HWVnqNrXUAVkbwva7cX0e
         nnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258197; x=1766862997;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngBNauNrNZTe1TfwL8GBZhWwkmx7MHKXzNom28N5iCk=;
        b=B2wsdbl+liGUlKDOL+uXhKbuuyXtb6OuXDsLMBVPnvy97MftzA7gC6MqshfSCPCOuL
         tCHgO5jIpNhGCZq3x6ShY63IdZihA/cga0++jWzXCEBstl2skciKOj6E2TnUnWUXA34s
         JU9VdLrBd9clnPnaP+w91B0f300yuMq/gaPFqH4yogUs4ZiVGzoWH6wFnhHZcWxBBPml
         vXYUg+GlDPd19YyV5YseGOyKKhB6K5jqg7F2BlhTEp4+ODXvCMd2hqBjZwvuvbcqrExg
         oR7DnkXvAjv15mbmYFpFtkProwcoReIfq1YSJ8UJVtjYHxtE0TBEKbJgERHMTzvBmvRG
         83hA==
X-Gm-Message-State: AOJu0YzIWHn9hgWtgXKpKSHfbM1/TVlOjvwa43J12mKx9kysNZdMHla2
	Y/MVuoZ8lFzMf1cBZZ2mRgEoS+TFcADe5TT4NXwhLONTrWAxSs3ddDEc58JNcg==
X-Gm-Gg: AY/fxX5fIfQphNSxw34yOKxz0sVJ3thlHmmtfeFPaVLgltkTAQ1BHVNqF7daSM/ZioM
	lXsDlkQVd8JIdDWIupndmNLz0WGaAB7vQEdfxjBcobwwNLGMoZzhv457Lzc08MWnmBIbPaBj0P7
	JQL4J/YNrTRXzfBaLUrTFgaN4HstdICW/Mqef5a82sUN6hEy+U7R19DyUJkWGQ6/2EVjPC+402S
	H8yPxnWWZNL5KkMBLrECT49ysHmrs1w2gtBndQwjOFTzTwyU22rz5+c0i68RIgwAk5TuiTfJScv
	7r1Jas5+lBGH/t7idtGmXOus7vGXjCaenMBw4znY4zQtjvJTWTeDvlQHTuo2O+vykjp51Ysp+F9
	2KJ3YS79R0cXir5+iys3HTvQXEb9tXuqZ1eFnXvmN1AchUq9TMs0tTcgIJ0SkVg9xOMIZKkdvHl
	27AD4b8pUFiwUHJA==
X-Google-Smtp-Source: AGHT+IGZfPwBf/tjAwnoVCgWDxuHZmn2IBBXn8ePMmRbiNqpT7mIoAAe+0i+B3+n385Shj3p8/corA==
X-Received: by 2002:ac8:5e53:0:b0:4f1:b362:eed7 with SMTP id d75a77b69052e-4f35f4849eamr155186161cf.42.1766258197220;
        Sat, 20 Dec 2025 11:16:37 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f08fcsm462279985a.40.2025.12.20.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:34 -0800 (PST)
Message-Id: <3c125bbc69342ad33d5f4dcec4512ce5e818c526.1766258187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
References: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:26 +0000
Subject: [PATCH 4/5] doc: convert git stage to use synopsis block
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-stage.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stage.adoc b/Documentation/git-stage.adoc
index 2f6aaa75b9..753a817639 100644
--- a/Documentation/git-stage.adoc
+++ b/Documentation/git-stage.adoc
@@ -8,8 +8,8 @@ git-stage - Add file contents to the staging area
 
 SYNOPSIS
 --------
-[verse]
-'git stage' <arg>...
+[synopsis]
+git stage <arg>...
 
 
 DESCRIPTION
-- 
gitgitgadget

