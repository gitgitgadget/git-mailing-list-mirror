From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 2/4] revert: refactor code into a do_pick_commit() function
Date: Sun, 30 May 2010 22:29:46 +0200
Message-ID: <201005302229.46979.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org> <20100529044044.569.69037.chriscool@tuxfamily.org> <AANLkTik6SBEkOICHdMYprzGitfS2hezDXKQ8Q5R8cAYs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 22:30:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIp91-0005Mr-Tx
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0E3U35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 16:29:57 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40851 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab0E3U34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:29:56 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3C053818093;
	Sun, 30 May 2010 22:29:48 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTik6SBEkOICHdMYprzGitfS2hezDXKQ8Q5R8cAYs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148015>

Hi Ram,

On Sunday 30 May 2010 13:19:39 Ramkumar Ramachandra wrote:
> Hi Christian,
> 
> Excellent feature to work on- I've wanted to cherry pick a range several
>  times.

Thanks!

> Christian Couder wrote:
> > -static int revert_or_cherry_pick(int argc, const char **argv)
> > +static int do_pick_commit()
> >  {
> >        unsigned char head[20];
> >        struct commit *base, *next, *parent;
> 
> Is there a better way to do this instead of allocating memory for each
> commit? When you cherry pick a lot of commits, it might make sense to
> use a shared memory pool.

I think that most of the time I will cherry pick less than 20 commits so I 
think the memory usage is not so important. And in any case it could be 
improved later if there is a real need.

> > +       /* this is copied from the shell script, but it's never
> > triggered... */ +       if (action == REVERT && !no_replay)
> > +               die("revert is incompatible with replay");
> 
> If it's here for historical reasons, why don't you remove it now?

Right, I will have a look at removing that.

Thanks,
Christian.
