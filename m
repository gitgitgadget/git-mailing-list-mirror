From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 15:39:21 -0400
Message-ID: <fcaeb9bf0707261239t6479a4f4j6dedfbaef7206535@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	 <Pine.LNX.4.64.0707261534550.14781@racer.site>
	 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	 <Pine.LNX.4.64.0707261638100.14781@racer.site>
	 <fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
	 <8564478243.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9BG-0003cE-Rg
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764506AbXGZTjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764085AbXGZTjX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 15:39:23 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:36288 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763972AbXGZTjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 15:39:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so124806and
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 12:39:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rb65isq79SNu1IMicfato3EYElYHPe/x0u6C/K82hA1S0H8rcMoCSWkvDatsiLOeMblW7Yd8quM6ra3aAuostPBdqNDJ260fGO1XZsYfIt3z03tYisiWv8Ss9A8BB3SsySYCS/xI8Kf26RF4pPfL5cj93pP+TUiDj2ZmGBZpIuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kVNCm5mTm+6DFSnTqaBcUZkvypw9INB///hbwtMJkE4b3VMsSCrRApW7RPo6xN1LrAdYfzmQQtjbGconW8hgN0/Ux1qUALRIs8LQuo6MA601ecblNNggXLHYVX37prB91+tQ4EYpv5OZGKbwcLmamv1YgghZzlzai4FlQsKVjXw=
Received: by 10.100.33.14 with SMTP id g14mr1919995ang.1185478761984;
        Thu, 26 Jul 2007 12:39:21 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 12:39:21 -0700 (PDT)
In-Reply-To: <8564478243.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53861>

On 7/26/07, David Kastrup <dak@gnu.org> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> Hi,
> >>
> >> On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:
> >>
> >> > I make MinGW busybox part of git for some reasons:
> >> >
> >> > - Making a full MinGW busybox would take lots of time. I don't need
> >> > busybox for Windows. What I need is a shell and enough POSIX utilities
> >> > to run git shell scripts without any dependencies. Windows users
> >> > (including myself when I have to use Windows) hate dependencies.
> >>
> >> I think that if you succeed to compile ash on MinGW, the rest is easy.
> >
> > No it's not. With a couple of ifdefs you can compile it fine. Then
> > there goes fork(), fcntl(F_DUPFD), /dev/*, job/signal handling...
> > Fortunately Git does not use lots of features. It only needs
> > /dev/null (and /dev/zero for tests), SIGEXIT and no job usage.. That
> > cuts down the effort porting ash.
>
> And here I was tempted to multithread builtin-update-index.c: it is
> actually quite natural to let one process scan directories
> non-recursively, stat the files, sort them on a per-directory grain
> and feed a sorted pseudo-index into a pipeline (recursing to scanning
> whenever hitting a directory), then let another process/thread do a
> merge-pass of pseudo-index and real index, immediately writing the
> output to a new index-to-be.  When this is finished and another
> process invalidated the old index already, reuse the index-to-be as
> pseudo-index and merge it with the new-index-which-got-in-ahead-of-me.
>
(snip)

If you are going to do it. I suggest to base on official mingw branch.
I haven't looked at builtin-update-index.c (hey, I'm all doing sh
scripts these days) so no comments here.

-- 
Duy
