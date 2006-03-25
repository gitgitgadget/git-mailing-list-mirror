From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] send-email: add support for mutt aliases files
Date: Sat, 25 Mar 2006 12:31:18 -0800
Message-ID: <7vfyl6uuzt.fsf@assigned-by-dhcp.cox.net>
References: <11432834101430-git-send-email-normalperson@yhbt.net>
	<11432834111445-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 21:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNFQ2-0007Yi-Oo
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 21:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWCYUbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 15:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWCYUbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 15:31:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9409 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751396AbWCYUbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 15:31:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325203124.KMCF17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 15:31:24 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11432834111445-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sat, 25 Mar 2006 02:43:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17996>

Eric Wong <normalperson@yhbt.net> writes:

> More email clients/address book formats can easily be supported
> in the future.

> +if (my $mutt_aliases = `git-repo-config sendemail.muttaliases`) {
> +    chomp $mutt_aliases;
> +    open my $ma, '<', $mutt_aliases or die "opening $mutt_aliases: $!\n";
> +    while (<$ma>) { if (/^alias\s+(\S+)\s+(.*)/) { $aliases{$1} = $2 } }
> +    close $ma;
> +}
> +# aliases for more mail clients can be supported here:
> +

I'd rather avoid proliferation of sendemail.{foo,bar,mutt,pine,...}aliases
variables.  Can we autodetect the alias file format and parse
the given file accordingly?
