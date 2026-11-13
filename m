Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794575472;
	b=BiBoBHWH06Ng3UQl2/LNYlbTe3rXme1ieKt8dFeCctrmFC1mXP3Qz7wYPbIkcN3X9umb
	 XGmvPAq7sORqEerI0+cOibG0o0xLXTyHiptplNoM85/jGZOArV+laSNKw4JjYFxrcm2sE
	 iqndEjv4zQ/auwkMMf9mquOeN9O06BObryHngkX6rBv7YE8K/6B5W8ae4fJUzK8qUhP2T
	 QxNEqE1RaTDbQ2lcPr65VQcTHxLuSs3m6wwRDI7vYG8FXUt3+/gUitkMWgJQjb5F7u8To
	 uHZzduo7jsFdkn5Bbpt9Z5kS6OQvi5NCaweRNF/CPQGpol0FyJ8QxP7SNRywbVBpqMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9lkUSuQjWQOeruim8nuis3iN5V1ceRhag41/K9JTPHM=;
	b=39Vyt46oW9uegfHaUc1im6NgrDfUCXnHf0Ov4oRa5Yzpc8ZJzVisry7x6SDMLxY01i6u
	 gMiX1ecm3kpBnotYXEdYjhqzdCHXREM1DWOc8lTu/oXi9BvgEKNktgbEyoDcKcUdsrwOk
	 eCQxZxethTJ38vczyXeFbHxbJ1i1sSBSXtnmaR4Y+hD+CC31sQEwc+FuMUDmelRAvhmw8
	 LUJp8dNBcNm0gL3PpGCfpHzwk5skruEdvrIFaiYZLx8JmAbY//fMhgsznleDaSujdiC93
	 2LTE4h0dv/PW8rE70UTvb2ggqFbir0yIQQQA6l95qPljQm9CRSYpPFRaxpngNXLD+iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3jpnDt8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442860A5BCA
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E442860A5BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3jpnDt8
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso1284836a12.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 05:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575471; cv=none;
        d=google.com; s=arc-20260327;
        b=Upf9IxLWa7WzbsnW8qudCRgQUeMfK3EEibWwXeXOozjxl3zek62lL+eEfYwyVGwYtY
         hQNTl9dgOuI4M1Iml9zfyWyhPdIWiZAK0KrMdjpwfF614kdVzKL/sLK7cbb+VHehPQgx
         MR9klocjJQ/6zffsw2eXLNRmc3DaQ8mr0FCm6yaGhNZLt747C76LvmsOb+q+ECa1SRLz
         KpadqQH+jzlb4N1Ijpc0wnw+F4TgaOucXofEdqPt3dGnvFuaxTwI1qLDbLl/tTaBqny7
         O0096iPbo5tShu2mdW/VcCs+LduEB0kKaXHrMcl8hXMOfwbcKuK/GcpuU+4KYKJqLTgS
         uaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9lkUSuQjWQOeruim8nuis3iN5V1ceRhag41/K9JTPHM=;
        fh=9y5RHKSJjUxgzZUzNgdTktbm7UmuCP3+vb2XY/7eZhA=;
        b=DpRLIMBXfMSJa8l2BrkjKzXrPwPakLqMV3w7VaWhvK/YztLpIvpcW41a417+wvP+w4
         cDwu55/7YUpU4XzuyzP7dr0QDYp8ki1aEQU/uJpe4bQRt5EC6DKPbXfAJgALS8pFHs5k
         kgusp6/j+5zV8gPykFSB+R+2gKS1O6U5k9IMoQK5938IoQz7DoOkK2TeZHMCYi7hDD/y
         Hp7SXKdJw/avSimX9QbF8kjFvr83Nb5uuoKyQJMw8+wJ1mNh9PUBuT6LMags/OR+Tnkq
         1Cj3+UjqZoueI/MDLHGrt00Ss1NK/qTH/CpgffCxFtoJmpi5uB3YtkI/dS4F4VkttioB
         8R3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575471; x=1795180271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9lkUSuQjWQOeruim8nuis3iN5V1ceRhag41/K9JTPHM=;
        b=j3jpnDt8NMh15gisWelYw3VRi403sqifxznlQFxnlfBM2+Lj0h5BgnRyeRBDge0O4S
         Lt7gC73tvDtX0PDVOU5LWTqJf64zGZriFJyzWkH/Zo7KElI+NesYcz5lAzNA44PMKRaF
         rgKGnEwKnnN7D13LiBJqT2bMaLGeAYmFB+i/1tGNHTDnSKfDoOtz+J+IvSYSko2IEd9k
         /ljG8RCibkVVwnMUWvX0FtI+kz+p14hSA5WnW5SxaXCVaWKjNZxcU6QfFa8oemsyfv4f
         7lADqG2EPSz8r4FOLUvJy1fAhAaPpQHKfadWtWSBhPgOSu9MEWb0TZZbi0eU2dJMd6iV
         M0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575471; x=1795180271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9lkUSuQjWQOeruim8nuis3iN5V1ceRhag41/K9JTPHM=;
        b=cAUWzypP8gyqZUsj7HXyzcke7BjglfqpNLR5/ZAgUXEOh20tAR2IT0bCx5EVsyJAic
         culpZSziUAevXz80rnKytU7isUdLEQZrzQUyzmJtGvhejqyRRWphUVNWNZ7E9yjCrmE4
         cbgXLcScK3H+G/4+lUaCdzBG6a1EnhvnhJ9uhevsv4KxNKYJI6L7Bk0n5ix2WwCcPErw
         B6a7VokpSJVRTf8SJitz0WN6I3jFxI7u/iJ5EZdJ5Fz5BlbiPi6zHA23pYLeKKWOtItq
         iLXTlUf9jPvGXRiDSxxC6JPB5jptoiz5yGadR9DMsdByIEnQRrhx6a292hVfou9t2Gcs
         qCAw==
