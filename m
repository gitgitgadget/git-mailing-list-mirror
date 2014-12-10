From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 01:18:15 -0800
Message-ID: <20141210091815.GA18372@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:18:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XydPi-0004K5-3X
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbaLJJS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:18:26 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43823 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaLJJSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:18:23 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so2275942ier.4
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1vHvel0dywEiH2RwPTx9jLnCf18oW2IpUoBW2Q8FdzM=;
        b=kY/O/qnrD9eBTZKfwA0jk02evxAvbW2E1DRF8uCY/8pi0hqW5XI3cXMguvWDYGBcEM
         R3P8HgHhB2g0WqapQobs5A0ZzJ/fIus3ik9QsZ6ZP/Thxope6NQ2De5nwm8wb7RagPF9
         VwRBfe3VSuX/+WKOInWU6y67fIvRrteYWXWqGO6aAeX9OqotCeoAA0mDuZoYtRJwIxc1
         01TWr8uwSPyocFKEmmomhJDL8IGgVC7S3sV5FpjN2U/Is2X1Jjx/cJmP4qbu0SZwkhw+
         8UFsETZu3OuBp9mIixuof1OzBIXM3eRzdEGOlQhfNLpvM5kjgOajujjmtcOPr5yQ/X8q
         FvMQ==
X-Received: by 10.107.17.169 with SMTP id 41mr2811349ior.90.1418203102304;
        Wed, 10 Dec 2014 01:18:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a4ec:4fac:afb2:e506])
        by mx.google.com with ESMTPSA id j2sm2373440igj.14.2014.12.10.01.18.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Dec 2014 01:18:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141210084351.GA29776@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261199>

Jeff King wrote:
>> Jeff King wrote:

> We could probably do a better job of keeping our header files neat and
> well-ordered. And perhaps would so if they had a coherent narrative in
> the first place.

The example I was looking at before was refs.h.  It is still a mess.
Hopefully strbuf.h will work better.

[...]
> On Tue, Dec 09, 2014 at 02:23:37PM -0800, Jonathan Nieder wrote:

>> I suspect a simple tool to extract the comments and produce something
>> like the technical/api-* files would help, since then when someone
>> writes a patch, they could try the tool and see if the result is still
>> easy to read.
>
> That seems like wishful thinking to me. Some subset of developers will
> be happy reading the documentation in the header file, and will not
> commonly run the tool. Therefore they will also not bother to examine
> the output of the tool when making a change (either because they forget,
> or because it is simply a hassle that they do not care about).

That is okay as long as enough people extract documentation to ensure
the result is sane.

It is similar to what happens with Documentation/*.txt.  A subset of
developers just work with the source and make local changes without
looking at the big picture (and sometimes buggy markup or documentation
organized in a confusing way results).  But that doesn't change much.
When people forget to look at the manpage and write text that is
awkward in context or markup errors, one of a few things happens:

 * a reviewer notices.  The patch is fixed, and the patch author
   develops better habits for next time.

 * someone using the documentation notices later, and it gets fixed
   then, which is still fine.

Both outcomes are much, much better than documentation that never gets
organized.

[...]
>                               The api-* files have slowly grown out of
> date over the years, and I believe that is because they are too far
> removed from the code people are actually touching.

I don't think they ever were very comprehensive or up to date.

As far as I understand, the api-* files are intended to be usually out
of date.  Their main purpose is to explain the gist of how to use the
API.  They were usually written way after the API was introduced (so
they are behind already).  They are clearly written and as long as
they mostly match the code, that is enough for them to be useful and
educational.

Then every few years or so, someone updates the file with the latest
API changes, still with an eye to overall organization and readability
of the document.

In other words, they prioritize clarity over currency.

Of course if it's possible to have clear documentation that also
matches the current code, that would be even better.  I have hope that
moving the documentation to the header files will get us there if we
do it right.

> I did drop some asciidoc-specific formatting from the main text (e.g.,
> "+" lines for connecting blocks), which means that extracting the result
> and running it through asciidoc won't work.

This unfortunately lost some structure (e.g., which paragraphs were
part of the same bulleted list).  It would be more common to use a
hanging indent:

 - The `buf` member is never NULL, so ...
   string operations ...
   by `strbuf_init()` ...

   Do not assume anything about what `buf` really is ...
   ...

 - ...

[...]
>                                             I think it makes the actual
> text much more readable, though. But we could do it the other way if
> people really want to asciidoc it.

I also don't mind losing the asciidoc markup, especially given that it
would be a pain to reconstruct and render.

My reaction at first glance is that this is trying to do something
good but the current implementation is less readable than
Documentation/technical/api-strbuf.txt.  Am I looking at a work in
progress, or is this meant to be ready for application?  Which aspects
would you be interested in comments on?

Thanks,
Jonathan
