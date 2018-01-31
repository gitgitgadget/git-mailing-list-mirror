Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6141F576
	for <e@80x24.org>; Wed, 31 Jan 2018 10:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeAaKQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 05:16:20 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45545 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeAaKQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 05:16:16 -0500
Received: by mail-oi0-f46.google.com with SMTP id c189so9427728oib.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 02:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVVLZTHJp54FfZ4BkKqe0o55RSYU/IrrIUc+M/c/Nfw=;
        b=BsMKaoKvsMqwzLSe3RRWxxl422+R9ewR0Y/9+IsDWeKXbfvD5nLMkTUJAmqz29Tor9
         zLr95XUe7mFfm3fe6DeVucmem3ZZ+vLU8UPkDXwrSNj2orMDswIhttrjkEh40N+em2lE
         uNHnBgw3jBDHUSKJCCbH7rYmJ8RLGUgFVY8WR8PhP39WUHHKFk9DJYENNgm7xBeU+nh/
         P5Gx4xNB+62gMDEBGqyjEkGzB1bflZY7vWUd2PnMFFsMyEcg5Xelu3hBeioGzTgMWy6D
         tTYVgxr7TlCahNEwACvIqeQPA0Tq+0PQChSCLmMMBK7qGPpgUe4JdjruZ5S1UcEMhfOh
         1RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVVLZTHJp54FfZ4BkKqe0o55RSYU/IrrIUc+M/c/Nfw=;
        b=bqlReN1Pc0UdYdtxNrukaVrZpDiLDV4JxxyKPbu3fihp53+kULeCia2R0H/aciyU35
         5FVgPkhbV++0rJXQ/vPqYskuHAkXQhVk8Mr7QYg6z7E+KNY+X4RXHFiwiW5kruhI9Lr6
         nyXBjd1upPnnEZ67Du2HvpNZhy9i05mQZ4Cddabx/0/en+T4Zauci++ubuz6nddywLOR
         AshgdtMYvRhGXKAkEq+eTREjTYOVa3daBpe+aAs/xOY8Nyu3RSRQoiUIWRcSLKWqUGmI
         AP/6U0OtxqIbFxCouLFMZvRnUDqp59LmqGWd3ph6iLEumoqOkLy/2Rk+i6HKiEX6ihky
         5Sug==
X-Gm-Message-State: AKwxytdxoLoj4moxqLYeYORIkkjyFe+e1nsvu3Qyw6+Uot0cz7eFJYBI
        XUErhTo7zGnyUEmgF4ME3K092KYO2YK/JsuqVmo=
X-Google-Smtp-Source: AH8x226BXC4tMH0A05fpaKFMWB68punO08MjyNmpACNaCPvB+gIxsXI3XY6yu5vnIVgrJr26y58u0c23g7iaQSaFzkY=
X-Received: by 10.202.196.208 with SMTP id u199mr21272330oif.117.1517393775243;
 Wed, 31 Jan 2018 02:16:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 31 Jan 2018 02:15:44 -0800 (PST)