X-Gm-Message-State: APuU4Z8IBPGxhiAwa12YwVC3gxGw0qQXnfz+F2A6OMbsI9vB3iLhpKEU
	hhyTcmQGakyD2ZFOzaQYTkcV3SggYF2xt/KwMrd7+cp7z++9lDsBBh50il0tc02QHvb7lzWlxjn
	dQ29/BTs1MDb04Aj8OxwMKBJM8A5+80AWQf/pqzXH4g==
X-Gm-Gg: AYBFou0Y6j4EyDMg2J28yb70zVbWbjXr1zjkesDeMAn/xxsK4LYO9Vhz91aKn7kULhX
	FaDz//AZIOM7RY1gH8A2ZxA6C//+sDWdog4yLjpm6Gk4IamxfLldlUxX5Za7GjBqOnrps1jbRHc
	xB7QTWMzCIZ6OMZNoL0PfYhPeYWOL1IMkoxmSgCxbBOYPpoBd7eZMaXvw4SCFhAkQLGDqNWs7Z9
	08U91f22gAVsPkpJ3VIDhz3ZjlB+UrGUdPnk3BTp+yVDgk+V7B6eU1ULd6BmBsCrs/jsa+t/P/e
	OrK/DKFtpQAS/Eb/9AOkhe5XATTzrJCCKJIeyU7e6S/A4WyWLuLu1tSH/Zs8HiDxeao1/ucngXw
	furfdDbVw82RCJJ3j5KuSSyWjObADqNmWgRNWeJ/cyhCS0aOZzuNpyUj2z+tCx3gmVI1Fxnmc9Y
	+5QdEfB7ARQWZmZFPrN9j6bcNWp/dn/LhpW7XM/vvGfUbwqUtxkQ5gsJqkz/Yk0cHVD0hj6PIdj
	Ce/tUgYXQhwa3QTB5qjUtZyzyF/DUh8vmmgOOlQ68RFow==
