From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 14:23:18 -0500
Message-ID: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcgRu-0001wD-UY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbaDVTdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:33:42 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:41569 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaDVTdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:33:41 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so6209281oag.34
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=CWulE+EZ9Fe6n+wuHqbwZXUp8iob0hZyvLUsTmndawg=;
        b=pryMcc5P2Mv7h1lMTa9E9B0qkSQYN7UNqUUtqIATXJwWldujg1+XBQFdwmpQHjDYji
         yRJOoJ08r5TcFNnjKk+rC9UJY4l8KfsbgfDrUxaxS3pVa/X21w3HcflMV/051uBmo1OX
         gLVnbOIjgRzuSB5Lt7KbTVxb5tV8rtfbJ+afpzK8wFGbCi2X9D5FqUJz8qKBqh1F6Ivz
         jUX0Vjuf6wqUKGZ8UJg/raKCeMBU6SCyip3DkZiQZD8u5OOmakWF0Ko23LxnVTPAEgHB
         v8DoirQBueFr7TctpWnsYKZLxzKFmxaf2gpEmeMhUatAoBaFLzw4e34Lq3972wfK+WFF
         BQ0Q==
X-Received: by 10.60.155.72 with SMTP id vu8mr3446422oeb.60.1398195221152;
        Tue, 22 Apr 2014 12:33:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm181367794oek.12.2014.04.22.12.33.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 12:33:39 -0700 (PDT)
In-Reply-To: <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246774>

Junio C Hamano wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > On Mon, Apr 21, 2014 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >>> If we don't standardize this now people will come up with their own
> >>> definitions [1] [2] (and many others if you just search GitHub) which
> >>> are again likely to differ (slightly), hindering interoperability.
> >>
> >> I am afraid that that ship has sailed long time ago, though.
> >
> > That's most likely true, but it does not get better by postponing this
> > even more.
> 
> As I already said:
> 
>     I think it might be OK to implement them as the lowest priority
>     fallback alias, so that '[alias] co = "user's definition"'
>     anywhere in the various configuration locations will override
>     it.  I am a bit hesitant about adding start-up overhead, though.
>     Also I am not sure if people can agree with (1) a broadly wide
>     selection of aliases and (2) the actual definitions for them (I
>     am OK with "co === checkout" myself, but I'd rather not to even
>     think about my Git wasting cycles parsing extra configuration
>     items to support "br === branch" at all, for example).
> 
> I am not fundamentally opposed.  I just do not think it would add
> much value to new people at this point, and it will actively hurt
> if we shoved barely cooked one in 2.0.

You are probably biased in that you've used Git far much more than the average
user has (or future new users).

> So even if we agree that it would be a good idea to have some
> default fallback aliases, the set of such aliases we ship must be
> limited to a set that everybody can agree on, both in the sense that
> "adding alias XX is good" and also in the sense that "alias XX must
> be defined as YY".
> 
> As you allueded to, the Git userbase is a lot larger than it used to
> be back in 2006, one alias, e.g. "[alias] br = branch", that is
> reported as either useless or needed to be further tweaked by a
> person on this list would mean that we would be either spending
> unnecessary start-up cycles (for "useless" case) or adding cognitive
> load of having to differente between "branch" and "br" (for "needs
> further tweak" case) for thousands of users who would be better off
> if we didn't have that specific alias.

I think it's reasonable to follow these guidelines:

 1) Each default alias should have two characters
 2) Each default alias should map to a command without arguments
 3) Each default alias be widely used in the wild

This set matches the above:

  co = checkout
  ci = commit
  rb = rebase
  st = status
  br = branch
  dt = difftool
  mt = mergetool

You might not like 'br', but there's tons of people already using that alias,
so it's not "useless". I can go find links to many examples if you would like.

> So while I understand the desire to have a bit more handholding and
> am not fundamentally opposed to the desire, I am not optimistic that
> an attempt to implement these "aliases" would result in a very
> useful addition to the system, even if done after careful thought.

The fact that you are not optimistic about it doesn't mean it's impossible.

> In any case, this definitely is not a 2.0 material.  I agree that it
> would be good to start discussing it early (rather than later) if we
> ever want to do such a change.

Why is not material for v2.0? Because you say so? Are you going to wait another
ten years to introduce this to v3.0?

This is actually the perfect time to do it.

-- 
Felipe Contreras
