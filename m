Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495122522B9
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068183; cv=none; b=QV9p0buYLO4nXvx+A1qJcIXB/P80fTOMPxnwnXRb1WPE6LOZS9oGfIBdSmsnRtX65UwMz5ljKrpBRl1B5LIx4kzaXCwo5onVWhTmUdQYO12jkZZTOPT5IcBjcgJGeGNaf3QGnfknnlFQzxP793176lSctACX3xu2PSqAONEk+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068183; c=relaxed/simple;
	bh=0JjbpvrAZSQMIh9V7Svv41tD0xpl1nppEEb//PUKmQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaUh3u4178XlM/VVFvFci9lyPAnn/HNHovVH4TQm5avUuJ5BCgWG3iMhKkH49PuMDdcu2ucHeXunbct5f2HFD+XbKMtyzTCU+Ae/CC+c6iZgHtbJ82gOjOoMk7N49dkm0h3emtfMJj42Zv1DQA4232rq572igcAwJqH0CHpnClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPGF6Jif; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPGF6Jif"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4767e969b94so92904151cf.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068181; x=1747672981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiSMtWSLW1pfdnmfn3L9HZaxPd48IIXvqIclUvPBGy0=;
        b=MPGF6Jif75vmPdqaKrYohK2oYre68JOHbzXWN+1HX6T7lzAPZVA39dyqtXhNXdOu68
         ZmEHFU/hehpX1sVIOqYcJUVLFic0+P1Og8hITKfwevACIWf/B3Bj8YzMF/E9b4Y/2NDp
         vSoItH/zNElz1R8/y/7sdbCBnmexJ17OOsT3GTbL9B3VnEuARQ+cisvuH8ynuas5Rl3+
         klmzbm4LqNj2R+ZX96bsIEvrpvo5zcgdPqnBAxVQ6qhk1H/s5iRRrktCQ+royYTWx3M8
         YNB+jrTNurPTtka+T1cawPiPkirs8ySSZi8EJtzXxmualxBqlW1MpE45ctYwj5C0sflK
         lxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068181; x=1747672981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiSMtWSLW1pfdnmfn3L9HZaxPd48IIXvqIclUvPBGy0=;
        b=KOCj6zuVNxs4mTU20pbffkvcoXVhHpmWCYcOP+m47C/ufvFqGMS5UGh+X/BXcdSLiw
         1WAKN1TyLel0XpUqn7Uz7XhjkhTfj/oQC/eh6MLUrIQK140fH7saaVaL6j4RrHolGV48
         HmqcjYQIst4hWuW5y3rfv0ks07bJUB0WtGxL8W0zTMMVHNMC7WBAouBHbS7WElUk496Z
         DbY7QKmTkVHX+1P0vZXamnjlIHIwurzCFE/CqvUD4Cvx8XZG0/4de4GfcBMvWr6qgKud
         EQweAjAg5Pv2IPNT+BzcbkoOIimP7/rTMkklheZUe9AUFWiKGhW+0SZRMovh1tcQ5K3d
         EshA==
X-Gm-Message-State: AOJu0YxbSRKG7ZM/qUZ5Z4teBUkuOBJ08uiabjKd6prpZYCPO5Fsf0rp
	skgjNiIUnmQu/nLrs1q3tBbQhesuHW2XFZRaVQQMZujt/b5vnK8mgjY0vEQB1/4NyYDVbE8jdPh
	xbrU0hAiTugWXNDvMceGWERANkYUXzdG+aOA=
X-Gm-Gg: ASbGncs01vzbN0tEgWWOnZHM+5JzjWQ0VOE6hij+UJOjkDdX8uPGTZiz6HEqI5viWKM
	Mnh8RyA+3AILawxLT19Sux9N2Sp72JPvQsVXu2BvvJUUmAjIRl58dOUbSNYuCDEpD6jtXACajW6
	sXtZC3AUE+CRR8mWkzGl8CCm8O5mHwmypj5rBKx/2ierDrUPXbbpIULfj+IZMrqGvX
X-Google-Smtp-Source: AGHT+IHxIM5M539Sv7UcidVpWLDdRcMGCW4kJ0MEPEL81EB8o1OJRCm3bAKQ/TwWGpJh4Bn270xvNClv7xAwy3KK464=
X-Received: by 2002:ac8:578c:0:b0:480:9ba4:3022 with SMTP id
 d75a77b69052e-4945273580cmr195941271cf.17.1747068181033; Mon, 12 May 2025
 09:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
 <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 12 May 2025 22:12:50 +0530
X-Gm-Features: AX0GCFtal82CWSnHV5XM1s837uf_qcbMTVH11QsjaEpC12j4C32htnOc5prX0xg
Message-ID: <CA+rGoLfv6E7=TCm99yt4SYsZ1P-QRxD+vMuaHtDWX=ufneiYUA@mail.gmail.com>
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
To: smacdonald@kaimaging.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Changing this I found results to be correct

I think you can use this patch if you want a solution on an immediate basis,
testing and merging this into the master usually takes some time.

After testing with similar use case listed above

jayatheerth@fedora:~/Documents/code/test$ # Clean up previous test directories
rm -rf ~/Documents/code/test/ui ~/Documents/code/test/sdk
mkdir -p ~/Documents/code/test && cd ~/Documents/code/test

# Step 1: Create the submodule repo
mkdir sdk && cd sdk
git init
echo "SDK file" > sdk.txt
git add sdk.txt
git commit -m "Initial commit in SDK"
git stash listk stash messagextsh itbmodule add ../sdk
hint: Using 'master' as the name for the initial branch. This default
branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
hint:
hint: Disable this message with "git config set advice.defaultBranchName false"
Initialized empty Git repository in
/home/jayatheerth/Documents/code/test/sdk/.git/
[master (root-commit) 033e72f] Initial commit in SDK
 1 file changed, 1 insertion(+)
 create mode 100644 sdk.txt
hint: Using 'master' as the name for the initial branch. This default
branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
hint:
hint: Disable this message with "git config set advice.defaultBranchName false"
Initialized empty Git repository in
/home/jayatheerth/Documents/code/test/ui/.git/
Cloning into '/home/jayatheerth/Documents/code/test/ui/sdk'...
done.
[master (root-commit) 870c575] Add SDK as submodule
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sdk
Switched to a new branch 'feature_foo'
Switched to a new branch 'feature_sdk_foo'
Switched to a new branch 'bugfix_bar'
Saved working directory and index state On bugfix_bar: debugging
stash@{0}: On bugfix_bar: debugging

I found it to be on the bugfix_bar correctly as intended.

-Jayatheerth
