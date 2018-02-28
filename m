Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A261F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeB1AoM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:44:12 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44013 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1AoM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:44:12 -0500
Received: by mail-vk0-f67.google.com with SMTP id p189so449200vkd.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CgP3DT7esy+lzMP+21rrwy8ryrTMAFbtzAghDFKiMnI=;
        b=gyZfS0D+bbpZCbhgpXB1yCX0NMHhhcu22VMw8r8+oKAGEur4T9gqtT78ucE3VOnn21
         B+baRvwQjkJkCV9L3bYMGLa8QAM7Zc3NqmM6DWn8tBP9xruaVeaAKn0ncWUhyGedriW1
         BhGyXEOH7Hn9t3jPTlht6evOdnJlMexCD7pnjCy/ghq+FJIVy9Oz6TL8p4YUFoI7CiZn
         V3AtUQhn0R9ThdnoslENKBwHOfAv1Cbpmhxck3pt6yM/LYZ0r3VuEGN6cG/E04CG9R0Y
         tor/zg4Jm+1KrnQyCgu9OdYPyze2uomWKypFMktGj+bNGCS/O9hVNSxz6M63s/Eivhkb
         R52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CgP3DT7esy+lzMP+21rrwy8ryrTMAFbtzAghDFKiMnI=;
        b=RvR5+UM5LDH+jdVSGHmPjjVllNrB1drRAUqr87Kdkld4yWbk41fH9TWV4J4wXOggdg
         a3xZzP6ahLm+ZsQSOgTOeclIuoV4MtH2zJtKk1NhBYLh9r3rpFcwYJlt6hs3knRqYxes
         J27VCTxxrYmevTZmEn+xaVckmRHArhrwTbBoXvimp0KY841IS74uv6bozGg2vNslhFAH
         GVIKCmSc3YuBREic22O8XrsTO1AyC0J1nb8/CnuybwEZ2tkxJuQpWYapgbWszVgiDwE0
         Q27xB6TZgAlOAmkeRWkDx4tbDQFk885vwImYZ77aXmRjywuiGZxTJf5nMBbQRvGDL+5b
         B0sg==
X-Gm-Message-State: APf1xPAzL4i137j2X39dmTxaVPZWXIwsUldRXak+YV+JISK17CUefPJu
        uDvv4R02dgmisYryy3e6fR7RBLecNcH7FV6dpw0=
X-Google-Smtp-Source: AG47ELsSbkod+eZ6r1bC5lcGtbc9KdvUQlhJB9qf4U8q1CSq7yEq3iFga+I2ueOqr1BjzKR3UE/kHlzxb7fGU9GHoZE=
X-Received: by 10.31.223.135 with SMTP id w129mr12739545vkg.48.1519778651350;
 Tue, 27 Feb 2018 16:44:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Tue, 27 Feb 2018 16:44:10 -0800 (PST)
In-Reply-To: <xmqqlgfep1x7.fsf@gitster-ct.c.googlers.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180223233951.11154-5-szeder.dev@gmail.com>
 <xmqqlgfep1x7.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 28 Feb 2018 01:44:10 +0100
Message-ID: <CAM0VKjmxT=KE4OR5KtkWx0Tk=ddBjWt6HQn=BGgXaxm4NTmA0Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> +             git read-tree -i -m $c3 2>actual-err &&
>> +             test_must_be_empty expected-err &&
>> +             git update-index --ignore-missing --refresh 2>>actual-err =
&&
>> +             test_must_be_empty expected-err &&
>> +             git merge-recursive $c0 -- $c3 $c7 2>>actual-err &&
>> +             test_must_be_empty expected-err &&
>> +             git ls-files -s >actual-files 2>>actual-err &&
>> +             test_must_be_empty expected-err
>
> Also, with the error output of individual steps tested like this
> (assuming that test-must-be-empty checks are to be done on
> the actual-err file, not ecpected-err that nobody creates), I do not
> see a point in appending to the file.  So perhaps squash this in?

Agreed again.


>  t/t3030-merge-recursive.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index cbeea1cf94..3563e77b37 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -526,13 +526,13 @@ test_expect_success 'merge-recursive w/ empty work =
tree - ours has rename' '
>                 export GIT_INDEX_FILE &&
>                 mkdir "$GIT_WORK_TREE" &&
>                 git read-tree -i -m $c7 2>actual-err &&
> -               test_must_be_empty expected-err &&
> +               test_must_be_empty actual-err &&
>                 git update-index --ignore-missing --refresh 2>actual-err =
&&
> -               test_must_be_empty expected-err &&
> +               test_must_be_empty actual-err &&
>                 git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
> -               test_must_be_empty expected-err &&
> +               test_must_be_empty actual-err &&
>                 git ls-files -s >actual-files 2>actual-err &&
> -               test_must_be_empty expected-err
> +               test_must_be_empty actual-err
>         ) &&
>         cat >expected-files <<-EOF &&
>         100644 $o3 0    b/c
> @@ -551,13 +551,13 @@ test_expect_success 'merge-recursive w/ empty work =
tree - theirs has rename' '
>                 export GIT_INDEX_FILE &&
>                 mkdir "$GIT_WORK_TREE" &&
>                 git read-tree -i -m $c3 2>actual-err &&
> -               test_must_be_empty expected-err &&
> -               git update-index --ignore-missing --refresh 2>>actual-err=
 &&
> -               test_must_be_empty expected-err &&
> -               git merge-recursive $c0 -- $c3 $c7 2>>actual-err &&
> -               test_must_be_empty expected-err &&
> -               git ls-files -s >actual-files 2>>actual-err &&
> -               test_must_be_empty expected-err
> +               test_must_be_empty actual-err &&
> +               git update-index --ignore-missing --refresh 2>actual-err =
&&
> +               test_must_be_empty actual-err &&
> +               git merge-recursive $c0 -- $c3 $c7 2>actual-err &&
> +               test_must_be_empty actual-err &&
> +               git ls-files -s >actual-files 2>actual-err &&
> +               test_must_be_empty actual-err
>         ) &&
>         cat >expected-files <<-EOF &&
>         100644 $o3 0    b/c
