Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8785202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdKTWOz (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:14:55 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34795 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKTWOy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:14:54 -0500
Received: by mail-qk0-f170.google.com with SMTP id v137so9475978qkb.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1xUnDGyZO1EAI64ZMKOupodyfP3KP6dHgH6H9GgqNZs=;
        b=Q+r15v+4SI7z+9F818SPW5eCpQvBrWnGO0M0Vf/cgQVFYbWOa7yzYMbskcl2qEaWpl
         F0dQcnjdkYi5B5/3aaA/OoE4W1eXCNrQbvGzSXbUAqjiSQGJ2HT7x9DfaqT8fhHtE65G
         09zY3N1RY/N13RPg99DbMw61Uh+UVe2Ws81okuHOH6SaVkeeAOx87aO30Nb/2z93QHKw
         HSsv6uC5IQWhoXmUrfaAtN+EjIf1aUNl77m1lUumHlb4QpB8n05fYK57KKWaPujUZYf0
         RuvAlADxekyk3aHR24ZhNz4SV41AvyJKaREwC2t8stF0KYA9wzfRgtEiQhUUbjo0gVG1
         asOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1xUnDGyZO1EAI64ZMKOupodyfP3KP6dHgH6H9GgqNZs=;
        b=OA05+uhKdUL2mVElx/0BkRDXcyFk9s+5Dpmo8eIKpZmWO2R2esZr4w7N7m2KZ50Y2/
         p0KhGGEe4IW7ckArdPHbG6AD4sYffQMvgMY2T+7y3+uthP5CrspnTPrRm2fBAaL5sfov
         /8lxa2IYN6wanBu1omeMt8K1oMMPQdFhiT0zeuNak3EOnI4oJ7MEDoijDi1iR6jFabut
         yAV8q0zK2/3pSHk166xbLxZQcri/UF4SM5xt1jyDxvGS50JM20PN4RsJ3n2JW8eSAG3I
         t3kbMqwaJkYtU0b9en5vBlWuvPEyrMFJWtAMCzgYl7IMm8foFoqLgiF/UIuiZjXCMKWT
         GJmw==
X-Gm-Message-State: AJaThX6U0K1DvXo32YNr+kO4EPHVM5jbmgSFSqoK1SyeLnDWNaA7gOu8
        RZsmD2TROLJkrIManG8erM7fBT62ayNdNJRqBMM=
X-Google-Smtp-Source: AGs4zMYgn3GgUoP8e+0U/sUV0ZGZ2oSs3+xUWIiL+4SUuN3bKtlLDgMSSaUy5p6O09fxfX2T80w8OGsW+gsWiQK+PLE=
X-Received: by 10.55.42.75 with SMTP id q72mr23696820qkh.57.1511216093470;
 Mon, 20 Nov 2017 14:14:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 14:14:53 -0800 (PST)
In-Reply-To: <20171116154814.23785-1-alex.bennee@linaro.org>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 17:14:53 -0500
X-Google-Sender-Auth: c0Y7aEMUwArC2quNI7LhHhV9NGQ
Message-ID: <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few more comments/observations...

On Thu, Nov 16, 2017 at 10:48 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> diff --git a/perl/Git.pm b/perl/Git.pm
> @@ -936,6 +936,9 @@ sub parse_mailboxes {
>                         $end_of_addr_seen =3D 0;
>                 } elsif ($token =3D~ /^\(/) {
>                         push @comment, $token;
> +               } elsif ($token =3D~ /^\)/) {
> +                       my $nested_comment =3D pop @comment;
> +                       push @comment, "$nested_comment$token";

Due to the way tokenization works, it looks like you will only ever
see a ")" as a single character. That suggests that you should be
using ($token eq ")"), as is done for "<" and ">", rather than ($token
=3D~ /^\)/).

What happens if there is text before the final closing ')'? For
instance, "foo@bar (bibble (bobble) smoo)" or "...)smoo)". The result
is that "smoo" ends up tacked onto the end of the email address
("foo@barsmoo") rather than incorporated into the comment, as
intended.

What happens if you encounter a ")" but haven't yet encountered an
opening "(" (that is, @comment is empty)? For example, "foo@bar )". In
that case, it unconditionally pops from the empty array, which seems
iffy at best. It might be nice to see this case taken into
consideration explicitly.

I also was wondering if it would make more sense to take advantage of
Perl's ability to match nested expressions (??{$nested}), however,
that feature apparently was added in 5.10, and Git.pm only requires
5.8, so perhaps not (unless we want to bump the requirement higher).

Aside from those observations, it looks like the tokenizer in this
function is broken. For any input with the address enclosed in "<" and
">", the comment is lost entirely; it doesn't even end up in the
@tokens array. Since you're already fixing bugs/regressions in this
code, perhaps that's something you'd like to tackle as well in a
separate patch? ("No" is an acceptable answer, of course.)

>                 } elsif ($token eq "<") {
>                         push @phrase, (splice @address), (splice @buffer)=
;
>                 } elsif ($token eq ">") {
