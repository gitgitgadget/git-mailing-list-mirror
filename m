Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DC01F461
	for <e@80x24.org>; Fri, 30 Aug 2019 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH3S0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 14:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbfH3S0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 14:26:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF767AC8F;
        Fri, 30 Aug 2019 18:26:36 +0000 (UTC)
Date:   Fri, 30 Aug 2019 20:26:35 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned
 repos
Message-ID: <20190830202635.0bc7e14f@kitsune.suse.cz>
In-Reply-To: <xmqqd0gmzk0c.fsf@gitster-ct.c.googlers.com>
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
        <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
        <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
        <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
        <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
        <xmqqd0gmzk0c.fsf@gitster-ct.c.googlers.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Aug 2019 09:38:11 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Albert Vaca Cintora <albertvaka@gmail.com> writes:
> 
> > On Tue, Aug 27, 2019 at 9:35 PM Junio C Hamano <gitster@pobox.com> wrote:  
> >>
> >> Ah, your "rm" command needs to learn "-f" option, too, then?  
> >
> > The whole point of this thread was to remove the need of -f forcing the removal.  
> 
> OK, I misunderstood what you wanted to do.
> 
> If an implementation of Git were making everything under .git/
> read-only, including directories, then it is veriy much reasonable
> to complain against such an implementation.  The usual "I know I am
> doing something unusual and forcing it" safety given by "rm -rf" is
> not enough to remove such a clone, and user would need "chmod -R u+w"
> beforehand to be able to remove---that is being unreasonably paranoid
> in the name of protecting against mistakes.
> 
> But requiring an additional single "f" when doing "rm -rf .git"?  Is
> that realy too much of a hassle?  The option "-f" is to allow people
> deal with an unusual situation, while preventing everyday use from
> doing something harmful unintendedly.  And removing a cloned
> repository is an unusual situation that would not happen every day,
> no?

Not everyone's day. Some people's day, sure.

I am not in this situation so often but indeed I sometimes clone
several repositories in a day to search for a patch or piece of code
and then don't need them anymore. Some people may be in such situation
more often or regularly.

That's why this request makes sense to me.

Thanks

Michal
