Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319084;
	b=fuBdrQ/GKHJvE6EBUDCjuyzrnxgSF+fiJQGeFFtU5yPd7x25CG+a6scwmW+meGX1atR3
	 cDhbaDO8TgTQPJs6b4Uod7EjSj8KhUqa187SFG8jiX61PDJSh3c3v/9A881bRJ4Or/KZF
	 W06LD96YbkHs3hvOoq97hIz3T3cmw87v95ESqjcKdIR0AgMDp80UxGIhtItSyEkSJ0fNF
	 tEcS1wMKrNrq0oK9MTZezEEyJhpSoN9YqVP5dNoLLwKyYR1EDi7TqfYY5AuP5znFb6MBK
	 WBBrewyc5hZYKYxmrKrczKT28q58k8CK0KyUi/1uhPdCQqtR8ebpuCv4QKFdoxR0NeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tQBPKAYUA7wYHXTtFxuOAWqmB7lHQ3Y/QebKzjtCgMs=;
	b=tVeioKE7ejugp5nGShmCZf5mutnBDmudwEiquAAcdU2h/f02o16iq/KrLwnmEbem3hG2
	 pwUEvzsX1s1MZ0O4H2wlY20UiCByt4dFunWdbyWhQTDbX15S+F0lHfCOfh3dLC9ELv/wr
	 zfN4d3wTjB4l9pl5TkOFZm2cGCtsM9MrwCdtkL90tO9vnJzU9sy/xPnq74Kl4lxYvM3mj
	 yXgNOa2mQf7gQFJzSA++5ME5t9wNLjCM5aU+Mpy7ecgu4q0mSDumgWGgbP3M0VDGo11+f
	 TfOy0gcYa892HDh93CXD2cZYUPyKyIsg0sGrkH564T0v8mZTKEwG/eCanLrJ+MF8MXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTmiYDgL;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF4606A336
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCF4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTmiYDgL
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37628596783so233975eec.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794319083; x=1794923883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQBPKAYUA7wYHXTtFxuOAWqmB7lHQ3Y/QebKzjtCgMs=;
        b=JTmiYDgLqqN4+yM+81lE+qpwzFUqDvpFuHT+Y/n8O8Vzjvj7Z+238tc7eER2euFtCV
         JX99ol3WriyCsy0cX/TB+ztpBewe9rMknYDVPhisnZ8LImUG+yEmb3tl4z902xabnZWU
         +aDMeqoDsngo7fel93WgL3EI++mH21K5g6VcT683qpHNkrfKWNhM4r42J75CEPIQwN8a
         CYXs4m5760MVOWkeG7TncItTvFBl9oaOo063rg2MYuda2pTPyY64fD/P+xTYpGPiMwgH
         RfgtJdSkP4jizJH5n9l41HGycfasHhCpgFvgoqIM+6rbBtXe8cRy5QOa02rQsyhzOPVz
         lb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319083; x=1794923883;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQBPKAYUA7wYHXTtFxuOAWqmB7lHQ3Y/QebKzjtCgMs=;
        b=d4OncnKj93a8COaVKzY+HANifRBTWl6iAt+zu5YVpiv3Y6cX944K2gpb1Q9EQwra53
         1H+8Sq7vgBC2Qs/izSxkRhJh28/IKG5iWH4dqmAGq77lJEbVsfK5fzwedIsT14izE7bv
         3KvocJpUf/OuNyqdPduGJ5PeTdsfX2X5ruAPUbyUK40hq+M6E7BnlLRaVCA1HMsPt+zF
         foWDh5qX/B4Xg7dRr32RqJWIvMoNOVWwLzwimewBmp0eURaZhXHYtD+3PDZFtZW+wlEc
         jJDYiLgJuEUEIGQFKuxWOxWzywjm7MzELerEWBVKP1BanYnZDQfAXjtRRsWnKzeVFFaT
         yxfQ==
X-Gm-Message-State: APuU4Z/9B7Kl2Aj0/9fle5Db5BeSv0g1NvB49kwDVLqNjVPHSzAlF5zk
	F6lWpiqM8YmAxeGJFWnNLelSHX4HDbUx3PkcbmWrq/4LuqKJZnsbCZF+rumZg7wH
