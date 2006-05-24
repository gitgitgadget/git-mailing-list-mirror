From: Jeff King <peff@peff.net>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 09:23:17 -0400
Message-ID: <20060524132317.GA4594@coredump.intra.peff.net>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com> <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com> <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com> <20060524122246.GA3997@coredump.intra.peff.net> <93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 15:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FitKx-0006w2-SG
	for gcvg-git@gmane.org; Wed, 24 May 2006 15:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWEXNXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 09:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWEXNXU
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 09:23:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33517 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932740AbWEXNXT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 09:23:19 -0400
Received: (qmail 82995 invoked from network); 24 May 2006 13:23:17 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 May 2006 13:23:17 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2006 09:23:17 -0400
To: geoff@austrics.com.au
Mail-Followup-To: geoff@austrics.com.au,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20683>

On Wed, May 24, 2006 at 10:03:44PM +0930, Geoff Russell wrote:

>   ":errno_h" is not exported by the POSIX module
>   Can't continue after import errors at
> /usr/lib/perl5/5.8.0/i386-linux-thread-multi/POSIX.pm line 19
>    BEGIN failed--compilation aborted at ./git-cvsimport line 26.

Hmm. It looks like something is nonstandard in your setup. I just compiled
5.8.0 from source and the :errno_h tag works fine. What is your
platform?  Can you try the following and let me know which work:
  $ perl -e 'use POSIX qw(:errno_h)'
  $ perl -e 'use POSIX qw(errno_h)'
  $ perl -e 'use Errno'

-Peff
