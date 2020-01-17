Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D50C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C442C2073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OGOgZF7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgAQNav (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:30:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:36149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgAQNav (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579267844;
        bh=qf74Rj9p2REATX7w7ccc7Gdmjhq0kiF4OHVIaZNgPWM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OGOgZF7EAIdpr9LI5W2s377i/mOVpotXB+aF/w06IpjrX1aQMoG6TEXYrc/ESNIms
         9/pCzXvceKpN8hrTFRr5UE70o2SiFUuaokI7bkUuW0SIo1uIDJ8SnOaTWQDjxfGgec
         zseNVMiA44WKjcg//2SdoxxaGNvbj1cXwFJqFqwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1jfoql3KiK-015H4c; Fri, 17
 Jan 2020 14:30:43 +0100
Date:   Fri, 17 Jan 2020 14:30:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
In-Reply-To: <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001171428170.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com> <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com> <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
 <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4SfOpHcADP9mZ98e1AwqMWAVRWkwenl4+x6q/GcWNSo0toyn2kK
 FFNOcZNBNaUUxrBCkSk1RI5ANjOppSzfRyaSZE9steyOdF3rR41cy6AHzTBtYiAognof37e
 MCqq+dXazJ4ruMxqDhNCSlgq8fKHzr/3mvjPTPVWri0tRmdOwaiQXLbC2AI0nNsWCQj5B1s
 nGfiExSmWyO9/Xnj/cicg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xAXawBiBqY=:VxtuM+xasv7RNFKlW73lGM
 5sd1w7O16Lxtbagt5rf93H9/X8aXuLgpUcaFcR8aftyD/odxpuAJodBhl4Rzw5IgITLqmBVov
 9mw8+2vOoo8zTk8J6SAgwd9Pggcahr9vHN5340Vs+5F2o0IQBvNlIeGFsgajyViS9mJt9d4a5
 YSmhLL3QxiU8k+ic9IjaJgmjhHPNRZx2AxQcMV2y3NYyJgXQ+ymPNj+3Mevr1TFhb+17R0POI
 I1+pjrMexZJbUiaSDN+AfEdBp0v75xYke+4O/bVwNvmSYk/n5ENuTDMT9koz4Zw6EPYsTST58
 suJh567keQcJiqdt6iCUbW9Qklyj27NraxTg+CGEQrbSbdrUtS2HFJ88ptv/tXwJ0Vwq34sxO
 jqRNU4MThZE9mHT/GOMtWlFZzn3k96su2FC+d+1tBlStK0hmZaUqNrcqq3cp6+tTqZ0RzIUz8
 cxz9Vwg6Muh+00Gn8fpY/C0oiUH3CM+AacN96dHFnKSMmUeZYoy4DRFqnTkvtvZf1LsTfOwPX
 cYrQaOj4DuWGfBK7Lg3MUZ23H+vn28Djg3Fi0wiWyyhfRf6p64rr9qs53jWNnJH/7TZlRA2k5
 v2oC2spPwwee+VyfbpHIPdUwGvAaKu+j1tnkK4gd6KlLQIXTpz0wiXaO3/Mk4WpgAiqPTONQL
 yxoVEy1u3ZUFSXAYOnDj4teiqiqWzV6Y9s+EmlvIMEWqq+D2u2ub0A+PqQ4sRlxxwpMdOC24n
 7isqrONq2WkOcyS1q9En2BK98xcPDlBY/IKPrrTS5jLM7HVk9vJp9ehVLR9nzr4XHCStfTm5C
 LU94GwyH1V7CuepRpfztIZ6lcO40qF5QhtQ1goOTkCjpMeA4Ido/zpl8lzRZRrX+8ptX+R4bz
 5IhmrloUr/cJudP29DjZfCkuOGcxWE3NOvTVRC5Ob++HRg6agZ7JgqX1tYc9EscQez/T1zw1K
 wbbqky54dEIt5AkwojYkMNyh5uh/7G00tVXZ6e2uEtSKTf1o+qBcWHIHm5uvGAm8YW1CeXWjW
 D7Tys/S/aK5bOO5syor24oyNiKijR4ugmSr250yaUqNqzlj4XmjYfuucCIDho46aKD+XzoFSR
 4Pbe/faifweVwKptHdGpFt0dcZk733ugNRyDQOAaPKy7cMduCYyDiluuxjZ4Ti3GO6Z/z6TTY
 bvLPubKuKPNinVDO7ikpfLGn2FrTS4CIRO+pnUprGn0H0j6HXg9LNKHfFjHn9pDFseqe7NxWJ
 5+hlCEeorLovG/WOx6AGU1CpN+tnhsZ+moHy3Cv9D6O0FslVqleEEI9Ps7VQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Fri, 17 Jan 2020, Bert Wesarg wrote:

> On Fri, Jan 17, 2020 at 12:50 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Bert,
> >
> > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> >
> > > When renaming a remote with
> > >
> > >     git remote rename X Y
> > >
> > > Git already renames any config values from
> > >
> > >     branch.<name>.remote =3D X
> > >
> > > to
> > >
> > >     branch.<name>.remote =3D Y
> > >
> > > As branch.<name>.pushRemote also names a remote, it now also renames
> > > these config values from
> > >
> > >     branch.<name>.pushRemote =3D X
> > >
> > > to
> > >
> > >     branch.<name>.pushRemote =3D Y
> >
> > Should we warn if remote.pushDefault =3D X?
>
> AFAIU, the value of remote.pushDefault wont be renamed yet. So you
> suggest to issue a warning in case remote.pushDefault is X. But as X
> does not exists anymore after the rename, the value of
> remote.pushDefault is invalid. So why not rename it too?

If this setting was usually a repository-specific one, I would suggest to
change its value, too. But it is my understanding that this might be set
in `~/.gitconfig` more often than not, so I recommend a warning instead.

> > > @@ -305,7 +309,7 @@ static int config_read_branches(const char *key,=
 const char *value, void *cb)
> > >                               space =3D strchr(value, ' ');
> > >                       }
> > >                       string_list_append(&info->merge, xstrdup(value=
));
> > > -             } else {
> > > +             } else if (type =3D=3D REBASE) {
> > >                       int v =3D git_parse_maybe_bool(value);
> > >                       if (v >=3D 0)
> > >                               info->rebase =3D v;
> > > @@ -315,6 +319,10 @@ static int config_read_branches(const char *key=
, const char *value, void *cb)
> > >                               info->rebase =3D REBASE_MERGES;
> > >                       else if (!strcmp(value, "interactive"))
> > >                               info->rebase =3D INTERACTIVE_REBASE;
> > > +             } else {
> > > +                     if (info->push_remote_name)
> > > +                             warning(_("more than one %s"), orig_ke=
y);
> > > +                     info->push_remote_name =3D xstrdup(value);
> >
> > It makes me a bit nervous that this is an `else` without an `if (type =
=3D=3D
> > PUSH_REMOTE)`... Maybe do that, just to be on the safe side, even if
> > another type is introduced in the future?
>
> I'm not a friend of this last 'else' either, but it was so to begin
> with. I'm all for changing it to an 'else if'. Though while it is
> impossible that 'type' has a value different than one from the enum, I
> would be even more comfortable with having BUG at the end.

My thinking was: even if this was a bare `else` before, why not fix that
issue while we're already in the area? I like the `BUG` idea.

Ciao,
Dscho
