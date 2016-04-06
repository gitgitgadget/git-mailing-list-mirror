From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple tags
Date: Wed, 6 Apr 2016 02:21:38 -0400
Message-ID: <CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-3-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angqY-0006je-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760197AbcDFGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:21:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35869 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbcDFGVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:21:40 -0400
Received: by mail-io0-f195.google.com with SMTP id s2so5799961iod.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Bv9xfPz9UpDd6/lE+aDCol1/mY7xnG/v6j/wjDgYY9c=;
        b=N/w+Tq4rYf9baO8GTsvJH/M8cnT5AssBJRHIGmlwdJUEasjPiOR7z5tzYVeFJA/u4s
         PrmR3ZUhfjfU3sFAgg4aHfYtD4WDi8a8Hq3piddaUFkrj2vkt5EU2IuqyTsjPmGmeFiG
         uTrmD05j1eBKM8Pjf7gU/eCPc53VmOv5MDJku4b6xhM0Jce1yUwxv5hlSBvNJbe6vuU6
         NVtDkfQuL2mbaIxpcMaazvIvjpO6ATpeBK5YH7i8O7gvm8ETdSE89LyPI/15eembSq+K
         TiUQqsKqWm4LSCNj79tkCdar9nt9+AP5b4xn99/HIqw1/aH/DzPVFfKnI0FK85VWiSf4
         4RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Bv9xfPz9UpDd6/lE+aDCol1/mY7xnG/v6j/wjDgYY9c=;
        b=DHDWlclvGxtQH91XL2FHoBmvhxrl3Ux6biN+wAp3+jgFCJeZ7Mg0AGO+UiPYsfMtex
         6WkjxKVQ4/DLfc+D+So4GyJRLI/PY7dWS7PH8mzlaUT3p5Sj2/Q46/k8Rmxfw4KnuHVU
         7ksnsZ/X9pUbgaT52q1Gmj67V6jONw9cVzKBxNRlcT9zdElSscTF5Am5WwGvqrds9dcQ
         VSt37LDDCrQH80Ufbh4F0KY7caGWAN+N9UKSLZB87Z6Pt19HJc7rSpQoa7FlYLV/X7wE
         npmJ+JNHTFSJXrwzqEJwrHpZWtFn1QSbR5yIwNj0Vq1aZX7A7JMLB4J2JHtvsOg2qQvH
         0bvA==
X-Gm-Message-State: AD7BkJI+rJMuUTWvV94geIKmPAGrWK78hw1omdvqhNhreRRsZmTYkRZQyuf/QT3Q1qqPOtjAW5daay0kVY26cw==
X-Received: by 10.107.9.28 with SMTP id j28mr16287677ioi.104.1459923699039;
 Tue, 05 Apr 2016 23:21:39 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Tue, 5 Apr 2016 23:21:38 -0700 (PDT)
In-Reply-To: <1459872449-7537-3-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: sBuuhpqTh6K1SMZ1TcqTy07C7fM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290826>

On Tue, Apr 5, 2016 at 12:07 PM,  <santiago@nyu.edu> wrote:
> t7030-verify-tag: Adds validation for multiple tags

s/t7030-verify-tag/t7030/
s/Adds/add

> The verify-tag command supports multiple tag names as an argument.
> However, existing tests only test for invocation with a single tag, so
> we add a test invoking with multiple tags.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
> @@ -112,4 +112,16 @@ test_expect_success GPG 'verify signatures with --raw' '
> +test_expect_success GPG 'verify multiple tags' '
> +       tags="fourth-signed sixth-signed seventh-signed" &&
> +       for i in $tags; do

Style: 'do' on its own line; drop semicolon

    for i in ...
    do
        ...
    done

> +               git verify-tag -v --raw $i || return 1
> +       done >expect.stdout 2>expect.stderr.1 &&
> +       grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&

Hmm, is there a reason you didn't stick with the more strict regex
Peff suggested?

    ^.GNUPG:.

(Genuine question: I'm not saying your choice is wrong, I'm just
interested in the reasoning behind the decision.)

> +       git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> +       grep "^.GNUPG" <actual.stderr.1 >actual.stderr &&
> +       test_cmp expect.stdout actual.stdout &&
> +       test_cmp expect.stderr actual.stderr
> +'
> +
>  test_done
