From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 3/7] t0040-parse-options: improve test coverage
Date: Wed, 4 May 2016 04:36:54 -0400
Message-ID: <CAPig+cTW9=w8fMTwcF-Z6DPmXMM4qiWZA=7S1GcFEoGG8hPUtw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-3-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsIn-0005yn-D1
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664AbcEDIg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:36:57 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34312 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603AbcEDIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:36:55 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so5207437iof.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=62eeA1DohcuN/EVHgfPZVC2kRxjyqOzZvNhoVbJ4l/4=;
        b=DhvWy5uMww9DeIdyWmSVU45aNFuRNVDND6k7ngyqJK/43Kz3Z4wVFY4ilDFfIVMdfp
         zaQ6/k8pHqke/UUL71EX66M5sq1h4IlVSna7OKu24avnxWTkjV34PZ9Szd3dYnu41qw0
         9hYSsfWGqerUoRPCTQxQ2qo824n3nQqtN0CEuWE1ikSxu19UqsA6WSfgnw8qsQgHelsh
         VpwCoV320yTh7tIYrwhvMiUP4yF1ISVdv0GqaOdATpr8QhrXniut5slVWY1H+33rDMKt
         QFpCrG8WllQ8oPtZZmpIyYAptF+Fb/e1Z6GKg7CZIxS2mXvXYCN2ygA0KbRN0lcW96kT
         6Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=62eeA1DohcuN/EVHgfPZVC2kRxjyqOzZvNhoVbJ4l/4=;
        b=TjPDTPF9mGOgFXS3oKHw1U01m6K7DBBtDeWNGYWlXHmi6EwXwzB6JVIdxGoOFQeX0o
         Ndad4ni1xrQiQjh7rj5hD5Z115cmEx+7CovoxWm0q23YlJ1HbStqY2+1MosY/I26k7Dw
         keCGAqZ9h5lkkuC2KgFYcjE8Db5rCzaSuN8oHhnQkWXiYVncyFdzOXovTSa3oqQpr3fb
         NB6RLI2duenY/+uAFFZezBI5UZuCrgVl88wVZj94nscqPQQR5vRnR8HXH7JFXZyHgTDE
         VykpOY5gwAIAaVm+9PdqBt8Q8aSO09YU0+nac7PyVzM/bvPUPDqvh3MchpAnlnB7sJrZ
         yP5A==
X-Gm-Message-State: AOPr4FUsAg1mNP/UTQAg/fctuNxag8b3TU91/T/yXRuYliBFb7KIq7VaTuOiZP3ocXGCj70zKTj/02Ks0UUjEg==
X-Received: by 10.107.47.37 with SMTP id j37mr8671707ioo.168.1462351014800;
 Wed, 04 May 2016 01:36:54 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 4 May 2016 01:36:54 -0700 (PDT)
In-Reply-To: <1462046616-2582-3-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: u9m3seZvmsGNS_ziEYg7gE9AGNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293519>

On Sat, Apr 30, 2016 at 4:03 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Include tests to check for multiple levels of quiet and to check if the
> '--no-quiet' option sets it to 0.

As this patch is also adding a test of --[no-]verbose, the commit
message should mention it.

More below...

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -476,4 +476,61 @@ test_expect_success '--no-list resets list' '
> +test_expect_success 'multiple quiet levels' '
> +       test-parse-options -q -q -q >output 2>output.err &&
> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'
> +
> +test_expect_success '--no-quiet sets quiet to 0' '
> +       test-parse-options -q -q -q --no-quiet >output 2>output.err &&
> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'

It wouldn't hurt to have two tests for --no-quiet: one which tests
--no-quiet alone to ensure that 'quiet' *remains* at 0, and one which
tests --no-quiet in combination with some --quiet's to ensure that
'quiet' is *reset* to 0. These tests would give you good coverage for
changes by subsequent patches, such as the OPTION_COUNTUP patch which
flips the initial value to -1.

> +
> +test_expect_success '--no-verbose sets verbose to 0' '
> +       test-parse-options --no-verbose >output 2> output.err &&
> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'

One would expect to see 'verbose' get the same treatment of having a
test invoke --verbose multiple times. (Yes, I realize that the "long
options" test does just this, but testing multiple --verbose's is not
its primary purpose, so having a test which does test multiple
--verbose's as its primary purpose can be beneficial and is less
likely to be broken by someone in the future.)
