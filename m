From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] t6030: explicitly test for bisection cleanup
Date: Fri, 27 May 2016 23:27:12 +0530
Message-ID: <CAFZEwPMyts8msEgdHOiPfC-_HEXp8SJ7-8FQScr-af=5tSxq7w@mail.gmail.com>
References: <1463134469-26071-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	chriscool@gmail.com
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 19:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6M0d-0007WO-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbcE0R5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:57:15 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36461 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbcE0R5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:57:13 -0400
Received: by mail-yw0-f194.google.com with SMTP id l126so7220977ywe.3
        for <git@vger.kernel.org>; Fri, 27 May 2016 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=EHef0TVqXikg+ltjmq0lU62MoIdBVLIho043eHjXfgs=;
        b=j/rq9vE8IRrw1Rn8WN3Mu5MKn7XRLe60XZ4FUKjQU8TfrmlOG0Gt5PDya4Y+agD33M
         XLHGI466nBiCIPeK4a8KIaCj+aKgmzLelvvSYDcU7+HpJvBYqrcENqkqqkD8NazF5t3X
         LpiMBQa2iXYkshbCAw/bJbwnLUPmrn5MAZX1SLIDzuqgJZHlcFq8jPsD+NGL5z08aDlm
         ZFeJzuFmywhuIpWzydrmp1/nZmXtnSmJUvf6lGZM+hdEZJOlv6ZFl7lsu4JpA17Rs6QE
         PuI11PwtPnSOdbq8rpWfudEwZegI+/iNiqmqRmkPYt0b5Hnjc0cwX/tPp7zL1iI7H4Fp
         2LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EHef0TVqXikg+ltjmq0lU62MoIdBVLIho043eHjXfgs=;
        b=Xz8PKJRTUqONGUm3hhxW86M6+qPWlts6m5qsw56mTh5NNu4aPTipO1xcfBAWYooJ8o
         fQwvKncOU+kGJEaaOv+hKqs0O/FB7sLNrqSAZdmQIGecJEEo2w9lFYn1rHiqRzCh9foY
         W3l6v3CV/wxlEIEbnxDmEr1Dd7WaWEo/nq6VYswBA9CMgkgjWe6HEj98rXnHdeVrHQwr
         S6c9B8IqfSOTxTkpim94T2wLsAj0xntsxi943g1CzBxGhvvnzEO9GMAa6DfhMBhF/GZ7
         ttKddivIQ3IEF5eKLI03GNCaLen8E1GChCrkBerhOqKa8Gx2k4T4nafeUFr3buu7isPM
         ZZ2g==
X-Gm-Message-State: ALyK8tIjsyuZS95rjjYxCULXr6RoBgex0FzwgOAfKk+ra6nvcUFwAHDuwjeWdn0SwZvRsPrJmwkqE2Jg9bPrBA==
X-Received: by 10.129.134.133 with SMTP id w127mr9093874ywf.252.1464371832477;
 Fri, 27 May 2016 10:57:12 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Fri, 27 May 2016 10:57:12 -0700 (PDT)
In-Reply-To: <1463134469-26071-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295779>

On Fri, May 13, 2016 at 3:44 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> This is not an improvement in the test coverage but it helps in making
> it explicit as to know what exactly is the error as other tests are
> focussed on testing other things but they do indirectly test for this.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> I faced this problem while converting `bisect_clean_state` and the tests
> where showing breakages but it wasn't clear as to where exactly are they
> breaking. This will patch  will help in that. Also I tested the test
> coverage of the test suite before this patch and it covers this (I did
> this by purposely changing names of files in git-bisect.sh and running
> the test suite).
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index e74662b..1fb5ad9 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'git bisect reset cleans bisection state properly' '
> +       git bisect reset &&
> +       git bisect start &&
> +       git bisect good $HASH1 &&
> +       git bisect bad $HASH4 &&
> +       git bisect reset &&
> +       test -z "$(git for-each-ref "refs/bisect/*")" &&
> +       ! test -s "$GIT_DIR/BISECT_EXPECTED_REV" &&
> +       ! test -s "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> +       ! test -s "$GIT_DIR/BISECT_LOG" &&
> +       ! test -s "$GIT_DIR/BISECT_RUN" &&
> +       ! test -s "$GIT_DIR/BISECT_TERMS" &&
> +       ! test -s "$GIT_DIR/head-name" &&
> +       ! test -s "$GIT_DIR/BISECT_HEAD" &&
> +       ! test -s "$GIT_DIR/BISECT_START"
> +'
> +
>  test_done
> --
> 2.8.2
>

Anyone any comments?

Regards,
Pranit Bauva
