Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC3A1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeFFTrD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:47:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34091 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752348AbeFFTrC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2018 15:47:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DFAA321E77;
        Wed,  6 Jun 2018 15:47:01 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute2.internal (MEProxy); Wed, 06 Jun 2018 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=lxYjqiK3t8GG98qenpKH/TfEBReIY
        3Emkj5E8ppTsko=; b=SfC8indao4LC8icQmz7yB8biMV5/8/32EbGy7NdGFr+oN
        zYx+Fjo+DWSBny76bFu2poHOPGLIPNctopePdiLA4I3iR08/Kwwdu7ITXyOWPwLW
        sHc8u9uSuDbXPWoXDGxEPoJ0axoB9jQt2xYkphlWPgzzFy8+VISpCIhwojTEDOZu
        mgHVjDX/DlDWFtp+CsT3dX89vQpARyInp8X5EvPdtbIq8+m2CZRuh34ch79GvNHf
        jKM6dVfp3mKujuoJjikAyJVnuKlFjgbytu6lE5hBMcKu4iqd1Zch1SokMn/4fVUU
        Y8Spip//rByijPjHfd1nyWfcmQsP6aIY6l3ZQyC1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lxYjqi
        K3t8GG98qenpKH/TfEBReIY3Emkj5E8ppTsko=; b=lcKAc2Q+CB1UxgUePtk9de
        VUOq6cpuQxa4eeIm1KrGZloy57Od1vGHdU0y9814kkUmGi75SR6GzadHl6WOOnPc
        9dwiOt/Idz4caNbE9SN1LxnFdgF99kzal9tN6T3JjtqNJbRAupBhb16Llzc6SJDb
        EOHUYUcNYmlPRuy2zKM2d+CfdkGsyKfOAwdlCp4VRm9sprt+XwWfNuZj7EfOwi4B
        NrgoG6OSQbsz7XDb8nj7+IjQjxnwOpLbxN1T94BKNlG39Na5+kjWe2WcMvnNhnQO
        aqToWyiX7rbU/aXLPhFFEL1bIID3KW9ZK4Kmlpcvjgb2DO5eeuwccX6jFH3ubtyQ
        ==
X-ME-Proxy: <xmx:NToYW6326AmnlfbwKYo27d5Iur0Kek-3Ng0v0e0bGYk9K6AQv_Y1XA>
X-ME-Proxy: <xmx:NToYW0XcHPgZTIaLJ6o75K2nxYxUj7-TPkiOmADGepjm4ymoSnxosQ>
X-ME-Proxy: <xmx:NToYW7cpV2ao-05RzYwIF8ue-PrbkQEWhVkogvzCzeKmKESlX3u5JQ>
X-ME-Proxy: <xmx:NToYW5PMvuqSi4iJAbRiwWrzUH9OSNO7nW1y8qcD5sUzRom-YAKg7A>
X-ME-Proxy: <xmx:NToYW1ICSqKts85G71gtx39gK-cf2DhcICxVnTxcJcO-XLt01isNkA>
X-ME-Proxy: <xmx:NToYW868bQN3xlJbWmMiGfj0jeqv6n0tJNjJ0WAbia0nu4-7PysBLA>
X-ME-Sender: <xms:NToYW1fC4JBHSKumat8AY8qag2qj2IRu0FMy3_Qy3UM_DKZitpophQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id B08FD42A1; Wed,  6 Jun 2018 15:47:01 -0400 (EDT)
Message-Id: <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
From:   Thomas Fischer <thomasfischer@fastmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-fb4a77ea
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
 <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
Subject: Re: git rm bug
Date:   Wed, 06 Jun 2018 14:47:01 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree that the entire chain of empty directories should not be tracked, as git tracks content, not files.

However, when I run 'rm path/to/some/file', I expect path/to/some/ to still exist.

Similarly, when I run 'git rm path/to/some/file', I expect path/to/some/ to exist, *albeit untracked*.

I do NOT expect git to *track* empty directories. But I also do NOT expect it to remove untracked directories.

-- 
  Thomas Fischer
  thomasfischer@fastmail.com

On Wed, Jun 6, 2018, at 2:33 PM, Robert P. J. Day wrote:
> On Wed, 6 Jun 2018, Thomas Fischer wrote:
> 
> > OVERVIEW
> >
> > "git rm" will remove more files than specified. This is either a bug or undocumented behavior (not in the man pages).
> >
> > SETUP
> >
> > 1. In a git repository, create an empty directory OR a chain of empty directories
> >
> > $ mkdir -p path/to/some/
> >
> > 2. Create a file in the deepest directory and add it to tracking
> >
> > $ touch path/to/some/file
> > $ git add path/to/some/file
> > $ git commit -m 'add path/to/some/file'
> >
> > THE BUG
> >
> > Run 'git rm' on the tracked file.
> >
> > EXPECTED BEHAVIOR
> >
> > $ git rm path/to/some/file
> > rm 'path/to/some/file'
> > $ ls path
> > to/
> > $ ls path/to
> > some/
> >
> > Note that path/, path/to/, and path/to/some/ still exist.
> >
> > ACTUAL BEHAVIOR
> >
> > $ git rm path/to/some/file
> > rm 'path/to/some/file'
> > $ ls path
> > ls: cannot access 'path': No such file or directory
> >
> > The entire chain of empty directories is removed, despite the fact
> > the git outputs only "rm 'path/to/some/file'".
> 
>   git cannot track empty directories. as that was the *only* content
> in that whole hierarchy, the entire hierarchy had to be deleted.
> 
> rday
