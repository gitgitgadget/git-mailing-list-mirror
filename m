Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB58C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E82067D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DaNvStw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGMTii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:38:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:42139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGMTii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594669105;
        bh=2cqMFw5lS0dkMuIa/W8e072/bjvYbsG+COvB27DR3Ic=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DaNvStw8M3XJpZP++yMUPvhav6QueKVS/mj1Of7Xkf/ip0T9VL5o1su1JLn/sbmA4
         JMlC6crjxOcg78gHxFojegCDHx/ofL+jaqlcs7Zm6JMsBvjOII0ogs8xTWiI6in/Vv
         w6W4nD3qBPJrHjuKg1kk/8hsAXrbr9fj1KdJpuR0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.215.195]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1kSkTS04hH-00cMkb; Mon, 13
 Jul 2020 21:38:25 +0200
Date:   Sun, 12 Jul 2020 10:19:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Edward Thomson <ethomson@edwardthomson.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <CA+WKDT2DV6ymu-AG9B2h34=K+4KW7tcCpAfTV-rTdifqfS7R=g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007121007440.50@tvgsbejvaqbjf.bet>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <20200629224113.GC9782@camp.crustytoothpaste.net> <CA+WKDT2DV6ymu-AG9B2h34=K+4KW7tcCpAfTV-rTdifqfS7R=g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zslolk39pLEp0LpNc47II5CD45Z0U+xzg1F2WN1nqj4GCGHrpYW
 IELTLm3uTC06rQqaClva2a3lLc30nFK7rVK8C37P1T62lLxvsVr/oEio6hTFht/QTA2BUeV
 vgpgS36KaMKAZVoIs0U3I6ZXdmeJLdRC5xY/lInH/mSd6G534g7QbLRQaaPFwg3Ob+iFUOW
 JNvRq8a7nREOAhcpePhqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tzGYA8NRsxo=:FlfI81Bye/ViLz5m3Kf3Yx
 Sh3H+ARMXQNpv1dx1skbwkaGUs7sYfLCmGjugqs0kOp3ZXzbSCgdiPoQL1QNtVtbR+gQjXLCC
 BPH1gpmfHJGX+9FOb/Nem1GlgqklEcqJ7VqtmkiW+BMFxuXMzfdLzMFbup+OZBp4elk06n2Z+
 LnGqbygmaItm2FF3lxUUjgNltY4h/8oX0K8dc/BfIbd0uvAgeNCk281kxGWkyQy3JdzIIHVli
 m2NSytUbK7jZAmB27P7rm6/2tomhksykUxLP5+YtygUs9B4AU+jCPhF4gmFhnfUE90VT3AIwf
 eO3Hia42dnl2qd+2U9xjc5xW/V/7IyteKGn9RNw2HgiY1fhcf5pE0IVfPiM12HoFn+3+fHlAZ
 pV+NDSteQNgrJT0er4TGeIG15BcN/wWPZIW0CkerluO5LAZARtOW78Ft2NnHjeAC+WXXyAavM
 r45E0hCBy/91H3W564fD34l5Cx90zMQnqh5ikpK1bgYhZpjJgQJAGhmLwtIjLR6r2V+T2Al5z
 2AJ1Q7IX9gswn4x03TWrre2Xe6syyldy4u4WzMQWfeJhJeaZIsqJoO9/HiVMYX1KHiQnslJJV
 rhBBKTDAAFCmvvy5lD6JtCVJsinl/qNe01+n/0PPfJxidwrGTbLwJnj6lFpk5q6F3WJAl0wUE
 OGWjuWUOLd+hu5+5Lu+zJVvUe5e15WLGyZ/RV0R4ih40vGvWjYhWthPLAdRRyI8y7sCyFzU6g
 N3G+BUu3kjHRbc62tIYcwzr6K2MXDZKoh/aNm9qQ8w5co9jICjSr7ZbTNI4vUruupMG4Yb/jR
 1p0r6W+Qkpt9A6ibWF5oH7fvY1psCUJ60lfcnxSh4VZ1d3tMmal/Zq2vco3Uhil91pgfdIRNt
 mED7biEcvpdZPBxendBpw2AcEWrA+jgssD15jXYApQF/IRIdCfCpqiJ88QXwAG7aYFAqklBSg
 wRFvuMZwWDaNmxvWoxSBaBg+LhyX0r60pmi7QhoPxagfQ10UiWoHk1RteUPWtM7kzIx2KNgSO
 EVALRi0SBK54dqzO18z8xDxUqeyvU35INuIDL5hSzYEJ1ZkvMWOZSn045E0UYOfjtnVL5c5I/
 AF0UTxSxLtGq2ct8vYjfRMK0nOfSqp1jgV6f+GS+GAcdFQwj7G8fpeIVe7Lc5A46tEN7kHPof
 UgQcghFHFjc5arOvdXmP6+QYn9d5WdEBtwi+VIHHcKv53yH38G8zb3LEZt0TPtUGWvQLjqjpp
 89F4AiiLRuabr/6OJhWoLFgrRpmhfN/zUGiVg8A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Sun, 12 Jul 2020, Edward Thomson wrote:

> On Mon, Jun 29, 2020 at 11:42 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > I'm very happy with this and the way it's progressed since v1.  This
> > seems simpler than earlier designs, and I appreciate the improved focu=
s
> > on avoiding special-casing branches, since I think that will make it
> > easier for folks to choose branch naming that suits them.
> >
> > Thanks for working on this.
>
> I agree, this is an improvement.
>
> One thing that isn't obvious to me, though, is why templates take
> precedence over the command-line option.  I would expect the command-lin=
e
> option to be the highest priority option given, just like configuration
> values specified on the command-line override values from configuration
> files.

Side note: I have not tested this, but I trust you did, and my reading of
the code agrees that it does this.

The reason why it works that way is that while the `copy_templates()`
function is called before the `create_symref()` call that creates the
`HEAD` symref, the latter call is guarded by the condition that `HEAD`
does not yet exist. Here is a link that highlights both calls (and the
code in between):
https://github.com/git/git/blob/v2.27.0/builtin/init-db.c#L229-L270

Now, it is probably not the intention of the code to prohibit the
config setting from overriding the template files, but instead it intends
to guard against overwriting files by running `git init` in an
_already-initialized_ repository. And I don't think that it possible,
really, to change the logic without making the effect quite hard to
explain.

The truth is that overriding the default name via editing the templates is
just not a very good strategy, it is fraught with peril, as e.g.
`init.templateDir` is a thing that can be easily specified via the
command-line (`git -c init.templateDir=3D/tmp/my-templates init`).

Ciao,
Dscho
