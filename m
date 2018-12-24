Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EC520A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLXUyg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 15:54:36 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:43601 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXUyg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 15:54:36 -0500
Received: by mail-vs1-f43.google.com with SMTP id x1so7751944vsc.10
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eIK9i32Od/Vhp4BLtaGxMpNKVDW1T+UEPybKb6we9zY=;
        b=Vo8JPiAeTlmS/q/1rcYNF7ymc6JUsFdEQ8JaXRCAvf/+FLWjVN/nuilvo+dNfgZHFL
         E9jT6qzJtvvx1Ngl5bXubNLb1DF1vJKKY3a7xvjAvJ19lEztRzqNQ3KTf5ebxXxQSRiv
         ZMH1bX1vptzmNraR2+0jqb1bTykVEGr7nrgMPfzUhfxVvgkQmHRAXREBeG+5CDR5iKXS
         DtYhMSrVye2aHThvaUpDqhAShBVCjjUAyQoCBLYihDoq/McN0uoNAdbXBBxc9Ial6ohQ
         8LIwAaNDNX3TvX9/flx5n3NkikH+5GAZ0bL9nn+30QIf6iuanQsa2HMuU2myinkVfLnD
         XIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eIK9i32Od/Vhp4BLtaGxMpNKVDW1T+UEPybKb6we9zY=;
        b=QTi42ScBA3Y08AQ7H8KETyQCbCqy6obUES7+1hdEmrN8LjZ8pk3E+mVi2J6jy3Sh8Y
         VIfdOd7E2GlD3TqtG17BsYNHdshBE5HCqIHu+PHAyvdj3qJc3/iXVqNzcDvD0nCb0lRY
         CeTF64Gbs0vhtVLCxqeVwDoEBssyv0XPKUI8/wS955e81WdxqKGBxMBwaqjgZb6XLx7L
         AbSa2bQBsZoEI8bL06rAhHy1D3KWTVNOJbtS9FOgo/IDz/KjdQ3WxW+uJE7HygK+0DzG
         KM0D1o1V9kpx38O2kQhhuNOoEMkbW6TNh0C9G585IbUUD8iOLcuhYbLqsUSByMQSTLcZ
         5gSw==
X-Gm-Message-State: AA+aEWYroCv9rsu5TiAZjZoKJrJrVxfyM1YQSMsUREESRbgdV5uErTBy
        /is+E5V8hLdC1oITEd1w3xrj+aCUcp60WXdF93eyaJrz
X-Google-Smtp-Source: AFSGD/VVzwKYxXZUe0E23+zcRQ1EIpmmDkIvtlb1pGdrDfiMYz01/qOtpxXTKQviQ3dud3c4QCaJXlONx/Fg/2pbjzg=
X-Received: by 2002:a67:5bdc:: with SMTP id w89mr5911845vsg.109.1545684874530;
 Mon, 24 Dec 2018 12:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20181220214823.21378-1-orgads@gmail.com> <nycvar.QRO.7.76.6.1812211659220.41@tvgsbejvaqbjf.bet>
 <CAGHpTB+9L55Gvezhb7x6Kb49WS_nfzmKdVvpH3_=6GM7y8YQ_g@mail.gmail.com>
In-Reply-To: <CAGHpTB+9L55Gvezhb7x6Kb49WS_nfzmKdVvpH3_=6GM7y8YQ_g@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 24 Dec 2018 22:54:23 +0200
Message-ID: <CAGHpTBLP2emg5L9vT9OPneapNP_6eHRXYF-9jT20ZkD07HJKJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5403: Refactor
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for reviewing this.

On Fri, Dec 21, 2018 at 6:06 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Orgad,
>
> On Thu, 20 Dec 2018, orgads@gmail.com wrote:
>
> > diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> > index fc898c9eac..7e941537f9 100755
> > --- a/t/t5403-post-checkout-hook.sh
> > +++ b/t/t5403-post-checkout-hook.sh
> > @@ -7,67 +7,48 @@ test_description='Test the post-checkout hook.'
> >  . ./test-lib.sh
> >
> >  test_expect_success setup '
> > -     echo Data for commit0. >a &&
> > -     echo Data for commit0. >b &&
> > -     git update-index --add a &&
> > -     git update-index --add b &&
> > -     tree0=$(git write-tree) &&
> > -     commit0=$(echo setup | git commit-tree $tree0) &&
> > -     git update-ref refs/heads/master $commit0 &&
> > -     git clone ./. clone1 &&
> > -     git clone ./. clone2 &&
> > -     GIT_DIR=clone2/.git git branch new2 &&
> > -     echo Data for commit1. >clone2/b &&
> > -     GIT_DIR=clone2/.git git add clone2/b &&
> > -     GIT_DIR=clone2/.git git commit -m new2
> > +     test_commit one &&
> > +    test_commit two &&
> > +    test_commit three three &&
>
> A very nice simplification (but please use tabs to indent).

Thanks. I already did. I sent these patches twice - first revision had
spaces, and the second one had tabs.

> > +    mv .git/hooks-disabled .git/hooks
> >  '
> >
> > -for clone in 1 2; do
> > -    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
> > +cat >.git/hooks/post-checkout <<'EOF'
> >  #!/bin/sh
> > -echo $@ > $GIT_DIR/post-checkout.args
> > +echo $@ > .git/post-checkout.args
>
> While at it, you could lose the space after the redirector that we seem to
> no longer prefer:
>
> > +echo $@ >.git/post-checkout.args
>
> And since we are already cleaning up, we could easily move use
> write_script instead, *and* move it into the `setup` test case (which
> makes it easier to use something like
>
>         sh t5403-post-checkout-hook.sh --run=1,13

Done.

> The rest looks good (modulo indentation issues). I would have preferred
> the separate concerns to be addressed in individual commits (one commit to
> replace the `awk` calls, one to avoid the clones, one to simplify by using
> `test_commit`, etc), as that would have been easier to review. But others
> might disagree (Junio recently made the case of smooshing separate
> concerns into single commits, even squashing two of my patches into one
> against my wish), so... I guess you don't have to change this.


I also like commit granularity, but since I'm not familiar with the
workflow in the mailing list, how to amend and resend commits etc. I
try to keep the number of commits low :)

Thanks,
- Orgad
