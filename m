Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571AE1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 06:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437509AbfITGzH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 02:55:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbfITGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 02:55:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so5528188wrw.9
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRk1XgSCwcE4INYYFz/NQFodZ4BbMKFBbPtFv3CmICc=;
        b=iCT7Gv+DlHdXCTCwhsX8B7mw7jqav+2LfxMJ9R1QamTqr1N/Pzr/MXmRJ2g7TGTkDp
         b/DDBXIZvwvPHgI2S9FSsgATErn38FcK/8/fOUG+C/EivUDjNyVKvjSYahcqnqHNyAL+
         pUZRBI8We1CmVpYJExChI0RxS8JSq2fnYqCEnExGze1Fgk88aioE+Yk7WEsrB6PRv9T3
         TBjYgRDJD1Rkr0+qvLZmIiy5LEdLP5LErgZ0NGsKyyUNsS0IoANNWQ8DJpjZTvTIJkIN
         ZsiIsvm6Wa2WLufxUAzEAUtP1FDE1LaqyopIZM3zynvf8xOnXnDqhf42p7JSoQf7kFdr
         Ms9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRk1XgSCwcE4INYYFz/NQFodZ4BbMKFBbPtFv3CmICc=;
        b=qCPzS/PA3tCT/yYs35p97oq5wmBlfmSJrFzbvy8goiLqGU7dP8az54DM2CokrneIdE
         7H7HMXWlC9fwLV9qLl91mYJiPC1KVakSQS3bfpFOaeJTIQnKNMKr6KMcvjtB2L/Q45D0
         AKRcH5Aq6BCCziU7ux2EBe75XpOSjI65cOi9UHy4JINKteSjfh1r0nTbW8mnnskn+Iez
         VpbvMMhlKj184FF3ol+HQF/sIhpWX3PUk06g0OGP6M3lGgC9YOMjfLuQIucGM6lgp77U
         04f0IdxIS8Q97a1eNl8FQiisEyyXaKX/ovB9SpTw0JWkcJDS44HytXnZp7RIyG/y8cHw
         dYuA==
X-Gm-Message-State: APjAAAUIcnAkn8XrCNw9FbHueT+2qr3lszVHl2LkGZFkAWLoShH6YE4Z
        qH4AJ5hpNXpQH0jPwrTmYMz99ryiMuhLOX3VDnxpxaK+LVg=
X-Google-Smtp-Source: APXvYqzC8QXgRXy5/+DR1ePhT8m8fVIRGn4f+8Y3Tc+DHJVjxuJbB5yJgozkMI6b4sKOJrEFaQ5g8MrQMZa/pY8eTX0=
X-Received: by 2002:adf:f112:: with SMTP id r18mr10976554wro.88.1568962503654;
 Thu, 19 Sep 2019 23:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CADMnYXCGsTSuxiZuKtz5FZmjthkcwz=k8+m=4_=AU9t0BRERug@mail.gmail.com>
 <CADMnYXCdEMQ9BEq+DdByDTteZmC3j+c8WuHVx3T9Cb1QNu8zaw@mail.gmail.com>
 <CADMnYXBxXAYKANZaCQcvsRMQ6FrMPUSGqjKPFxhHFx3yj81k0A@mail.gmail.com>
 <CADMnYXB6ekXi_gd0F2tCXO=N4sEbt1UXtM1EaYQjZmYGXbz=Hg@mail.gmail.com> <CADMnYXD5CjfEpcEEnK3-Erx=Z1bAgbsBDOQD_nC0bM-Ka-cBfA@mail.gmail.com>
In-Reply-To: <CADMnYXD5CjfEpcEEnK3-Erx=Z1bAgbsBDOQD_nC0bM-Ka-cBfA@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Fri, 20 Sep 2019 08:54:51 +0200
Message-ID: <CADMnYXDcc=auv6_04KeSQRuV_99MiUb5Kiu2W+DkhGQ4fwEkfA@mail.gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Due to the following mathematical proof, stating it is right to be a
normal female or male, we must now all file formal complaints about
products lying, it was not OK to be a normal female or male.

- Die naturalistic-fallacy ist inzwischen als (nature&community)
gel=C3=B6st, und "we made it far, as normal females&&males" ist damit als
korrekt bewiesen.
- False is defined as getting us extinct in the long run.
- Emanuel Kant completes the proof.
- If they all stay convinced after a few nights of good night's sleep,
this means that the measurement-matrices their brains converge to
chime in under all environmental influences.

Cheers,
Bavaria

