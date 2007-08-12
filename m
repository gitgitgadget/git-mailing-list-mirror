From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Mon, 13 Aug 2007 00:54:33 +0200
Message-ID: <85ir7k5pp2.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<85abswo9gf.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
	<85wsw0mt77.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org>
	<69b0c0350708121358w13d04047s1916d3599c2e040a@mail.gmail.com>
	<85y7gg5tc3.fsf@lola.goethe.zz>
	<46a038f90708121517s3ce137e6x898e3f7a59d55a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Govind Salinas" <govindsalinas@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 00:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKMKW-0000z5-Nz
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 00:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933448AbXHLWyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbXHLWyg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 18:54:36 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:38200 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932730AbXHLWyf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 18:54:35 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 043344CD35;
	Mon, 13 Aug 2007 00:54:34 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id E55A42D3788;
	Mon, 13 Aug 2007 00:54:33 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id C78721D7141;
	Mon, 13 Aug 2007 00:54:33 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 663A01C3C79D; Mon, 13 Aug 2007 00:54:33 +0200 (CEST)
In-Reply-To: <46a038f90708121517s3ce137e6x898e3f7a59d55a2f@mail.gmail.com> (Martin Langhoff's message of "Mon\, 13 Aug 2007 10\:17\:20 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55733>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 8/13/07, David Kastrup <dak@gnu.org> wrote:
>> Well, what I have in mind boils down to something I can use without
>> leaving my editor... (...) and I naturally use Emacs.
>
> heh! As an emacs user, I have to say this might just be a tad too
> much :-)
>
> The main fix for your immediate woes of having gitk work fast is -
> imho - to limit it by time, which I do all the time.
>
> And on that track I'd *love* it if gitk could work as follows:
> start-up as if I had said --since=10.days.ago (unless I pass an
> explicit --since) and put a "get more history" button at the bottom
> of the commit list. And make the default --since settable via git
> config as gitk.since or somesuch.
>
> That'd make newcomers to git go -- WOW -- on gitk, and save old
> hands some typing ;-)

Sigh.  Why does one have to limit _anything_?  gitk can just keep
asking git-rev-list -20 --stdin enough questions to fill the screen.
It can get more history if it _needs_ it.

tig actually sucks up the whole of Emacs history (100000 commits per
branch) as fast as git-rev-list can produce it.  Without locking or
swapping.

> On the gnus backend - I don't think the nntp backend is good enough,
> as it can't deal with merges. But if you can write up a new backend
> that can read merges, you'll be golden. You'll definitely want to
> limit the number of commits you read initially, too.
>
> Now - both your emacs-gnus-git backend and gitk/qgit would benefit
> from having a long-lived git process that you can talk to via a
> socket for the stuff that you are bound to be asking a lot of
> (cat-file, diff, etc). Something like git-fastimport but for common
> queries.

Can be pipes.  Pretty common way of talking to utilities from within
Emacs.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
