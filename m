Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710F81F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFDUPA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:15:00 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36665 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:15:00 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so14367996vsp.3
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CONhww/J3XLNgak14/t2peU3vSeK+VCicSReJ6ji7I=;
        b=u4nXMEBEz5dCrZ05tVrdI2cpvrQJsvkxRoT3+DaTEIe68dqdkS1GAm7r/A9ocJALY8
         An/yyfJzaXf0v/otnsDdbkuJt7uZJJpvkzUSFuP0SvH9J3CU/gnlshnZkIWdrFbm+rVl
         E9TvhdhTF7ude7lOg73av2WsA3C4PA+r1bWHqRqU5NiY4ewKXLsXrYh5dzi6vZiYuce8
         RFdLn41mA/z0efZ4IsJtAB/WJJH+AoLMdy/vaslAuxwcomZ4y/aGJIX27uqux/NKSzU8
         uoIp8mRQ3F41WTWVcXHVNmgF/wszdIa3PnZEdcQEdV9brRlphY/GII5DyKBU2YvyM17E
         xgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CONhww/J3XLNgak14/t2peU3vSeK+VCicSReJ6ji7I=;
        b=O10A0aOdbp+1B0uNgx66iqgcPjAqMQiuN4T0qAKCbvVhW7IinY4YXGWP6YkzoPt2Rc
         UWnXdwPfyP3THDaaOn4tTkwbLWcdG7Kr7wFk7uHpMalg7XCSc9V0qGOnsB5yVMN5jwfe
         Tu6EdN/5+w/tcXTLvNYFXT1Y8v+ldJJE5mQJwbid8esDG7tIxu9QsGExhyjPb+tSvjnS
         jjSpXB/rbumyXQR1h/+w/RkLmY92nkQtItI+FdZ0KLg5RmdQsvFK5MLeyIdoiFzOtV9h
         yLNX3599WVbo/uTvtSgcYtmJLsFSnNBABmZtqmohQ5faRWlEsAQakesyZ2JKcwxIRpHn
         1eAQ==
X-Gm-Message-State: APjAAAXx6Kk1QqOSrQ6j1+7PYhHOzxrDRG03/1MNg6tMWAzqaVr1OTL8
        tHD6jz+EJWgdWL0yIDYniSvlrihbPed0747tkY4=
X-Google-Smtp-Source: APXvYqwxf9Xd/m4DexCuhY5yBr9rbizZXuYXJ/jnBmg0auXTSMY6hbred6dp0OTOxq+zWX+vZ/bDUjx0CNFRya9U5nE=
X-Received: by 2002:a67:fac5:: with SMTP id g5mr5284215vsq.53.1559679299300;
 Tue, 04 Jun 2019 13:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190604023039.GR951@szeder.dev> <20190604072614.26885-1-newren@gmail.com>
 <20190604131400.GS951@szeder.dev>
In-Reply-To: <20190604131400.GS951@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Jun 2019 13:14:46 -0700
Message-ID: <CABPp-BGmgCPt7y9Qhtud3VAPDE-D07=Cw6jH9QverveMWV_iuw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: restore accidentally dropped setting of path
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 4, 2019 at 6:14 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Tue, Jun 04, 2019 at 12:26:14AM -0700, Elijah Newren wrote:
> > Of course, this wasn't the only bug; it also showed we had a glaring
> > whole in our test coverage -- there's a dearth of tests for rename/add
> > conflicts, and in particular none involving content merges for the
> > rename side.  So, I created a patch which adds some tests for that
> > (which triggered the assertion error).  I pulled SZEDER's fix into the
> > same patch and added a commit message explaining the issue, using a
> > Based-on-patch-by tag for the fix.  SZEDER: if you'd like to see this
> > in a different format (maybe I add tests which show the error and then
> > in a separate patch authored by you we introduce your fix?), just let
> > me know.
>
> Nah, I'm fine with it.
>
...
> > In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
> > to a diff_filespec", 2019-04-05), we actually switched from
> > (oid,mode,path) triplets to a diff_filespec -- but most callsites in th=
e
> > patch only needed to worry about oid and mode so the commit message
> > focused on that.  The oversight in the commit message apparently spille=
d
> > over to the code as will; one of the dozen or so callsites accidentally
>
> s/will/well/

Thanks, will fix this up.

> > +             git ls-files -u >out &&
> > +             test_line_count =3D 2 out &&
> > +             git ls-files -u b >out &&
>
> Are these two 'git ls-files -u' executions as intended, i.e. first
> without a file and then with 'b'?
>
> Or is this a bit of a "Huh?!"-inducing way (for me; for you it might
> be an idiom :) to check that 'b' has two unmerged entries and no other
> file has unmerged entries?

Yes, with rename/add there's always a possibility that the original
filename ('a', in this case) appears unmerged or that due to the
rename/add collision that both paths are renamed (e.g. 'b.HEAD' and
'b.MERGE_HEAD') and entries for these are found in the index.  I'll
add a quick little comment before the second saying 'Also, make sure
both unmerged entries are for "b"'.

> > +             git hash-object b >actual &&
> > +             git hash-object ours >expect &&
> > +             test_cmp expect actual
>
> So these last three lines compute the object ids of two files and then
> compare those two oids to make sure they match...  But wouldn't a
> 'test_cmp ours b' do the trick just as well?

Yes, that'd be better.  I'll fix it up and resend.
