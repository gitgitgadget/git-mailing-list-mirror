From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Cloning tags from master
Date: Mon, 15 Oct 2012 20:08:13 -0700
Message-ID: <CAJsNXT=JHds1fxDVYECXhVaRgkgFg6-amGBRy6HQDgxOiUOkkg@mail.gmail.com>
References: <1350330293914-7569301.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: dquince <devin.quince@troppussoftware.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 05:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNxW7-0002Vv-Fv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 05:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab2JPDIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 23:08:16 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55977 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab2JPDIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 23:08:15 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3908875lbo.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=dTipKOLwjP5n1MCt+uH9C5AZRlgIOIXW1yCqpm+vpjk=;
        b=Tkfe4Vf5SNNG32w3oUpxzXqzed98Hmp1k2woQ6hRSxs6Pel8Ya8TxmQ5nRhBtIe8t3
         OF6ybt/nQM2vKmA9qCKLZcNxlxWX06D4Mr9MwAhCL3hqu9Q98+QPwLSQN9G760kLB3BH
         LGo/nbCR4/Jf9aRpRHRbEllN2oG09kstvEwO2QySD1WFvuIC6cmxKmIFv8+LZRo9ntj6
         nan0DGGtU1TS4havP3LK/rNmauzsf6ieIn8XecEeEdmu1YL3UqIV6rLxw0JJsEXGajK2
         iNBAFwvgQJkOwKm3fCCMXE8vn02NMCUNRXIEZmYphO7/WsXLfKH9Wv0VUb6brFg+T79N
         5/fg==
Received: by 10.152.47.97 with SMTP id c1mr11353485lan.37.1350356893830; Mon,
 15 Oct 2012 20:08:13 -0700 (PDT)
Received: by 10.112.6.197 with HTTP; Mon, 15 Oct 2012 20:08:13 -0700 (PDT)
In-Reply-To: <1350330293914-7569301.post@n2.nabble.com>
X-Google-Sender-Auth: yWvgS4JaCWOp1ruRHUGnK_W2Bto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207798>

On Mon, Oct 15, 2012 at 12:44 PM, dquince
<devin.quince@troppussoftware.com> wrote:
> I am trying to implement using tags in our build process, but am running into
> an issue with pulling tags from master. My scenario is as follows
> We decide on a release and I tag master with testtag which has commit
> testtag-1-gf3b117e
> When I make another commit to master and check the tag, I see it as
> testtag-2-gfb56442

I don't know what you mean by "check the tag", but those look like the
output of "git describe" when HEAD is one or two commits ahead of
testtag (with no tags that are closer).

> When I try and pull the tag using testtag, it just wants to pull the latest
> commit to master.

You're probably not running "git pull origin refs/tags/testtag", but I
think that's the only way to "pull the tag," so I don't know what
you're doing here.  The tag doesn't include anything that's not part
of the tag's history, though, so "pulling" it won't get the latest
version of anything.

> I verified this works in branches other than master, so can this be done
> from master or does the tag just follow the head?

Tags never follow anything.  Once they're created, they stay put.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
