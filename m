From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 18:51:44 +0100
Message-ID: <CAMuHMdXaf_wfmwpQ4O5v+n8vd4uwddDANyZna4ufK10JxZhSvA@mail.gmail.com>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
	<alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
	<20130312041641.GE18595@thunk.org>
	<CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 18:52:25 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFTN9-00072f-Um
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 18:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938Ab3CLRvq (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 13:51:46 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41043 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab3CLRvp (ORCPT
	<rfc822;linux-next@vger.kernel.org>); Tue, 12 Mar 2013 13:51:45 -0400
Received: by mail-ie0-f169.google.com with SMTP id 13so171427iea.28
        for <multiple recipients>; Tue, 12 Mar 2013 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Skl6CM6fItltpqMOTpdFTALWj1aTmGJTixLOeJKe8bA=;
        b=xJL4mDulw0GKCpmJ4i+d59lgp7FCc5sfhWb/3HtadR23HwmunUMKINvZl5yMW/MY4P
         1QmaqEP+g11PF1reYI7HSn+IjlBSx4Ma9Xa0bnk1fFBHVCWY26RyC1wQu2VWaHTKmZos
         mj1e455frDhv7xjDOqbfDdKC05yhDubHHGHnM9UsBNZvDUv4ovSQfB4tTY9qX7/zqaon
         lYphLwzrRmjuyn0P7Flsu8N7XwqByxr7v7rZUboWtzPIk9yusmD4+ybPmvFicT4PYltg
         2oz1RV78flm+7LRHA4K/1S1HYiyb4WdWPPt3NT4bZw6dZp6cNVSQId4JXu5kmMz2/DSf
         mN9g==
X-Received: by 10.50.191.164 with SMTP id gz4mr12883843igc.2.1363110704936;
 Tue, 12 Mar 2013 10:51:44 -0700 (PDT)
Received: by 10.64.82.137 with HTTP; Tue, 12 Mar 2013 10:51:44 -0700 (PDT)
In-Reply-To: <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
X-Google-Sender-Auth: RRPze5wdhlAF2RStTnStK3nZwkg
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217978>

On Tue, Mar 12, 2013 at 6:13 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>> Why not just force the head of the security tree to be v3.9-rc2?  Then
>> you don't end up creating a completely unnecessary merge commit, and
>> users who were at the previous head of the security tree will
>> experience a fast forward when they pull your new head.
>
> So I think that may *technically* be the right solution, but it's a
> rather annoying UI issue, partly because you can't just do it in a
> single operation (you can't do a pull of the tag to both fetch and
> fast-forward it), but partly because "git reset --hard" is also an
> operation that can lose history, so it's something that people should
> be nervous about, and shouldn't use as some kind of standard "let's
> just fast-forward to Linus' tree" thing.

In many cases, "git rebase x" does the exact same thing as
"git reset --hard x", with an added safeguard: if you forgot to upstream
something, it'll boil up on top of "x".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
