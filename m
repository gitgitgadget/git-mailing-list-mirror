Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE17E00B
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629537; cv=none; b=KzP5xqK4bxElCmA6bUb0wpeT82lVNEeiea93jLTpYAfk3gZuUkaaoPiNLUeQBw563rJWaC/xEsrmNcC8eZ92hXFgzfv8nQc6MigCVcXjgmpn7A4zdPiGv6puaTfB3fsuLDF2idsa0PLYq0w/K6Px6lo15r/VVIivQatuIUdeYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629537; c=relaxed/simple;
	bh=HO83snTYWW68JVwKuyaxKdY8C6QkioBw239N/KZB+LE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rypZQP7kK5KWNjyUYX3pCzgJNppiQDV+RhoJ+kvtXDLlJClIGI//Ur+AZiRKpno7/FDfzOtIrYBCYLIAI+7ACYlg8IJR/a3X6Y4W4epaSdGPx3z44/UeZg3dxVnViwj/1HZrrKsS7bjjFC9qdgVQ7tGiHm2SMG7ejQjtYamHHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp48EOlr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp48EOlr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so1847861f8f.0
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727629534; x=1728234334; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ju9RbwFJWnZ8pxHwwjiqpQxIN3gxHVlYI/oq9E8k7o=;
        b=Zp48EOlr72fYeuMbvTIEehzxjJtimrrjL3rT7GR2RLftXQGrUStXwRMcdbiOLpygX8
         g5iTw2gQufjLVarC7ZBu2Cps2BSEVhWZVIMA2NH8yo7hFMi66OmEkV/SyYvssNST11S9
         Y8z3pD9onhMgn1aew7ULwX4aOQjq8Dig8GjW/bF98+AGO42cH4oVEkQ9Mb6CZv5YpxuY
         jJCHzSb5TLubp7Y0BqbH8MP6buf3nI85f+0OgW/vZiK35/7dxcTjZ8PaDWV4YjPTisDj
         cLfMfiYMPdKIg0zGD20xvMjbRJmD2GUWCdsoGJ/T4ysY6w/Fe8t+qtjMuC4WCjVSWPT0
         WMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629534; x=1728234334;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ju9RbwFJWnZ8pxHwwjiqpQxIN3gxHVlYI/oq9E8k7o=;
        b=Ox2jlMQWzgFaduV0bqA5HUNTwbAH/OvD4TZJQIPaMvYKVHs2e9JtiyzI5o1/DzE6O+
         GXbzsxYCGa4KedQFlcTuB5drFW6z002QZHZCEBlrypJ/Xltv+1jmemL5fZ6N+qURHULR
         g1b6qSm0d0cZyK1BZ3jNjuLPVydX5VMaISBKeKQEaccy+S2L9Kp2I8j4dW9wTeQAMFts
         AY/xexPY86wQYoXH1KvcX4/AH120HAXtDPes6DWYxG+wNdL1eFeVktgtp458PR6Bkiaq
         0/Fe2ofqjo+2ArVgCoAnsuC9U1I+oeZbYUOZxoZ72GDR3g58cd0XkXs5ULXvGttNo0hw
         oPRw==
X-Gm-Message-State: AOJu0YzHY64WWUjp8eU2NpZhrlx5aqQmk8i3sx94clH9RpMsc+DCYToE
	aO2GbjQSvbOZqaoW2Ou3U+uyp4Hm/gVzbGRiXIjiES7Hk3kQIc/PcNFC2A==
X-Google-Smtp-Source: AGHT+IFTCCIikWxv6Z1zIqeLHm6Yy0coIea7KMUw04R27m/eJz7xyRDwfEhXowZAs44/GznG9V/1Jw==
X-Received: by 2002:a05:6000:10c3:b0:37c:d23f:e465 with SMTP id ffacd0b85a97d-37cd5b07333mr5212385f8f.55.1727629533813;
        Sun, 29 Sep 2024 10:05:33 -0700 (PDT)
Received: from ?IPV6:2003:e7:1f11:de00:3518:68e4:bd7e:ce23? (p200300e71f11de00351868e4bd7ece23.dip0.t-ipconnect.de. [2003:e7:1f11:de00:3518:68e4:bd7e:ce23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fdb0sm7219083f8f.89.2024.09.29.10.05.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 10:05:33 -0700 (PDT)
Message-ID: <69e3564e-3314-4a6e-b489-11a96022e08c@gmail.com>
Date: Sun, 29 Sep 2024 19:05:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: Clemens Haffner <c.f.haffner@gmail.com>
Subject: Bug in git-gui
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I think I found a bug in git-gui on Windows (Windows 10 64 bit)

git-gui Version 0.21.GITGUI
git Version: 2.44.0.windows.1

To reproduce: (I have not tested it with rsa keys)

- Create an ed25519 key with a passphrase (--> .ssh/id_ed25519). 
Help->Show ssh key detects that key perfectly and shows the Public key 
to copy
- Push something to a repository:
--> it will fail.

 >  Pushing to xxx.xxx:clemens/test_repo.git
 >  CreateProcessW failed error:193
 >  ssh_askpass: posix_spawnp: Unknown error
 >  git@git.xxx.xxx: Permission denied (publickey).
 >  fatal: Could not read from remote repository.
 >
 >  Please make sure you have the correct access rights
 >  and the repository exists.

- When using a key without a passphrase, it works perfectly well.
- When using ssh-agent with a key that uses a passphrase, it also works 
well.

 >  Pushing to git.xxx.xxx:clemens/test_repo.git
 >  To git.xxx.xxx:clemens/test_repo.git
 >   = [up to date]      rev1 -> rev1
 >  updating local tracking ref 'refs/remotes/origin/rev1'
 >  Everything up-to-date

this bug must be in git gui, as it works perfectly fine via git bash.

"git push" spawns a new window, which asks for the passphrase. After 
entering the phrase git works as intended.

It seems to me that the git gui cant spawn that window where it asks for 
the key.

If that helps:
I'm using Microsofts OpenSSH implementation:

 >  $ ssh -V
 >  OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2

Greetings,
Clemens Haffner




