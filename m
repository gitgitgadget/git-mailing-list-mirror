Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F431391
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718584624; cv=none; b=QEA1GkDyR+ov4J/ndqxvnFejHVpAYCiKhC8EP0C3L1kzCOxl3EZq+9z7N3UJ3ZtfA6f9rmb3oeWdWnQVUY67wryPI9ItDH1PwFzuj1BHh/akzHUVGTpQSe8mexsi+GTQRaE7fuw9rw6S2envHlVh6++URkFHmtgzul8Ma5kFL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718584624; c=relaxed/simple;
	bh=alNG58mjgreCLZh5dTwR23GYE/JIdUFKC26wdbMUkvM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=F+PKwwu8hwcBR1JBi3OFu3joa7PTTEbFRMGr0ShhFDz0d1Q5vj42Js0zcKUGQLdQlT75IUMNu4Kc7m9ViSwbf7xOfQD7AjrVlTp5vLFDEVPgovT3oP9k9ifgEHhesCDhvmgSGtIEfRhWw/HLfw48J9kxaAm4KTkgIpddtARSN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuGKoNfI; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuGKoNfI"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f96f8489feso2223285a34.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718584622; x=1719189422; darn=vger.kernel.org;
        h=content-transfer-encoding:disposition-notification-to:subject:from
         :to:content-language:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3si4vLlMzroUNIB2BzeoQ7tyFaamcMarmxML5rlJGlc=;
        b=BuGKoNfI6DcDxxHSU9oQraqzaggCAV5oR55vRT95gQXhrwFxtAVlabm5R13RwXSTP1
         w1gNncv7tj93jFxTRYw1Xh58lLoj2QfrUfc7NFydAIdTUIWlCFVivpn9ZTaaJ9/yAfdR
         ZpvSB1uYMNQ5NBmAGEUV+JiON6bd/pNouHz5Rz0bsKEmNZBHN3mnsjewvvPgV4EJRWle
         kkyWYySjxUh56f4pDCkvJOqUmRhzEMx/LtY2+mAnYqZj46qqkbrnxEEGUdNyDY8uAL1C
         Dtfh06M97QJOHfB8wKE/qB6+AOGIOKBKsgN1Y9eqY1Jb7OSjzQ8VWZtTOm8FJ2FsyoUV
         9u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718584622; x=1719189422;
        h=content-transfer-encoding:disposition-notification-to:subject:from
         :to:content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3si4vLlMzroUNIB2BzeoQ7tyFaamcMarmxML5rlJGlc=;
        b=Phr0N/7RKEbvSrlY8SAjurm0tMalj1ESuidqz4oy5+WSt8gmWrndbvrQVh92Lkm3wU
         oGoiBYnu/bKZ2WDWR4/QUMlLLIlBDFBerp2K4WpRJkTYMCI/8ujqLR7B/az7eQPfNNpy
         0EVcvFnMZDw5GkYRC01tH5I0D+aoH07eLAj7/369KlJzb0TZniDimot2tHTY4HWnnzWx
         61x3ryDwdNUB6tS0okxcVl4DMVCVPmpbSedHHjAUfwZA6FkrQwtDFCxELjIeS6c8pKtS
         MQ+DryE62/db1z7U26FiWO574aiSMHqDH7iJv0GtB5uUsAdqSHBQgimQn65r7zuL+7xk
         jQDQ==
X-Gm-Message-State: AOJu0YwLpYvXuLk/dtTgon+LN2hTk8lepMIIO+RwIXmCrrs1WA8C866O
	89+9/6BywEq1UL7s8Ti0wqFCgrq4USfsGVaDd6xjSP336WsiDOGTXlmRTQ==
X-Google-Smtp-Source: AGHT+IHyPCKJmeRYFA5iPGm9vXvEHQ01XKLzo5lRZOHCzRMp8+1VA3g8DYNawmHfE8/IrT/BrmCT9w==
X-Received: by 2002:a05:6871:4cd:b0:255:52d:44b1 with SMTP id 586e51a60fabf-25842b1e9admr7567234fac.41.1718584621262;
        Sun, 16 Jun 2024 17:37:01 -0700 (PDT)
Received: from [192.168.6.104] (mail.3111skyline.com. [66.76.46.195])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm2317502fac.41.2024.06.16.17.37.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 17:37:00 -0700 (PDT)
Message-ID: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
Date: Sun, 16 Jun 2024 19:36:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: "David C. Rankin" <drankinatty@gmail.com>
Subject: Local git server can't serve https until repos owned by http, can't
 serve ssh unless repos owned by user after 2.45.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

   Security enhancement in 2.45.1 have broken ability to serve git over https 
and ssh from local git server running Apache. (web server runs as http:http on 
Archlinux)

   The fix of adding the following to gitconfig (system-wide and per-user in 
~/.gitconfig) does not solve the problem:

[safe]
	directory = *

(* or the actual /srv/git/reponame.git makes no difference)

   On Archlinux, all repos are served from /srv/git. This has worked well for 
both https and ssh allowing repos under /srv/git to be owned by the user with 
public-private ssh key. (they are members of group owning /srv/git with write 
privileges)

   After 2.45.1,

   - git will not allow https unless the repositories are OWNED by http.
   - git will not allow ssh   unless the repositories are OWNED by user.

   A catch-22.

   I've tried every possible file repository ownership of http:user and 
user:http with permissions of 0775, but no luck, it is either one or the 
other. I've even tried making users members of the http group, but ssh still 
refuses push unless the repository is OWNED by user.

   The errors run the gamut from https attmepts:

$ git pull
fatal: unable to access 'https://www.mydomain.com/git/examples.git/': The 
requested URL returned error: 500

to ssh attempts:

$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 1.01 KiB | 1.01 MiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: error: cannot lock ref 'HEAD': Unable to create 
'/srv/git/pico.git/./HEAD.lock': Permission denied
To valkyrie:/srv/git/pico.git
  ! [remote rejected] master -> master (failed to update ref)
error: failed to push some refs to 'valkyrie:/srv/git/pico.git'

   This was discussed on the arch-general mailing list under the thread "git 
server changes - how to allow https AND ssh now that /srv/git/xxx.git must be 
owned by http?" at 
https://lists.archlinux.org/archives/list/arch-general@lists.archlinux.org/thread/3GCCU6QZNGRY45WMQAQEVF572AIHN646/

   There was a suggestion to try a bind mount for the repositories, but that 
seems like it may introduce other issues, but if that is the correct approach 
I'm happy to try it.

   What is the correct local-server way to now serve repositories over https 
AND ssh from Apache without running into this either-or ownership problem?

(gitweb continues to work fine)

-- 
David C. Rankin, J.D.,P.E.
