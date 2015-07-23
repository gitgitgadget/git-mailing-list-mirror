From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Thu, 23 Jul 2015 15:46:33 -0700
Message-ID: <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 00:46:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIPGC-00066t-2c
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 00:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbbGWWqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 18:46:36 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36514 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbbGWWqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 18:46:35 -0400
Received: by pachj5 with SMTP id hj5so3159217pac.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qY6g9/L4Mq4U1K4z0R3Mk0Z9292jqEu+BGN05ir7/Ik=;
        b=slHqIlYJYoCkZjNsmr1VkYviuLmCVVARHo/d0Ip/0vJBPF16pB5Nu3KxGPXeVx7FHF
         neonCC2rk5aBUu9hDBG4tDsKrwQB7UvEqyMEnhth0gFRG7WOzTitmeIrVxr9I9f0xbmU
         DepMUG41j0NYvQEo5UmN/oEq/qG3xmtXcAyS8LbpTRGovT3i4QQnZdIXiUcXjzp1C6jf
         5QTsq6srR84Xpz3IUuE3ZiRBFVbq2WNZHef0hkVf6l6cKkpPCoh0H6XbtRZKWQkmmWhT
         1PI51YfRZY9qUtGmoNnX5YeM8Kt41Gv6RCcdkDjbCD01CNdWxaDAvfNR5QrTHDxBJuw8
         fQwA==
X-Received: by 10.66.249.101 with SMTP id yt5mr23409834pac.116.1437691594764;
        Thu, 23 Jul 2015 15:46:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id r6sm10821443pdn.24.2015.07.23.15.46.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 15:46:33 -0700 (PDT)
In-Reply-To: <20150723012343.GA21000@peff.net> (Jeff King's message of "Wed,
	22 Jul 2015 18:23:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274531>

Jeff King <peff@peff.net> writes:

> But other projects prefer to keep the messy history intact.
> For one thing, it makes collaboration on a topic easier, as
> developers can simply pull from each other during the messy
> development. And two, that history may later be useful when
> tracking down a bug, because it gives more insight into the
> actual thought process of the developer.
>
> But in this latter case you want _two_ views of history. You
> may want to see the "simple" version in which a series of
> fully-formed topics hit the branch (and you would like to
> see the diff of their final form). Or you may want to see
> the messy details, because you are digging into a bug
> related to the topic.

While I can see the reasoning behind the above [*1*], I am not sure
if the output with "--first-parent" would always be a good match for
the "simple" version.  Wouldn't the people who keep these messy
histories also those who merge project trunk into a random topic and
push the result back as the updated project trunk?  Admittedly, that
merely is saying that "--first-parent" is not a solution to such a
project, and does not say much about the usefulness of the new
configuration, so I'd queue it as-is.

[Footnote]

*1* I do not necessarily agree, though.  The history being messy is
    a sign that "the actual thought process of the developer" was
    not clearly expressed in the work, and it is not likely that you
    have more insight by looking at it---you will see more mess, for
    certain, though.
