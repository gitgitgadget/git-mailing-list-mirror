From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sat, 16 Apr 2016 23:07:02 -0400
Message-ID: <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
	<1460823230-45692-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 05:07:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ard3L-0004DT-E0
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 05:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcDQDHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 23:07:05 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:32932 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcDQDHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 23:07:03 -0400
Received: by mail-ig0-f193.google.com with SMTP id g8so7231946igr.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8uqTyrUNT2KD8Fm6svqBQ7Enpbybf4vS9AxSTf66NTQ=;
        b=Aq0g958aCJZ6mqGMPAX1hwK0OsIG4YfAwn0kvKmGIKN0mshe1f7aQy4YnmhyfrZzzE
         x297lQLj5I41gCQyD2tzNNRSUoZnQxUCQL689iZNM8k6BiJ+1i3nSI7zwppXl8aRB1be
         hbX+W+dqoTI7XXZ1CEvDtUFU899ZpwHdssMmd5gmDJfyA6ti5fHgAae8Hlq7u/6GgfNS
         /Y1V7SQbrb7ULVcxUTTHxYA5t4ZupRvqWomX8HWPWEN8f0FSLeTkhR8U3ZNs5c52N7uI
         qvQS37ElmoksubiRZjXs1qeO67tUw104tRPF8gm3JSyPzjmJXq86s7iJA3Ay9PtaxEd3
         cVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8uqTyrUNT2KD8Fm6svqBQ7Enpbybf4vS9AxSTf66NTQ=;
        b=Fz3E5Db9PUwsIC8IkRoNI644HtW9WcGk4E30GQWxwKUXGgTu9nw0RUdOoxlgHsyq0s
         vVhBjWaw+0jHoThBR/AmbLGLP6CXKBpwx7zqxG8e26Mb066eG30n7uZzHPyf1AWTrFpG
         mnbyLKpqkCcPcNKAdOwSE9qg9ortnPfw6A/CAqm3jZ9tnpxsrgng8y5qMm6Kh94d1QRw
         njH+6SsC14g/KCcSCisaOPmNrjQsm2y063Vy+T+zoYYRLHXjV50PtJDuW8u+w5KY42B7
         GpPnAjvVs2iYb1aeKfZwdUg36WRGbXcOqKRyee6kR5DqhgxpWDfVHdI6qaeRp4zxqaio
         n0Ww==
X-Gm-Message-State: AOPr4FWbVRL5ryd0vezCm9QKXPZDgPZEISQOMh2PzTDHqdXKuuphBw20YYpFnhpzFqE6WGteYvj5LcgBbnGkWw==
X-Received: by 10.50.205.42 with SMTP id ld10mr12486453igc.17.1460862422234;
 Sat, 16 Apr 2016 20:07:02 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sat, 16 Apr 2016 20:07:02 -0700 (PDT)
In-Reply-To: <1460823230-45692-2-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: 1_zkQwaiF7JYETtDfW_ds_DDQWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291740>

On Sat, Apr 16, 2016 at 12:13 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> test-lib: add a function to compare an expection with stdout from a command

Rather long subject. Perhaps:

    test-lib: add convenience function to check command output

> test_stdout accepts an expection and a command to execute.  It will execute
> the command and then compare the stdout from that command to an expectation.
> If the expectation is not met, a mock diff output is written to stderr.

I wonder if this deserves more flexibility by accepting a comparison
operator, such as = and !=, similar to test_line_count()? Although, I
suppose such functionality could be added later if deemed useful.

> Based-on-a-patch-by: Jeff King <peff@peff.net>

Since Peff wrote the actual code[1], it might be worthwhile to give
him authorship by prepending the commit message with a "From: Jeff
King <peff@peff.net>" header.

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -941,3 +941,37 @@ mingw_read_file_strip_cr_ () {
> +#      test_stdout is a helper function to compare expected output with
> +#      the standard output of a command execution
> +#
> +#      Args:
> +#              1: The expected output
> +#              2: The command to run
> +#
> +#      You can use it like:
> +#
> +#      test_expect_success 'foo works' '
> +#              test_cmp "This is expected" cmd_to_run arg1 arg2 ... argN
> +#      '

test_cmp?

> +#      The output when there is a mismatch mimics diff output, but this
> +#      can break down for a multi-line result

Hmm, considering that $(...) collapses each whitespace run (including
newlines) down to a single space, I don't see how you could get a
multi-line result.

By the way, either the documentation should mention this limitation
("not possible to check multi-line output") or the implementation
should be upgraded to support it.

> +test_stdout () {
> +       expect=$1
> +       shift
> +       if ! actual=$("$@")
> +       then
> +               echo "test_stdout: command failed: '$*'" >&2
> +               return 1
> +       fi
> +       if test "$expect" != "$actual"
> +       then
> +               echo "test_stdout: unexpected output for '$*'" >&2
> +               echo "@@ -N +N @@" >&2
> +               echo "-$expect" >&2
> +               echo "+$actual" >&2

This faux diff output is quite a bit more noisy than the simple error
message emitted by Peff's original[1] and it doesn't provide any
additional useful information, so it doesn't feel like an improvement.
Adding quotes around $expect and $actual in Peff's error message would
probably be an improvement, though.

> +               return 1
> +       fi
> +       return 0
> +}

[1]: http://article.gmane.org/gmane.comp.version-control.git/291475
