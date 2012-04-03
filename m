From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Updated tags on repo are not updated when pull
Date: Tue, 3 Apr 2012 12:44:54 -0700
Message-ID: <CAJsNXT=mQgt++g-Tz=kfDjC+PC7wJhc77f6zu7vg8GSnJfDq3w@mail.gmail.com>
References: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>
	<CAJsNXTk8R0yjad0T9605v-CMMdCA+C0v3Rqt65h_k6MK88UD9g@mail.gmail.com>
	<27353249354D994D8E42D75D75FBA6148965A9@OASBEVEXM01.oaifield.onasgn.com>
	<27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:45:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF9f2-0003nU-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 21:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2DCTo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 15:44:56 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34000 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab2DCToz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 15:44:55 -0400
Received: by wibhq7 with SMTP id hq7so68784wib.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4hWy2ghut7TfjWziVoOEZnirRCRSObVCinbX2Hafwzc=;
        b=VzOmTmPqL8OHUgcmPLOapnC8v6lh1P+7dj/vNVUI/PixMN6d9RLABm7kOaXhv7TgYY
         bMSZiMQGo4zT+p2oVrdl3aQHR6rbqkYTQa/d62lCn9aiXa/ouQAQ8q0Dpq6EySE1WhZA
         EYo/SmFCg5FDyAckVoRQT5GulknaIBsl6rS0S/L8QdXDLLROjSedPv5YexRhJeEhpXMG
         KNYLoLK4/fbht+AZNwCZq2I8kCJtH9QIFQCPvEjsTxq6gt63GN3vbYeZzraPjMlv8t3N
         Yr/1ZoCjCq5wS4lfhfx9WVC17SP8QYGlcUNvNxU5Mym56O8QdyWBNKubeTrrfHLVKeo2
         hs5g==
Received: by 10.180.95.74 with SMTP id di10mr11004484wib.1.1333482294365; Tue,
 03 Apr 2012 12:44:54 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Tue, 3 Apr 2012 12:44:54 -0700 (PDT)
In-Reply-To: <27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
X-Google-Sender-Auth: tP9V0eru5snA4zV74SjgnON94Vs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194640>

On Tue, Apr 3, 2012 at 5:00 AM, Sebastien Tardif
<sebastien_tardif@oxfordcorp.com> wrote:
> Like almost everything else, if a local repo is not updated, many things like HEAD and branch may not point to the latest thing.
>
> I agree that using branch is somehow a workaround, but it's still wrong that the tag is not updated by default when doing pull. Even if I find a long documentation about this behavior, it will still be wrong.

The documentation is at least an indication that it was a reasoned
decision on the part of the Git developers, so changing it would take
more of a discussion than "Please fix."

> Let just admit git is still new, this use case is not original at all, it just show some outstanding issue with Git.

Indeed, I see what you're trying to do with those tags, and I like it.
 There just needs to be a way to implement it while addressing the
concern about tags changing out from under people.  A branch is
*almost* what you want.  Basically it's a branch that no one updates
except the build server under specific circumstances.  You could
enforce that with hooks, but I think the biggest problem is the word
"branch".  People (and UIs) have ideas of what a branch is and what
it's used for, which don't *quite* match the intended use.

I wonder if the Git developers have any ideas on the best way to
maintain a pointer to the latest successful automated build, and other
such things?

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
