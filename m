From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Tue, 18 Feb 2014 14:10:32 +0100
Message-ID: <CALKQrgeH+xOqjOv8Z0nnBrmE0=L8GMWn+ewiN+mWBkO5dOvtvA@mail.gmail.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
	<xmqqob32s08p.fsf@gitster.dls.corp.google.com>
	<20140124213521.GA26602@sigill.intra.peff.net>
	<9D08338A41454F778D03FB2E9F4B7DD1@PhilipOakley>
	<20140218085224.GB2692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 14:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkRg-0003kb-82
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbaBRNKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 08:10:40 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:44231 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbaBRNKi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:10:38 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WFkRY-000664-Ht
	for git@vger.kernel.org; Tue, 18 Feb 2014 14:10:36 +0100
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WFkRY-000H4Y-9Q
	for git@vger.kernel.org; Tue, 18 Feb 2014 14:10:36 +0100
Received: by mail-pb0-f48.google.com with SMTP id rr13so16738310pbb.35
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PWy7wQD738I3NaSOLvQZ9h1yTag5XIepEjs4FHMGwBg=;
        b=PO9YmFg/UkORCMS6YFax58dePyVcGqW96Y16Egd8tuTfJN9bstwrFj4rwOfuwSqqAo
         975gV92roEXv7hcy+QzClZpI14dXQxtNo29PiCzwS7DOh3sxMkhf0vNIDNk8uULNmoD8
         dIJPVFN8oK+/uejPmzz0g7Al3cFgCOHH/52cfNGggjbEYT9M4uONqNZvqNQUYXmomFHQ
         gnsd6+xzkN/esAiiXxNTnnmHZFt1Weeu7rOlLkRLX0GIP4wVYSNJLtqpINAyye9zfEqd
         o55h+SpDJaWTfMvXaZjkOp0NH/XX1WERIDuccmoC5yKHGqBof3TEIOEpXNKW9GXj2sXB
         eJbg==
X-Received: by 10.66.136.71 with SMTP id py7mr33378732pab.2.1392729032260;
 Tue, 18 Feb 2014 05:10:32 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 18 Feb 2014 05:10:32 -0800 (PST)
In-Reply-To: <20140218085224.GB2692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242299>

On Tue, Feb 18, 2014 at 9:52 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 15, 2014 at 11:50:10AM -0000, Philip Oakley wrote:
>> >>> This patch introduces the <branch>@{publish} shorthand (or
>> >>> "@{pu}" to be even shorter).
>>
>> Just to say that I'm not sure that "publish" is the best word for
>> this concept.
>> [...]
>
> I would much rather have a name that describes what the thing _is_, then
> how it is meant to be used. The concept of @{publish} is a shorthand for
> "where would I push if I typed git push on this branch". In a
> non-triangular workflow, that means sharing your commits with others on
> the main branch. In a triangular workflow, it means sharing your commits
> with a publishing point so that others can see them. If your default
> push goes to a backup repo, it does not mean publishing at all, but
> rather syncing the backup.
>
> So I do not think any one word can describe all of those use cases; they
> are orthogonal to each other, and it depends on your workflow.
>
> In that sense, "publish" is not the best word, either, as it describes
> only the first two, but not the third case (and those are just examples;
> there may be other setups beyond that, even).
>
> Perhaps "@{push}" would be the most direct word.

I agree that we want a more general (i.e. workflow-agnostic) term to
differentiate between "where we pull from", and "where we push to". As
such, "@{push}" should have a corresponding "@{pull}" (which I believe
should function as an alias of "@{upstream}"). [1]


...Johan

[1]: I don't think there is a reason not to reuse the "push"/"pull"
terminology for these concepts, but if there is, I guess we could
instead call them "@{source}"/"@{destination}", "@{src}/@{dst}", or
"@{from}/@{to}", or somesuch...

-- 
Johan Herland, <johan@herland.net>
www.herland.net
