Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5B770ED
	for <git@vger.kernel.org>; Thu,  9 May 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278653; cv=none; b=ATEKsP3hUkB2IEXv6PNKi8Eeb/i+P1YkrcHdhzO97LfBcPEUNnuYFBnHtfMEYCx3CflM4kokKXgDvuFRFjucyqytxMCNbSXuhJnphASGPQq1R21KcBk1dHjtkXdjvhdY1AUmcFYZ06Za/S5VOO90t9JcHcPzQkomHoZue0tXzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278653; c=relaxed/simple;
	bh=O6cqtGF4U3vG+Qv+PFD7D0Pu6W+8v0lCOWQVAuSgtHU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=KBiPnvlKFYVOMmUhwzMsKraN1UXkmKqw6KrG2H+/WmQw4M0P76jylbGkGx6SL5GGLyDN9wjCIi4/+kONNB2WGi28ah6gBrJsnWhhxfVWwiTsWorZ/h8AcmG52TAhupANndVYmpTds2OE2M2Qnfrrzh5cSl8OgnfDKxoyLENBsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPRdrJWo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPRdrJWo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed96772f92so9888865ad.0
        for <git@vger.kernel.org>; Thu, 09 May 2024 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715278652; x=1715883452; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jk7w4eElrolMQvyDx6wSLar7Ntu2ax+h7cpe0ZuxsSc=;
        b=lPRdrJWoh5p+7N5s+JomD6Jj4TdvMjFzmvMc5r+xArDLgGoOYA1KuzG8usvew6jVFH
         IEWOFBKkdaBxRsfau7qE1qT12Aiv8G/3hkiWUPbW8NuXcuo1lxc1IuIm/L2mjz3KqfY4
         tMtMp9d4cbf5Et6CqzoZwr4XRlNSRXCh1hzi6pnWCPucz82F9pqOnF9LNrEda0p+SU7G
         io22F+YdU5UFJ7lqNEU4KNyPZVhwMXZZW0bPqacuY2N85kGAlUnzeq7VXJQEYvNzauzn
         FgpVhezOIoJe7oSgPH86oTtoyNXjFD4Q+Y3CQpZwx53Pi9jASwTiiTbiSg6qR6bx0fOr
         kD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278652; x=1715883452;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk7w4eElrolMQvyDx6wSLar7Ntu2ax+h7cpe0ZuxsSc=;
        b=obCaEgnBn12a6Ng2Nwbg2K/2qSF8pNiLYr1Bj4MmeceM4iETJIzV4yfpnPoCX8zYyK
         ZHgxdCNFJQz2xXfYal+QqaAP2iUJAGwslC+wZVphRwgQAI8NryrOSUzRlhtMC1Tokvh3
         LoZ234Gkd4G8W1txT4QuTTtzmiqAkBQMKTUYhBa/PAgbsNrAXCBGKQevM+Y0CRDouLFh
         /fu5bkpeQORe8ZkFdxXgQQU3du3sv6699yXt4z8ByKuhNAEqdkOfZdfnQtJrGRShtMYR
         YUpyV1mRftHMxVwIFbDHk6RoZ3Efm9Fl0xwUgmgNO6JRrLIK30Ou1l99GjfanHubUj3x
         mDrg==
X-Gm-Message-State: AOJu0YzGiw/j4vx4a0h+/s1kMYT03hm55bbI89aO97uOojFcs4AsKk+/
	3HNfqCAxV6QEPrS9UkYgdeUqH4VWnH4A5PRvRJpBRXT+qlwKeb4nrpJgew==
X-Google-Smtp-Source: AGHT+IF+CaHCBvu9sKEi+vyBQZEPNDshlnoxzUiqOS+a40x3egXmBNkq4JIYTd/xVrRMK3b9WWS7Ng==
X-Received: by 2002:a17:902:8542:b0:1e5:5bd7:87a4 with SMTP id d9443c01a7336-1ef43d17fc8mr4533655ad.16.1715278651839;
        Thu, 09 May 2024 11:17:31 -0700 (PDT)
Received: from smtpclient.apple ([2601:645:b82:8e0:681d:8a4b:862d:bf87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038c4csm17497175ad.226.2024.05.09.11.17.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2024 11:17:31 -0700 (PDT)
From: Ilya Kulakov <kulakov.ilya@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: git-gui: Visualize * History does nothing on macOS
Message-Id: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
Date: Thu, 9 May 2024 11:17:19 -0700
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Both "Visualize <branch>'s History" and "Visualize All Branch History" =
do nothing on macOS. In the terminal it logs:

Error in startup script: 58:103: execution error: Not authorized to send =
Apple events to System Events. (-1743)
    while executing
"exec osascript -e [format {
        tell application "System Events"
            set frontmost of processes whose unix id is %d to true
        end te..."
    invoked from within
"if {[tk windowingsystem] eq "aqua"} {
    exec osascript -e [format {
        tell application "System Events"
            set frontmost of processes ..."
    (file "/opt/homebrew/bin/gitk" line 12321)

The relevant code at =
https://github.com/git/git/blob/0f3415f1f8478b05e64db11eb8aaa2915e48fef6/g=
it-gui/git-gui.sh#L271-L279 should not be fatal, because the permission =
to access "System Events" and arbitrarily manipulate windows is =
optional.


Best Regards,
Ilya Kulakov