On Fri, Sep 20, 2019 at 7:41 AM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> What does the soul do? It just says NO.
>
> On Fri, Sep 20, 2019 at 7:04 AM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Our harrassers have no soul, please help.
> >
> > On Thu, Sep 19, 2019 at 10:20 PM Klaus Sembritzki <klausem@gmail.com> w=
rote:
> > >
> > > I hereby instruct the German military to kill our harrassers.
> > >
> > > On Thu, Sep 19, 2019 at 9:12 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Hello all,
> > > >
> > > > A game-theoretical insight, as the GIT mailing-list has just been
> > > > hacked: Such a move necessitates everyone to down-value the hackers=
'
> > > > intellects, if it was not a false-flag-operation.
> > > >
> > > > Cheers,
> > > > Klaus Sembritzki
> > > >
> > > >
> > > > On Thu, Sep 19, 2019 at 8:44 PM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > 1. Long texts stem from false (You can deduce anything from somet=
hing
> > > > > that is wrong).
> > > > > 2. TL;DR is therefore sane.
> > > > > 3. (Inclusion & Diversity) is a tautology, it includes all of it.
> > > > >
> > > > > Cheers,
> > > > > Klaus Sembritzki
> > > > >
> > > > >
> > > > > On Thu, Sep 19, 2019 at 8:35 PM Derrick Stolee <stolee@gmail.com>=
 wrote:
> > > > > >
> > > > > > During the Virtual Git Contributors' Summit, Dscho brought up t=
he topic of
> > > > > > "Inclusion & Diversity". We discussed ideas for how to make the=
 community
> > > > > > more welcoming to new contributors of all kinds. Let's discuss =
some of
> > > > > > the ideas we talked about, and some that have been growing sinc=
e.
> > > > > >
> > > > > > Feel free to pick apart all of the claims I make below. This is=
 based
> > > > > > on my own experience and opinions. It should be a good baseline
> > > > > > for us to all arrive with valuable action items.
> > > > > >
> > > > > > I have CC'd some of the people who were part of that discussion=
. Sorry
> > > > > > if I accidentally left someone out.
> > > > > >
> > > > > > I. Goals and Perceived Problems
> > > > > >
> > > > > > As a community, our number one goal is for Git to continue to b=
e the best
> > > > > > distributed version control system. At minimum, it should conti=
nue to be
> > > > > > the most widely-used DVCS. Towards that goal, we need to make s=
ure Git is
> > > > > > the best solution for every kind of developer in every industry=
. The
> > > > > > community cannot do this without including developers of all ki=
nds. This
> > > > > > means having a diverse community, for all senses of the word: D=
iverse in
> > > > > > physical location, gender, professional status, age, and others=
.
> > > > > >
> > > > > > In addition, the community must continue to grow, but members l=
eave the
> > > > > > community on a regular basis for multiple reasons. New contribu=
tors must
> > > > > > join and mature within the community or the community will dwin=
dle. Without
> > > > > > dedicating effort and attention to this, natural forces may res=
ult in the
> > > > > > community being represented only by contributors working at lar=
ge tech
> > > > > > companies focused on the engineering systems of very large grou=
ps.
> > > > > >
> > > > > > It is worth noting that this community growth must never be at =
the cost
> > > > > > of code quality. We must continue to hold all contributors to a=
 high
> > > > > > standard so Git stays a stable product.
> > > > > >
> > > > > > Here are some problems that may exist within the Git community =
and may
> > > > > > form a barrier to new contributors entering:
> > > > > >
> > > > > > 1. Discovering how to contribute to Git is non-obvious.
> > > > > >
> > > > > > 2. Submitting to a mailing list is a new experience for most de=
velopers.
> > > > > >    This includes the full review and discussion process.
> > > > > >
> > > > > > 3. The high standards for patch quality are intimidating to new=
 contributors.
> > > > > >
> > > > > > 4. Some people do not feel comfortable engaging in a community =
without
> > > > > >    a clear Code of Conduct. This discomfort is significant and =
based on real
> > > > > >    experiences throughout society.
> > > > > >
> > > > > > 5. Since Git development happens in a different place than wher=
e users
> > > > > >     acquire the end product, some are not aware that they can c=
ontribute.
> > > > > >
> > > > > > II. Approach
> > > > > >
> > > > > > The action items below match the problems listed above.
> > > > > >
> > > > > > 1. Improve the documentation for contributing to Git.
> > > > > >
> > > > > > In preparation for this email, I talked to someone familiar wit=
h issues
> > > > > > around new contributors, and they sat down to try and figure ou=
t how to
> > > > > > contribute to Git. The first place they went was https://github=
.com/git/git
> > > > > > and looked at the README. It takes deep reading of a paragraph =
to see a
> > > > > > link to the SubmittingPatches docs.
> > > > > >
> > > > > > To improve this experience, we could rewrite the README to have=
 clearer
