Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792662760;
	b=lRlfYVL/w2Hy2zjkpuCUZPbT9mIU8i4sm/WvjC3JJOKwU9U7p7uQBBUzz533lT9km+BL
	 nSWjVGQPgUGmj9MjwG1hXFmj48x/LL6/pXkOjFtf7+GktHT08xoLk7E+S/xdHHrP+bFS9
	 emRPE34sv50wEJkqpC503eNksYW9LZsTloJY2ixkvX9NUCDeQbRyI6sX3b5M/JE5fZBL3
	 XhXZJiAe+vTgyinTN1I0vNiMktQIqGAcDtq7U9yCgKMwAas4/cBGCNfKSdzm7FRPqP4kk
	 nMxyRCu1NLOwNyYDxgIKVGVMt+BSjG0NLQu8fdaW+zaSRB6w/o8WcX/qpzka9hoKBFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=StehEnLqwRlw6zsnA9Zb9se/V3Yxkin1ogBTwnpeZGU=;
	b=AZPELJNf7sor/NOolP0QfrZSj3ZvSpR2GMAncj2FrxyblOQFXyZY+l6XWjH7WAC9w+5A
	 353pfsQLulGw/KICnnflEFaUJUhOukLctdku1nL6GLu8S4whWjxGsCAEzCQhIVhDM/hB+
	 F/yHKItDmEVwle/bFyW48MILSfFbXdGxbC127+LLrXiYZg+VkqJMkVBIlsFuIm6HtVHRD
	 6PrFrc/chpM71LxXABUw9wG8axS8VqZ66TXXEW95WhCewbrGgqCoY0X9UHEWCsDxROaqw
	 jb/D5Tqgib5FJiZhL6x5i8BOgf6Z6A8OBD4uxZUDxIHjRPRI9xvamcBh5eQMysllVAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taphome.com;
	spf=pass smtp.mailfrom=taphome.com;
	dkim=pass header.d=taphome-com.20251104.gappssmtp.com header.i=@taphome-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zuBgD5fQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35B606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E35B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taphome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taphome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taphome-com.20251104.gappssmtp.com header.i=@taphome-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zuBgD5fQ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c434376dbebso164251366b.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792662758; cv=none;
        d=google.com; s=arc-20260327;
        b=eigmP8orV3xX2KO5yBnb3iHp4xeBTztAisnE/SnyVsDhfVm7fJwMKtlm9DqVCjhASd
         M8WbOwtiG7P/hEhdgShcqNnsvRJoX1IhJiyZjFPiBbdt1itIUSkb+MUbohOLJ49dPKVP
         9rxD2quCL0R8uaW3N4M+uCZNUN2XkaBkV0mtJCRFPO65DaNfvXW9TeWPwObAH5m2epIA
         MuiVvqQk7nIsSGnRswR+v572fqvd72/rnhF9UYz6pQCv37QSmnmYXXfZrjn5SH8YNWs3
         UeubLdQgg9aAcaQcoLnJX9hUgIr9dipmyrkuA9fL3Uton9cM+Swbc6hy49+f710NC0kq
         O0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=StehEnLqwRlw6zsnA9Zb9se/V3Yxkin1ogBTwnpeZGU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=KQsjQ3vOGNZmQ+CcnoKK0PNEVLGvzH79KT8G2gB/0TpAvX9MPlDMW780kodzDOjnLP
         4P5D5xuThZjaeCi5jh5dn/z5ytbhFP6/4HYAR4CEwwtrAwS/PJ9EOVTMMnv+c/hqbdt6
         sY+V8ijaXxdXoi7PJwKJjmkFSZo8vQ/zeWGZedGZLRz74Hqapd7rFuU/VJEb6pbkxLYZ
         I9dh4SxCsmXOUMDu1vYBRMKaSFEE6g+rH+iYe3k48PPtsSWE0HcYP7fwYYYptibA/4Ms
         EykxE9NfhEsxuZ2F5RQ0Qir3NRHNXyXHNwFzChYrDRuSQFInuz5WUwwv0oYoYmK0Oj5J
         5LLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=taphome-com.20251104.gappssmtp.com; s=20251104; t=1792662758; x=1793267558; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=StehEnLqwRlw6zsnA9Zb9se/V3Yxkin1ogBTwnpeZGU=;
        b=zuBgD5fQ6GQXDw9ybTCLwdjNPOFFeHlZEZLnJi4ZCxVYBcwcwx+DEYKi6TcGRUaCAF
         ADlXkHRFSe/SrvZbIBMNrBOV8ix02d2sobypnDfMo3JwJqNL9lGyBn+nEg9iV1kCSUgG
         LPGcVzW63lyr9SIYvTt4h0RjDLlYnK5pj4KPgbSIy/Bc+slXUDbTSZM8hFQW5EzKVyyR
         ChmY7XrgVUikxjt8M0ScOawpRstv+ScdOofTGwAQYoqeBR2PwB32HIhFyj9F4s30xJNZ
         FaKu1o0c2FAfOOVWoypAlmP52g9fDyvXH4sbmcYuNEJbiADY1LfEg9fpjj26nbe2vvUj
         qDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662758; x=1793267558;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=StehEnLqwRlw6zsnA9Zb9se/V3Yxkin1ogBTwnpeZGU=;
        b=oEiLX+r4iaGeYGD4IWeSetI3zIMW7FgZSxaT/j09pwnlIAp/rwLfXetunaO19szSeV
         jUVGkDUkES7cvElpPsk9B88tYN0cJiCyLIbdCKxpsOQhM3d5YmwpL3pKjgBRjlZ6AP3E
         uKe0pHmqL1Lo4SwjnuqIxfhSBo1l0iWzyDvxp5O7xHT4MaarkhmQhHZBDpG2uXrMXkID
         doOIDrTyrRR3bk5y+6Gs0voWHqLHtosehpKNzDx65VErjhXES5qpo7uTAaMKxcjMFUp7
         otwB/WLVhoqwBL2clIOnP8GCss17ozk6renLmLlb27UaDT4O0q2LEoz6TmEzDc0lP74S
         UQMg==
