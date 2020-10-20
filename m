Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFDC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD8D22251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="donLsNZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438114AbgJTTdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:33:39 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:58086 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391043AbgJTTdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:33:38 -0400
X-Greylist: delayed 140843 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 15:33:36 EDT
Date:   Tue, 20 Oct 2020 19:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603222414;
        bh=B5C/omZAmH0xh3dH+vSWBqrl1xRLzJV4FAUP1knyhjM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=donLsNZVpsOE7P4Iytx4Y8n5Kx/GdBYMQtMoF+6rcbKYfflRaBnDdD00qGd+VeFwp
         yq/wP2KxAypq0LwP2RMXf0rwpJFZjGq5Z2VBL4NApFYFm41ZvJZ7cDRE266kLlRE8o
         FR9ljupNzxcaOl6l6IaRcm///BDT6SYgtef7rIPM=
To:     Phillip Wood <phillip.wood123@gmail.com>
From:   Joey S <jgsal@protonmail.com>
Cc:     "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>,
        "me@ttaylorr.com" <me@ttaylorr.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey S <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in test script
Message-ID: <8sVPe0y2NOpCfqcDBmjBK5jJgJdS7FH7InhekygiMy41mgadB9Rim7QaeoT5E_MYdxw52RHKLLdTGQ-2UIkVKMSJlun_AjvR3lUUcNNNHDI=@protonmail.com>
In-Reply-To: <0c61c3cc-b6b6-84dc-7e3f-99a41f676e7f@gmail.com>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com> <20201020001103.GB2774782@google.com> <xmqqpn5dd5dv.fsf@gitster.c.googlers.com> <O2ACwMmJ8_oj_OrMPF4bGf-9nctJiXbFxJ6yzlWWCob0Zr25aSCOfcCc8pGNukbReQQJi_6igxiEyQT1hWp3ccbY1pJr62Y4eNk097tInP8=@protonmail.com> <0c61c3cc-b6b6-84dc-7e3f-99a41f676e7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

> `test -e <path>` checks whether <path> exists and exits 0 if it does and
> the shell treats an exit code of 0 as success. `!` inverts the
> success/failure of the command that follows it. Using that and looking
> at the definition of test_file_is_missing in t/test-lib-functions.sh see
> if you can fix the conversion so that the tests pass.

Thank you, that makes sense, now the test cases with `! test -e` replaced w=
ith `test_path_is_missing paginated.out` all pass.

Sending PATCH v2 next.

Thank you for your help,

Joey



=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, October 20, 2020 6:19 AM, Phillip Wood <phillip.wood123@gmail.c=
om> wrote:

> Hi Joey
>
> On 20/10/2020 08:24, Joey S wrote:
>
> > Hi everyone,
> > Thank you very much for the input and feedback, it's much appreciated.
> >
> > > All this text above is useful context for reviewers but appears as pa=
rt
> > > of the commit message which is not what you want. If you add notes af=
ter
> > > the `---` line below then they will not end up in the commit message.
> >
> > Understood, thank you.
> >
> > > > Modernized the test by replacing 'test -e' instances with
> > > > test_path_is_file helper functions.
> > >
> > > s/Modernized/Modernize/
> > > Will do in the amended commit next.
> >
> > > > -   ! test_path_is_file paginated.out
> > >
> > > It would be better to replace`! test -e` this with
> > > `test_path_is_missing` as the modified test will pass if paginated.ou=
t
> > > exists but is not a file. `test_path_is_missing` will print an
> > > appropriate diagnostic message as well.
> >
> > Thank you for the explanation : )
> > After replacing `! test -e` with `! test_path_is_missing paginated.out`=
 however, the changed test cases are failing;
> >
> >     $ cd t/ && prove t7006-pager.sht7006-pager.sh .. Dubious, test retu=
rned 1 (wstat 256, 0x100)
> >     Failed 3/101 subtests
> >
> >     Test Summary Report
> >     -------------------
> >     t7006-pager.sh (Wstat: 256 Tests: 101 Failed: 3)
> >        Failed tests:  7-9
> >        Non-zero exit status: 1
> >     Files=3D1, Tests=3D101,  5 wallclock secs ( 0.03 usr  0.00 sys +  3=
.49 cusr  0.65 csys =3D  4.17 CPU)
> >     Result: FAIL
> >
> >
> > Is this the behavior I should be expecting?
>
> No it's not! As one aspect of this process is to help candidates improve
> their understanding I'll give you a hint rather than the whole answer.
> `test -e <path>` checks whether <path> exists and exits 0 if it does and
> the shell treats an exit code of 0 as success. `!` inverts the
> success/failure of the command that follows it. Using that and looking
> at the definition of test_file_is_missing in t/test-lib-functions.sh see
> if you can fix the conversion so that the tests pass. If you get stuck
> do let me know and I'll try and help some more.
>
> Best Wishes
>
> Phillip
>
> > > ...Alternatively, this would fit just fine in a cover letter. Usually
> > > cover letters are not necessary for single patches (where the patch
> > > message itself conveys the full message, or a little bit of additiona=
l
> > > context below the triple-dash line is all that's necessary to clarify
> > > the intent). But, if you want to introduce yourself, a 0/1 cover lett=
er
> > > is fine, too.
> >
> > Will keep this in mind, thank you Taylor.
> >
> > > > One thing missed by other commenters: the Developer's Certificate o=
f
> > > > Origin line - which is what this indicates - should have your "full
> > > > name".
> > >
> > > ... and it must match the authorship.
> >
> > Changed, thank you both for catching that.
> > Thank you all,
> > Joey
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Monday, October 19, 2020 7:59 PM, Junio C Hamano gitster@pobox.com w=
rote:
> >
> > > Emily Shaffer emilyshaffer@google.com writes:
> > >
> > > > On Mon, Oct 19, 2020 at 04:26:07AM +0000, Joey S wrote:
> > > >
> > > > > Hi everyone,
> > > > > Hi Joey and welcome.
> > > >
> > > > > Signed-off-by: JoeyS jgsal@yahoo.com
> > > >
> > > > One thing missed by other commenters: the Developer's Certificate o=
f
> > > > Origin line - which is what this indicates - should have your "full
> > > > name".
> > >
> > > ... and it must match the authorship.
> > >
> > > > So in my case, I sign my patches 'Emily Shaffer
> > > > emilyshaffer@google.com'. If I'm wrong that's fine, but JoeyS sound=
s
> > > > like a name and initial rather than a full name.
> > >
> > > Thanks for pointing it out.
> > > If somebody from the "mentoring" group is taking a tally, it might
> > > not be a bad idea to identify which style and procedure rules are
> > > often failed to be followed by new contributors so that we can
> > > figure out ways to make them stand out in our documentation set
> > > (e.g. Documentation/SubmittingPatches but maybe a separate cheat
> > > sheet might be worth having).
> > > Thanks.


