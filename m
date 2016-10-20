Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CA820986
	for <e@80x24.org>; Thu, 20 Oct 2016 05:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbcJTFyN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 01:54:13 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33295 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbcJTFyM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 01:54:12 -0400
Received: by mail-yw0-f171.google.com with SMTP id t192so37793445ywf.0
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hiqkQi7DgB7aQoUKSB59ja0Ww5F+XKYnX06C3RaJjhk=;
        b=DMcaOXb1MUcxy6SREWsCgjwtVCKAXd42AcVl13NqvjCmpVr74eNduJIEmnFoDikWJY
         z+Fqu1yh0yMwJbjhjWWYlIkRlDUHL7lOhP6rHEABdqy6anMb4sDLvGukwVH6mADMp0ox
         NHsKMyuE6sjax+UiFXme7v7FGsUY0NKDGQrm4Js2aElqYD/B4A7s0xvmOxXUlIclV63X
         WjAUelt/XjNqOF0ENslJGnwWv0Z26gEodawJsuqy3/vLsA3DMu9XlIm79XPO9aV/jphz
         ZuvUuag6T37UBrBAq67HtUzDsr7KeiQ3PvcBlflUCFFmVUOP3eL1d1vWpfNyp2Sqn3BK
         0sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hiqkQi7DgB7aQoUKSB59ja0Ww5F+XKYnX06C3RaJjhk=;
        b=izwgdiAHaGeqBAoacckyf9soaw3QNpC94D3lPA2QpGbUhDDltvGb2POiNETiTGVWMR
         91wzd8FBRR3oXeFhiEZcaaFnrEYUflmserxhXIjRop/R/IKAswVzEca4F2Bhw4Z1uP0t
         JadPR+CEBiBE0My0Tgyd078PsmMlCash6zwEuOd3+v90zPA6B8AU7NwJWYcgCUBrLZVd
         0zPOBSj7BxqZQI6xirSKh/5W2+WEYxIPxBnpDTqhOxKdTXof5GElHFfnz60bKIJUOkF7
         oIKnUSeuONBvDo4c6d778Ye6MZxCPJaKZdf0M9ufCY6VN4cgDD65sJSWGhevXxpYNYaI
         1BZQ==
X-Gm-Message-State: AA6/9RluFdRoHUAGe9FEoQv3TwSk/XhnKggpz55zHijPelNpGBuCp3ijRdQDpLsN6ASVTVI+vOV8ciyxIC85yw==
X-Received: by 10.129.102.85 with SMTP id a82mr10229721ywc.160.1476942851669;
 Wed, 19 Oct 2016 22:54:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 19 Oct 2016 22:53:51 -0700 (PDT)
In-Reply-To: <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 22:53:51 -0700
Message-ID: <CA+P7+xokV9CJ-XRyGn8yU7cinc+KvOfL3zMw4Dfdx4LxULSiHA@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 7:13 PM, Jeff King <peff@peff.net> wrote:
> I suspect both of those would complain about legitimate workflows.
>
> I dunno.  I do not ever use "git commit <file>" myself. I almost
> invariably use one of "git add -p" (to review changes as I add them) or
> "git add -u" (when I know everything is in good shape, such as after
> merge resolution; I'll sometimes just "git commit -a", too).
>
> But it sounds like you want a third mode besides "--include" and
> "--only". Basically "commit what has been staged already, but restrict
> the commit to the paths I mentioned". Something like "--only-staged" or
> something. I do not think we would want to change the default from
> --only, but I could see a config option or something to select that
> behavior.
>
> I suspect nobody has really asked for such a thing before because
> separate staging and "git commit <file>" are really two distinct
> workflows. Your pain comes from mix-and-matching them.
>
> -Peff

No. What I want is to *prevent* mix-and-match from happening.
Basically, sometimes I use "git add -p" to stage changes. But if I
just did a "git diff" and I know all the changes that I want are in
the file I will just do "git commit <file>" or "git commit -a". The
problem is that sometimes I stage stuff, forget or just make a brain
mistake, and I go ahead and use "git commit <file>"

What I want is to make it so that when you run "git commit <file>"
that it is smart enough to go "hey! You already staged something from
that file in the index and it doesn't match what you're asking me to
commit now, so I'm going to stop and make sure you either reset, don't
run "git commit <file>" or run "git commit --only <file>" or similar.

It's just about making it so that if I happen to make the mistake in
the future it doesn't generate a commit and instead tells me that I
was being an idiot. I don't want this check to just be "you can't
stage with the index and then tell me to commit -a or commit <files>"
because I think that's too restrictive and might make people complain.

Essentially, I want the tool to become smart enough to make it so that
an obvious mistake is caught early before I have to undo things.

That being said, it's much less of a pain point now that I know I can
go "git reset -p HEAD^". It never occurred to me that git reset -p
would work that way, so I didn't even try it.

Thanks,
Jake
