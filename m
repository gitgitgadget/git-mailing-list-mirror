From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Sun, 26 Jan 2014 11:34:38 +0400
Message-ID: <20140126073438.GA3858@kirill.netbynet.ru>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
 <20140125223721.GA2684@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 08:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7KFP-0007OX-PB
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 08:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaAZHe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 02:34:58 -0500
Received: from fallback7.mail.ru ([94.100.176.135]:57673 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaAZHe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 02:34:57 -0500
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 825F2F69ABBF
	for <git@vger.kernel.org>; Sun, 26 Jan 2014 11:34:54 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hli0HflfeODw5gWe4mRozOc04ge9QZ3Q7vS/gbais0I=;
	b=HaiLEhn1bKR0vjgA2kix5SJvzzIzYupy45KxreVCNSJrrhTfLn+lnO6pEMVvJ8g+L9BdIEMrnQAMwSeDkqy+NKjA0bZr4KZ5/y4/PacNZ+2/crSpqpPTiQ3A4BRZ2Lw+MlWYlQjwvOKJwRMTtoKYRnemFTsxnSXKtg1lr3WNl4A=;
Received: from [46.73.163.248] (port=61551 helo=kirill.netbynet.ru)
	by smtp39.i.mail.ru with esmtpa (envelope-from <brilliantov@inbox.ru>)
	id 1W7KEr-0003mo-VA; Sun, 26 Jan 2014 11:34:42 +0400
Mail-Followup-To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20140125223721.GA2684@dcvr.yhbt.net>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241079>

On 2014-01-25 22:37:21, Eric Wong wrote:
> Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru> wrote:
> > Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
> > ---
> >  git-send-email.perl | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> 
> Some documentation references to .mailrc and its format would be nice.
> 

Unfortunally I can't found official documentation on this option:
http://linux.die.net/man/1/mailx
http://publib.boulder.ibm.com/infocenter/aix/v6r1/topic/com.ibm.aix.files/doc/aixfiles/mailrc.htm

On my system (Debian GNU/Linux 7.3) documentation on mailx not conteins
description senmail options.

> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
> >  use File::Spec::Functions qw(catfile);
> >  use Error qw(:try);
> >  use Git;
> > +use File::HomeDir;
> 
> We should probably avoid a new dependency and also remain consistent
> with the rest of git handles home directories.
> 
> Unfortunately, expand_user_path()/git_config_pathname() isn't currently
> exposed to scripters right now...
> 

Ok, if new dependency is not allowed I see next ways:
- add new argument
- add new configuration parameters
