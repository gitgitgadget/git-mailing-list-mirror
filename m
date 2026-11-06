Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982467;
	b=wH1gH03CPhI0VRs4FErjh3Tp104AM7kdO/d+Uip5rBxvaU5GAv41QVKtyYw/rjeiom+u
	 qj8Cga16hiJCIh5Lk3cN4HvTVCBSpEYe7+0vFh6XOwyBXHOK/YEWv2WVLsD19Y5DbMo66
	 CD+07MctrClCo7rhecGZyrX0IS3yiqNXxS17YpVO4prj7JUQFG/YdgbObVgVEFaSgkxml
	 9bQzqllcjii0EUdzGtn2Mcx6lCL0+lmnjSbXWgdo4RfXQoF9szvb5TSAGE5T+laQXcx+w
	 m74twLWu1pfequPxTu7pqjWbRoNQ1q2LnnxG1OFg1hp334M+bOQrhdMGnmsVERw5TGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RDTw0Wo2i60bUKc2lfCOD5y1mo+919uxE8vYuKlUbsE=;
	b=AqHlgO6CH/G56KXfrKPB/75gDdk/dUWYZce3n5/1rcQilKjzaV3tgnGvwzW0qHEs/jiQ
	 3I3ThHs25wSRADyP2greR260SN/7HdYFFeW5sa/N3rQ6Jc/w5uZaw+e7p6EC2PnAeIhko
	 /FcHkxWxVSxbEPVuO81cvW0n+4gLtcSsibyxYqXiU5DSyHRF6nFIhI5sBDdCfwS1O3uEk
	 rjvNKmAZyRM5dsknRN/qUOemvZhMPoM3b6jcNq9feiJXjJ6a3KrL1FoaqmChRI6fju5p/
	 4flpLuJXo7oS4VKHwzRWj+et42DEckU74Vs2PiVF5Aruf9N2D7JfL7r3qrlfkK1iCVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L11feUWM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30567606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30567606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L11feUWM
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so2104a12.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 08:27:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982465; cv=none;
        d=google.com; s=arc-20260327;
        b=NWfgMZEbXZ+p1xnIx55D4zsLF+7QfFGGfGKmQHSROfyNU3bplQI0NFPRo+xuWRom5a
         ouF2fs3hQvGYa8jUWu5BzvrjaMQfcXevP2dipT1BnJxKyjaro4qWFzJkUEfv+AAFN4Hh
         nWmv3FcNmWs7hNkF8hbypfR6a56fdYVmeG2yMvI+mQY/87X5tA3sAiWqezIyoD1kEGdW
         9VVCm1R0MutmrezQBO2PewJpjzAN1hm+/ZrPutgTDOUiLsHIXYz7/BLkQaIljzSnL7As
         zeHAlSjhxfueMJ6q655IVNRxfo7DYd+GmjAPGcf77Mp6FMN5zmsrxsK9js5TPBLH/3Ik
         zzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=RDTw0Wo2i60bUKc2lfCOD5y1mo+919uxE8vYuKlUbsE=;
        fh=jLrygO8sq3srlr1WmCBBWtpH8RI4Y5qjVbPUJOJX3Go=;
        b=mVW8l3vSf4ANG77FLnRMwYs9+xQv+vb0K8ENtEiI5OZcURwdPLF9182lcrz3zNpmzC
         6Ga0IX6fOIqfcSu54nqn3RToWJrAQMRTtbDmYlD7GLn5o/xr+scU4KvjG5lH0kAdLUIX
         TWu79AlNf/EmrrJ6D1uW6vkYOYpnfgi7sQAG0axHUbFVh6t9pfG76au4ol88XIC1OSVj
         0AU+wMlhNAe7liDJTjgUbRFl0FqXwx0wzUeAuhtP8ZWX0cHjUMXGtooNChe3E07kHKcs
         VKZt1Vz+3eqNXvHwAFaSiVcwhyypFtNDKBIkkfzOEA423VjCWq3VMzPEYEPRPKGS+KFk
         PFuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793982465; x=1794587265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDTw0Wo2i60bUKc2lfCOD5y1mo+919uxE8vYuKlUbsE=;
        b=L11feUWMl5DsdVgWno8us2q1xLKc3qEEF7ORQLVHQGBQ79rmAJo+OplI6MgU3A+Q6u
         k3z/c2HHe6qV5bvMSb9yl1g6q11XlAmRaMb4YTxJXmyCAVkzuyliGRWQf5IU7wczMkSf
         cgPQvxjFllCvYWlF+2sH9FHGxehoShVUTrSh0dXSKHhe1yAbyfo82cfUQOemjRiLvQZ7
         T1ngRgezUiR58B072AXuAhPxrUO7xufL92f1hSFB7L+KeApFqu1xsmsMYIRWy9peZUTp
         oruDgbYvXFLF2sl6wP/zV9FKtIEtSdXQvszEYNITYkK9LjT8adXfulwMs0nbhi0hrtzk
         G1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982465; x=1794587265;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDTw0Wo2i60bUKc2lfCOD5y1mo+919uxE8vYuKlUbsE=;
        b=DPpD2crEbcMOx5kVQ0W/wKTSVq7qLJuffMOivSmxWhE7d5XyDJ0lBGb8mTrpLKvbJv
         YEb6sbRHG7qN+Cf2/UCgYHg1i9xxjwZBjzeppQjaMyEc+exzTsg1C4i03BNRYNj8xuo3
         /Q3W1yHsK0kN/x+J6qw5QI/T8PNqL+ZxrDWTimSWGgKDGMac+1giHZBuyaT201jjE8UC
         s+rbHATNjfl7djoveF9kNvXMpKTKzcWwDJUFlG5xL8czJcjuKrHJocC23w0T1CcLxNJq
         mrljfeDALbVdpot59AvYNJt3tMM48YnuSUBHTZGpY4mVmwUO1vdTs/S9BenUt7fVSqtr
         eG1g==
