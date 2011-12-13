From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 18:12:11 -0600
Message-ID: <CA+sFfMfH33hoRxdB01a6h=msVVjf3MwZXd7SFE6UVoVbxJVBoA@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box>
	<7vr51htbsy.fsf@alter.siamese.dyndns.org>
	<20111129220854.GB2812@sandbox-rc.fritz.box>
	<loom.20111210T062013-538@post.gmane.org>
	<7vborhaqgw.fsf@alter.siamese.dyndns.org>
	<CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 01:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFyi-0007y9-S2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab1LMAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:12:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38240 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab1LMAML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:12:11 -0500
Received: by ggdk6 with SMTP id k6so1770102ggd.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 16:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e00F2hOXOaBJ73T6hra7xE2ohySG6vgotFzfE+Az3b4=;
        b=IghmVVBVp9MkU093tUDNF2YynyUOojAJkuiJMai5rEPsbQhKqr8NDHvt8zGNmnfp5y
         E8m2mvG/goUt8BLsS6F15FaEo8mRzItH+dV/iGVqq3UcsyEJbodaj/wfqVLqWE9e+bTb
         aRpxyUxK+somBt6C9ps/CGyylbJ5GQ182YZHw=
Received: by 10.182.15.104 with SMTP id w8mr1448156obc.20.1323735131156; Mon,
 12 Dec 2011 16:12:11 -0800 (PST)
Received: by 10.182.77.230 with HTTP; Mon, 12 Dec 2011 16:12:11 -0800 (PST)
In-Reply-To: <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186979>

On Sat, Dec 10, 2011 at 9:27 AM, Leif Gruenwoldt <leifer@gmail.com> wrote:
> On Sat, Dec 10, 2011 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> So that use case does not sound like a good rationale to require addition
>> of floating submodules.
>
> Ok I will try another scenario :)
>
> Imagine again products A, B and C and a common library. The products are in
> a stable state of development and track a stable branch of the common lib.
> Then imagine an important security fix gets made to the common library. On
> the next pull of products A, B, and C they get this fix for free
> because they were
> floating. They didn't need to communicate with the maintainer of the common
> repo to know this. In fact they don't really care. They just want the
> latest stable
> code for that release branch.
>
> This is how package management on many linux systems works. Dependencies
> get updated and all products reap the benefit (or catastrophe) automatically.

What happens if the update to the floating submodule introduces a bug
that prevents A, B, and/or C from building/running correctly?  If the
submodule states are not recorded, how would the previously working
submodule version be restored so that development on A, B, and C,
could proceed?  I guess each developer could manually checkout @{1} in
the submodule in their working directory, though that wouldn't work
for a new clone, and it's not very elegant.

I presume that if A, B, and C, do not care to know exactly what was
fixed in the common library, they probably do not care to investigate
the breakage in that repo either.  Or, they may not have the
expertise.

-Brandon
