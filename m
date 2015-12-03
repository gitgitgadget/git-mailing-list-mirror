From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Thu, 3 Dec 2015 12:03:37 -0800
Message-ID: <CAGZ79kbtOEMk2woY5rovvC4xduiQRsKp+BXVt=5h9d76tpLWSA@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
	<CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
	<xmqqegf57sfe.fsf@gitster.mtv.corp.google.com>
	<xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4a6X-0004aD-UT
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbLCUDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:03:40 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34039 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbLCUDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:03:38 -0500
Received: by ykfs79 with SMTP id s79so99958273ykf.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 12:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FjNeGwMMJnlAjwtb3SEPu7sLiDn0XksyaZsm7yRvvuo=;
        b=Om8hmLwq9IyKfwQUgce1cliK/oQKpV9JslMwSxcv2zOm8S42UL/cOyS98ipRVYQj2V
         AGFPWnDqtzlAKCv5DwEJq/7D5rEstUqEksAawaxOHliuwc5raMtUN7tFrnMs9utcX8Lo
         dUx8WaGqBeXR6IbGEqljPHIOzm/aXbyYWYkNUp1pJ5GuvdOdl2ABXqzTPnDRfTF7e1Nj
         iSi/xTMNxsZWE1ndiK0RhjYHUaX10EizK7mjoJGGUiPuPAijnK6zPIzlr5FuzAwSYOeC
         Mv+vHa1a9WpWpmMxXXSPgZIS4EF0dEQIUomaWnQnhm0klxNhfvWS9oxBxLJi/USPnkIP
         T+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FjNeGwMMJnlAjwtb3SEPu7sLiDn0XksyaZsm7yRvvuo=;
        b=dWedk+sdymOkzkqa8MVmiTPzeOWS3CiGj7ItGW+TDmveAntfOz6z5CUJU76y4QK0di
         YHI0md0rf2eHngBgJY607x3cUN7wqPIjyUiN3SwVCTRa9QbQomn15Rgfm7ZUlUqLjiX3
         +wFVM6m6JQ6a0AWDpot8nZefPgHmq9cn65vQBr9FYMqrIkmjzRRpHFHCRCwDyjXkFtpB
         icpxNPvj4aKrgKNJePzXF3VNHXqPx2ixELTRK8jQFPetDVBm6LtwaL50ZyNnW8ejhemh
         e+Bev5qHC765VnBKgNFP9cGDFvk2DDpWSJfHQSxiu+6LST0HlL83AisiP3Jq08cmBYHo
         2HQQ==
X-Gm-Message-State: ALoCoQnW/Odk9vP3Xzv54PJwZolxiOhaoikG86sWosPI0qrAE4RRXFR7iKrAGv8i14l2jIICd66R
X-Received: by 10.13.221.21 with SMTP id g21mr9591164ywe.320.1449173017301;
 Thu, 03 Dec 2015 12:03:37 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Thu, 3 Dec 2015 12:03:37 -0800 (PST)
In-Reply-To: <xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281965>

On Tue, Dec 1, 2015 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not think you would need a new option for this, by the way.
>> Just add a new syntax for the LFS of a refspec that cannot possibly
>> be confused with existing choices of what can come there (i.e. an
>> empty string to denote deletion, or a partial refname), e.g. come up
>> with an appropriate string in $sign and allow the following:
>>
>>     $ git fetch ${sign}c78f7b5ed9dc
>>     $ git fetch ${sign}c78f7b5ed9dc:refs/remotes/origin/frotz

That looks good to me.

>
> Instead, we should limit us to 40-hex object name and nothing else
> in the initial incarnation.

ok, will do.

>
> i.e.
>
>      $ git fetch ${sign}c78f7b5ed9dc1c6edc8db06ac65860151d54fd07
>      $ git fetch ${sign}c78f7b5ed9dc1c6edc8db06ac65860151d54fd07:refs/remotes/origin/frotz
>
> If the remote end (which, as Peff pointed out earlier, already knows
> how to respond to a fetch request for an exact object when
> configured to do so) allows such a fetch to go through, "fetch" can
> (and will) update the ref named by the RHS of storing refspec with
> the current code, so there is no need to do anything special to
> support this.
>
> As to ${sign}, I was tempted to say an empty string might be
> sufficient (i.e. "do not use 40-hex as your branch name"), but it
> probably is a bad idea.

I would think if sign is empty string the server will check if the given
40-hex is unique (either a branch named so, while there is no such
object or just that object and not branch/tag) or the remote would
reject due to disambiguation. This possibility can be done later though.

> A single dot "." would be a possibility
> (i.e. a ref component cannot begin with a dot), but squating on it
> and saying "anything that begins with . must be followed by 40-hex
> (and in the future by an extended SHA-1)" would rob extensibility
> from us, so perhaps ".@c78f7b5ed9dc1c6edc8db06ac65860151d54fd07" or
> something?

My gut reaction is to reject that notation, as it is very cryptic.
Looking at the @ sign, it reminds me of the reflog notion such as HEAD@{-1}.
So maybe it would be more appealing to specify
HEAD@{c78f7b5ed9dc1c6edc8db06ac65860151d54fd07}
to mean a specific commit. By saying HEAD we indicate it is not meant as
a branch (both on the remote as well as locally).
By having the @{ sequence this would also be dis-ambiguous from any
branch.

> That is leading "." denotes "this is an extended refspec"
> and the next character denotes what kind of extended refspec it is.
> For now we say that "@" denotes "exact object name is used instead
> of a(n abbreviated) refname".

So using @ as you propose I could also specify .@refs/heads/master as
an un-abbreviated ref?

Did you have any reason to pick . specifically or are we welcome to bikeshed
why a colon might be better? (or ":", "?", "[", "\", "^", "~", SP, or TAB)

We could use [id]c78f7b5ed9dc1c6edc8db06ac65860151d54fd07
or [const]c78f7b5ed9dc1c6edc8db06ac65860151d54fd07 ?

Looking at the big picture here, this being a preparation for improving
submodule cloning, we also want to allow tags here?
