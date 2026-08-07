Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BC44239B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103296; cv=pass; b=hVcGd5/L6a1o7MvvxPW6u6l/qlddmlrPk5gYJEZaFT4jL2sgC15ojCLCFIE3TSPzHmtR+GilgJ82yZzGSxDAM/QWOID/HQuomxuUlaJ9KMl9Sb3tbPZNU7uZ/pPEjLuDpMH6mvefzQncIeKAh5PKc7VweYIdC9Z5guaRB/u/kT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103296; c=relaxed/simple;
	bh=x+4Y11Lvb0i49/1WgM4BoA6P0vrjVLIgjTsUWtUt7Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpjfNu92xalzr9IM8GAYv9fV/sWfbMrXS+0fDXCJXQ06Zpwdt+SXVap/GgKTtMe65YPyMQjDHWRgrI8+v25UPpYkQXatSigHRScEQxbc/KKyDY9jUJwbb0kSF4ubSxISuXgJOd9oD75jg+2SKOTnsdYxoSCFbTpea3l6XbFWfGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=ARe/p9iG; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="ARe/p9iG"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80e24970f1dso27329077b3.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786103285; cv=none;
        d=google.com; s=arc-20260327;
        b=ZiAocPvl7D3Or6Xy054ECPSOc/3bGl9yQNrK6eZu3tF+BHA/A5t1HIq4hWJMaax0Yu
         tY4Bkqf0n5cv7SypdXyyDRG2fLT021uLg5CG5CfcXiMOeWcEKsF0zGFDOCRM8TMLNUNl
         CVe0Ta6uanA7khXedOyFfTpinIh+grNTN+0QcwiRsq05iGgVRE0SLQfh75RL8nW1mB2y
         IbLSYFolOAvjK+BtTTQFX51rfMOOMma6+VOC2PpdvnQYoX2ickNDKWC+FI/zXBP2NU9W
         KUIGMytM6OuxukOjrTf1LnZL5CCKznRpLfECwYsoUNB+CX4bbRWe6noAUme6+dEbuKBQ
         iF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQ2DszuhVI/PlJv1/qwBI6MvlIRG/arqEmu/6lv4nPw=;
        fh=UddtoLbE9Yj9iozJv7vvmEEv3aOSMqmdtuygYe0qd+M=;
        b=U9gFdzelEJ1aBsvRdYu+KAGht2S01hHBBwsC9qKv1vK7opMFgeYv3Tp8vOR3/kUf0h
         W+rV4lpg3qR56Cwwt19uMSAXfmmLt9Yr5AUDcOXLNrFDT6y96nM/84acrzC58TMQcf2/
         V01+TIj+4HxWkCkQfXYaOGH3PcRuAXfe0tf/Noa6+ednVGXBxMzWaiL2JbqAehRYt4fQ
         xIROPBfMmmE5QtJsobkCHVUIoT8elXcTwTHXpnMZkKKRX0vssZrYv1ZUfqXCOXi/viGe
         A93xiCB1G2BPfXAHaEJvEpEciAW4Hk/l2z/VdBKGwX92HNYfMj/KIscXbrAAK1HiiGwu
         ywbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786103285; x=1786708085; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQ2DszuhVI/PlJv1/qwBI6MvlIRG/arqEmu/6lv4nPw=;
        b=ARe/p9iGSEN1ohTlEjzKNiEfA42SW8h6LMJhS3KJJaY0K2KvH2DqsS9T6gjPY8KBQX
         cgrAHGjtB52qdBvbCuXkSsUVuhUUYy186tYBYMur6XjnUjAykDQKDVrgvIFvHhvpMdrj
         +LW8CNBOimP0C0LC5ipsESOy+CRF4vJ9ax9Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103285; x=1786708085;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQ2DszuhVI/PlJv1/qwBI6MvlIRG/arqEmu/6lv4nPw=;
        b=nNZYnTRAmiNM0x+wPsuxhz/Y30ROYmoPr3/Ak7XyxlEy2Zxh4qq7n6cEzO0f0DGGlW
         iR0XbPZbYJ2L8YTHnYxjDDKax3qCXhDeraeBGDvCncgZFpQZxfL1P75526RUfZMJw5Ks
         R7Bm5D7HsDjA01jVTOC1YGTuRUBhWMeyvq7IyrX6IwUM56nJOzOSoG7qU5eEARI4k9LO
         xkRla0jghpdhuR2I52PoqrmDAsj/cERJ3GuMewW1yr4Ft42vKK2K6WUBKUVk7X7i7prL
         1V9mxe5stKSjP2DUSOJFv0hojGb+rZw6W+LBwQXY6v1pgdCbNU3f1Uri1ZtUZv9w6A/n
         6rVg==
