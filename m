From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 22:03:44 +0930
Message-ID: <93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
	 <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
	 <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
	 <20060524122246.GA3997@coredump.intra.peff.net>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 24 14:34:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FisZ0-0007MK-3U
	for gcvg-git@gmane.org; Wed, 24 May 2006 14:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWEXMdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWEXMdp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 08:33:45 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:59299 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932723AbWEXMdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 08:33:44 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1194225wxc
        for <git@vger.kernel.org>; Wed, 24 May 2006 05:33:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/IOQBcHceI0j4GnS4YOziPQCKmVRX1quDbo3SMxLz3uxdX5G2R8F6eF5DNnBkoXuirDYnNEoEGaifvjxGT5nPG/eLQtjK0T/SbABSh1kD6tVFT724Lq2HZY166xeLqm1zO3ItpH5uqvPTLzCh4a1+5DntpwfhldLCgyYeY4CWg=
Received: by 10.70.48.18 with SMTP id v18mr7655862wxv;
        Wed, 24 May 2006 05:33:44 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 05:33:44 -0700 (PDT)
To: geoff@austrics.com.au,
	"Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
In-Reply-To: <20060524122246.GA3997@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20681>

Dear Jeff,

See below.

On 5/24/06, Jeff King <peff@peff.net> wrote:
> On Wed, May 24, 2006 at 08:49:03PM +0930, Geoff Russell wrote:
>
> > I did have to change 2 lines in git-cvsimport to get it to run with my
> > 5.8.0 perl (problems with POSIX errno). I've attached a patch but my
> > work around isn't as quick as what it replaced.
>
> Can you describe your problem in more detail? The POSIX errno constants
> have been available since long before 5.8.0, so we should be able to use
> them.


   $ ./git-cvsimport

   ":errno_h" is not exported by the POSIX module
   Can't continue after import errors at
/usr/lib/perl5/5.8.0/i386-linux-thread-multi/POSIX.pm line 19
    BEGIN failed--compilation aborted at ./git-cvsimport line 26.

When I deleted ":errno_h" I needed to patch the place it was used (as per patch
I attached in original post).

Cheers,
Geoff Russell



>
> (btw, the change was introduced in my commit() cleanups:
>   e73aefe4fdba0d161d9878642c69b40d83a0204c).
>
> -Peff
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
