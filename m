From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 19:43:09 -0700 (PDT)
Message-ID: <20060701024309.63001.qmail@web31805.mail.mud.yahoo.com>
References: <7vy7vef52m.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 04:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVS1-0000SS-QC
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 04:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWGACnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 22:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWGACnL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 22:43:11 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:44924 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750792AbWGACnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 22:43:10 -0400
Received: (qmail 63003 invoked by uid 60001); 1 Jul 2006 02:43:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5Yda8XE8/ioaktF4XIpfpj2eQaBYfl+d559xQppwD1kBISVxKYyA/Am2tz/E/JlYQEQ09+7kwxZul3BWWXiaOnsuVwhQLNKsVloUMwK55CD4I1xBarTtpELuMCMMLzNDlQjvnZQkGMuaMs2jNAVL2E+Fn1To08qX1IiKzMaAy4E=  ;
Received: from [68.186.62.135] by web31805.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 19:43:09 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vef52m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23031>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > This patch allows history display of whole trees/directories a la
> > "git-rev-list HEAD -- <dir or file>".  I find this useful especially
> > when a project lives in its own subdirectory, as opposed to being all
> > of the GIT repository (i.e. when a sub-project is merged into a
> > super-project).
> 
> Both patches from you were seriously damaged.  Check your MUA
> before sending further patches, please.

Yes, I'll take a look.

> 
> They were trivial for me to apply by hand, so no need to resend
> them.  I like the effect of this one I am replying to very much.

Junio, Linus,

I took a comparative look with and without "--full-history",
and FWIW, enabling full history just clobbers the output with a lot
of unnecessary information.  I.e. it shows merges which do not have
direct consequence or change to the files in the path spec specified
after the "--".

I.e. no new, relevant information is being shown when "--full-history"
is enabled.  In fact the default git-rev-list case, simplify_history=1,
still shows a merge here and there which doesn't have any direct
changes into what is being sought, but the difference is
about 48% less clobber.

Can you consider the default case to be simplify_history=1,
which is currently the default behaviour of git-rev-list.

If not, is it possible to make this a configurable flag
in gitweb, so that people can decide how much non-related
history to show?  I.e. I'd opt for the default case,
no full-history.

FWIW, I think that the original intention (had there been a choice)
would've been to show only most relevant history, i.e. changes
directly related to paths and files after the "--".

Thanks,
  Luben
