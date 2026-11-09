Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234691;
	b=n3kNwVBF2qHvrKEdOd5JgDFkM2rUk3bMHu0W2YoEbnUl/BYcGesGskBEqPSHjyXZ/eP5
	 Vq/sEz93rGqkEPG492i8JyQ1xVy6LHEUfKxZUAh8gl1LPh0hvFUH9ZEaMCcNprb0/rdOo
	 fxlWqbc+fAz4ptz5XAH4pS//YOSGuARasMjqFsBPA3O2qKVfEIvCR/WX4OJPZWVBBMgoM
	 9PehgNFMmhU1YPmopllFCC1Vwgw8bZ+d3D07XewGQjWRV2FP3j2c3uZl5+A88b6xfhMH0
	 ywGiGCiwC38UYJUIblHZVXFXgeuwwwuuolvQiNxYafOKPU4Y76Q26RtTuEcpBFGIrsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qGzM3vkyInnOauOJzYeqnBs8u1ZporcjID02LOUBHx0=;
	b=fohpqv0rZ455FcT434ePbPwxCR4VxYeOWKJTVTcUANIX+pqJK7zVqQTHHiSHI5GeFI8h
	 cT81o3PXekWzEMMjiz/8LceD+25UDuAInaTZaU3KfXRqRaj1QmfxsYBsNxeIgJ/J6pzdA
	 xBDjM39u7rUe8JxvfMULBsu7It4lKM8VqLmJlS+8zpZWHzQf5rrh3YVgmpEADtKMM1fqR
	 gETgFdYuoYCludOFGRReh59wRXc8cIzXc2yTeGEmd8vdEoxBImS3spv8PnbzgXWzsvy2T
	 5W0zAFjCGKOaIAbQNKbizsVni+8yzG+JGVbraAbClFP497a45JWyWSOZXdWF0GK5IrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PZlepn2v;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE3606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DE3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PZlepn2v
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso600365f8f.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794234689; x=1794839489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGzM3vkyInnOauOJzYeqnBs8u1ZporcjID02LOUBHx0=;
        b=PZlepn2vVlnRCf2DDxE+TCe/80YTsz/muoCA4ppIwwu53a+1RVy5ZeOnaKzxfRcriU
         yCSCug1kOrWRLWTJw1/8iwXfOOyR2E8Oo4vJ9/yT8cjywVwrr48uXjE6Rg+SkyhjP4Kl
         Ji2nKkXGAvqgNKsGSjPNLoo13O6htp9NgIQhRBSp2W/ktIiTkIoNP8E7V0V9Ams4QYve
         Zm7NDtgxfk2TEi022PrkL4D/hzvPzheOxfcuBrAIgsicdhb2Jawq6IturDl60nvTIObB
         XOEFRZLNPdmxodhLlWlPwpeahBJNLqKIc8O8Xs22+hqPLSbWFQHw52WxEzuNHR2BN+96
         bHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234689; x=1794839489;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGzM3vkyInnOauOJzYeqnBs8u1ZporcjID02LOUBHx0=;
        b=VXtGf9jqD59hQHYPILyQs81I9cV67y3SiPyk1ITMM5DBG+DBneYHJpokoihfdhW1ap
         /ibBtp+SyW4QgwouBlCQlk3lhsh1shL4GEiuv/vv/ANEsMufjHRRxaUdsGdSDqCKYLJ+
         1jMS5rEcN5sFWVhFhFlYvooZpKohhiqmbVpAmemdYymbCjR3557+cwTmUH+t4CcFhV6a
         F/5Q8v8KxNzPQz7UYQrCqavbYOTANI76vhpE1SPQihzZsDVa3l4wjBcfUYZADoh8EfP+
         38JX8bJEICLLIiJg6im+w7LiUPJNYSN/H+3MFmMRDoEqVfAepG1ZEVCGpOUjhJa2ajLa
         yt6A==
X-Gm-Message-State: APuU4Z8YdGYuJ95euGBBpktb/1+PRXOHpGuuHulaYqLXjHaACoYPNQcv
	5CljOG/bfJ308sR6aKTqWGAey2XbPc7Uf8aC0PeNdSMF0cwV8+cVildw
