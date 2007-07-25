From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE]: PyGit and libgit-thin
Date: Wed, 25 Jul 2007 21:57:59 +0200
Message-ID: <85odi08ddk.fsf@lola.goethe.zz>
References: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com>
	<20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDmzs-0005fl-Gx
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 21:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXGYT6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXGYT6I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 15:58:08 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47294 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722AbXGYT6F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 15:58:05 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 6351A31EA48;
	Wed, 25 Jul 2007 21:58:04 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 4F00C345C1B;
	Wed, 25 Jul 2007 21:58:04 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-004.pools.arcor-ip.net [84.61.0.4])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 201DD30A959;
	Wed, 25 Jul 2007 21:58:04 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DC1FE1C452FD; Wed, 25 Jul 2007 21:57:59 +0200 (CEST)
In-Reply-To: <20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net> (Yann Dirson's message of "Wed\, 25 Jul 2007 21\:50\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3763/Wed Jul 25 17:37:41 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53709>

Yann Dirson <ydirson@altern.org> writes:

> I had a quick look at the current pygit API (as described in the
> README), and I find the current revlist one somewhat confusing.  Why
> using post-contructor methods, and not using named args in the
> constructor itself ?
>
> That is, the example reading:
>
>>>> rv = repo.revlist()
>>>> rv.include('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9')
>>>> rv.count = 10
>>>> rv.show_merges()
>>>> for commit in rv:
> ...  print commit.id()
> ... 
>
>
> would be IMHO much nicer to use as:
>
>>>> rv = repo.revlist(include=('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9'),
> ...                   count = 10,
> ...                   show_merges = true)
> ...
>>>> for commit in rv:
> ...  print commit.id()
> ... 
>
>
> What do you think ?

Nicer to use if the commands and their options originate from withing
Python.  But if Python parses arguments from somewhere else and passes
them on, the former interface leads to much cleaner code AFAICS.
Pasting together a named argument call piecemeal is not going to be
pretty, I should think.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
