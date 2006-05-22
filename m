From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 00:54:15 +1200
Message-ID: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <446F95A2.6040909@gentoo.org>
	 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>
	 <446FA262.7080900@gentoo.org>
	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	 <44713BE4.9040505@gentoo.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 14:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi9vT-00065b-3Q
	for gcvg-git@gmane.org; Mon, 22 May 2006 14:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWEVMyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 08:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWEVMyQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 08:54:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:5271 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWEVMyQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 08:54:16 -0400
Received: by wr-out-0506.google.com with SMTP id 50so599716wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 05:54:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FjuQSWz3LpAX8K2ANVmF8d/FN1Un97xxbkmE/QETMWBZ3RW9ZvrHuAcQ9UwFsP8+2dLN6YozsOyRzH+hbCh1xxoEvcxBVFj4r7wdaX0TtN/XBYRIrEaluOOYHeQEHnko86aLyv1QjH+svdl5AMJ7v/Y8lpMe7wyin4i889gmcJQ=
Received: by 10.54.101.13 with SMTP id y13mr4787424wrb;
        Mon, 22 May 2006 05:54:15 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 05:54:15 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20502>

On 5/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 22 May 2006, Martin Langhoff wrote:
> >
> > Or a slow leak in Perl? The 5.8.8 release notes do talk about some
> > leaks being fixed, but this 5.8.8 isn't making a difference.
> >
> > Working on it.
>
> Thanks. Looking at what I did convert, that horrid gentoo CVS tree is
> interesting. The resulting (partial) git history has 93413 commits and
> 850,000+ objects total, all in a totally linear history.

Ok, so there's 3 patches posted that should help narrow down the
problem. There's a new -L <imit> so that Donnie can get his stuff done
by running it in a while(true) loop. Not proud of it, but hey.

And there are two patches that I suspect may fix the leak. After
applying them, the cvsimport process grows up to ~13MB and then tapers
off, at least as far as my patience has gotten me. It's late on this
side of the globe so I'll look at the results tomorrow morning.

(BTW, I typo-ed Linus' address in the git-send-email invocation. Will
resend to him separately)

I'll also prep a patch as Linus suggests to do auto-repacking while
the import runs so we don't eat up the harddisk.

> git would basically cut down the disk usage for a live
> repo by a factor of 7 or so.
>
> _And_ I can do a "git log origin > /dev/null" in about 2.4 seconds. Take
> that, CVS.

Heh. Faster Gitticat, Kill Kill Kill!




martin