X-Gm-Gg: AYBFou3iJdASpxtp4xL8o1UeAWKqaajTGAILNk9DbWwiZ88PckTCfI6MjBuVEduoSzf
	4y9Txbr+AL4Jtz+2PZhOhlc1xFna64efy97k0gMBXZKAhrdx+KQJFSWHst7kPbidQQld2r+2I2R
	61MJwyqw532x+VY65wHL5duzi5y8jv8CsTMIuUk/eXWR00dRWb0R1Q8hDJR+sB16Qw6y3pn6JU0
	/dhWBg2KEvhWd1Vi9S929p5pd577X4FQLcMKWFFQ5guv4HIhfw15wKIsckr4tY9JMZiQV03weYF
	xEX0pNRSo5lnM565fc156VVV9SZ6Snw9Pxil0TIqMnM5z7eFTHEdijozzmSHMwGDvOoc8Yz5PWe
	FDGZjcPO27fHFBMcdhxo29/K+Cb7BaMlm6qMXylEGIIHSy3GGmgZPf5AUWSGCj1kp+pDsgZRTVJ
	wUnYCpq5kUSVIdQHwz1NXcD4gmiqRZTeL/7CyNd6PennZmICGKMdoFQABUCCKO/y+nXWQQje0gR
	I7Zw/b6i4ivJPy9ApXT/tvS/ghmEFsGxoxnEbdkoIUzS6+Kwf7XEir7BqoimaHF4WrNWvOsJUMH
	RlMt4Y3RFXxf08GI22xt3XJ0tAf5Ik0P4dtzIVBmXLpJ
X-Received: by 2002:a05:7022:2208:b0:184:992:c9ec with SMTP id a92af1059eb24-1b3b6195445mr5013167c88.38.1794319081612;
        Tue, 10 Nov 2026 05:58:01 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm16073358c88.10.2026.11.10.05.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:58:01 -0800 (PST)
Message-ID: <79a2222b-2087-460f-b4c8-c24c3b7c087c@gmail.com>
Date: Tue, 10 Nov 2026 19:27:58 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] object-file: move iteration over loose files into
 backend
To: Patrick Steinhardt <ps@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-3-fbbc86c29693@pks.im>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-3-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> The logic to iterate over files part of the "loose" backend is contained
> in "object-file.c" even though it's an implementation detail of the
> backend itself. Move the logic into the backend accordingly.
> 
> Note that the function is a bit on the weird side: it accepts a generic
> `struct odb_source` as input and doesn't cast it down to its backend at
> all. This is because all it requires access to is the `path` member of
> the source, and from thereon it knows how to iterate the subdirectories
> of the "loose" backend.
> 
> We should adapt this function to accept `struct odb_source_loose` to
> properly reflect that it expects a path to a loose object database. But
> that would require changes to a bunch of callers without much benefit.
> So for now, the function signature is left as-is. But eventually we may
> want to change it once we have reworked a couple of its callers.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/count-objects.c |  1 +
>   builtin/gc.c            |  1 +
>   builtin/prune.c         |  1 +
>   object-file.c           | 92 -------------------------------------------------
>   object-file.h           | 44 -----------------------
>   odb/source-loose.c      | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
>   odb/source-loose.h      | 33 ++++++++++++++++++
>   prune-packed.c          |  1 +
>   8 files changed, 129 insertions(+), 136 deletions(-)
> 
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 3f7b20fde53..aae040567e3 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -14,6 +14,7 @@
>   #include "quote.h"
>   #include "packfile.h"
>   #include "object-file.h"
> +#include "odb/source-loose.h"
>   

It seems like we can remove the include of object-file.h while at it.
>   static unsigned long garbage;
>   static off_t size_garbage;
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 81cecf6b6c3..d3ba6f0c9e9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -31,6 +31,7 @@
>   #include "packfile.h"
>   #include "object-file.h"
>   #include "odb.h"
> +#include "odb/source-loose.h"
>   #include "path.h"
>   #include "reflog.h"
>   #include "rerere.h"
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 97f4c1418bc..af2a547d931 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -17,6 +17,7 @@
>   #include "object-file.h"
>   #include "object-name.h"
>   #include "odb.h"
> +#include "odb/source-loose.h"
>   #include "shallow.h"
>   

Ditto for the above two.

>   
> +static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
> +				       struct strbuf *path,
> +				       const struct git_hash_algo *algop,
> +				       each_loose_object_fn obj_cb,
> +				       each_loose_cruft_fn cruft_cb,
> +				       each_loose_subdir_fn subdir_cb,
> +				       void *data)

This was made 'static' during the move but that seems to make sense to me.

> diff --git a/prune-packed.c b/prune-packed.c
> index b6749b8d132..d0a8a062b97 100644
> --- a/prune-packed.c
> +++ b/prune-packed.c
> @@ -3,6 +3,7 @@
>   #include "git-compat-util.h"
>   #include "gettext.h"
>   #include "object-file.h"
> +#include "odb/source-loose.h"

This could also benefit from losing the include of object-file.h

Rest of the patch looks good to me.

-- 
Sivaraam

