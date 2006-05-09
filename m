From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 09 May 2006 19:23:51 -0400
Message-ID: <1147217031.21611.4.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	 <7virogc90u.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org> <e3p5om$djs$1@sea.gmane.org>
	 <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	 <7vu07y252m.fsf@assigned-by-dhcp.cox.net>
	 <20060509184519.5a707231.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 01:24:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdbZN-0004Ag-80
	for gcvg-git@gmane.org; Wed, 10 May 2006 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWEIXYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 19:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWEIXYm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 19:24:42 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10369 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932093AbWEIXYl
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 May 2006 19:24:41 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FdbZF-0000X7-3s
	for git@vger.kernel.org; Tue, 09 May 2006 19:24:40 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FdbYW-0005fN-0E; Tue, 09 May 2006 19:23:52 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <20060509184519.5a707231.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19863>

On Tue, 2006-05-09 at 18:45 -0400, sean wrote:
> On Tue, 09 May 2006 15:42:25 -0700
> Junio C Hamano <junkio@cox.net> wrote:
> > Does this mean you can have anything other than LF and ']'?
> 
> Anything but LF; how's this for ugly:
> 
>     ["hello Worl\]d \\backslash]

Actually, LF is already handled just fine in the value part:

[proski@dv .git]$ git-repo-config s1.k1 $'v1\nv2'
[proski@dv .git]$ grep [sk]1 config 
[s1]
        k1 = v1\nv2

Note that quoting doesn't solve this problem (unless multi-line section
headers are allowed), but backslash escaping does.

But I guess everybody prefers quotes for their friendly look.

-- 
Regards,
Pavel Roskin