X-Gm-Gg: AYBFou2LRXnYBsu0n3DdmC5X0/ycLDtCN3KLuwTC22qskUpQlH8LELwBynebopWWXXb
	zjwedithzXdzaPhM6Qf+RMfppErYWIgPuIeuJPbgjNhI1zbwjLKEluraaUFnzLA+xMnKjYFXZxm
	pq/zwIf0jgSP4a0FndbbxpszBrLKdUmJAOdVDDeCnSJeEiNv9Siuv1u0lkdCxHcnYzG7egHArVh
	BhP0OtnLBAPUZnibQjrE60b417Vp9UDgGAK8v070ulTfkdubjnG3jOLsYZUHXAP9ueP2hFE6Mmq
	y9uEXZqgxpIX7vU3RZ7gcK3ZrvevhZxTaSVoXr6iuJgGSezNoVSTZIxUFyuZJ34rhHU5cW7boJT
	TiZNd+4AC+LbKYnjBgGiryykBTnIAqZ/pgYDMat8St5IVszWQyfcau/dLCM45QGvSKDV5sIjrKy
	qj4LC8HzqbtvT869NeqMsJfcaU2sG5pJNUvYGrQGs93VycqugdFiCPyhQteNKoyuME/Xw+sRnVW
	h4IBLaOslRJJ0BTRRBLKLXlwzk/YDN2xkD3j/M5tnI+ADVBlKEx1uzj41Mm42GNhzi0+sTrEqiy
	WyQGgciFuGvPKfQk4iWK/TaYxNofuvh+NYdWB5X0nCyGW2KzKKUodu7OIlUHOVLaDJKELVdwVjB
	XaQ/iNg==
X-Received: by 2002:a5d:5f81:0:b0:491:f77d:47e4 with SMTP id ffacd0b85a97d-49585f85839mr8895526f8f.49.1794234688851;
        Mon, 09 Nov 2026 06:31:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596acf59esm10583463f8f.23.2026.11.09.06.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:31:28 -0800 (PST)
Message-ID: <d5bb8fe0-7706-4e3d-b471-ad004411a9ed@gmail.com>
Date: Mon, 9 Nov 2026 14:31:22 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
To: Tanga Joris <tangajoris@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, jackrawlings2011@gmail.com,
 christian.couder@gmail.com, siddharthasthana31@gmail.com,
 kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com>
 <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
 <CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tanga

On 09/11/2026 13:13, Tanga Joris wrote:
> On Mon, 9 Nov 2026 at 13:52, Phillip Wood <phillip.wood123@gmail.com> wrote:

It would have been helpful to retain a bit more context here, I've 
restored it so anyone reading this could see the patch that I was 
referring to.

>>> diff --git a/f b/f
>>> 
>>> new file mode 100644
>>> index 0000000..d00491f
>>> --- /dev/null
>>> +++ b/f
>>> @@ -0,0 +1 @@
>>> +1 

>> To me this looks like a corrupt patch because we have a blank line after
>> the "diff --git" header followed by valid extended diff headers. Now
>> that we accept this do we respect the file mode?
> 
> No, it does not respect the file mode. "new file mode 100755" is
> ignored and the file gets the default mode.

So that is a good reason to reject this, rather than silently applying a 
corrupt patch.

 >>> diff --git a/f b/f
 >>> diff --git a/g b/g

>> This is the only one that I think it is reasonable to accept - we have
>> an empty patch for "f" followed by a valid patch for "g"
> 
> Alright, I will keep accepting this one.

Do we accept that now, or only with your patch?

> For the next version, I plan to die with an error when a "diff --git"
> line has no header lines after it, and a "---" and "+++" patch follows
> before the next "diff --git" line. The error would name the line of
> the "diff --git". An empty section followed by another "diff --git"
> line would still be ignored.
> 
> One thing I would like to check with you. On master, a blank line
> after "diff --git" is accepted in a patch that modifies a file. If
> that patch has "old mode" and "new mode" lines, the mode change is
> lost. The rule above would reject these patches too. What is your view
> on this?
Oh, so

diff --git a/f b/f

index 573541a..d00491f 100644
--- a/f
+++ b/f
@@ -1 +1 @@
-0
+1

applies. That looks like a corrupt patch as well to me and if we're 
ignoring the mode headers I'd say it is definitely a bug and rejecting 
it is the right thing to do.

Thanks

Phillip
