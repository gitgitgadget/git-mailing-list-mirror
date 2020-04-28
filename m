Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413BDC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E4F20B1F
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgD1SRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:17:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgD1SRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:17:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3762AAC7F;
        Tue, 28 Apr 2020 18:16:58 +0000 (UTC)
Date:   Tue, 28 Apr 2020 20:16:57 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?UTF-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: proto v2 fixes for maint (was Re: Preparing for a Git 2.26.3
 release)
Message-ID: <20200428201657.30467979@naga.burning-in.hell>
In-Reply-To: <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
References: <20200428055514.GB201501@google.com>
        <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Apr 2020 10:25:09 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Since then we've heard about a few related (non-security) regressions.
> > I'd like to avoid giving people an excuse not to upgrade, so this
> > morning[1] I promised a discussion of what I'd like to see in a 2.26.3
> > release to help with that.  
> 
> Thanks for starting this.  
> 
> I'll have chances to comment on other areas you listed, but since
> I've answered on v2-proto stuff to somebody else already...
> 
> > The protocol version change was painful for users that fetch in the
> > same repo from linux-next and other linux remotes[5].  The problem has
> > been isolated and fixed, so we could either apply the revert or apply
> > the fixes[6].  
> 
> The demote patch hasn't even hit 'master'.  
> 
> My preference is to merge the demotion down to 'master' and 'maint'
> while merging down this fix to 'next' and to 'master'.

I understand that this issue puts v2 protocol into question and you
want to go back to v0 as default. Why not merge the fixes for v2,
though? Even if it is not the default keeping it broken in maint does
not sound great.

Thanks

Michal
