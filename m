From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] tag: support --sort=version
Date: Sat, 22 Feb 2014 16:07:49 +0700
Message-ID: <CACsJy8B5UL+nsDxMCUj5+Cp7-me_R2T1etMTh+_JpW8Fqkt9DQ@mail.gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <20140219140909.GA20128@sigill.intra.peff.net> <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
 <20140220204345.GA3374@sigill.intra.peff.net> <CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
 <20140222075935.GA1576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 22 10:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8aE-0003vA-94
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbaBVJIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:08:43 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61786 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaBVJIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:08:20 -0500
Received: by mail-qc0-f172.google.com with SMTP id w7so4964172qcr.17
        for <git@vger.kernel.org>; Sat, 22 Feb 2014 01:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=70p3b5X6GSNb8EiTf2vcZrBU+hq8tbVUt9hioWK4xE4=;
        b=V1SyPR7/tYb4QwwkWEfYLm5MtS2Sd/GUGaKEv6NjDmB5wXPm/DSEPeQmNDkzCYH7VK
         8diuf4azTPbMI6mqoPRb1fm7WpZQ2OjHQFIJVg6I478uY2lTHzJgtZAAMYVY9Ix8vF96
         Zdzp67aaNoT8IGFqPqCxfEDkiOgPNjn2pN/p0UjzGLJq9pJbcT47dU4O67ZYFNxSx+j8
         Ec97rZQHnu6pE3hvBDE2Z8bQOv6e0FuEeTfigehMBctaLErDS6elJ6l7S6/GRWW65jFB
         9Wcp0KXr9gRKu+YhmtzUi3oqOE+oYouwCPgxu282mDW+t38k4/z3W93tGLfLthYu/nDo
         XvpQ==
X-Received: by 10.229.118.4 with SMTP id t4mr16144929qcq.9.1393060099627; Sat,
 22 Feb 2014 01:08:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 22 Feb 2014 01:07:49 -0800 (PST)
In-Reply-To: <20140222075935.GA1576@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242512>

On Sat, Feb 22, 2014 at 2:59 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 21, 2014 at 06:58:16PM +0700, Duy Nguyen wrote:
>
>> >   --sort=[-][comparison:]field
>> [...]
>> Why not reversed order? So its syntax could be
>>
>> [ "-" ] FIELD [ ":" [ "version" | "v" ] ]
>>
>> It fits better to current f-e-r syntax where modifiers are after the
>> colon. And it avoids the possibility that someone adds field "version"
>> and we can't tell what "version" is what.
>
> I find my version a bit more obvious, for two reasons:
>
>   1. "version" here is not a modifier of the field name, it is a
>      modifier of the sort. You cannot use it in non-sort contexts (like
>      --format), and you cannot order it like other modifiers (you cannot
>      say "refname:version:short", only "refname:short:version").

Or you can read it like "type cast this field as a version", where
sorting is affected but formatting, not so much. So you can specify it
with --format (but it's no-op, unless we find a fancy way to color
versions). I don't see a problem with accepting both
refname:version:short and refname:short:version in future for-each-ref
either. It will be the first time we accept multiple modifiers though.

>   2. There are actually two sort-modifiers: "-" for ordering, and then a
>      comparator. In your proposal, they are split, whereas in mine, they
>      are next to each other.
-- 
Duy
