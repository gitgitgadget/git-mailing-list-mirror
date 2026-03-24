Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746E38423C
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377529; cv=pass; b=L+vzsrrXURGP7KcEEhQ7trlIjULNNcL4FtHN4nNcCQGZuL82634tnfHsEOUC/6pRdOLemS6PQSU638FxYZ73qj99Mud4+X75OQZKVpF752GzGUL9IRaRNDf98f1eWFiRAhbGUsVOchAVr5Z1GZnzkDs6Ba5uOIJ45WULZyjuASQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377529; c=relaxed/simple;
	bh=hH5ys1xPlVsOEu7Sjg+EPFNX4IXQFMwR6tDRGqtRirA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQU8SAdEmOIBzw9VpJrPkHqaqQeCmqEO6YNb20cnnswTwiDk3bhku7Lfi67KaozBAF+pJoVAdI2N6MK6NhHWfBI0rH8dlOsiNxnbAUW08v8dUC+V2WZ8uPxXCYmAuhPD2oqFXSacBw62UdcyPyARP/gySKmF70VcNn/ML7k80bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b8095668ebso281029eec.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 11:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377527; cv=none;
        d=google.com; s=arc-20240605;
        b=SAGEezmhl4kbGeBpnZgxtldNqWShY2kz60A4TrwwXYACLpRfhFUhHtc1SDQgs42FGf
         hrFCZbq3+bMtR9o0bDnks3bnd0lGAkrog/NBsTRBAXOEXSf/cMdKZbzJJ/tpWMPSoqkj
         sTXKxEAbvNcYiV3tS7BGWi9GP11GIjzR6f30NhqtZpDnhoJyD+51QkP6FZbYB46lkrjJ
         LQxR+Jy7lY+CXz8YXYBFFDw8q2FCGn2+kML4SHStdD7oEBJ9KNxDQYE/v2hIa+1uPM0R
         iJZzx0PbI8Vmx9933HM5EKxxku2gPAveU1Rp6B50RQ4jeCK4+fr+Q5uK5HrnqxQkFOdq
         NWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=rjwUqQfxQabmfNGV5g10E70abdbXftD0PJxfPkxfTbE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=gl4bB5dLkdVR+TVmwYaQ4s81M70JD/D6YHviiomDOmQWaQ4m+CLhrsff4bhzQzaSIH
         u+By38tB0rEUVHjVwDdaVn4ZM+/jeSjtozFfJ6WTUmk9nfDbFST7sgVMVexYBNG1J27B
         k/Lttl608E+uYRZHoRswcYRScxyPiF4Fsv7Ga7kiLG19nQiZHirptgedmLX6XSxv5s3H
         X/rl5cyjmnK7zvpzWcI/o4uzVrgL2u2s1nWCwgjlTqU+bHxe7/yY5+I+ixq9V5mUG2IA
         XiI+3HfoF1qREj4rUK5nzJ0zO8Qv9Tgq1CesbbiQ5hXFv7PPZYLN0/406hlK9dYByAd9
         2JRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377527; x=1774982327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjwUqQfxQabmfNGV5g10E70abdbXftD0PJxfPkxfTbE=;
        b=FOTR8Z4Y7olSVQsNcKmssdnQhThS2GrPHd9GhuXNBAB/OfC90cOKi1OrpQCVO8wJRa
         9LVwpoL9fP5SveNQNxlYr0dx/IStggCXH1O2veY/Bp5oL1uua34+o6i9MCc9oxohMMuB
         NsyGg+ly5695xihFcCRPS5WfpSdoU4m9EGwYNGzhhbgGQHwib7Ylbg8ecL8/rpsSnAvD
         hund6nIQA2zBRb+vDEn0PvqcFra5pkVPTD6RAzRfRW/ntIOqVCnYXLPOZ9eXpP9mH3O0
         E7yvPrt7352cypLCbVa2PXubzwp+vnKNPjUBu2TQ372+k/DJuMguiIZyIESorbCvu0lz
         W3yg==
X-Gm-Message-State: AOJu0Yy/HpIBrM+zV/43Y3ejR7mm7p5JhUj/FNPyMhBwfoEbzifvSzEr
	AjsgW/O+d9ikLjRBNvpebbXnlHXLrnONSc5jGu+HH36pHbhmVNu7F5sC+/1geAja8F6YA52TGz+
	OYhVu25V498l8C5WJJoOnhWRHRUiTlJM=
X-Gm-Gg: ATEYQzylnJh9xHw9IOwENHA5Civ75QpVgJSF/LlI3jMnsrj3TKewnRcgXrfZ+myP5VQ
	EVGBXVhS8ATLoUvnrvvlaLAO60Li0+CjrVwEF7DySbOFmSoUL85Cq/oNg4WgtHDSZBUq94W9z1/
	BKWGnX7UP79iu59OZhcqzoi6yb4BUEnlIlDsMqB3Puketd0de+U2/yj/0eX4JxBHDhNBH+aedh/
	26HAUqfke5+Ck8LD45XlrrDPBdFQQP1v7OLa75Z3bMFwvGYelO0T34+urYwFhjBguqir2qAHBGi
	YrQdCZuL4WnT0UmBBSIjfjUBBUkmT8kiQUb3uYUVog==
X-Received: by 2002:a05:7300:fb87:b0:2be:e92:7f44 with SMTP id
 5a478bee46e88-2c15d439d5dmr87227eec.8.1774377527082; Tue, 24 Mar 2026
 11:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
 <acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g> <acKx6yBi-BWUVJcv@exploit>
 <xmqqo6kd18sr.fsf@gitster.g> <xmqqcy0t178a.fsf_-_@gitster.g> <xmqqbjgdyt6l.fsf_-_@gitster.g>
In-Reply-To: <xmqqbjgdyt6l.fsf_-_@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Mar 2026 14:38:35 -0400
X-Gm-Features: AQROBzAqhkEOlTENx6sk5-hdaHfihN1eTKwjDADpldazDkWumllfU2LnSdY1SFA
Message-ID: <CAPig+cQPD3vAxbRAJsqyd5=x2xCkTHj0Z6Gt2t+GiGjXDYei0Q@mail.gmail.com>
Subject: Re: [PATCH] t7450: make test "set -e" clean
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> In order to catch mistakes like misspelling "test_expect_success",
> we would like to eventually be able to run our test suite with the
> "-e" option on.
>
> Often we write "A && test_expect_success ..." and want it to mean
> "If and only if A holds true, this needs to be tested", but under
> "set -e", this will cause failure when A does not hold true.  We
> need to write "!A || test_expect_success ..." if we want to run the
> test conditionally.
>
> Or write it properly with if/then/fi, perhaps like:
>
>         if ! A
>         then
>                 test_expect_success ...
>         fi
>
> Make sure we do not fail unnecessarily under "set -e".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git i/t/t7450-bad-git-dotfiles.sh w/t/t7450-bad-git-dotfiles.sh
> @@ -220,7 +220,7 @@ check_dotx_symlink () {
> -       test -n "$refuse_index" &&
> +       test -z "$refuse_index" ||
>         test_expect_success "refuse to load symlinked $name into index ($=
type)" '
>                 test_must_fail \
>                         git -C $dir \

I suppose this is the absolute minimum change to make this work, but
typically we would handle this sort of case by defining a PREREQ,
wouldn't we? Using a PREREQ would also set a better example for those
new to the codebase.