X-Forwarded-Encrypted: i=1; AL+hErE5RQG5tSeJqji0VjnnxQAa6jnHmw2m6TIDaTPuzypQwBF+EqskvB1emnhS+lku1v1thsg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g3gRSB/eCGgBH5hUJPAC1ewayaflbquciw5Nn3Jb5VxT1GVuR
	csny4ZG8kbxSXNFcrgh30diVgoVXRGj/qay2jdSS7f5BFJ6PMmeGTIFYDOIpU5PvuVA3m8eCPCf
	/e2HHD9l2miFks0uh/1b+Pp9xTIm9bLhBnpAU+OLZ
X-Gm-Gg: AYBFou1LugbrIoF6eyVGKgcjWC3yH5nzOUQ9rc3RR84vKT8mZmRd3DJfCGSG2jMA06c
	KK1OAYJuaNoBZgpTrfpsnq3lwJxC3Dd7xe7MxzQ+T4rMT0LPUEeo7Pk9PKtlPnjP+dn3RPqbG3s
	FCB9lImZfIdMuIsghCwbtTZK/qHvugmHLN9uS7Qh/ARrY2AAFTrTtKyBJFENYwgOf3UxNRqmAf6
	dSE7BAUCnRv5WSRYWwPRr0x3y4R1XaI/b3RUjk36FTb2IhTdbCdvlBSGi5z5xs8njTK4agzooT8
	xxC3QbBQIoSTCq2HExeb6bSOzsAFcKh8XUWxsKhBtRrFL68awyYwKr9NjnTXEuEzChpVcXZSCpt
	C4KJv5k3q2wZZYmEZLtEWgML+UPsCr/3ATe5oKRaopYIaCWPPk+joz4fSdkBDN4Ek3agv2T5s19
	V4i+usqQKI2g==
X-Received: by 2002:aa7:cf19:0:b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b6f6e1c4b5mr11182a12.8.1793982464889; Fri, 06 Nov 2026
 08:27:44 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 08:27:44 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 08:27:44 -0800
In-Reply-To: <au0EE96afsApvfZM@fruit.crustytoothpaste.net>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com> <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
 <auusPUaYRmUBDsdI@fruit.crustytoothpaste.net> <CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
 <au0EE96afsApvfZM@fruit.crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Fri, 6 Nov 2026 08:27:44 -0800
X-Gm-Features: AclHuK_jj0VBQKSqGBabgBXyVn5b5cTRic4iE-wlG9r1pY5Yg_bztABcv9i3Z_c
Message-ID: <CAF+mdifMUi2EZHU2tRzLr_dw2DwWa0UyPb5bbvk-SuMUYC2+DQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] http: add exponential backoff without Retry-After
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I can't imagine a situation where 1s is a reasonable backoff for a 429
> response since I can't imagine how the load could reasonably decrease in
> that amount of time.  I suggested 30 seconds because that's a reasonable
> amount of time to back off and allow load to go down (and I think that
> 30, 60, and 120 seconds is a reasonable set of timeframes), but I'd say
> it should be at the very least 10 seconds.
> ...
> Note that the curl binary often makes very cheap requests, such as
> static pages or small files, but we are making what are almost certainly
> very expensive requests requiring a substantial amount of server
> computation, so the curl defaults are almost certainly not right here.

ACK. In that case, lets go with 10 seconds (10s, 20s, 40s, ...).
Waiting 30s, 60s, and 120s feels too long for interactive commands,
whereas starting at 10s still gives the server breathing room.

I will send a v3 with http.retryAfter defaulting to 10.

Thanks!
