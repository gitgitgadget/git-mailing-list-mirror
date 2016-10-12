Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9EB207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbcJLN1q (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:27:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933166AbcJLN1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:27:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CCD843D40;
        Wed, 12 Oct 2016 09:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=cmvmkBjZMlMURDDHB3zWjGiP5sw=; b=Hk6I+04
        l34MtjvMlAH4RZer4UNzeeNV/3r89QwLNive0FU3aCmQ5guz1SNhRHtEi4lTnVG3
        MVywdfCHjNLTit4Qze4SoeaAhFvgiZJoWABmpYpvn/FXUwix5SQB6gQQ1plAm8Fd
        AvNKRKARaqqPQTK+pk/nGVFxMeZ5g+K7Mow8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=h/M/FEKU9lwDups/RKK2Vj0E9AcxynkMw
        eNQtgLD8XqpY/bNfmBATLzeMa2hxM/KMRSrUzslXo8TVwf3a5GhcxqmViLsgriy/
        9M9+c0KGTMnHvx9D8D1p7NsEtBjR8pHm/z1KF6zekB6OHvz4RGyitJ5dBtU1tnwg
        e0SJcr3Erc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0583643D3F;
        Wed, 12 Oct 2016 09:27:42 -0400 (EDT)
Received: from pobox.com (unknown [128.172.245.7])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9648C43D3B;
        Wed, 12 Oct 2016 09:27:40 -0400 (EDT)
Received: by pobox.com (sSMTP sendmail emulation); Wed, 12 Oct 2016 09:27:40 -0400
Date:   Wed, 12 Oct 2016 09:27:40 -0400
From:   Joshua N Pritikin <jpritikin@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: interactive rebase should better highlight the not-applying
 commit
Message-ID: <20161012132740.dvyofl36qtualxgk@droplet>
References: <20161011190745.w2asu6eoromkrccu@droplet>
 <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com>
X-PGP-Key: http://people.virginia.edu/~jnp3bc/pubkey.asc
X-PGP-Fingerprint: 275A 6673 208B 1E36 CDEC  5188 281A 7053 6127 B3F7
X-PGP-ID: 0x6127B3F7
User-Agent: NeoMutt/ (1.7.0)
X-Pobox-Relay-ID: A64B4986-907F-11E6-AF9B-5F377B1B28F4-03616332!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 01:55:22PM -0700, Stefan Beller wrote:
> On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > I assume somebody familiar with GIT's code base could make this change
> > in about 10 minutes.
>
> Can you elaborate how you come to that estimate?

Hm, a false belief in the general awesomeness of GIT developers?

On Tue, Oct 11, 2016 at 02:25:19PM -0700, Stefan Beller wrote:
> On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > As of GIT 2.8.1, if you do an interactive rebase and get some conflict
> > in the stack of patches then the commit with the conflict is buried in
> > 4-5 lines of output. It is visually difficult to immediately pick out
> > which commit did not apply cleanly. I suggest highlighting the 1 line
> > commit summary in red or green or some color to help it stand out from
> > all the other output.
> >
> > I decided to suggest this change after I realized that I probably
> > skipped a commit during an interactive rebase instead of resolving the
> > conflict. I knew I had to skip some commit so I assumed that I just need
> > to skip without reading the commit summary carefully. Now it is 7-15
> > days after I did the erroneous rebase. I had to spend a few hours today
> > with GIT's archaeology tools to find the lost code.
> 
> Looking at the actual code, this is not as easy as one might assume, 
> because rebase is written in shell. (One of the last remaining large 
> commands in shell), and there is no color support in the die(..) 
> function.

I'm sorry to hear that.

> However IIUC currently rebase is completely rewritten/ported to C 
> where it is easier to add color support as we do have some color 
> support in there already.

Sounds great. Is there a beta release that I can try out?

Also, I have another wishlist item for (interactive) rebase. Sometimes I 
do a rebase to fix some tiny thing 10-15 commits from HEAD. Maybe only 1 
file is affected and there are no merge conflicts, but when rebase 
reapplies all the commits, the timestamps of lots of unmodified files 
change even though they are unmodified compared to before the rebase. 
Since the modification times are used by 'make' to compute dependencies, 
this creates a lot of useless recompilation that slows things down. It 
would be great if rebase only changed the timestamps of files that were 
actually modified.

Thank you.

-- 
Joshua N. Pritikin, Ph.D.
Virginia Institute for Psychiatric and Behavioral Genetics
Virginia Commonwealth University
PO Box 980126
800 E Leigh St, Biotech One, Suite 1-133
Richmond, VA 23219
http://people.virginia.edu/~jnp3bc
