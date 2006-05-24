From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 23:17:32 +0930
Message-ID: <93c3eada0605240647i48db0588ja343e348f5feb08e@mail.gmail.com>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
	 <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
	 <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
	 <20060524122246.GA3997@coredump.intra.peff.net>
	 <93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com>
	 <20060524132317.GA4594@coredump.intra.peff.net>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 24 15:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiti4-0002YD-Ek
	for gcvg-git@gmane.org; Wed, 24 May 2006 15:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWEXNre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 09:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWEXNrd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 09:47:33 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:17551 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932746AbWEXNrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 09:47:33 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1205554wxc
        for <git@vger.kernel.org>; Wed, 24 May 2006 06:47:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i4b4HyrbyS73j62+S4ERDFoBhGQ+Gq3Ggb34oMYNAPmzuuJVLkrRRxF3zEaQzEr1HUs3cuzSNM5fmS4HCTt/fcLc2+kHEkpLbhgVpWL/YiCRCDMpReJ5SPwjrUAf5C8AoWYU4elKcahOs16mUMmB1TNgvgOvnJzVxQ+t+aPIltI=
Received: by 10.70.95.17 with SMTP id s17mr273059wxb;
        Wed, 24 May 2006 06:47:32 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 06:47:32 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org,
	"Jeff King" <peff@peff.net>
In-Reply-To: <20060524132317.GA4594@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20685>

Hi Jeff,

On 5/24/06, Jeff King <peff@peff.net> wrote:
> On Wed, May 24, 2006 at 10:03:44PM +0930, Geoff Russell wrote:
>
> >   ":errno_h" is not exported by the POSIX module
> >   Can't continue after import errors at
> > /usr/lib/perl5/5.8.0/i386-linux-thread-multi/POSIX.pm line 19
> >    BEGIN failed--compilation aborted at ./git-cvsimport line 26.
>
> Hmm. It looks like something is nonstandard in your setup. I just compiled
> 5.8.0 from source and the :errno_h tag works fine. What is your
> platform?  Can you try the following and let me know which work:

I compiled perl from source on Mandrake 9.1.

>   $ perl -e 'use POSIX qw(:errno_h)'
>   $ perl -e 'use POSIX qw(errno_h)'
>   $ perl -e 'use Errno'

All 3 work.  But if I add a second tag before the ':errno_h", then I
get an error.

The "use" line that makes git-cvsimport compile for me is:

        use POSIX qw(strftime dup2 ENOENT);

Which just imports the required symbol and not the full tag list.

Cheers,
Geoff.

>
> -Peff
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
