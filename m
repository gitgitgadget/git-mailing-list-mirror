From: Gary Fixler <gfixler@gmail.com>
Subject: Re: `git log --graph` with multiple roots is confusing
Date: Mon, 30 Jun 2014 03:04:19 -0700
Message-ID: <CALygMcDr2N2oyLOkVzE3XqAXu8DMSe_LhHXdL0QwN8W3JaV9zg@mail.gmail.com>
References: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
	<20140630080829.GB13153@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 30 12:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1YRk-0006S8-R7
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 12:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbaF3KEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 06:04:21 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44082 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaF3KEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 06:04:20 -0400
Received: by mail-wg0-f47.google.com with SMTP id k14so7816689wgh.18
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VfbAGX77tUsGQ/1GGpaopAPz2vjKtiIfaBDjTwtL4tw=;
        b=wRlGox7fukUJl9Wwp3+yY2QIni8w8mrD1X0/OeMsKBz8lqAayel5b9CD9ZQha2fzxQ
         AxN/m1ctLW8fQlCZrMJXlfPL1f/XSQJIqji1kNsHlTBxXMrSYH20h9ASHvnmooF9jJbE
         xiRmQ0ww6OTgeoTYcFtuunaS1lVMmaFBXhaNAWMtNfiCIqDr2TyA6kIdypI/sQFaBddJ
         jTZkTh/vNjwt2lF0q2kt+rzB9+TX9yRwf7DDnFq1WKAXxAUV4Oq6p5hQA+zHLrLJNvKj
         BBgA7pKwjJOcvgP2H5GCaf0bq8/vyeWPaLbYydv4BRRcqdE4VZK5d9QTJnQxw1heBFQm
         jSLQ==
X-Received: by 10.194.171.68 with SMTP id as4mr27680129wjc.80.1404122659117;
 Mon, 30 Jun 2014 03:04:19 -0700 (PDT)
Received: by 10.194.108.5 with HTTP; Mon, 30 Jun 2014 03:04:19 -0700 (PDT)
In-Reply-To: <20140630080829.GB13153@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252661>

I just made a new test repo, added and fetched two unrelated repos,
and then did the log view (all/graph/decorate/oneline), and tacked on
--boundary, but saw no change. The root commits looked the same.

-g


On Mon, Jun 30, 2014 at 1:08 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jun 29, 2014 at 11:40:40PM -0700, Gary Fixler wrote:
>> I sometimes pull things in from unrelated repositories to rebase or
>> cherry-pick items from a different line of development. I've done this
>> to bring isolated features into a project in their own feature
>> branches with their full development histories, and also to extract
>> lines of development out to their own project, with their histories
>> intact. These are usually not connected commits, but things I have to
>> track down across time with `git log -S` and friends.
>>
>> When I `git remote add otherrepo <url>`, then view things with my
>> aliased `git log --oneline --all --graph --decorate` alias, I'm
>> usually immediately straining to figure out what's what, as the two
>> trees stack onto each other with no separation. It would be nice if
>> root commits used something other than *, and/or if they could be
>> colored differently by default, or via some option to make them stand
>> out as parent-less commits.
>>
>> Is this feasible, or already possible?
>
> Have you tried `git log --boundary`?
