From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Mon, 25 Jan 2016 17:58:22 -0500
Message-ID: <CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:58:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNq5c-0005r3-G4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbcAYW6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 17:58:24 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33372 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbcAYW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:58:23 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so6345064vkb.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p8Epa2Twc2Tfu1vMx7IyYEnRMXl9gYoD33btL23l/yk=;
        b=MJmGCREPVJnU4FEKM0/oMFIWjbYsOoeEXOHEOiC76DVlIMHRdfCXmo0vz/sjiPOFjf
         2TxsG7S+U3TANKLRs9/Ynx2sy+pPxr2wao5ptItXkrSwJDzNG/tqpaIaaZBDeLnY/2Iv
         lWy2lHkX7oOQhGVjrKf4M+2kv7Hc2exWKCXFFzS6JtxboR57vVVROpZLEG4Z9O2OPnV+
         ZspgKOIdbIPy5LSiRYYxfoGA9VPOvj0wJBi69tCFk1ExQNyG6DgtgZQbTZzJESZZiIli
         JEbseNjBBhOiWdGozZNbqVGxSPdsWsIJMMaDr2OZVK3PgX9KbeSCSiSntJZECWsVsw9j
         tP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p8Epa2Twc2Tfu1vMx7IyYEnRMXl9gYoD33btL23l/yk=;
        b=Fya/K7Ql50VjnlEL0bukMCy6bf+UJcaOQRVxc8pR3ap3QK+oJ7MtRvsaos0abPeL2S
         xrLCdiSKV7mg1RhHiOWPeQ0Y694cpmvz59ntOzaDTC9jexQ1xIZLtn3l/wPJAkUtpyjg
         XvLRv2wMuAl1qRXRawgO3W8rm16FRb5XhBBL9Uy55Sb/ViKZRyR6VpZCBElWa8PFHr2R
         KZUaZVDSkR7glyMhl5Z8v/fAuzTKlepplm6NsmPKcPI6L8+/2ZHFgYK5icD+sKgcEq7/
         8JPhH1M+JQ+JRinWRNXVY6PVmZQmi87hJMD9UJ0gdL6YFYUSCWlTQRr8zIx1xQEIhvTl
         vfZA==
X-Gm-Message-State: AG10YOSBE46Qejezzbg+O75oPJfI2TsdbIbFEln7ThhtwVOMHJkBKKmAOT6b2nrB2+GW2OW5o81Edida5BEAGQ==
X-Received: by 10.31.41.20 with SMTP id p20mr6093046vkp.151.1453762702256;
 Mon, 25 Jan 2016 14:58:22 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 25 Jan 2016 14:58:22 -0800 (PST)
In-Reply-To: <1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: UxFc6syfPA_QIbee3dzNK2uofFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284766>

On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce optional prefixes "width=" and "position=" for the align atom
> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>
> Add Documetation and tests for the same.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fe4796c..0c4417f 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -133,6 +133,47 @@ test_expect_success 'right alignment' '
> +cat >expect <<-\EOF
> +|       refname is refs/heads/master       |refs/heads/master
> +|        refname is refs/heads/side        |refs/heads/side
> +|         refname is refs/odd/spot         |refs/odd/spot
> +|     refname is refs/tags/double-tag      |refs/tags/double-tag
> +|        refname is refs/tags/four         |refs/tags/four
> +|         refname is refs/tags/one         |refs/tags/one
> +|     refname is refs/tags/signed-tag      |refs/tags/signed-tag
> +|        refname is refs/tags/three        |refs/tags/three
> +|         refname is refs/tags/two         |refs/tags/two
> +EOF
> +
> +test_align_permutations() {

Style: in shell scripts, add space before ()

> +       while read -r option; do

Style: drop semi-colon and place 'do' on its own line

> +               test_expect_success 'align permutations' '

This title is not as illuminating as it could be. It would be better
to indicate which permutation is being tested. For instance:

    test_expect_success "align:$option" ...

Note the double-quotes. Or:

    test_expect_success "align permutation: $option" ...

or something.

> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&

This is not wrong, per se, but referencing $option inside the
non-interpolating single-quote context of the test body makes it a bit
harder to understand than it need be. As it is, at the time that the
test body actually gets executed, $option still evaluates to the
desired permutation value so it works. However, it would show intent
more clearly and be more robust to use a double-quote context to
interpolate $option into the git-for-each-ref invocation directly
rather than allowing the test body to pick up the value at execution
time.

Fixing this means using double- rather than single-quotes for the test
body, which means you'd also want to flip the  double-quotes wrapping
the --format= argument over to single-quotes. Also, for style
consistency, indent the test body. The end result should be something
like this:

    test_align_permutations () {
        while ...
        do
            test_expect_success "align:$option" "
                git for-each-ref --format='...$option...' >actual &&
                ...
            "
        done
    }

> +               test_cmp expect actual
> +               '
> +       done;

Style: drop the semi-colon

More below...

> +}
> +
> +test_align_permutations <<-\EOF
> +       middle,42
> +       42,middle
> +       position=middle,42
> +       42,position=middle
> +       middle,width=42
> +       width=42,middle
> +       position=middle,width=42
> +       width=42,position=middle
> +EOF
> +
> +# Last one wins (silently) when multiple arguments of the same type are given
> +
> +test_align_permutations <<-\EOF
> +       32,width=42,middle
> +       width=30,42,middle
> +       width=42,position=right,middle
> +       42,right,position=middle
> +EOF

Overall, this version is much nicer now that the tests are
table-driven rather than each permutation being copied/pasted.

This is a tangent, but it's disappointing that this entire test script
is skipped if GPG is not installed, especially since none of these
tests seem to care at all about signed tags. By requiring GPG
(unnecessarily), these tests likely are not getting run as widely as
they ought to. Consequently, it probably would be a good idea to drop
the GPG requirement from the top of the file and have the "setup" test
create lightweight tags ("git tag ...") rather than signed ones ("git
tag -s ...").
