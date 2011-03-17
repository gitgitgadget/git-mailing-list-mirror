From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 20:53:04 +0100
Message-ID: <AANLkTinu3_ZEfkqyVziE2Z=t-R4j_6zRiddrkXOOvAwe@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
 <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
 <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
 <AANLkTi=Fnacc9JamGdOEYhHY8PJgaidSLmif_z5Qdfp0@mail.gmail.com> <20110317191517.GC20508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JGE-00078Z-9G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab1CQTx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:53:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52049 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1CQTxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:53:25 -0400
Received: by gxk21 with SMTP id 21so1272042gxk.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Esg6VbfUxQw+tRWQ+BeBHee0ZqzHX9NgOBcYRnFt6hM=;
        b=wdGv+I6Q5lj+m0m8DufDpAjYKKYS/322EwvpglWYeCcm6mjoWZbv6tukth8rjimgxc
         M/AwoObwzlViY0PCXC411ZF5c7MeNlYfg2ubeaVQjKxUYxu8fW7jDZgLZdBPA8Tza6VU
         L1Bb3AZZeOXZpOBKu9mDBeVqON087/+WHCxP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aHbmjG1FATnmrP2F57nnDzJzhPrEYGyeHfpx2gP66d55k2ugYaBRMdYBXN7hkZf0Hr
         /WuW9JUNgi+948yAqGLfb5jkW0xEEkFQ9W7Al/uu/eQ+To4zERYIyCTvn1Ti277qCZCC
         RaLoF5/a1ZE2I2gFT9Ribawh3ZAP12xMJtJyY=
Received: by 10.90.250.2 with SMTP id x2mr222162agh.202.1300391604135; Thu, 17
 Mar 2011 12:53:24 -0700 (PDT)
Received: by 10.90.223.11 with HTTP; Thu, 17 Mar 2011 12:53:04 -0700 (PDT)
In-Reply-To: <20110317191517.GC20508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169269>

On Thu, Mar 17, 2011 at 20:15, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 17, 2011 at 07:48:54PM +0100, Alex Riesen wrote:
>
>> How about not to record the merge as a merge commit, but
>> just resolve as much as possible, commit _only_ what was
>> resolved, and revert everything else. Including files merged
>> cleanly, as the last merge by maintainer will have to clean
>> merge them anyway. And of course, commit as normal:
>
> But that still has the same problem. You've reverted unresolved files
> back to the pre-merge state, which is the tip of one of the merged
> branches. How does the integrator differentiate that from the case that
> your resolution happened to take one side of a file?

Maybe they're lucky and it just never happens? But yes, of course...
