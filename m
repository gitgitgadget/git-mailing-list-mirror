From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 1/3] wt-status: Make conflict hint message more consistent
 with other hints
Date: Wed, 26 Feb 2014 18:07:45 -0500
Message-ID: <CADgNjan+2kS-L4KwS4-wBMHcuQdW4cuHTNj4TA3yqExtr=dCUQ@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com>
	<xmqqmwhd391s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 00:07:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WInZv-00016j-70
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 00:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaBZXHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 18:07:47 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:53683 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbaBZXHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 18:07:46 -0500
Received: by mail-we0-f173.google.com with SMTP id x48so2220000wes.18
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 15:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Q/ZqWJ6CxtCqDwfqGceG561TSKIjNxSAraQEX2Hu/UQ=;
        b=yHT5zqvojWUVg9ZxG9lB4SXVk6rVc1bFR9qdI0mnztuJcYHuzft88k+ZDJVggRVCHX
         s8Mo7NUSrGeOo2d5mv5UVP2QSkb6OjUYyXPRfTZz5zpots+qmQEliUKvJU7+fKLhcZ1y
         lt6OElLQdtOnFnMpo231G/hANyrDJWTcR6kwdthT9SvMyINTzIrBp9bwNMhg36QSZ+LT
         r81fbvAfR0ksOfUMbGSiq+rhg4S4A1T3iaXrjdZMFT4tC6Lv04U7VuA59iJSnHwzwtH0
         9NlNEaZqa8FFhsmP4xcfclQ9nf5qyauKlWc4r8Bx3t3iDgMLie84z65GbXhUxJWIYW3J
         /tuw==
X-Received: by 10.180.97.72 with SMTP id dy8mr9897413wib.5.1393456065524; Wed,
 26 Feb 2014 15:07:45 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 26 Feb 2014 15:07:45 -0800 (PST)
In-Reply-To: <xmqqmwhd391s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242770>

On Wed, Feb 26, 2014 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I see that you are trying to match the phrasing used in the other
> side of this if/else (which is outside the context of the posted
> patch).  Over there we say "... to conclude merge" while the new
> text says "... to conclude THE merge".  Don't we want to match them?

Ah, good catch. My mind just read it as "conclude THE merge", even
though the word wasn't there. Let's add the "the" in. :)

> For those who did not look beyond the context of the patch text, as
> I had to look these up to convince myself that the proposed change
> is a good one.  This function is only called when we see MERGE_HEAD,
> so "unmerged" here can come only from a failed merge, not other
> mergy operations like am, cherry-pick, revert, etc. and telling the
> user that 'commit' will conclude the merge will not be misleading
> (unless you count "'git commit' will conclude a conflicted 'git pull'"
> as misleading, and I of course do not).

I'll update the commit message to explain that I'm match the other
side of the if/else.
