From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 6 Sep 2013 09:53:30 -0700
Message-ID: <20130906165330.GA6462@google.com>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
 <vpqioyfukkw.fsf@anie.imag.fr>
 <20130905232322.GB29351@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:53:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzHy-0002UX-CC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab3IFQxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:53:38 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61469 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab3IFQxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:53:37 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3460705pdj.40
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y8Oc4yjteYE7vIEaVM0XxVNiF+wOjRqKkqdSbEonAFE=;
        b=kotUeTw49VqmrdV0stR+jkUDOQl79maep4gstPOV0y75xMxeg3r/TA4Agq9lcwCeM7
         v6Sz8keiyu/khJsuI/6XcuykGDVgbBNMnOHef2akjpdivdkj3o6mB0iXtjjvE+1oJzjX
         bkUsNa8FBWCM1HkCFOgJhfuz+dMKAMVLuLo0t2neRVpzy+KiV7iU9/mGGxyFjwpRkWQg
         ZceAfffxk2ZopHRSmDkO9hdJvO8Oa7G+Nm12hWo77pL0vvDh4vbvOnQq11Aac7OodJkF
         ESNsdKDyZ+kLuEeOqxL2Zh5mteZmKq/8di8kTk7nvedCzCht76RHAKveby9uNVVdgYzb
         6+1Q==
X-Received: by 10.67.30.100 with SMTP id kd4mr5270588pad.24.1378486417506;
        Fri, 06 Sep 2013 09:53:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yg3sm5932535pab.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 09:53:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130905232322.GB29351@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234063>

Jeff King wrote:
> On Thu, Sep 05, 2013 at 09:36:47PM +0200, Matthieu Moy wrote:

>> I'm fine with any name actually (since it is enabled by default, people
>> don't need to know the name to benefit from the new output). Maybe
>> status.displayCommentPrefix was the best name after all.
>
> FWIW, I had the same thought as Junio. I much prefer something like
> status.displayCommentPrefix for clarity and future-proofing.

Sounds fine, but I don't understand why we'd want this to be an option
with a future in the first place.  Why not just fix the remaining bugs
before merging to master and make it unconditional?

[...]
> after:
>
>   On branch private
>   Your branch and 'origin/next' have diverged,
>   and have 472 and 59 different commits each, respectively.
>   Untracked files:
>           t/foo
>           test-obj-pool
>           test-string-pool
>           test-treap
>           test-url-normalize
>   nothing added to commit but untracked files present
>
> The blank before "Untracked files" was dropped (was this intentional? I
> didn't see any note of it in the discussion),

That's a bug.

>                                               and the bottom "nothing
> added" line butts against the untracked list more obviously, because
> they now all have the same comment indentation.
>
> I wonder if it would look a little nicer as:
>
>   On branch private
>   Your branch and 'origin/next' have diverged,
>   and have 472 and 59 different commits each, respectively.
>
>   Untracked files:
>           t/foo
>           test-obj-pool
>           test-string-pool
>           test-treap
>           test-url-normalize
>
>   nothing added to commit but untracked files present

The added blank line before "nothing added" sounds like a good idea.

Thanks,
Jonathan
