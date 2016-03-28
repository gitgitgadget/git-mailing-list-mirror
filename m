From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to use @{-1} with push?
Date: Mon, 28 Mar 2016 09:53:15 -0500
Message-ID: <CAHd499A-8iajchG7hUMKNnCN9riarU4G3S-HZxXusOdewwaVCg@mail.gmail.com>
References: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
	<xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
	<CAHd499B3Z58hj--Pa0uM36A2H3Xpmayrb+RiLeOBkmnu70yW1A@mail.gmail.com>
	<CAHd499BCciG5Udd_sj550jPKg_ahZmWOi-zUOU-cr_wYmri=Rg@mail.gmail.com>
	<xmqqoaa22xmg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:53:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akYXj-0003lR-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 16:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcC1OxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 10:53:19 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36692 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbcC1OxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 10:53:17 -0400
Received: by mail-vk0-f51.google.com with SMTP id z68so158341803vkg.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=E4uic8zKmnD/2JJYhVrBB/V94mOseh/twQ2Rp19eRhE=;
        b=fHwo/mqeuvKLLk+EqmE2BwgWtw8KQDK0wnGa8zJr4ZSEafqpBPlFFtzEf/vH6Tqp/x
         qCBpKUePrNSElERTxNrCCytIQROB5n44aaj9frKZueI9alENyVXAZqNdBrag3pYZtKHb
         96gmY/qiLOWYz9nN9UOQXUS9kP1ygK3PLsK/p+F8Q1wtmOArhPou8bJvpw7OrqqIq/rK
         L1Oij4GmaWxFRgh+YeLSaBDOxLsZa2uyMo41pQG00OtbsoqCQkRr7B1nlQi6sYdp1NI9
         vTG1OmSkBdtEvGn3yOwMogmLOrrPE60NSrCX+zsoB0AFKmKfn8wl5JatVZAO8aaYbCqu
         BxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=E4uic8zKmnD/2JJYhVrBB/V94mOseh/twQ2Rp19eRhE=;
        b=j1UenA/GnSFVIVAsMjStvl6295deg4Dh1ToFtEnqBg/d6nohKu71avqBcfdyRiZgBv
         C1ZGz7QHUnlm/6Lo3rp62ey73f5575iOUwW5AAdpBH7LU8t/sC3C6gBDjq/w6IykxhKq
         6k/AY6riPz25O/id0gDV9E1n2UxuIkCa9WUyG+G8oQwHA8x0JnEbisWKqDNuhW7WrC8H
         EZ50w3sbb+y/6izkzJJLpwG9a62LhAsk8jXteNpAWE4CowDYFlw1j/aeOxfgXxJ5rERv
         XIBtDjxPHKwAlDTQiM1HhZ5BhvX1npABQKQ/r/nq90mk9s3wto8X18SuKXAhyzPn/Rc+
         QVGA==
X-Gm-Message-State: AD7BkJIhpfm+idvjH+zkWMlyH0oFke8rT183W2A1mKYL1lkH36B+FXddSfyvozO5PELIxuM5yj/oapxPtg60VA==
X-Received: by 10.176.1.16 with SMTP id 16mr12857835uak.56.1459176796100; Mon,
 28 Mar 2016 07:53:16 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.66.68 with HTTP; Mon, 28 Mar 2016 07:53:15 -0700 (PDT)
In-Reply-To: <xmqqoaa22xmg.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: XajtrLgbBqDMoo2RqTr-BDUMrXo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290038>

On Fri, Mar 25, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I thought these are clear from their documentation.  "push" works on
> refnames, "branch" works on branch names.  "push" takes an branch
> name as a short-hand and adds refs/heads/ when it makes sense, but
> because it does not make any sense for "git branch" to create a
> "branch" in a random place in refs/ (e.g. "refs/tags/foo" is not a
> branch), it takes "foo" (i.e. the name of the branch, whose
> underlying ref is "refs/heads/foo").
>
> So
>
>         ref=$(git rev-parse --symbolic-full-name "$2") &&
>         case "$ref" in
>         '') echo >&2 "No such thing $2"; exit 1 ;;
>         refs/heads/*) ref=${ref#refs/heads/} ;;
>         *) echo >&2 "That's not a branch $2"; exit 2 ;;
>         esac &&
>         git push "$1" "refs/heads/$ref" &&
>         git branch -D "$ref"
>
> or something?

Reading the git documentation feels a lot like reading the C++
standard. Not the best place to go to learn something. Some of the
terminology is very detail-oriented. For example, until you explained
the differences between push & branch, I always thought "ref" and
"branch" were interchangeable. But now it's clear to me that a branch
is just a type of ref, but refs are not branches. Also as a Windows
developer, I am not as well-versed in bash scripting as I'd like to
be.

So thanks for your explanation, it is clear now.
