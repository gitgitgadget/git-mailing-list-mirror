Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5691D20288
	for <e@80x24.org>; Wed, 19 Jul 2017 12:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbdGSMxD (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 08:53:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:52722 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752794AbdGSMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 08:53:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsOsW-1deWc93NJA-01228W; Wed, 19
 Jul 2017 14:52:53 +0200
Date:   Wed, 19 Jul 2017 14:52:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 8/8] sha1_file: refactor has_sha1_file_with_flags
In-Reply-To: <20170718093920.3265c67f@twelve2.svl.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>
References: <cover.1497035376.git.jonathantanmy@google.com>        <cover.1498091579.git.jonathantanmy@google.com>        <a4f04b3ec9cc1ba08a5dd7f459dce95411fb03e2.1498091579.git.jonathantanmy@google.com>        <CAP8UFD24QVAuTXXH3zvR5zwZwub20o37uGyt8Uf+rRtjjk8QTA@mail.gmail.com>
 <20170718093920.3265c67f@twelve2.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VZ0JVLNKwRHicOAYlIJhTCmdtHc5PuSkC5DjHUauxDMsKProEgj
 eHyYyiMismLcDhgKAqacslbwvyUZOgBXI/FSbUUvEc1w/1kpaqHCgxUZgrEjvJCPCY05cKf
 3fQmSuVkSTMDPdH6hei9KULMCXZXGxG87fga7uJpJlqObBjF0+HFivSKu/QIw3yWOxwxMKP
 kz5P1h43uS2E1pWDREjbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oScZE1TAypQ=:DZ/sNsc2EDth7Epe8MGA5L
 W3iJ/Sf3FG06tDlYtHutOUue9I5eIk/dsNuokY9+aMEk7qnK5C2qIOhgWU1J7XCaSd5ljegwJ
 h7QcjVZGK3jO0ORsu8gM7mOLT9BX1YMKD75M8mLQdZnQUXHPxK8DiiedQSa6L/a3DGXifCi9V
 4t7VJMbJuA4WrQyNbxQBKjaRSOsuUUUcTqJGN012QBt5dwGfcUjw1/0Sh+7JMfQfSE1UMvAHx
 JkcLHhj3OEMR3nGBo4l8IYSu0ipXDdlAsX3LEX7P1r9uyERIHwFNI/2ZJmwOkg+VSQ9eHakpY
 YWqUMKcIOwZrWv3IIMHIjeTp4nkxzfsZohps93H8iiRC7uTEWEV5sDEZcwrGMatQpDOAUsuoI
 P0b0NyNASNsxFe5W80D3PU6PQAoXs3O8FYQAkqJ30vCFv1PHHneU8xmjgooZOejw/XOnKDBWq
 KE3AG3difh34Dh+8FRo8Qijn1/sPAMigQaMu1NEDRal1BGjp6YEoyEiqPnt+DhG9Rc78D9cNR
 zuL9ilhtkwuO1ei++Dcu725q4eqbV4Z1rNbWLdVSnBK0W5SMblTLUCgmPJndUeFNm6Cwu7gcX
 cL/a9NYaqbvH/E0lJGJVCA4xBiWXoXVVJupPT+gb0/NqkWvmhlQh7EpVf4VrrtgqRGsgsohVk
 VyToif0OjxxOlslaAsqO+5JBpnRuij3ArOCSOPOuVtilK81fDWfpcMyv2t0u+jd/SWBJGsSzs
 yxpZI8AHqOhGuMmWZ3PWlyimF3H9vfSOMWIKU7fnBFrxFCW6o6xksJuCQ7jCha0h1u2851KS3
 ny4YnxwdZ7qMTJ0q2FBdXMzBPGreGgD30mPxpv1Afgi64BiX8Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 18 Jul 2017, Jonathan Tan wrote:

> On Tue, 18 Jul 2017 12:30:46 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
> 
> > On Thu, Jun 22, 2017 at 2:40 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > 
> > > diff --git a/sha1_file.c b/sha1_file.c
> > > index bf6b64ec8..778f01d92 100644
> > > --- a/sha1_file.c
> > > +++ b/sha1_file.c
> > > @@ -3494,18 +3494,10 @@ int has_sha1_pack(const unsigned char *sha1)
> > >
> > >  int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
> > >  {
> > > -       struct pack_entry e;
> > > -
> > >         if (!startup_info->have_repository)
> > >                 return 0;
> > > -       if (find_pack_entry(sha1, &e))
> > > -               return 1;
> > > -       if (has_loose_object(sha1))
> > > -               return 1;
> > > -       if (flags & HAS_SHA1_QUICK)
> > > -               return 0;
> > > -       reprepare_packed_git();
> > > -       return find_pack_entry(sha1, &e);
> > > +       return sha1_object_info_extended(sha1, NULL,
> > > +                                        flags | OBJECT_INFO_SKIP_CACHED) >= 0;
> > >  }
> > 
> > I am not sure if it could affect performance (in one way or another) a
> > lot or not but I just wanted to note that has_loose_object() calls
> > check_and_freshen() which calls access() on loose object files, while
> > sha1_object_info_extended() calls sha1_loose_object_info() which calls
> > stat_sha1_file() which calls lstat() on loose object files.
> > 
> > So depending on the relative performance of access() and lstat() there
> > could be a performance impact on repos that have a lot of loose object
> > files.
> 
> That is true, but from what little I have read online, they have about
> the same performance.

Then your online sources missed out on what we have in compat/mingw.[ch].
I would expect _waccess() (which is used to emulate access()) to be
substantially faster than the hoops we jump through to emulate lstat().

Ciao,
Dscho
