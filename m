From: Pavel Roskin <proski@gnu.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:23:06 -0400
Message-ID: <1147893786.16654.5.camel@dv>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
	 <8aa486160605161542u704ccf03w@mail.gmail.com>
	 <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
	 <8aa486160605170641p2ab8704o@mail.gmail.com>   <e4f9eo$b60$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:23:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRc5-0003OE-2b
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWEQTXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWEQTXO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:23:14 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12743 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751016AbWEQTXN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:23:13 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgRc0-0004Vy-Gy
	for git@vger.kernel.org; Wed, 17 May 2006 15:23:12 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgRbu-0004LN-AY; Wed, 17 May 2006 15:23:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4f9eo$b60$1@sea.gmane.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20229>

On Wed, 2006-05-17 at 15:46 +0200, Jakub Narebski wrote:
> Santi wrote:
> 
> > In the other way, now I find the value of being able to say:
> > 
> > $ git add t*
> > 
> > and be sure that it does not add an ignored file. Unfortunately
> > git-add cannot distinguish between both.
> 
> Well, it could. If 'git add <filespec>' would result in NO files 
> added, take <filespec> as literate <file> (filename), regardless
> of ignores.

Can we apply the ignore rules to the directories but not the files?

This way, "git-add *" would add all files (rarely a good idea), whereas 
"git-add ." would respect the ignore rules.

Kludgy as it is, this approach would generally produce more expected
results than others.  If you let the shell expand the pattern, expect
all junk to be added.  If you let git expand the pattern, expect it to
adhere to the ignore rules.

-- 
Regards,
Pavel Roskin