X-Gm-Message-State: AFq9FYJM4sVR/xBGUb+KzQfE4ypiLHqe8wdViaO4M/9d50RP0VhtWvk8
	OMPGCwCZpzDXEac5SckPG5gk3pStIIGH1FFwGAJULd9dBlj/O6/d/j6Lx1SwuvBgD/R4jeVv2GC
	rrhqFBSHsGtSlzKAnIKmOYKuLVhqzCSp/Lom3Bqccywv5WHdLjjIcGXZwpw==
X-Gm-Gg: AYBFou19dp2l2/8HHvbBt5d8xOA9+ErdmN5cvfTA1hAHsiSBw2Kme4p5o2TLid0Z/f6
	10DOaI14EFj6j/hDZqLL8y9NxQ7IAOYBAUg3UKp3N5NAWrwkwt0mRbclxmZ+ZltY+plVV7Tm8uH
	eGCCN2YJGg/ii7G7J55ncjY+zEW8VwyqwEf6bRYFmbn7lxMx/4qqBsMYVvOinND6x2Kjz9PHLSn
	ETwOMNxyJLiQ2pQqStOiPVs5fC95N2MwNtSB2NKvkHRGIIpyStRTDiZgeyyEPpptIN2nrNANzl4
	qC4KZK3DB61pJfft+QymY4DgmBSrBqDpFD7PLeeUwVwp4LbbPqVSbKYK7HnL55TKazdKOZp07Tm
	3PjAucJU0ww+oa74kIKWIZgHlDYSUVuaiI1ozULONtsMnjMOoSY7s0frvlJG3pdzejSOQ5zhn27
	9b06NIBK+LLXHQMX4=
X-Received: by 2002:a17:907:6e87:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c468d5dafdbmr206955766b.1.1792662758249; Thu, 22 Oct 2026
 02:52:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?J=C3=A1n_Waclawek?= <jan.waclawek@taphome.com>
Date: Thu, 22 Oct 2026 11:52:27 +0200
X-Gm-Features: AclHuK-Rc2norbiwkO5QcQ0yVv4JaYT5dxDvARb4J9RRBf2h-qrT9p1pFdRzFFo
Message-ID: <CA+jzbCGmDYCS5XZmEnYpZ31a-cV5bncR04xv2BXz3eCyhBuCiQ@mail.gmail.com>
Subject: Feature request: update password in remote URL
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It would be useful to have a Git command that replaces only the
password embedded in a remote URL, preserving the username, hostname,
path, and other URL components.

For example:

git remote set-password origin NEW_PASSWORD

Security policies on various git servers stipulate to change password
relatively often. Currently, if a password expires or changes, users
must reconstruct the remote URL with the new password or use a script
to modify it. A dedicated command would make this operation simpler
and less error-prone.

The command should replace only the password component and preserve
all other parts of the URL unchanged.

I am aware of existence of credential managers, but sometimes they are
just too much. I also understand that storing passwords in remote URLs
has security drawbacks, but this feature would help users who already
use the embedded credentials, work with servers that require URL-based
credentials and understand those drawbacks.

Jan Waclawek
