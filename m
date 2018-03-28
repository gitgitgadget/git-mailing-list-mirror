Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA821F404
	for <e@80x24.org>; Wed, 28 Mar 2018 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC1F5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 01:57:05 -0400
Received: from mail.javad.com ([54.86.164.124]:54226 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeC1F5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 01:57:04 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6523D3E863;
        Wed, 28 Mar 2018 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522216623;
        bh=SoY5hQIZlObGfvLUJ+1D9NB8ufYlLokPiUOnb9N7d4k=; l=1235;
        h=Received:From:To:Subject;
        b=Ys6jAuk7I5cVN8mFJe8vvzXM86h7FmhbpPz25XulTe7KsZjlpzRwQePFyB5UqMph1
         nzQcRjAe8ttdIFkSdV+VB4EKJESh+68SIB2xJzC0ypNs2qj1DXG6qbAuJsBerq6arD
         JVdYqxPJdbSSkgcNpEC/zJ959UxBAigqWO8NW2pg=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f144z-0002bM-2X; Wed, 28 Mar 2018 08:57:01 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87woxyf4lk.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 28 Mar 2018 08:57:01 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Mar 2018 15:49:17 +0200
        (DST)")
Message-ID: <87605gd9oy.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,

[...]

> But I'll stop here. Even my account how there are conceptual differences
> between the changes in merge vs non-merge commits (the non-merge commit
> *introduces* changes, the merge commit *reconciles existing* changes)
> seems to fly by without convincing you.

Good for you, but Git should keep caring about content, it should care
not about meaning. Please leave it to the user to assign meaning to
their content.

If you rather want a SCM that focuses on meaning, I'd suggest to look at
Bzr and see how it goes.

> I use rebase every day. I use the Git garden shears every week. If you do
> not trust my experience with these things, nothing will convince you. 

Unfortunately you have exactly zero experience with rebasing merges as
you've never actually rebased them till now, and it's rebasing merges
that matters in this particular discussion.

> You are just stuck with your pre-existing opinion.

I'm afraid that it's rather your huge experience with re-creating merges
that makes you stuck to your pre-existing opinion and carefully shields
you from experiencing actual paradigm shift.

-- Sergey
