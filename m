Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE8101EC
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672893; cv=none; b=g2baxUGdEkknEGVGQoNLI1hdHeDFGlViG0CRHzRKxc1q0xXnKhxdWeOwldp7DF5N71HEpEM1WJxrhhZRDVEdcKQs85H3Gj3ketrFN6MR4qkQoHStAgzJlmaHHyJlvKXU4vjvfm6IMSmVqcEJQAnTnorFcdR/J8ylS0AU4n5koeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672893; c=relaxed/simple;
	bh=8qY4p0uxCnpbieEcbMj+eIQSi7BrBzdli5B7PP0Rdy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux5rxb+lxempla0d6J9qyLfnPUXa9bD7Og4dRoBzFKrgeFm+ISqO3MYJrZUgqCyBaULfS2bdYQytIYzNogUVf27Q1xlb1sU25VBSUCfBul7LdJyC33hmOVoO3LnsmAahrgjqJquYD7iNZ/Exc++LYbFq7k3Dirs0P6tDZAkUV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuotS+so; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuotS+so"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b97b5822d8so2412546eaf.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718672891; x=1719277691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3pQersoSKfAcZn3ibr4UM6IQd6zeSOb98oqaMYAtr8=;
        b=TuotS+souOAe15Ztakdz8IdMMRv8zwlJetYyDKmC+e+pA2tb2gP1LJIbvSh+pqXT7p
         UeUt8abl6D7gPJL72T4ANxSWVvH2cB34JUkN+tCFrH4X3pQkIij7TuxkBooi30/urck5
         DzFu3vKV2r48llq2ZdgoO+xtOldQGygEeBK3tJmG99RfvHQ3h1a70YUDhq9iMQaDV+0/
         XBe+2Ic94Gii8S/cdDudGQrZCARoewmtUtfa4XuxSXpgIuLaonu2VW0ThC61h3+iTzK5
         YW7yYKC8DaaJMV2Lah7qnp4XbJQSUk9VP7U/mXxXArAcaimn6zLG3nM5i+61GvkWnped
         qj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672891; x=1719277691;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3pQersoSKfAcZn3ibr4UM6IQd6zeSOb98oqaMYAtr8=;
        b=bNRuQYJsdMTBMvEDdODVIicV9G9eD6bQYVUbC1y/fBKqftK6QmwRSnYr282rFcI7aL
         Vtj/sUqdfkxQSGzAW0yJ3kzv3i0qMo5LISGIte9ukjnghWJ2d1jp7e+eTUfo51GoFNuk
         y+vYDeDdsZukqZYjVC+Eq7DzXtosFQLCDACkZNUyh6M/e+2GClaE10rRVvlWaPtBtIQE
         7xFFWdFDH0TdxBl8bOkm2kD5qUneon9O18jgndonrOyprbwCr8x0cBWb4zCJ8pfuVOjo
         kIH69CPcNEVvGnKbLZLBfipPOSsRXuZwKfhMQATmA0NGi9QLNeMD7prla4cyOQYRVbMt
         jzuA==
X-Gm-Message-State: AOJu0YyiAyRkJinUs88XvNIycFDTFzgN+G475LA7RDEgkIJLDqSzfjmU
	YKeTVet1/BqJZxm78cvAa9MmxY2NqwgYclDfrZb/8GkY7WbDs7W3
X-Google-Smtp-Source: AGHT+IFJn1Gbb6JNsJSE/K0a9rG7xMjurLUNHpslWnYHTlTPkRaFaA256D6zOuPizywGeVCFdeYuvA==
X-Received: by 2002:a05:6820:1ad4:b0:5b9:fc9f:6a6c with SMTP id 006d021491bc7-5bdad9fd485mr12268889eaf.0.1718672890894;
        Mon, 17 Jun 2024 18:08:10 -0700 (PDT)