X-Forwarded-Encrypted: i=1; AHgh+RqZkrgC/C9WqNt7x+7PcDdI5d2uD7Pk4ywwndj7ACD3vOtdKIAuaU18gvCYym07eaUVMss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7anrYsHJFYd5c+vZrsS9ikWRNMGXbmelPa2S7LRSF4pGxgsh
	Qvih6Z7M8RR4YQ0hfxMgvjgahin+Le7HhmvQOM9bt3C4sZ/7HEQEH5fUfyMgQwaep0grsBQKnsW
	POaotQmYejX0334K2mUApXLap0tVPiJZD0PSg8JHf58aqZKhTUZSoEsXGeQ==
X-Gm-Gg: AR+sD11Zc+kFXSR3D29pbNltkBL4lrmNWndm9/+F8DISpqvaKMK6s1g4IkmbqTJbQeK
	lC1I99g5nPB8ufpYvGP+iwHrJedrqbvvlKWOsYQa8+ovH5/Dgk+qw40FYK0bI8nMjbKuwJa2BfJ
	gk64md8mlezT646ywwgFnrIwRcGynWdFcxIDiXwuE6I+t6z87zJY4X+DEcjhgzJ15AXtVBAvfXu
	AtP2RInisP3lUlxB5vjYylkGmKBkHvlqw6iL9CWxI98ttqKCW04o1ty6A8cvkTZNeoL5ly3ENPz
	PK7FJ/8hFTwRIWNVs5dgyZvw7j3hpIz43mE5IF0N2Lo=
X-Received: by 2002:a05:690c:9689:b0:80c:3848:bde5 with SMTP id
 00721157ae682-82258a8f2dbmr49109607b3.13.1786103285405; Fri, 07 Aug 2026
 04:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BFqghtx4p_Nqx+AWpU7SVn3mXOZGDQ0yoN-ZYQgXmZC=g@mail.gmail.com>
In-Reply-To: <CABPp-BFqghtx4p_Nqx+AWpU7SVn3mXOZGDQ0yoN-ZYQgXmZC=g@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 13:47:54 +0200
X-Gm-Features: AUfX_mzBgAT7h3w6LjH7qnTggbHU0kYNhpb6-LViLcl3MPJO9u2lPqeEXalxM8M
Message-ID: <CAL71e4MULMmbMyrE2iKgNXD36vpjnxCYXTcNw75ibu_nwxqAPQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] commit-reach: introduce struct paint_state with
 per-side counters
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:02, Elijah Newren <newren@gmail.com> wrote:
>
> became -> become

Good catch, will fix.

> So: pop, clear, check the counters, and _then_ decrement the counters.
> This means the zero-counter-check still include the just-popped
> commit.  If the decrement were before the check, we'd actually just
> barely miss the merge-base most the time, so this order is important.

Yes, I should perhaps add a code comment for this to ensure it
does not get corrupted in the future. Something like this:

    /* must check exit conditions before decrementing counters
       for the dequeued commit -- the counters may otherwise be
       be temporarily zero until the commit has been processed
       and its parent nodes have been enqueued.
     */

Or is it overkill?

Thanks,
Kristofer
