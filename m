Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823E50A93
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307078; cv=none; b=CCkOVZ87GTqhRGOeQe47qpIRFKCstW4rP3RoDkg0ujkGlS6vfY4/kdB3Hz1H69ATcJT8WRV922BzdIF4G+mFs2ELBcH15w4SogMYzbTLP2LLhDhOyehaEYnqMijNBbBd9Qhkkv17MLcg7O6Za4pgaOnIDi98eDn1XG/C8VycKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307078; c=relaxed/simple;
	bh=fkL9H/6n2Aj0O06ugSLuP+3M5nnn4lCy+OsVdBDHYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIsWLateRWueipkx+lUhHeiMefY7EqajOW+j4KH/ZbAX+zl/X2svOQ6VYeUVZEsfDfljOocqpnmB8VzFKJh0JM5NbJbOUfXU7VEXlf0HqKq5I/UXAjM72tkbKwZI6RawTqUwDmE3nRxTDvWtJCCjdyytBAWOCHd/s4kabvTXpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6TJwZW4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6TJwZW4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-429e6ed0b32so2604571cf.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307075; x=1706911875; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRvzHj1dLl6q0SOeUlveInBlMT0+7bzzVWCzLmTo0Y0=;
        b=B6TJwZW4INsAIRQyUvcA0ACBiyN7OSKRBw0jLdAGcUETGEErU1xvM4clfhbEfoSQHY
         aU8at6HUeoXvRnLmpedrJ6fjmjTleCJaaejI5SMON8z6dAgPsutcneiwmRObCYmp3inl
         0DLk55cjWkVuFvwIw9oxX+2/eEUxjPyD2fe78u4bantCmtZfC1QE8ZzsuXXVTvbOLXOV
         Sfv30LH1kqPkRlTFbzvDEQ87bbVOsFvpFDR0I4WIEvfIv7bNImy9HnZc99mY4ySj55Gf
         0rD8fHL+0dZYjNJt/d6B0R8MQBQkwcUwSY2PXBBlV13bccwM9N7iZb+SHLnnG1hBa/r2
         qJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307075; x=1706911875;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRvzHj1dLl6q0SOeUlveInBlMT0+7bzzVWCzLmTo0Y0=;
        b=wBp2AO5jvJDVv9ujLlIakW8aWVS3f7CFgrpDUVnlaMiOKwS6rYeIdeMVukvpAAzTOe
         xq7qDSpXZ+rXmJr2VGlEW3Pmd+sxp0CCzHECoHGNQQt/zmVcg0cRxOS/l1aQ9oHm/Obj
         dQn9fM8iVj+HwwQac+G1l474vbDHc+p36Vb0DgWqluyab+nWuPjITBGQqmO7wJl33yJq
         sq8WBWbIUkoPm4pGyhUIjrhsXrQHfb+pN46a18v/VGeVjQFvXaVltdz2HWo7vaCysUjh
         nyuyeyptBIH8mNgUqym4mGsuliNn8BfP1ldBOd1gX7aUYvrIFnO+3r3hFAhZlv/zncJ+
         Oj+w==
X-Gm-Message-State: AOJu0YwAl+TFT4E2yOPl8AI+5kf1NXQnhaVPvZjHRFbv1o79+G2SNh9O
	j6N8cO1MXwaC8zgkmGePKFJzshd/cYefULaHIzoU5raZup5ckhOV
X-Google-Smtp-Source: AGHT+IFnj/jN2DohqMJeaTzYVTexcvo3sM9Le3BWWX1aEY1a0kTUTzRIqOhfzTKpomHonMzTQ2XO6g==
X-Received: by 2002:a05:6214:2a8b:b0:686:90f0:2a33 with SMTP id jr11-20020a0562142a8b00b0068690f02a33mr1018729qvb.5.1706307075289;
        Fri, 26 Jan 2024 14:11:15 -0800 (PST)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id v1-20020ad448c1000000b00686435dde29sm863741qvx.62.2024.01.26.14.11.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:11:14 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
 Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
Date: Fri, 26 Jan 2024 17:11:14 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <BF772E83-2BFE-4652-A742-67FADF3D8FE2@gmail.com>
In-Reply-To: <xmqqfryjn686.fsf@gitster.g>
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
 <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
 <xmqqfryjn686.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

On 26 Jan 2024, at 16:18, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  1:  b3b3e8bd0bf ! 1:  cdf7fc7fe8a index-pack: test and document --strict=<msg>
>>      @@ Metadata
>>       Author: John Cai <johncai86@gmail.com>
>>
>>        ## Commit message ##
>>      -    index-pack: test and document --strict=<msg>
>>      +    index-pack: test and document --strict=<msg-id>=<severity>...
>
> Ah, I missed this one.  Nice spotting.
>
>>           5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
>>           2015-06-22) allowed a list of fsck msg to downgrade to be passed to
>>      @@ Commit message
>>           directly, (nor use index-pack for that matter) it is still useful to
>>           document and test this feature.
>>
>>      +    Reviewed-by: Christian Couder <christian.couder@gmail.com>
>>           Signed-off-by: John Cai <johncai86@gmail.com>
>
> I haven't seen Christian involved (by getting Cc'ed these patches,
> sending out review comments, or giving his Reviewed-by:) during
> these three rounds of this topic.  I'll wait until I hear from him
> before queuing this, just to be safe.

Christian was involved on an off-list review of this patch series. You can see
it in [1].


1. https://gitlab.com/gitlab-org/git/-/merge_requests/88
>
>>      ++	Die, if the pack contains broken objects or links. An optional
>>      ++	comma-separated list of `<msg-id>=<severity>` can be passed to change
>>      ++	the severity of some possible issues, e.g.,
>>      ++	 `--strict="missingEmail=ignore,badTagName=error"`. See the entry for the
>>      ++	`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
>>      ++	information on the possible values of `<msg-id>` and `<severity>`.
>
> This is much better than the tentative text I tweaked.  Nice.
>
>>      ++--fsck-objects[=<msg-id>=<severity>...]::
>>      ++	Die if the pack contains broken objects. If the pack contains a tree
>>      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
>>      ++	that blob (for the caller to check) after the hash that goes into the
>>      ++	name of the pack/idx file (see "Notes").
>
> Not a new problem bit I have to wonder what happens if the pack
> contains many trees that point at different blobs for ".gitmodules"
> path and many of these blobs are not included in the packfile?  Will
> the caller receive all of these blob object names so that they can
> be verified?  The reference to the "Notes" only refer to the fact
> that usually a single hash value that is used in constructing the
> name of the packfile "pack-<Hashvalue>.pack" is emitted to the
> standard output, which is not wrong per se, but does not help
> readers very much wrt to understanding this.
>
> [jc: dragging JTan into the thread, as this comes from his 5476e1ef
> (fetch-pack: print and use dangling .gitmodules, 2021-02-22)].

sounds good, will wait for some clarification here
>
>>        +
>>      ++Unlike `--strict` however, don't choke on broken links. An optional
>
> You'd need a comma on both sides of "however" used like this, I
> think.

good catch

>
> In any case, I thought your original construction to have this
> "unlike" immediately after "die on broken objects" was far easier to
> follow.

I'll reformulate this to be clearer. From the previous version I realized I
didn't take into account the pre-existing "Die if the pack contains broken
objects" block so I put it at the beginning. But now I think you're right in
that the "Unlike..." comes too late.

>
> Thanks.
