From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: What about SHA-1 collisions?
Date: Thu, 8 Nov 2012 10:44:43 +1100
Message-ID: <CAH5451mwShC3QmX-5NxUO-00gx6uxNVKUHw4zrb=pyduHBJXLQ@mail.gmail.com>
References: <20121106202643.GF28437@raven.wolf.lan> <loom.20121106T223000-502@post.gmane.org>
 <20121106220938.GH28437@raven.wolf.lan> <CAJo=hJtF2+Z1BDQnysB7hk2MM336iEUMHd3zSLCm14yvw1_-wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josef Wolf <jw@raven.inka.de>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:45:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWFJA-0008NT-NW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 00:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab2KGXpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 18:45:06 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:65264 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2KGXpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 18:45:05 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so915976qat.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vINyIIyB4QQXElogwjPyvT9VzbbB3ESy2d7C+G8Bqs4=;
        b=zQk5OILJ7LH22alNzqG5TI/C7JqpBOiFkWtPO1xL1LzQV2sFdaorF/5z1SQ6kqEGr+
         LIzxkngRGr5KKYwJQp6IEKVLAVfCXraRl+ngM+FI2ziJhRgEa++zZXUWzWPQ/5K9O3Lm
         PWdHeij5cRvE4yFw1Y23fOVwpwO4iQedgBgZbVUyyFnq9B1AWY2nctLLpQNCPsfG9JHs
         4Vbwv8LnBmlzPf1Zil6v93AqqjNTqGv8k5jfY1AmT6iyVFfIXvkAzlUt3iC4X5VReCe7
         GRbdXN/3IEu/3CmED0no5rOwAsuKr3kkNb0E7b/GCZKqcfWHkIOz1SbNW4Q6uSZ97cgU
         npeg==
Received: by 10.49.48.111 with SMTP id k15mr10918547qen.28.1352331903504; Wed,
 07 Nov 2012 15:45:03 -0800 (PST)
Received: by 10.49.58.225 with HTTP; Wed, 7 Nov 2012 15:44:43 -0800 (PST)
In-Reply-To: <CAJo=hJtF2+Z1BDQnysB7hk2MM336iEUMHd3zSLCm14yvw1_-wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209146>

 A recent article [1] did an analysis on the number of items needed
from a given range to have a 50% chance of a collision. The famous
birthday paradox scenario was used, where you only need 23 people
before the chance of two of them having the same birthday is over 50%.
In this scenario there are ~366 options available to be picked from,
and 23 is significantly small in comparison.

The mathematics behind these statistics was extended to account for
any sized range (call it N) and it turns out that the number of items
(k) that can be picked before you have exceeded a given percentage
chance (T) of _not_ having a collision is roughly

k ~= sqrt(-2N.ln(T))

As pedrocr pointed out on Hacker News [2]

"Applying the formula for 160bit SHA-1 you need 1.7e23 objects to get
a 1% chance of collision. The current Linus kernel repository has 2.7
million objects. So to get a collision you'd need a repository that's
6e16 times larger. That should be plenty.

For some wacky perspective that's 10 million kernel sized
contributions for every man woman and child on earth together in a
single repository. It would seem git will reach plenty of other
bottlenecks before SHA-1 becomes a problem..."

An interesting analysis, even given that the OP presumes a collision
in their question.

Regards,

Andrew Ardill

[1] http://www.solipsys.co.uk/new/TheBirthdayParadox.html
[2] http://news.ycombinator.com/item?id=4753198