In-Reply-To: <56b8d8a3-9483-330d-64a4-ec0295b254ac@gmail.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1801282140330.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CACBZZX74WcK4qX5O1E_6nxv7f4Vpns3O-7dcURbs+QneKsA87Q@mail.gmail.com> <56b8d8a3-9483-330d-64a4-ec0295b254ac@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 17:15:44 +0700
Message-ID: <CACsJy8DH2_gBqj3xs4Cr6kOAUsQ5hn88weMeXR8GtYCNvYgLDQ@mail.gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 8:21 AM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 1/28/2018 5:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Sun, Jan 28, 2018 at 9:44 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> Hi,
>>>
>>> On Sat, 27 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>>> I just got around to testing this since it landed, for context some
>>>> previous poking of mine in [1].
>>>>
>>>> Issues / stuff I've noticed:
>>>>
>>>> 1) We end up invalidating the untracked cache because stuff in .git/
>>>> changed. For example:
>>>>
>>>>      01:09:24.975524 fsmonitor.c:173         fsmonitor process
>>>> '.git/hooks/fsmonitor-watchman' returned success
>>>>      01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callbac=
k
>>>> '.git'
>>>>      01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callbac=
k
>>>> '.git/config'
>>>>      01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callbac=
k
>>>> '.git/index'
>>>>      01:09:25.122726 fsmonitor.c:91          write fsmonitor extension
>>>> successful
>>>>
>>>> Am I missing something or should we do something like:
>>>>
>>>>      diff --git a/fsmonitor.c b/fsmonitor.c
>>>>      index 0af7c4edba..5067b89bda 100644
>>>>      --- a/fsmonitor.c
>>>>      +++ b/fsmonitor.c
>>>>      @@ -118,7 +118,12 @@ static int query_fsmonitor(int version,
>>>> uint64_t last_update, struct strbuf *que
>>>>
>>>>       static void fsmonitor_refresh_callback(struct index_state *istat=
e,
>>>> const char *name)
>>>>       {
>>>>      -       int pos =3D index_name_pos(istate, name, strlen(name));
>>>>      +       int pos;
>>>>      +
>>>>      +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>>>>      +               return;
>>>>      +
>>>>      +       pos =3D index_name_pos(istate, name, strlen(name));
>>>
>>>
>>> I would much rather have the fsmonitor hook already exclude those.
>>
>>
>> As documented the fsmonitor-watchman hook we ship doesn't work as
>> described in githooks(5), unless "files in the working directory" is
>> taken to include .git/, but I haven't seen that ever used.
>>
>> On the other hand relying on arbitrary user-provided hooks to do the
>> right thing at the cost of silent performance degradation is bad. If
>> we're going to expect the hook to remove these we should probably
>> warn/die here if it does send us .git/* files.
>>
>
> I'm not sure how often something is modified in the git directory when
> nothing was modified in the working directory but this seems like a nice
> optimization.
>
> We can't just blindly ignore changes under ".git" as the git directory ma=
y
> have been moved somewhere else.  Instead we'd need to use get_git_dir().

In theory. But we do blindly ignore changes under ".git" in some
cases, see treat_path() in dir.c for example.

> Rather than assuming the hook will optimize for this particular case, I
> think a better solution would be to update untracked_cache_invalidate_pat=
h()
> so that it doesn't invalidate the untracked cache and mark the index as
> dirty when it was asked to invalidate a path under GIT_DIR.  I can't thin=
k
> of a case when that would be the desired behavior.

You see, my only problem with this is tying the check with $GIT_DIR,
which may involve normalizing the path and all that stuff because the
current code base is not prepared to deal with that. Simply ignoring
anything in ".git" may work too. Not pretty but it's more in line with
what we have. Though I'm still not sure how it interacts with ".git"
from submodules which is why I still have not sent a patch to update
untracked_cache_invalidate_path() because it does make sense to fix it
in there.

> Somewhat off topic but related to the overall performance discussion: I'v=
e
> also thought the untracked cache shouldn't mark the index as dirty except=
 in
> the case where the extension is being added or removed.  We've observed t=
hat
> it causes unnecessary index writes that actually slows down overall
> performance.
>
> Since it is a cache, it does not require the index to be written out for
> correctness, it can simply update the cache again the next time it is
> needed. This is typically faster than the cost of the index write so make=
s
> things faster overall.  I adopted this same model with the fsmonitor
> extension.

If you turn on split index, the write cost should be much much less
(but I think read cost increases a bit due to merging the two indexes
in core; I noticed this but haven't really dug down). You basically
pay writing modified index entries and extensions.

But yeah not writing is possible. The index's dirty flag can show that
only untracked cache extension is dirty, then it's a judgement call
whether to write it down or drop it. You still need to occasionally
write it down though. Dirty directories will fall back to slow path.
If you don't write it down, the set of dirty paths keeps increasing
and will start to slow git-status down. I don't know at what point we
should write it down though if you choose not to go the split-index
route.
--=20
Duy
