From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 09/12] ref-filter: align: introduce long-form syntax
Date: Thu, 4 Feb 2016 19:00:40 -0500
Message-ID: <CAPig+cQCLDvWfzWqoLq9xKsMO7FPKYSn0HxtKizhMv94hxXyBg@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-10-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:00:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTpO-0006Or-9H
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbcBEAAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 19:00:42 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34667 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758240AbcBEAAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 19:00:41 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2075065vkh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mBLfVVervrOSPszoFDjqTZ2g9N7nnWki/KnnfZZzPbY=;
        b=aKFnSUHHpjIIn1IitvRbqHBQHm7Ndmb0P/ZmpX/GSi45S8kLaTDKONpsmiXnG4hFqr
         gqx7z+egvSMK4sDbfL5LK3VTq7eXaofKTurPGX/fOCvzGZlhYcWmqJP/ivpYPOg+maz5
         XZf4FvT3UXjqqE2Qb9JqynttYNs5mrq9H8yXo1gIyFlu+cE2OS+PdKUM6wHuEAnFS+l4
         xYKGlUhq3rmhTJA4+eDGqSy//0hadgCvhR7xTgo//9GWymjIBQPNPC4cvu4K4IqAzrRh
         0xUE084dDlr+LZzqvXpFUuGfdrzXfE6HsyT8VTkcbbsFBbT0Wq83FVjWKZpErMVe51w9
         BE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mBLfVVervrOSPszoFDjqTZ2g9N7nnWki/KnnfZZzPbY=;
        b=PHBjBMwtT/mu/i++Kl2V/3CWRYzxixqnjiU8xcYlR/uritRS/+a0B5WbzOq7QA+xcz
         1wDmRGHe4twzOZGpjHi10/h+Vur4sjhnrvvrUb6VwIAi2E2/Ibk1Dgdr5JgKK8VJ9/V7
         ku1WKsHlEwGXtJVFaVPvEstCeWWLj4PyXJiKL/vUvYF46wxeA7FwtUshIfGA8CX8Q5AE
         l0haZhB4I1EkPh6RVze5yz6UTzFbdbKzlrlQpsnb61+d5WudpfjtCmLaZXdBT5kQH6H1
         WnFnenjRyPD+El/MYSDfjrKh53OC4Z1vipgkSZbzX9+UhNzO+X/oURPAM7iuooFIOk6h
         8JUQ==
X-Gm-Message-State: AG10YOQKMqoI0aqn6sgidjLEfqqoFKrvHZ8OvYEDz1tEaArSXdEW7XrT9FbYZ0UV3yfIV7jAUwWnY3Qfv+xTjQ==
X-Received: by 10.31.168.76 with SMTP id r73mr7484091vke.117.1454630440648;
 Thu, 04 Feb 2016 16:00:40 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 16:00:40 -0800 (PST)
In-Reply-To: <1454262176-6594-10-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: aeAErxrKL_FOooGNJTq_Z08VU3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285526>

On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce optional prefixes "width=" and "position=" for the align atom
> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>
> Add Documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> @@ -133,6 +133,48 @@ test_expect_success 'right alignment' '
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
> +       while read -r option
> +       do
> +               test_expect_success "align:$option" '
> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
> +               test_cmp expect actual
> +               '

I think I mentioned this in the last round: The two lines following
test_expect_success() are actually the test body, thus should be
indented one more level. (Not necessarily worth a re-roll, though...)

> +       done
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
> +
>  # Individual atoms inside %(align:...) and %(end) must not be quoted.
>
>  test_expect_success 'alignment with format quote' "
> --
> 2.7.0
