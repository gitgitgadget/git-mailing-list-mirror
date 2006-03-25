From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 4/4] send-email: add support for mutt aliases files
Date: Sat, 25 Mar 2006 18:50:17 -0500
Message-ID: <20060325235017.GN26071@mythryan2.michonline.com>
References: <11432834101430-git-send-email-normalperson@yhbt.net> <11432834111445-git-send-email-normalperson@yhbt.net> <7vfyl6uuzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 00:51:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNIXa-00084j-5e
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 00:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWCYXv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 18:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCYXv1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 18:51:27 -0500
Received: from mail.autoweb.net ([198.172.237.26]:57296 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750741AbWCYXv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 18:51:26 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FNIXP-0002nU-FM; Sat, 25 Mar 2006 18:51:22 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FNIXZ-0007FH-1e; Sat, 25 Mar 2006 18:51:29 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FNIWm-0005uE-9I; Sat, 25 Mar 2006 18:50:40 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyl6uuzt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18007>

On Sat, Mar 25, 2006 at 12:31:18PM -0800, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > More email clients/address book formats can easily be supported
> > in the future.
> 
> > +if (my $mutt_aliases = `git-repo-config sendemail.muttaliases`) {
> > +    chomp $mutt_aliases;
> > +    open my $ma, '<', $mutt_aliases or die "opening $mutt_aliases: $!\n";
> > +    while (<$ma>) { if (/^alias\s+(\S+)\s+(.*)/) { $aliases{$1} = $2 } }
> > +    close $ma;
> > +}
> > +# aliases for more mail clients can be supported here:
> > +
> 
> I'd rather avoid proliferation of sendemail.{foo,bar,mutt,pine,...}aliases
> variables.  Can we autodetect the alias file format and parse
> the given file accordingly?

Don't bother - instead of lots of variables, just have two:
	sendemail.aliasesfile
	sendemail.aliasfiletype

-- 

Ryan Anderson
  sometimes Pug Majere
