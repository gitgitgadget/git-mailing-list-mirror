Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 6099 invoked by uid 111); 31 Oct 2008 11:38:26 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 31 Oct 2008 07:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbYJaLiV (ORCPT <rfc822;peff@peff.net>);
	Fri, 31 Oct 2008 07:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbYJaLiV
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:38:21 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:26637 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYJaLiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:38:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so494432yxm.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 04:38:19 -0700 (PDT)
Received: by 10.100.210.9 with SMTP id i9mr1802211ang.132.1225453099804;
        Fri, 31 Oct 2008 04:38:19 -0700 (PDT)
Received: by 10.100.92.11 with HTTP; Fri, 31 Oct 2008 04:38:19 -0700 (PDT)
Message-ID: <f73f7ab80810310438k3282639eta90f2a0589a12c1@mail.gmail.com>
Date:	Fri, 31 Oct 2008 07:38:19 -0400
From:	"Kyle Moffett" <kyle@moffetthome.net>
To:	"Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Cc:	"Sam Vilain" <sam@vilain.net>, git@vger.kernel.org
In-Reply-To: <d4bc1a2a0810300355q42b35a35p2ba0e778691a0ab6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <d4bc1a2a0810300355q42b35a35p2ba0e778691a0ab6@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Oct 30, 2008 at 6:55 AM, Stefan Karpinski
<stefan.karpinski@gmail.com> wrote:
> On Wed, Oct 29, 2008 at 8:48 PM, Sam Vilain <sam@vilain.net> wrote:
>> +  * 'git export' command that does what
>> +    'git archive --format=tar --prefix=dir | tar x' does now
>
> It would be nice if the "git export" command could "checkout" a
> non-repo copy of a remote repo at a specific version. This would be as
> simple as calling archive on the remote size and then unarchiving it
> locally. But would of course take care of all the plumbing.

I'm not sure whether the "git archive | tar" or the following is more efficient:

export GIT_INDEX_FILE="$(mktemp .git/export-index.XXXXXX)"
git read-tree -i "$1"
git checkout-index -f -a --prefix="$2/"

Cheers,
Kyle Moffett
