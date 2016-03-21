From: Stefan Beller <sbeller@google.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 14:50:13 -0700
Message-ID: <CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	<20160321205043.GA436@sigill.intra.peff.net>
	<CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7iQ-00061U-5V
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbcCUVuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:50:15 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37848 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbcCUVuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:50:14 -0400
Received: by mail-ig0-f174.google.com with SMTP id kc10so77906996igb.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0sjkjAgUn3tz3MqnhqUYb/DGyIPwEXyLoEPLZFw3pho=;
        b=UCaUzoV6zPG5jFVy6Q5f/8pOxCHsf3B6dPejNyBkjwFgTUqUwcnTGfxpF7H5aktOxL
         8f1PhNYLU0ogQrmrq4PHsjWrMp/rWt+Wkqv61yqUsOvIS/FPeMeWITl+1cRf48hCudn0
         rgftFc2m/GgLUG4dtsJXAxbG1Sz+CrVppbk2gR55bfqHFioKFa4HjK0JH+I3GGSk+a10
         S7sQnqm5APHJEFgrHHaZs6FE2NKbLRMi1zrJ3DSgkg9D5HqffR/60qmgm6VKOKjtfPuP
         lMA/EUmkMzbnr4T0cVFPvtolj+SDj4Ubt3f/88KPPV+3r+vl2HaFT3JsTRqa1vsWeObE
         og8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0sjkjAgUn3tz3MqnhqUYb/DGyIPwEXyLoEPLZFw3pho=;
        b=jF7H4LHsmYmQE8IVLan4pXg+ZRFmWmUyP90mltGZmBGOIGqJl/BPHIj1sdWHw6TkzO
         JcZS37B9Si4U4jadbR8wmUhOp3YwaoL/Ofwk8oxaHY7lkp0//GjZWVNRXlVeyG7070to
         k0Z/uWzcBnouGinMOWz7gYEMJDXqPuVNDnlxHx+uzA8fPLgwjshtKsJb13O4ocYthQE8
         jzjY+dO0ofA/SV3sHUIyvwJ3iI55bOmFs5tkw5hB4bEVlvuy0WAyQkZAtXMCYg9+NHkb
         Cw0LC0mKAVvDNxTUVNr8BZGfYAKLgRVM54Qqut2vd07hfT9+ayAWuAnAu9rZxYHxZxIi
         gLyg==
X-Gm-Message-State: AD7BkJK655zQbDbEkczEPfTDepY0IRNU1rjGJbQUXd4afeQVqBaljj19GO/Be45zizAeP8DjrAvUgJoxAgUJOB/W
X-Received: by 10.50.43.226 with SMTP id z2mr15689013igl.94.1458597013377;
 Mon, 21 Mar 2016 14:50:13 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 14:50:13 -0700 (PDT)
In-Reply-To: <CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289467>

On Mon, Mar 21, 2016 at 2:12 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:
> On 21 March 2016 at 20:50, Jeff King <peff@peff.net> wrote:
>> But that's just my opinion. Did you have some specific change you're
>> interested in? I don't think removing that message is productive; it
>> _is_ useful information. Perhaps it could be more clear that we are
>> talking about the tracking branch?
>
> I don't have a specific change in mind per-se, rather than to discuss
> how we might be able to improve the error message, or document
> somewhere that it's referring to the tracking branch.  Maybe that's
> the point--is it worth mentioning the time/date of when the cache was
> last updated?  That is:
>
> "branch-X is uptodate with origin/branch-X (as of DD-MM-YY HH:MM:SS)"

Actually I like that feature of recording the last known time we fetched,
I would have found that information useful in the past a few times. (unrelated
to this exact message, but if we were to make this change, we would
need to record
the time somewhere, and that's what I would have wanted)

I would think putting the date in this exact spot is a similar level of advice
what Eric was proposing earlier today in $gmane/289438
(was: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1},
give advice when force deleting a branch on how to recover that branch)
So people (specially beginners as this points out more of the inner workings)
may find it useful, but some would find it too noisy and rather turn it off.

Stefan

>
> No one's suggesting that this message is removed, I'm not sure where
> you got that from?
>
> -- Thomas Adam
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
