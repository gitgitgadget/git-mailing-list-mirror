From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Thu, 1 Dec 2011 16:23:57 -0500
Message-ID: <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 22:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWE7F-0003pN-5z
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 22:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab1LAVYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 16:24:20 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51816 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1LAVYT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 16:24:19 -0500
Received: by eeaq14 with SMTP id q14so828945eea.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0y2ZFhFrsdF1jBi4itsE8NtaBYNl2tD0ZR/knP6SGjI=;
        b=PbdwQ++vJCHttlvPLszH3dzbtd2xVFXfRwZi08hJJUwZh9SNMY19tJpJRuInzA65d6
         8ai1zzWbFpztczHQSC92771L2mL77tmzSarF+BZ0JONQckaaDC3mb9mlNExddE0qo2ih
         ueafHyt3rYWi0i7kM6a/dLubkotEHwo7ZbiUA=
Received: by 10.180.102.162 with SMTP id fp2mr985880wib.50.1322774658604; Thu,
 01 Dec 2011 13:24:18 -0800 (PST)
Received: by 10.216.61.142 with HTTP; Thu, 1 Dec 2011 13:23:57 -0800 (PST)
In-Reply-To: <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186194>

On Wed, Nov 23, 2011 at 6:00 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> In any case, I think your proposal makes it even worse than the current
>> state, and you should aim higher.
>
> Why worse? I'd understand if you said it's doesn't improve it enough
> for it to be worth the change tho.

I think that's what "you should aim higher" means.

> Anyway, my proposal was to get a discussion going, and I'm all for
> aiming higher if there's a way. What do you propose instead? You
> seemed to imply we'd remove --soft and --merge, and make --keep as an
> option for --hard but named differently, something like
> --keep-changes. Maybe I didn't fully understand.

I think there are too many scripts dependent on these switches to
remove them.  But I love the direction you're going in.

Aim higher.

> Mathieu even suggested that it'd have the behavior of --keep by
> default, and that you have to add --force to get today's --hard
> behavior, which sounds like a good idea to me (avoid destructive
> behavior by default).

Think outside the "reset" command.  Like this:

>From the "most popular" comment on http://progit.org/2011/07/11/reset.html:
> I remember them as:
> --soft      -> git uncommit
> --mixed  -> git unadd
> --hard     -> git undo

I don't particular like these names, but conceptually they are helpful.

What other commands can we embellish or create to replace the overload
git-reset functionality?

How about:
  --soft: git checkout -B <commit>
  --mixed: git reset -- <paths>
  --hard:  git checkout --clean

Phil