> > > > > > section markers, including one "Contributing to Git" section re=
latively
> > > > > > high in the doc. We may want to update the README for multiple =
reasons.
> > > > > > It should link to the new "My First Contribution" document
> > > > > > (https://git-scm.com/docs/MyFirstContribution).
> > > > > >
> > > > > > 2. Add more pointers to GitGitGadget
> > > > > >
> > > > > > We have a reference to GitGitGadget in the GitHub PR template t=
o try and
> > > > > > get people who try to submit a pull request to git/git to inste=
ad create
> > > > > > one on GitGitGadget. However, that captures contributors who di=
dn't read
> > > > > > the docs about how to submit! (This is somewhat covered by the =
"My First
> > > > > > Contribution" doc as well, so making that more visible will als=
o help.)
> > > > > >
> > > > > > Could we reference GitGitGadget as part of the Submitting Patch=
es doc
> > > > > > as well?
> > > > > >
> > > > > > 3. Introduce a new "mentors" mailing list
> > > > > >
> > > > > > From personal experience, all new contributors at Microsoft (af=
ter Jeff
> > > > > > Hostetler at least) have first had their patches reviewed priva=
tely by
> > > > > > the team before sending them upstream. Each time, the new contr=
ibutor
> > > > > > gained confidence about the code and had help interpreting feed=
back from
> > > > > > the list.
> > > > > >
> > > > > > We want to make this kind of experience part of the open Git co=
mmunity.
> > > > > >
> > > > > > The idea discussed in the virtual summit was to create a new ma=
iling
> > > > > > list (probably a Google group) of Git community members. The po=
int of
> > > > > > the list is for a new contributor to safely say "I'm looking fo=
r a
> > > > > > mentor!" and the list can help pair them with a mentor. This mu=
st
> > > > > > include (a) who is available now? and (b) what area of the code=
 are they
> > > > > > hoping to change?
> > > > > >
> > > > > > As evidence that this is a good idea, please see the recent res=
earch
> > > > > > paper ""We Don't Do That Here": How Collaborative Editing With =
Mentors
> > > > > > Improves Engagement in Social Q&A Communities" [1].
> > > > > >
> > > > > > [1] http://www.chrisparnin.me/pdf/chi18.pdf
> > > > > >
> > > > > > When asking your first question on Stack Overflow, this group a=
dded
> > > > > > a pop-up saying "Would you like someone to help you with this?"=
. Then,
> > > > > > a mentor would assist crafting the best possible question to en=
sure
> > > > > > the asker got the best response possible.
> > > > > >
> > > > > > I believe this would work in our community, too. The action ite=
ms
> > > > > > are:
> > > > > >
> > > > > > a. Create the mailing list and add people to the list.
> > > > > >
> > > > > > b. Add a pointer to the list in our documentation.
> > > > > >
> > > > > > Note: the people on the mentoring list do not need to be
> > > > > > "senior" community members. In fact, someone who more recently
> > > > > > joined the community has a more fresh perspective on the proces=
s.
> > > > > >
> > > > > > 4. Add an official Code of Conduct
> > > > > >
> > > > > > So far, the community has had an unofficial policy of "be nice,
> > > > > > as much as possible". We should add a Code of Conduct that is
> > > > > > more explicit about the behavior we want to model. This was als=
o
> > > > > > discussed in the meeting with wide approval.
> > > > > >
> > > > > > 5. Advertise that Git wants new contributors
> > > > > >
> > > > > > After we put items 1-4 in place, we should reach out to the
> > > > > > general tech community that we are interested in new
> > > > > > contributors. It's not enough to open the door, we should
> > > > > > point people to it.
> > > > > >
> > > > > > This item is much less explicit about the _how_. This could
> > > > > > be done at the individual level: posting to social media or
> > > > > > blog posts. But perhaps there is something more official we
> > > > > > could do?
> > > > > >
> > > > > > III. Measurement
> > > > > >
> > > > > > How do we know if any of these items make a difference? We
> > > > > > need to gather data and measure the effects. With the size
> > > > > > of our community, I expect that it will take multiple years
> > > > > > to really see a measurable difference. But, no time like
> > > > > > the present to ask "What does success look like?"
> > > > > >
> > > > > > Here are a few measurements that we could use. Each "count"
> > > > > > could be measured over any time frame. We could use major
> > > > > > releases as time buckets: v2.22.0 to v2.23.0, for example.
> > > > > >
> > > > > > 1. How many first-time contributors sent a patch?
> > > > > >
> > > > > > 2. How many contributors had their first commit accepted into
> > > > > >    the release?
> > > > > >
> > > > > > 3. How many contributors started reviewing?
> > > > > >
> > > > > > 4. How many total patches/reviews did the list receive?
> > > > > >
> > > > > > What other measurements would be reasonable? We could try
> > > > > > building tools to collect these measurements for the past
> > > > > > to see historical trends. Based on that data, we may be
> > > > > > able to set goals for the future.
> > > > > >
> > > > > > With such a small community, and an expected small number
> > > > > > of new contributors, it may also be good to do interviews
> > > > > > with the new contributors to ask about their experience.
> > > > > > In particular, we would be looking for moments where they
> > > > > > had trouble or experience friction. Each of those
> > > > > > moments is a barrier that others may not be clearing.
> > > > > >
> > > > > >
> > > > > > I look forward to the discussion.
> > > > > >
> > > > > > Thanks,
> > > > > > -Stolee