Received: from [192.168.6.104] (mail.3111skyline.com. [66.76.46.195])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c19ff14cdbsm91072eaf.16.2024.06.17.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 18:08:08 -0700 (PDT)
Message-ID: <d5ff3629-ef8c-472b-886a-3ec0dd6a2c9a@gmail.com>
Date: Mon, 17 Jun 2024 20:08:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
Content-Language: en-US
From: "David C. Rankin" <drankinatty@gmail.com>
In-Reply-To: <xmqq8qz376fb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 13:47, Junio C Hamano wrote:
> "David C. Rankin" <drankinatty@gmail.com> writes:
> 
>>    Security enhancement in 2.45.1 have broken ability to serve git over
>>    https and ssh from local git server running Apache. (web server runs
>>    as http:http on Archlinux)
>>
>>    The fix of adding the following to gitconfig (system-wide and
>>    per-user in ~/.gitconfig) does not solve the problem:
>>
>> [safe]
>> 	directory = *
> 
> It is not clear what you exactly meant "per-user" above, so just to
> make sure.  Is this set in the global configuration file for the
> httpd (or whoever Apache runs as) user?
> 
> The purpose of "dubious ownershop" thing is to protect the user who
> runs Git from random repositories' with potentially malicious hooks
> and configuration files, so the user being protected (in this case,
> whoever Apache runs as) needs to declare "I trust these
> repositories" in its ~/.gitconfig file.  What individual owners of
> /srv/my-repo.git/ project has in their ~/.gitconfig file does not
> matter when deciding if Apache trusts these repositories.
> 
> 

   I apologize for being unclear. The directory on the server (valkyrie) that 
hosts the repositories has the current ownerships:

19:53 valkyrie:/srv/git> l
total 60
drwxr-xr-x 15 http  http  4096 Feb 13 02:37 .
drwxr-xr-x  6 root  root  4096 Jan  4  2017 ..
drwxr-xr-x  7 http  david 4096 Feb  1 06:54 arm.git
drwxr-xr-x  7 david david 4096 Nov 13  2023 c_datastructs.git
drwxr-xr-x  7 david david 4096 Jun 15 02:42 embedded.git
drwxr-xr-x  7 http  http  4096 Jan 26 01:34 examples.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 gtkedit.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 gtkeditphmirror.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 gtkwritemirror.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 mtrxsolv.git
drwxr-xr-x  7 http  devs  4096 Aug 13  2023 notesdlg.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 objstate.git
drwxr-xr-x  7 http  devs  4096 Nov 13  2023 pgauth.git
drwxr-xr-x  7 david david 4096 Jun 16 19:14 pico.git
drwxr-xr-x  7 http  david 4096 Aug 13  2023 vect_t.git

   Prior to this dubious ownership issue, everything was owned by david:david, 
other than notesdg.git and pgauth.git which were david:devs with other 
developers made members of the devs group.

   After 2.45.1 update, those with read-only access over https could not pull 
updates anymore. I didn't notice right away because I pull everything over ssh.

   I do have other machines where I pull https copies of repos, and that too 
broke after 2.45.1.

   I read the error from the server log and then attempted to add the 
suggested config to ~/.gitconfig, e.g.:

[safe]
	directory = /srv/git/embedded.git

   That failed. I then scoured the internet and many posts said use * for all 
instead of individual directory names, e.g.

[safe]
	directory = *

   Same error.

   I then changed ownership over everything in /srv/git to http:http and https 
started working again! But ... when I tried to push over ssh it failed, e.g.

19:14 wizard:~/dev/arm/pico> git push
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

   I have tried every combination of ownership, e.g. david:david, david:http, 
http:david and the bottom line is:

   - https won't work unless http owns the repository (http:dontcare), and
   - ssh won't work unless the user owns the repository (david:dontcare)

   Somehow I need a configuration that allows both ssh and https to work 
together. My apache config is setup per the scm-git.com book adapted to use my 
server auth:

## git directory for https access

SetEnv GIT_PROJECT_ROOT /srv/git
ScriptAlias /git/ /usr/lib/git-core/git-http-backend/
ScriptAlias /git /usr/lib/git-core/git-http-backend/

<Directory /usr/lib/git-core>
   Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
   AllowOverride None
   Require all granted
</Directory>

<Files "git-http-backend">
   # authentication
   AuthType Basic
   AuthName "Skyline_Restricted"
   AuthBasicProvider dbm
   AuthDBMType DB
   AuthDBMUserFile /usr/local/lib/apache2/dcraccess
   Require expr !(%{QUERY_STRING} -strmatch '*service=git-receive-pack*' || 
%{REQUEST_URI} =~ m#/git-receive-pack$#)
   Require valid-user
</Files>

   This has always worked great. It's just the side effect of the latest 
dubious ownership security changes that have killed it.

   Hopefully this is just a temporary regression in the CVE fixes? Let me know 
if you need any more information. I'm happy to provide it.


-- 
David C. Rankin, J.D.,P.E.

