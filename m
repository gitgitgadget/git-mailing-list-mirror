From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/6] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Mon, 4 Apr 2016 21:27:09 -0400
Message-ID: <CAPig+cQJ6EzJ0976NJBHXRZyuTf1dr+0ZOvzrCfiTVZOp6fXBA@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-3-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:27:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFlz-0004Cp-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbcDEB1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:27:13 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36497 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcDEB1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:27:10 -0400
Received: by mail-ig0-f195.google.com with SMTP id kb1so210976igb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CEtgHuixKBCSsJbOEKXbMElIJMMfCkR4Jx4xN9HfOXk=;
        b=dfsyAuc6M3A1WIM3EIoq4k6D57m7cUOXdnLJoHuHTFjmM5vNNVro/NOLQi0r6ti4og
         UEQjOJJNc1v3UU7ZBRSO92wW1JzB/jBaRVteJLJEEYylJImNE4FI/VXdHyy/wUX3ljZb
         JG/dCTttSk5B4F8q/5RWtu/PRwQwaj+PtK/brlq3NoMFDICAM5MNddnS7pcD9al0djjh
         X60AHLJKvtf3PthEFCQCYJ8C/QhYQlJbHtCRi/0bmYf+2jMD2+Lz1dIjmrGrA52QQCj4
         0KaI4RNP2GO2MPMImpWQRMguEIFyPjq9+FE3bp8HRhDWlSJOiXd0IEqTT3QyxCeXgS8g
         Ra1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CEtgHuixKBCSsJbOEKXbMElIJMMfCkR4Jx4xN9HfOXk=;
        b=TG/sI/oPBOk6rWT5OgwratDe04iWM13y9DR1JZMndYTdZyOCn1j2KC4loiR5Sd6jpo
         0TjHP5thSBWR92mLS1OC7U9XO5F2brpVyd1W+a9cBy/q6XENnvajl7s5upCElWokKPLi
         YAX8xS3voEHE2riidRP5E7Bvn3dBWPsQp/sWJz2d9Y5+N19HjywfPg2NVER55W44gBrK
         G6j/P8wOgv4O2XqFIjg55HbnlXmy17An1/vsBr1rtj+EreVFWf3+JcO7V+g0BncqoY+Y
         yAE6Bxh82i/C7vGRkr+DWDcf+mkCDxohr+LBnITsgn3Ea+UVXc3NpjRbgW+LlgJ/9WN6
         V1cA==
X-Gm-Message-State: AD7BkJKyUOOKvF44ORC90dAc+6Kq9Yp9brHrbdFNgr8YVxoeavYyXdeCP25KQ0s0jB7M2XY0QqTBa73YJZ+RRA==
X-Received: by 10.50.40.101 with SMTP id w5mr14110865igk.17.1459819629869;
 Mon, 04 Apr 2016 18:27:09 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 18:27:09 -0700 (PDT)
In-Reply-To: <1459808535-8895-3-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: o1LvUiaxdxYpxyMU7K1UStVaTdY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290746>

On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> t/t7030-verify-tag.sh: Adds validation for multiple tags

Rewrite:

    t7030: test verify-tag with multiple tags

The leading "t/" and the trailing "-*.sh" were dropped since they add no value.

> The verify-tag command supports mutliple tag names as an argument.

s/mutliple/multiple/

> However, no previous tests try to verify multiple tags at once. This
> test runs the verify-tag command against three tags separately and then
> compares the result against the invocation with the same three tags as
> an argument. The results shouldn't differ.

The bulk of this description is merely repeating what the patch itself
already says, thus is redundant. The entire commit message could
probably be collapsed to:

    t7030: test verify-tag with multiple tags

    git-verify-tag accepts multiple tags as arguments, however,
    existing tests only ever invoke it with a single tag, so add a
    test invoking it with multiple tags.

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
> index 4608e71..f9161332 100755
> --- a/t/t7030-verify-tag.sh
> +++ b/t/t7030-verify-tag.sh
> @@ -112,4 +112,16 @@ test_expect_success GPG 'verify signatures with --raw' '
> +test_expect_success GPG 'verify multiple tags' '
> +       tags="fourth-signed sixth-signed seventh-signed" &&
> +       for i in $tags; do
> +               git verify-tag -v --raw $i || return 1
> +       done >expect.stdout 2>expect.stderr.1 &&
> +       grep GOODSIG <expect.stderr.1 >expect.stderr &&
> +       git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> +       grep GOODSIG <actual.stderr.1 >actual.stderr &&

Hmm, I had expected you to adopt Peff's suggestion[1] for the greps:

    grep '^.GNUPG:.' ...

[1]: http://article.gmane.org/gmane.comp.version-control.git/290691

> +       test_cmp expect.stdout actual.stdout &&
> +       test_cmp expect.stderr actual.stderr
> +'
> +
>  test_done
> --
> 2.8.0
