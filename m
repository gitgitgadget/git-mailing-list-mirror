From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] consistently try VISUAL, EDITOR and vi in this order.
Date: Mon, 03 Jul 2006 11:24:02 +0200
Organization: At home
Message-ID: <e8anmn$ufp$1@sea.gmane.org>
References: <7vmzbrv1yc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 03 11:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxKfb-0008Lw-9z
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 11:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWGCJYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWGCJYj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 05:24:39 -0400
Received: from main.gmane.org ([80.91.229.2]:52655 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751013AbWGCJYj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 05:24:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxKfD-0008HT-F7
	for git@vger.kernel.org; Mon, 03 Jul 2006 11:24:19 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 11:24:19 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 11:24:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23167>

Junio C Hamano wrote:

> git grep -e VISUAL -e EDITOR revealed this inconsistency.  All
> other commands seem to check VISUAL and then EDITOR as they should.
> 

> +     my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
>       system($editor, $compose_filename);

Shouldn't we check if we are in visual (non CLI-only) environment,
like X-Window, MS Windows or MacOS X, before trying to use VISUAL?
How other parts solve it? </me checks> Ah, we use VISUAL unconditionally,
at least in scripts...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
