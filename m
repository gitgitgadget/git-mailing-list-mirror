Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20014A60F
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022718; cv=pass; b=Szzsn81SCX7khamuff7pzL9FXAfkmdpAVL9K2dp7Q+8hM/sPFAC8UFE71P+IO4EhxVfhzC0NxIQUwwgGTP/GBgZBZ+Z11sWPqSD6BW7xP6irzJKHEkuFB2FD1sQpWOz3zHQhu9e5JqyDKn5Hjes+1q3WSjfwstlXCPKvf83AORc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022718; c=relaxed/simple;
	bh=Lonw8Pyamq0h7GPIbOzwiGr06kEMxSJ0XkUhYVk5blM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANjANSGcTYIv/1Munnnb7KoFerqtAdKzMycqATLlVNTSbZHLQFTqp2BB+VFPcE7QDUya+KokHDUY8wxLfeQb7jGG2OyUCD8iNz+MM3nMskeIZ2gSvmCX7bcZGIMb5IY9WVnkOgimwrS39t+18Bqnm5iUCNnqMgvCbr+nhPyQjFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be0629f76eso322289eec.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 19:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773022717; cv=none;
        d=google.com; s=arc-20240605;
        b=VC/Auffn8ihaAaaHVZXa0vPu+KDU1zzTy9fEgY4r4ymuMuHZfxVf0tLsmPrIKq/RMV
         pPNexXq8t4Z0ABoFfNlv0SZveqsvTaBKmrfiSdWodh57AuiXrHXbID4Ox3u6zYTaIBWd
         WZgnxUife3pKTL0E2vZlx2r9hIQOGtOOs8Q36xlktjvBNP4fQ9n3o8u+fuC7dbY7+6kI
         5ZCQuyPMdGWT3fQna6n0zOoYEtThzcp9p8XtNvz2Gp60biE7uc518n3XKjxnGjnxE3/Q
         gQoDu0VWlb1Rc0Wlhjbdmo1M8DbzXfz5AZv+eokJ8Or1iKv7FCaGLyinZheb0FKnrSHO
         +XJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Ss5GNAx1liKPubEmtdEdqMw0lgBGgrw8/omPZz16B/c=;
        fh=i53ynYO9BncglvirTbcjSfgVwFUR2x8H9+nJa8AADFs=;
        b=HerOzwwQzpoXX8SMHXdfd4qJ6/BunmY82PPEiIkuIM/4HzywsDj8fKqjyBCCNXLbB5
         LsF6gt46XEMUoKIEmciEYDp6fJEsA0yCwdg2XrQlyxWApSLM9v6YpsevnFKU/Gubt6O+
         XeQkszQywl4vxCilr/BDVKUFC93TDMZNdbW0b+GbAYEPoQfttLy+xzls+HJZwl6WXsD0
         YapUxqF/XDS2vcIQ7yIvFsYBj/UVKFFJy1XEDCi2YLQ6z5bEterQHNMYCF4N1k78koHj
         d4Ll7/WQoTkoAd1XU6/HAu2sJbE2myK+zp8s8du7IVryUgjBF7agWVheAp+dtYxEuxa8
         H7jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773022717; x=1773627517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ss5GNAx1liKPubEmtdEdqMw0lgBGgrw8/omPZz16B/c=;
        b=tISiWQDL3Hyigy5dwNc3iu+R8LtItT1FQJY91z9g/v96+KYbWhoF+m8V8DAXvPIcAq
         sqYOEgn1Ulor/eu+hipuroC26V+BlPgU9GdDXUoT61L2+dqdehqrLh+plR4O/2IhNDHi
         KsuQaPGK31XtLPNMesLNfyL424QzP0/eTqik89arQBaLnM1VH6y9gu+aRN7axClrbq5D
         JCABXWJQy5WyRwemnf6UoQo1Ga+DuCNCOxHU2y0J7tfWFrOcGUuad7X47ynkhX/zmB0l
         QtxJTBR5k8W984Fyf0aK8armXJpAlezkOts8HUbu7RO+dO23epkAHEHkfatGonobW60A
         JE5w==
X-Gm-Message-State: AOJu0Yy7vqQJnl3di7S97/KULH5t1ZoBJoSotcoVlhLQ0SN60e7OXlSi
	Vz+cmEVhF72/19TC5ygfpmgJ2qXddDHwmWAzytoWb/5O3XZkXnHIQX8jpTO2d/9qjL4KiJ3Urhw
	Qg05xq3jC65ipzn01CwywwH13honGiXZV4Rrd
X-Gm-Gg: ATEYQzzvRRznEKliHeXQexledXi8f20TldIDIVvZCQwKZFRFCMqYEpSAZgnN23OYJ42
	/5Mc62JoXHR/NcTVLj0O/w0Po8ysxUdqkcQL9IcmUD3n5pWW3xf2QZmaX8KzA+YwHZSuwMwTQaK
	oUJJ4+Lhk7r3WSzHaQrRm2Ft5gfPjHyGBZwxY0rA+xXWi8Yfuom5ZVXBEi5HV0NFBpsCrh2GkO3
	RaS2TOOuAIVr+wM7wKcUyKj10RQoW8JZ5k8usnmevc+ifbvOM4Tx4YVXCqe102SnUtrnw9uMRTH
	iALIuuW6h1GHVUDBzfYePd7xBccyDb/sAhh2Uw==
X-Received: by 2002:a05:7300:cd90:b0:2be:1f56:ed0d with SMTP id
 5a478bee46e88-2be4e09d96dmr1812591eec.6.1773022716620; Sun, 08 Mar 2026
 19:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com> <20260309005416.2760030-6-adrian.ratiu@collabora.com>
In-Reply-To: <20260309005416.2760030-6-adrian.ratiu@collabora.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 8 Mar 2026 22:18:25 -0400
X-Gm-Features: AaiRm50NAJyXVWLc93b5GL1Mqj0Bo8jyvQ9-svWnT95peiAIJnbLFUqvEgLQ9YA
Message-ID: <CAPig+cRngzGdd-ABWLSiypuJVQ-LVv-xqmn2h+c7qB8_OBpyRg@mail.gmail.com>
Subject: Re: [PATCH 05/10] hook: replace hook_list_clear() -> string_list_clear_func()
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 8:55=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabora=
.com> wrote:
> Replace the custom function with string_list_clear_func() which
> is a more common pattern for clearing a string_list.
>
> To be able to do this, rework hook_clear() into hook_free(), so
> it can be passed to string_list_clear_func().
>
> A slight complication is the need to keep a copy of the internal
> cb data free() pointer, however I think it's worth it since the
> API becomes cleaner, e.g. no more calls with NULL function args
> like hook_list_clear(hooks, NULL).
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> diff --git a/hook.h b/hook.h
> @@ -186,10 +194,10 @@ struct string_list *list_hooks(struct repository *r=
, const char *hookname,
>  /**
> + * Frees a struct hook stored as the util pointer of a string_list_item.
> + * Suitable for use as a string_list_clear_func_t callback.
>   */
> +void hook_free(void *p, const char *str UNUSED);

See [*] regarding UNUSED in header file.

[*]: https://lore.kernel.org/git/xmqqcy1g25fl.fsf@gitster.g/