X-Received: by 2002:a05:7022:f503:b0:166:b307:5855 with SMTP id
 a92af1059eb24-1b502fe3953mr2562351c88.0.1794575470960; Fri, 13 Nov 2026
 05:11:10 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112195858.53788-5-christian.couder@gmail.com>
 <20261112195858.53788-6-christian.couder@gmail.com> <xmqq8q2xhexs.fsf@gitster.g>
 <xmqq4idlhe69.fsf@gitster.g>
In-Reply-To: <xmqq4idlhe69.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Nov 2026 14:10:57 +0100
X-Gm-Features: AclHuK_tG5JI50hzqaoM2uct8yYPLtvl8aiooiTCNFToMoCT3Os4s9ogwz8q6uc
Message-ID: <CAP8UFD18rTvM0mu9oSPMd3V+J9GBgc07RM91Pfh4RJqZg0s9aw@mail.gmail.com>
Subject: Re: [PATCH 1/3] connect: let write_command_and_capabilities() send a
 promisor-remote reply
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Matt Cote <mcote@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 11:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >>  void write_command_and_capabilities(struct strbuf *req_buf, const cha=
r *command,
> >> -                                const struct string_list *server_opti=
ons)
> >> +                                const struct string_list *server_opti=
ons,
> >> +                                const char *promisor_remote_reply)
> >>  {
> >>      const char *hash_name;
> >>      int advertise_sid =3D 0;
> >> @@ -754,6 +755,9 @@ void write_command_and_capabilities(struct strbuf =
*req_buf, const char *command,
> >>              die(_("the server does not support algorithm '%s'"),
> >>                  the_hash_algo->name);
> >>      }
> >> +    if (promisor_remote_reply)
> >> +            packet_buf_write(req_buf, "promisor-remote=3D%s",
> >> +                             promisor_remote_reply);
> >>      packet_buf_delim(req_buf);
> >>  }
> >
> > This function was designed to have a fairly generic "here we send a
> > command and then capability exchange based on the settings stored in
> > the string list" interface for extensibility.  It is highly annoying
> > that we are now adding a specific option here to be sent outside the
> > framework.
> >
> > Isn't the misdesign being corrected that the "promisor-remote=3D..."
> > string was not sent as part of these server options list of strings?
> > Can we fix it without contaminating the API like this patch does, or
> > is it too late?

I think that if we wanted to clean this up, it would need a
significant refactor as there are three separate places in "connect.c"
that write the client's protocol v2 capabilities:

- send_capabilities() used for `bundle-uri`,
- get_remote_refs() (using send_capabilities() and its own loop) used
for `ls-refs`,
- write_command_and_capabilities() used for `fetch` and `object-info`.

They duplicate code for sending "server-option", "agent" and
"object-format", while each sends a different set of capabilities.

The server side already has a table of  capabilities (`capabilities[]`
in "serve.c") with generic advertise/receive handling. The client side
could have something similar for building requests.

> By this I do not mean that promisor-remote=3D... has to be sent as one
> of the server options (i.e., making the string sent to something
> silly like "server-option=3Dpromisor-remote=3D...").  Rather, I am
> wondering if the existing server_options string list should be made
> into a more generalized form so that the string list can contain
> elements whose keys other than "server-option" can also be
> contained (like "promisor-remote").  IOW, the caller can decide to
> put "promisor-remote=3D...promisor remote reply..." in the list,
> instead of sending it as a totally separate parameter, whose
> semantics is hardcoded (i.e. the fourth parameter to this function
> will be sent as a value to "promistor-remote=3D...").

I am willing to work on a significant refactoring along what you
suggest, but I think it should be a separate series from this bug fix
series, especially as we might want this fix to also go to maint.

In the meantime, I can send a v2 of this series with something like a
NEEDSWORK comment, for example one in front of
write_command_and_capabilities() saying that it should be refactored
with send_capabilities() and get_remote_refs(), so that callers build
the full list of capabilities, which would remove the
`promisor_remote_reply` parameter
