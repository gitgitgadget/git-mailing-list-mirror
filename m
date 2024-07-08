Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE23156E4
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433239; cv=none; b=hcsM+R6ONiPCdUF0h60Q/zfapS1veg9SGHZqrDzFevkD1qBkk5H64TUKwNWzGf7eswPHo9s1cT1od2U3hvylVBoCKIuq8fBERAZZvW08tdf02XdZYrb7P3oZX6bk5fXiJzSj3KsEQp05euoxZpYD2Iy0jcMPaPkQHQqlcwE/guY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433239; c=relaxed/simple;
	bh=prWjzje7L4Uf+u+HW+AJ8y2m9/sX2ZikSWWeI7xow+E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PicMBtMLut1K8oPdGi5yaHfdt7P4B1uDHA2FayMgjhiOXzW/1C5ZG0J5cdrModh2R6jNdUROvZh80w0ZD3I7QUdBx7XXuurGjLl6byF1aTBA0GCHi6F9Vda9fyAihsbxINAzGVS7uN5KtJqjPYHWxIV1CipD5+LsW2rAnF4lMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJwLPDkw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJwLPDkw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36796aee597so2403027f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720433236; x=1721038036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:content-language:from
         :reply-to:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=quJpypoucGbwLf8LmLiX8khrxC6luF3UeopnW0ESiVA=;
        b=GJwLPDkw1DCTBYJXSv9gQbj+n7g6so5S4+0NFnePeBwddh/F/MUj/U832Na26VKRLa
         pMMymWcPVcXX8x0xPsVzgXKBKJFr7BCK8a536hJLeb7DBZDhPdwhFix1p+suhFQibrUN
         y2CVXtrExvSmpv8VANcP9dXz97gCLrKbNL4ythbE8RY3a6jWpOlwO/HOXN3UdlxjqZXU
         xogcl1muxMCFwkuPzvZG/WXxBkCdP+tELYtzfd1ksnrE3gO2lzKfy5b7LOqjjOOcS6ck
         w473YFS7EsTLh7E8ihHaeirH6PrvcGT/evvKSBBws04tLsw8kV559jvGza7+eFF8uCNa
         djNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433236; x=1721038036;
        h=content-transfer-encoding:cc:to:subject:content-language:from
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quJpypoucGbwLf8LmLiX8khrxC6luF3UeopnW0ESiVA=;
        b=pZ/ZVihSe/y0sXKntxyWUwkoNpEGgclu/tSLkR7T5Sv/4DPrf6HnRUxKlIPbS5grpn
         fNtmeovtrQoIPgLPwEY43tP+hSF6SGmHJi4C4lRvZP5dSU4XgOGRv5dcoisqZU4t8/0a
         w/bjxQ/UoqtLLxUTa+Fu79gJtCA4rE41/en12ujw6Q4/rZTUOtCzA8kGS2NUP7PtkQng
         chJUgMH5/W0K0Y1c51j4ZqbL+ccKdHLp7yfy0NpAf7kc69W5LSZLP6Xb9Ol6ReVQcGgl
         PlQezNsR+oaE8SGuB6jatf3QWA6qhwjwM/bU0oc0OgIVrWUohfVdnhv/K8rIcpwDE1nX
         llUA==
X-Gm-Message-State: AOJu0YxfxgNGfu0JocW46OP/Cc3geI6WO6dyEayNoBglLDCG7nerGYDc
	HqtOR7gH8v9/lylXQIoo8hP07YOFxliof/N8kJauxEUp7+MVmAQ0aQlN9w==
X-Google-Smtp-Source: AGHT+IHG0Y+N6f/cCJj3M0+J2tha/qC5FaO3z8sv4/PRH3Lqa0bw40bOWnBKoa1tzkAqMqgooXiqgw==
X-Received: by 2002:a05:6000:184a:b0:367:9037:d075 with SMTP id ffacd0b85a97d-3679dd35321mr11123056f8f.37.1720433235914;
        Mon, 08 Jul 2024 03:07:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61c:a601:7f88:feb2:513a:4c20? ([2a0a:ef40:61c:a601:7f88:feb2:513a:4c20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679f9783d0sm10230820f8f.9.2024.07.08.03.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:07:15 -0700 (PDT)
Message-ID: <cc267962-ca2d-4c4a-9ed8-d40c4d282522@gmail.com>
Date: Mon, 8 Jul 2024 11:07:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Subject: BUG: "git var GIT_SHELL_PATH" is broken on Windows
To: Git Mailing List <git@vger.kernel.org>
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Sixt <j6t@kdbg.org>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Running "git var GIT_SHELL_PATH" on Windows prints "/bin/sh" which is 
not very helpful when the path to the shell is actually 
"C:\Users\gitlab_runner\scoop\apps\mingit-busybox\2.45.2\mingw64\bin\ash.exe"

Support for GIT_SHELL_PATH was added to "git var" in 1e65721227 (var: 
add support for listing the shell, 2023-06-27) with the aim of making it 
possible for external programs to learn the location of the shell used 
to run the command returned by "git var GIT_EDITOR". As the commit 
message notes this is especially helpful on Windows where the shell 
isn't necessarily in $PATH. Unfortunately the implementation simply 
prints SHELL_PATH which is unused on Windows. As 776297548e (Do not use 
SHELL_PATH from build system in prepare_shell_cmd on Windows, 
2012-04-17) explains the location of the shell depends on git's 
installation prefix. For the git-for-windows builds it looks like the 
shell is always in "$GIT_EXEC_PATH/../../bin/" but I'm not sure if that 
is universally true.

It is possible to work around the bug by doing

     git -c 'alias.run-editor=!$(git var GIT_EDITOR)' run-editor

but it would be good to fix "git var GIT_SHELL_PATH" or at least 
document that it is broken on Windows

Best Wishes

Phillip
