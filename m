From: Tim O'Callaghan <timo@dspsrv.com>
Subject: Re: use binmode(STDOUT) in git-status
Date: Tue, 29 Nov 2005 11:05:50 +0100
Message-ID: <20051129100550.GA2124@ELSAMSW37164>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com> <7vd5kkvd3q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 29 12:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh2NI-0004S3-5k
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 11:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVK2KFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 05:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVK2KFx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 05:05:53 -0500
Received: from vir.dspsrv.com ([193.120.211.34]:59322 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S1750949AbVK2KFx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 05:05:53 -0500
Received: from [145.36.48.101] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1Eh2My-0003IL-00
	for git@vger.kernel.org; Tue, 29 Nov 2005 10:05:52 +0000
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd5kkvd3q.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r570 (CYGWIN_NT-5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12934>

On Mon, Nov 28, 2005 at 10:31:05AM -0800, Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Activision's Perl generates CRLF unless STDOUT is binmoded, which is
> > inconsistent with other output of git-status.
> 
> I do not think this is a kind of patch that I should accept to
> apply to the generic part of the codepath, even if on sane
> platforms binmode() could be a no-op.
> 
> You should not have to say binmode() when you are emitting plain
> text (otherwise you have to say that everywhere which is
> madness).  I presume the Cygwin version uses Perl from Cygwin
> and would not have this problem?
> 
> If that is the case, maybe this patch should be maintained out
> of tree by the maintainer of Windows port of git that does _not_
> use Cygwin but ActiveState.
>

You could also check `perl -v` for the phrase "built for cygwin". I am not
sure how much of an issue this is though, because native windows support is
going to be a bit tricky without Cygwin as you also need (ba)sh, sed, grep,
etc.

Tim.
