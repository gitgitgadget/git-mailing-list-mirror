Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F8420987
	for <e@80x24.org>; Fri, 30 Sep 2016 04:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbcI3ELO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 00:11:14 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33427 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbcI3ELN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 00:11:13 -0400
Received: by mail-oi0-f49.google.com with SMTP id r126so116888157oib.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 21:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C59nCAOfwNEl/sgDPgPm/1FSKX8tR3G2bWQ0Qtq8aHM=;
        b=s9/9WvQ4vOm34PPDduqALxceyzv6Aysj1wQd0UbKURiEgROdHbG3IdNz4Xx5SyMbxq
         rKH7dAf31p0RWzOaPWxIONsVJbFzKpTRIdWuu8bX4xcWCVtD4bc8mmcmhWN8JLcrcUZH
         iGRadSJPZoM+EX5/8BUm6mfJNApvSz4Olnq1hxYZlLmf3Hkg8+CNH2Qdi3dhMv3tr7Qc
         6wO1pxIDdp7uFWvvDJBcXj1JXlVUOMRB+SHvcBDpAvFw7Vl+ef2yfjYKikCgyjpV6GvP
         WYnGA0mWOEbErO9fI6sjk0WnfrcHJdMXLDL/bMDmeTg8nItQbmkzKsJ0/xVy2TGTOZf3
         pInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C59nCAOfwNEl/sgDPgPm/1FSKX8tR3G2bWQ0Qtq8aHM=;
        b=hQ1BYk1iTxFFz2puoEyARMbBOsXeTItKVPS2UsfoCRQWKGeFjSyJtA+pinxyD8eIee
         /zKuhwtdmqc/v0ZY43Wfh+LpapldPauvyvTRGkjutPPSklZ24212uRkcCgHtPpR0MVeo
         LqTFlr8N9qQLCTUjxGwcsgF/VVoPTJE0vlLGXYAFRBIjbiY9oINhYAfHjofJGzJuwrUt
         3qFC9RAOm5svrcCW2zyK1gltEVkjZTHa7SXCp+lSQ8vdNDmjO5oGWaCJGQ2njweLZ2V/
         pYNk1mRt7bRbdc5QI7HRUyKRwzbunRpEMOAtg4Sh3jUGf4jDw0MRQnvIH+RVx1BH+Opn
         wuCw==
X-Gm-Message-State: AA6/9RkisinxhZ5sWW5fpXHg8BO59LAdYNiKJED21tSrGlabWWrRlWWSMQK5EGdfMFLzS5zWJnvx8OUuqX4LYA==
X-Received: by 10.202.4.21 with SMTP id 21mr4992133oie.91.1475208672319; Thu,
 29 Sep 2016 21:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 21:11:11 -0700 (PDT)
In-Reply-To: <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com> <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 21:11:11 -0700
X-Google-Sender-Auth: M5I0PPHobNTSge6FJs89TQZOges
Message-ID: <CA+55aFwsWxJqaK3mCZsjF6qcRmBKD0ffM9iW-1A6rWn05H5DFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113c0880e2413e053db1c843
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113c0880e2413e053db1c843
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 29, 2016 at 8:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * The script uses "git rev-parse --short HEAD"; I suspect that it
>    says "ah, default_abbrev is -1 and minimum_abbrev is 4, so let's
>    try abbreviating to 4 hexdigits".

Ahh, right you are. The logic there is

                                abbrev = DEFAULT_ABBREV;
                                if (arg[7] == '=')
                                        abbrev = strtoul(arg + 8, NULL, 10);
                                if (abbrev < MINIMUM_ABBREV)
                                        abbrev = MINIMUM_ABBREV;
                                ....

which now does something different than what it used to do because
DEFAULT_ABBREV is -1.

Putting the "sanity-check the abbrev range" tests inside the "if()"
statement that does strtoul() should fix it. Let me test...

[ short time passes ]

Yup. Incremental patch for that single issue attached.  I made it do
an early "continue" instead of adding another level on indentation.

                 Linus

--001a113c0880e2413e053db1c843
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itp95h5u0

IGJ1aWx0aW4vcmV2LXBhcnNlLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4vcmV2LXBhcnNlLmMg
Yi9idWlsdGluL3Jldi1wYXJzZS5jCmluZGV4IDRkYTFmMWRhMi4uY2ZiMGYxNTEwIDEwMDY0NAot
LS0gYS9idWlsdGluL3Jldi1wYXJzZS5jCisrKyBiL2J1aWx0aW4vcmV2LXBhcnNlLmMKQEAgLTY3
MSw4ICs2NzEsOSBAQCBpbnQgY21kX3Jldl9wYXJzZShpbnQgYXJnYywgY29uc3QgY2hhciAqKmFy
Z3YsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAkJCQlmaWx0ZXIgJj0gfihET19GTEFHU3xET19OT1JF
Vik7CiAJCQkJdmVyaWZ5ID0gMTsKIAkJCQlhYmJyZXYgPSBERUZBVUxUX0FCQlJFVjsKLQkJCQlp
ZiAoYXJnWzddID09ICc9JykKLQkJCQkJYWJicmV2ID0gc3RydG91bChhcmcgKyA4LCBOVUxMLCAx
MCk7CisJCQkJaWYgKCFhcmdbN10pCisJCQkJCWNvbnRpbnVlOworCQkJCWFiYnJldiA9IHN0cnRv
dWwoYXJnICsgOCwgTlVMTCwgMTApOwogCQkJCWlmIChhYmJyZXYgPCBNSU5JTVVNX0FCQlJFVikK
IAkJCQkJYWJicmV2ID0gTUlOSU1VTV9BQkJSRVY7CiAJCQkJZWxzZSBpZiAoNDAgPD0gYWJicmV2
KQo=
--001a113c0880e2413e053db1c843--
