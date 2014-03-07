From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Fri, 7 Mar 2014 08:08:37 +0100
Message-ID: <CAP8UFD0UnUGZb9hWyLS1vPJ6fh3QR-g_p5HNQk79Gqhs9YWi0A@mail.gmail.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<53183506.5080002@alum.mit.edu>
	<20140306155626.GB18519@sigill.intra.peff.net>
	<5318A537.4010400@alum.mit.edu>
	<20140306174803.GA30486@sigill.intra.peff.net>
	<08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
	<531904E1.6010606@alum.mit.edu>
	<xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 08:09:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLou5-0004AE-N6
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 08:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbaCGHIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 02:08:39 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:35957 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaCGHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 02:08:38 -0500
Received: by mail-vc0-f176.google.com with SMTP id lc6so3240100vcb.21
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BLoiK8aWt0oA6z9hsgJZfaICrlTun2Z4Q7KQk8H8NqA=;
        b=r4TkgJ5M3stCBrbI6ey66e84fqEmbls1GdwIVxHBpO/6Sxw5/+W2j/DuMJhfvXPHQj
         k+ayklWMIQ/zlNs3CKz4oxbUSLgH3kh/BNK1gC5qvoTjoNKoQRiDk/oQVt/rs4jX6bww
         YU6pmtMLq70rl3iSQKJbzzavCuUrndp4R509+jEkChq7cZBBeXlTurMpmztBRi0mpWQ8
         bPSbUyCesveNQ1ahCKeHeIwqeaUZWH+ZsNx4hvy+G2sV/fouyFOQWvXrVtdQdJZEYitC
         YpRjh6awPKY3NxvfyTL4hxdNTj3g6P2O6mTw+x9f67+cwSnEolCsV6vD9u8i/2dwN2o+
         noMg==
X-Received: by 10.58.37.232 with SMTP id b8mr37701vek.27.1394176117894; Thu,
 06 Mar 2014 23:08:37 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Thu, 6 Mar 2014 23:08:37 -0800 (PST)
In-Reply-To: <xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243602>

On Fri, Mar 7, 2014 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I didn't mean to insult all Windows users in general.  I was only
>> referring to the fact that since the default Windows command line is not
>> a POSIX shell, even an experienced Windows user might have trouble
>> figuring out how to execute a shell loop.  Putting this functionality in
>> a git command or script, by contrast, would make it work universally, no
>> fuss, no muss.
>
> ;-)
>
> Be it graft or replace, I do not think we want to invite people to
> use these mechansims too lightly to locally rewrite their history
> willy-nilly without fixing their mistakes at the object layer with
> "commit --amend", "rebase", "bfg", etc. in the longer term.  So in
> that sense, adding a command to make it easy is not something I am
> enthusiastic about.
>
> On the other hand, if the user does need to use graft or replace
> (perhaps to prepare for casting the fixed history in stone with
> filter-branch), it would be good to help them avoid making mistakes
> while doing so and tool support may be a way to do so.
>
> So, ... I am of two minds.
>

Maybe if we add a new command (or maybe a script) with a name long and
cryptic-looking enough like "git create-replacement-object" it will
scare casual users from touching it, while power users will be happy
to benefit from it.
