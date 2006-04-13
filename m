From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 22:00:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604132151040.29391@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 22:01:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU7zz-0007ep-Kf
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 22:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWDMUA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 16:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWDMUA6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 16:00:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41629 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964960AbWDMUA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 16:00:58 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 12DB41FDE;
	Thu, 13 Apr 2006 22:00:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 070591FDF;
	Thu, 13 Apr 2006 22:00:57 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D203A1FD5;
	Thu, 13 Apr 2006 22:00:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18669>

Hi,

On Thu, 13 Apr 2006, Junio C Hamano wrote:

> For an added line, xdl_emit_diffrec(rec, size, " ", 1, ecb) is
> called, which gives mb[0].ptr = " " and mb[1].ptr = <the
> contents of the line>; fn_diffstat() is called with (nbuf == 2).

Silly me. I did not check that code, but assumed that mb Just Contains 
Whole Lines...

> Instead of driving diffstat code from run_diff(),
> run_diff_cmd(), and builtin_diff(), I think it would be much
> cleaner to define diff_flush_stat() as a sibling to
> diff_flush_raw() and diff_flush_patch(), and bypass the
> run_diff() chain.

I guess you're right. It is also more work :-(

There is another bug: if a file is created, you see "ev/null" as filename. 
Ugly.

I'll try to fix it.

Ciao,
Dscho
