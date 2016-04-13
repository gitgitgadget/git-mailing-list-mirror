From: Stefan Beller <sbeller@google.com>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 15:52:53 -0700
Message-ID: <CAGZ79kYt8M1CP_3T+VYmz2EGPAyfxOx2zTEugLyHL+GsiZ9RSg@mail.gmail.com>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
	<xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
	<20160413224129.GC10011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTec-0003rL-TH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbcDMWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:52:55 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34782 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcDMWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:52:54 -0400
Received: by mail-io0-f182.google.com with SMTP id 2so87117596ioy.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Pzmc/3bwczkaYIFm/EXximHdndz/bWpFkuSCuTNBGzQ=;
        b=Zi+cNukPVRgEZvn4HXN/mTwfbhtS46Yrzi2vCI8Rjkm2JTdxeDR/qKu2ztq21bZGkI
         IWO8La+QYV0N3oCLMnH/hGbHkHRKQV/RAMy4jrPz7LgUAHjFCXxkVawndOZ0FCMNgcu3
         +NLO7tAeBrpISxHTRA4BOb7F5y3n9B4dOfQVjSZCsmbGEIDJnQnqWUGnQpbIHiB4AU89
         mkFrQzfq5cTGXUO7IL+UQHxXGWnZoB8N5bAqVYb898p5lVc1qpI4LtyCK+U3CM7G28w/
         M6uVHTgnCpmRdeeG6ZEGGsrUTbsninPR6oMg9CddnfAW66DP3Wa9QZrtSLqB0d3mQY9C
         IXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Pzmc/3bwczkaYIFm/EXximHdndz/bWpFkuSCuTNBGzQ=;
        b=SQdyjAwVSTU2GURN73+NYKJ4denGBorqqDgXcm55u6psjSth+suygIG9FND9isATR8
         wPmeHKiw9L/5ugBEiRTqkq9VYhV960HL9HW9I3dVt019F66+gtF5HZOoeVTK9eQgxuYT
         q49v0zlkmGkLdJB4BHGoVTAYVV20fDk58w/b+/q5g1rgJGwvFF9YS7nMF5J8Pb8KsaD0
         3oHiBtILxzI+yWw5b4QY68j6tv6bj4VG1XiR2vEeYuK6EKUCl0XaLL6j9ov0wzkH7pUr
         rY0ZPp6B5YOo7f/wrPTJTXN/NmDIexC3CIFpa7X1IfhrwKqtFFJulpX4vPIemu5KecG/
         VGew==
X-Gm-Message-State: AOPr4FX/1hHobTwi9znFoA5s9wQWjy5hkDxbw0dtdwRWBwWjDsRzRqEYekrmJ3VYp+fPxMXZMQZ0g8WYhCyi5oK0
X-Received: by 10.107.161.68 with SMTP id k65mr14581243ioe.110.1460587973278;
 Wed, 13 Apr 2016 15:52:53 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 15:52:53 -0700 (PDT)
In-Reply-To: <20160413224129.GC10011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291510>

On Wed, Apr 13, 2016 at 3:41 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 13, 2016 at 03:18:24PM -0700, Stefan Beller wrote:
>
>> * This is your preference for whole-tree operations. What are
>>    whole-tree operations? (Is there a concise definition?
>>    Are submodules whole tree operations?)
>>    These questions are motivated by origin/sb/submodule-path-misc-bugs
>>    which a) fixes bugs and b) makes submodule handling consistent to the
>>    relative-to-cwd philosophy. As most submodule commands touch all
>>    submodules in the tree, we could argue it is a whole-tree operation, and
>>    you'd like to see submodule paths from the root level, too.
>>
>> I'd like to avoid adding confusion here. So is there a an easy way to tell apart
>> which commands you would expect to use relative-to-cwd and which use
>> relative-to-root?
>
> I think some operations are fundamentally whole-tree. You do not merge a
> subtree, but create a new top-level commit. Similarly, even in:
>
>   cd Documentation
>   git log -p .
>
> the diffs we see still show the whole path. We are traversing the whole
> tree.

Oh I see.

    cd dir-with-submodules
    git submodule update .

would traverse only that dir-with-submodules/ subtree from the users
POV.

>
> If you are touching all submodules with an operation, I'd expect it to
> show full paths, not relative ones. But then I set status.relativePaths
> to "false", so maybe I am in the minority.

That would be `git submodule foreach`. Any other submodule subcommand
is similar to git log as they default to the whole tree but can do similar stuff
as "git log -- dir/" for sub trees.

Having subcommands behave differently w.r.t. path being relative or not
sounds like an inconsistency to me. Currently they are all relative,
i.e. `git submodule foreach` breaks your expectation for displaying paths.

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
