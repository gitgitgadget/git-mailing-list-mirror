Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97176F17
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851693; cv=none; b=mlTTzb3GPALbF86UeGRXhCZKQ/nx8qbP+ItB5wG4aDM22vG9WCKLm9/u4dD1Ld/TIpR5LgCWmz2sczQX8bmfNBwywr+VdnRiF1MYh31X19GU53EuTDtcIxW8+ewuhRUn0bcusZntQj1NqoD4Ugb9484zj3O0Z3wnoo7DvJadc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851693; c=relaxed/simple;
	bh=Kh9HeKnNSKPd2Gaz1kW+PbUu0Yz48dxEhPMQ8qqVu4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOHOns4S/atWfEoSvCwhSi0NLhmmaiUD744wg6x2WbvbCiLHjY7YlWLBYzf+2J4NLywc44yZTu4mI447s/wZ34v0qNLw0Q8ysyKaXsFtGscof9iPotcMhd8ycvBrMKP8qbtfxt4pCuha9/RBjJP5E5Gv1daq+Wtd1MS2mBe8oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so2589172276.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723851690; x=1724456490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRD4AjWND9t49GfBmhxcNC/VkIk0+llwJlYh47bgK9s=;
        b=oCS10k0huMc5Asio56+lY89+QqfhRbNkI5XxKbiIVPEFSB+x8g+UOV3YqCHqK2GaPr
         1MG0/1khFZt7CtTJRf8SvU204unBG/43cuDcuB7oAmjfU1TCJDbQxYvWVDJ+ZuagEuco
         PmQLt3ss5SlLqC6c8/fpOJVXb7c1CPwBxCTpcxAKuJFme3IObE5yOta8s/A5JkGelOv/
         CeAcM3K/Zt4NlisSfo6k3WzeFUDQD5BpN+2+pK+/494Mv2v9/Y9bJnYaI9fpI4CAMwmH
         NzNmkhdHGG3A6eqxsVXhJmL58/2kfptSd5N9eqQ24XZOMfPDgtWzCjFhdPkB1OKV7tJI
         +1mg==
X-Forwarded-Encrypted: i=1; AJvYcCXZr811mlKy0TwTsUYfaeFH+tONJe5QTWf/6N98cSK2yIpjvJt1VLO2RqIz96hbrspKLBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qYdc+xmpi+o3rQvA/F8s4+qUJf5Ir6aQpUne2eSNA3kYuKfW
	IymLsymZFdY0yvQlB4eIcf2xA4Tv0R0Xy65u9R1GoU7rn5VDhQaGYnpRvNKmJ+2grSBopeZ44R/
	kqF0XWeQOp4ehK5kCGLZZEdwfoFs=
X-Google-Smtp-Source: AGHT+IFH6lcoN3c2KW0dD5UnxIJ+iG0Af54TS/uZy7FjVlSSyIJ+SQkMzYiPA3fDkR2X2w8CsqDt75eFtpTn5ZOjDRw=
X-Received: by 2002:a05:6902:1885:b0:e0b:c864:3e01 with SMTP id
 3f1490d57ef6-e1180fdda05mr6084050276.47.1723851689839; Fri, 16 Aug 2024
 16:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
 <20240816-jk-send-email-mailmap-support-v1-2-68ca5b4a6078@gmail.com>
In-Reply-To: <20240816-jk-send-email-mailmap-support-v1-2-68ca5b4a6078@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 16 Aug 2024 19:41:18 -0400
Message-ID: <CAPig+cQr+n2dTN9OAbmCVc30GwUH2K67X-HGaF=-LazY1y+2bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-email: add support for --mailmap
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:06=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> In certain cases, a user may be generating a patch for an old commit
> which now has an out-of-date author or other identity. For example,
> consider a team member who contributes to an internal fork of a project,
> and then later leaves the company.
>
> It may be desired to submit this change upstream, but the author
> identity now points to an invalid email address which will bounce. This
> is likely to annoy users who respond to the email on the public mailing
> list.
>
> This can be manually corrected, but requires a bit of effort, as it may
> require --suppress-cc or otherwise formatting a patch separately and
> manually removing any unintended email addresses.
>
> Git already has support for the mailmap, which allows mapping addresses
> for old commits to new canonical names and addresses.
>
> Teach git send-email the --mailmap option. When supplied, use git
> check-mailmap (with the --no-brackets mode) as a final stage when
> processing address lists. This will convert all addresses to their
> canonical name and email according to the mailmap file.
>
> A mailmap file can then be configured to point the invalid addresses
> either to their current canonical email (if they still participate in
> the open source project), or possibly to new owner within the company.
>
> This enables the sender to avoid accidentally listing an invalid address
> when sending such a change.

Nit: The final two paragraphs appear to repeat what was already stated
or implied earlier, thus don't seem to add any value to the commit
message.

Nit aside, similar to the question I asked about [1/2], are there
downsides to merely enabling this new behavior by default? It seems
like it would be generally desirable to have this translation happen
by default, so making everyone opt-in may be a disservice. On the
other hand, starting out with it disabled by default is understandable
as a cautious first step, though it might be nice to explain that in
the commit message. Similarly, one can imagine a world in which people
want to enable this and forget about it, thus would like it to be
controlled by configuration (though that can, of course, be left for a
future change).

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -1085,6 +1090,14 @@ sub expand_one_alias {
> +sub mailmap_address_list {
> +       my @addr_list =3D @_;
> +       if ($mailmap and @addr_list) {
> +               @addr_list =3D Git::command('check-mailmap', '--no-bracke=
ts', @_);
> +       }
> +       return @addr_list;
> +}

For some reason, I found this logic more difficult to follow than
expected, possibly because it doesn't feel quite Perlish, or possibly
because in this codebase, we often take care of the easy cases first
and return early. Thus, I may have been expecting the above to be
written more along the lines of:

    sub mailmap_address_list {
        return @_ unless @_ && $mailmap;
        return Git::command('check-mailmap', '--no-brackets', @_);
    }

Of course, it's highly subjective and not at all worth a reroll.
