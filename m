Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A231F404
	for <e@80x24.org>; Thu, 12 Apr 2018 05:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeDLFmc (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 01:42:32 -0400
Received: from mail.javad.com ([54.86.164.124]:43490 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeDLFma (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 01:42:30 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 5BC3E3FEBC;
        Thu, 12 Apr 2018 05:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523511749;
        bh=rqr6oburn1emXxAVsqDxg1fdjXqzbQRibDhUzW/NBmE=; l=2959;
        h=Received:From:To:Subject;
        b=JvXsDvSBr3oCDnQtEW510RlqFdQLChQCm1kYmlC514hm5Jn4JSj7fkQSHUdOSyDqg
         pjo6z0rUl50MUyxOeFyT7plVOrHgGB5/wWlfVMLn1X3g585FgQzrXEbHAsgXOz2ngw
         hBX4Q8OPw9wAihB64ZSZ48XVnf4XEexIIl21aLhw=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6V07-0001AC-CA; Thu, 12 Apr 2018 08:42:27 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sfm737e.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8oh51jm.fsf@javad.com>
        <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
Date:   Thu, 12 Apr 2018 08:42:27 +0300
In-Reply-To: <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
        (Jacob Keller's message of "Wed, 11 Apr 2018 16:52:33 -0700")
Message-ID: <87sh810ym4.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

Jacob Keller <jacob.keller@gmail.com> writes:
> On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
>> It was rather --recreate-merges just a few weeks ago, and I've seen
>> nobody actually commented either in favor or against the
>> --rebase-merges.
>>
>> git rebase --rebase-merges
>>
>
> I'm going to jump in here and say that *I* prefer --rebase-merges, as
> it clearly mentions merge commits (which is the thing that changes).

OK, thanks, it's fair and the first argument in favor of --rebase-merges
I see.

I don't get why this detail matters so much it should be reflected in
the option name, and if it is what matters most, why the patch series
are not headed:

<twisted quote>
rebase -i: offer to rebase merge commits.

Once upon a time, I dreamt of an interactive rebase that would not
drop merge commits, but instead rebase them.
</twisted quote>

> I hadn't mentioned this before, because it was a suggestion that
> someone else made and it seemed that Johannes liked it, so I didn't
> think further discussion was worthwhile.

So you guys seem to be winning 2:1, or even 3:1, counting the guy who
made the suggestion. Except it was Buga's suggestion [1], and I believe
I was able to convince him that something like --no-flatten would be
better [2]:

<quote>
> I hope he'd be pleased to be able to say --no-flatten=remerge and get
> back his current mode of operation, that he obviously has a good use
> for.

Makes sense, I like it, thanks for elaborating. [ Especially that you 
used "(no) flatten" phrasing, where original `--preserve-merges` 
documentation says it`s used "not to flatten the history", nice touch
;) ]
</quote>

So I assume it's 2:2 by now, with the author of original suggestion on
my side.

I still find

git rebase --rebase-merges

both being ugly and missing the point.

When I look at it with a fresh eye, the questions that immediately rise
are: "What the hell else could 'git _rebase_' do with (merge) commits
but _rebase_ them? Why do I even need to specify this option? Should I
also specify --rebase-non-merges to rebase the rest of commits?"

Well, if it was called something like --[no-]keep-merges, it'd make more
sense as it'd be obvious that alternative is to drop merges (notice how
the old --preserve-merges does match this criteria). However, it'd still
miss to reflect the generic intent of the patch series, -- to preserve
history shape as much as possible, -- now citing author's head message
non-twisted: 

<quote>
rebase -i: offer to recreate commit topology

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.
</quote>

-- Sergey

[1] https://public-inbox.org/git/bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com/
[2] https://public-inbox.org/git/a3d40dca-f508-5853-89bc-1f9ab393416b@gmail.com/
