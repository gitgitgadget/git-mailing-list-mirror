Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF721F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937926AbcKNThb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:37:31 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35556 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936411AbcKNThQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:37:16 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so8532891ywh.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g2GYqStLZ+bzQcoDvfDnGMGWPIZpF4yiO4MfRv09QXM=;
        b=hJ/hWH7aSKAddWJs2VUMATvQMpQVUeNDBuGnTOLv5CCspwvKiDY26WBFUJOF1l4grH
         2czuGZp0aDqawhfHj7Se4KyH+5RGKbV+eSuhDqhcWYlcHShMC2goIb6dvMDESENeI0zw
         i/k6IEVdpj9lFDsPf28Izeysr7jVPD0/AgoO3Qw25bWLhniWA8FcqGrjd0HCOIfmVBPv
         dMd48l2JXqazjb2Wx+irkFSXX/XKvOx2uH9Hhs4q6YZb7m8PWGL7V62hfAq/eRRlH30+
         Ir/GOfjVzLe0GddzHzVktdAmemqMvlEduT9Y7yqc1jHcBMJLGs3VEE9rCXxOyWKreuHz
         mxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g2GYqStLZ+bzQcoDvfDnGMGWPIZpF4yiO4MfRv09QXM=;
        b=h98ML+jmEP1bJaAQa8Jntq8fg+8oTgCcR1NrhGDE82IkXWeoS6pa6pJO9s2Yb07BRi
         PA/DAuHaOVoqnE2p+3kfKiuZzgZ6kOQx6plV//lzGwIEkZM+DKkGEyLX/5rBp1rx0jAI
         hwaTaccuj1/lsdmnHwnx1MEM8ZSjaacRWL+mMFSjZnf34kthshug7FWagc//ZJFLvgvd
         CtygvS8YfytsD9nbQvX8uNFJplaMDW/mccvl8dPqvlAP2hv15X0ThRavuoXrXnDY02N5
         EFqlDFjHBJ0FX48MZGkmkFKMW0PcMvkApyj6+MlkLvUY+1yQMDFM1pPyzDGs3H4veBVM
         Gp0w==
X-Gm-Message-State: ABUngvd+J4atGfmIdRhc5SrVmPavD9Atfb3GfMAZ/p2w8xRn7Bp4PBPpa8BOIaYsEHT3d50c+hluxQRr8pZGZw==
X-Received: by 10.129.70.198 with SMTP id t189mr15817545ywa.131.1479152235839;
 Mon, 14 Nov 2016 11:37:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Mon, 14 Nov 2016 11:36:45 -0800 (PST)
In-Reply-To: <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com> <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 15 Nov 2016 01:06:45 +0530
Message-ID: <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 7:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>>> index 600b703..f4ad297 100644
>>>> --- a/Documentation/git-for-each-ref.txt
>>>> +++ b/Documentation/git-for-each-ref.txt
>>>> @@ -96,7 +96,9 @@ refname::
>>>>         slash-separated path components from the front of the refname
>>>>         (e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
>>>>         `<N>` must be a positive integer.  If a displayed ref has fewer
>>>> -       components than `<N>`, the command aborts with an error.
>>>> +       components than `<N>`, the command aborts with an error. For the base
>>>> +       directory of the ref (i.e. foo in refs/foo/bar/boz) append
>>>> +       `:base`. For the entire directory path append `:dir`.
>
> Sorry that I missed this so far and I do not know how many recent
> rerolls had them like this, but I am not sure about these :base and
> :dir suffixes.  From their names I think readers would expect that
> they do rough equivalents to basename() and dirname() applied to the
> refname, but the example contradicts with that intuition.  The
> result of applying basename() to 'refs/boo/bar/boz' would be 'boz'
> and not 'foo' as the example says.
>

True that the options ':dir' and ':base' seem to be conflicting with
the use case
of basename() and dirname(), These were names which I thought best fit
the options
with no relation to basename() and dirname(). But now that you mention
it, it would
make sense to change these names to something more suitable, any suggestions
would be welcome.

> So assuming that :base and :dir are unrelated to basename() and
> dirname():
>
>  - I think calling these :base and :dir may be misleading
>
>  - More importantly, what do these do?  I do not think of a good
>    description that generalizes "base of refs/foo/bar/boz is foo" to
>    explain your :base.

$ ./git for-each-ref --format "%(refname)%(end) %(refname:dir)"
refs/heads/master                  refs/heads
refs/heads/ref-filter                refs/heads
refs/remotes/junio/va/i18n     refs/remotes/junio/va

$ ./git for-each-ref  refs/heads --format
"%(align:left,30)%(refname)%(end) %(refname:base)"
refs/heads/master                 heads
refs/heads/ref-filter                heads
refs/remotes/junio/va/i18n     remotes

I guess this should clear it up.

>
>  - A :dir that corresponds to the :base that picks 'foo' from
>    'refs/foo/bar/boz' needs an example, too.
>

I could add in an example.

> Or is the above example simply a typo?  Is refs/foo/bar/boz:base
> 'boz', not 'foo'?
>
>

Not a typo, but open to changes in name.

-- 
Regards,
Karthik Nayak
