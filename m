From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 11:47:31 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D35454.12423.D32681@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D327C4.7000101@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Russ Dill <russ.dill@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 01 11:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lox4Y-0006X1-Ig
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 11:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZDAJrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 05:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbZDAJrv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 05:47:51 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:19733 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952AbZDAJrt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 05:47:49 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 29430ABC9C;
	Wed,  1 Apr 2009 11:47:50 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id E073FABCAE;
	Wed,  1 Apr 2009 11:47:49 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n319leXW009321;
	Wed, 1 Apr 2009 11:47:40 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 11:47:39 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 11:47:32 +0100
In-reply-to: <49D327C4.7000101@op5.se>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.094025Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115361>

On 1 Apr 2009 at 10:37, Andreas Ericsson wrote:

> >> Not only that, but modification times are much more useful with make.
> >> Merging or pulling small changes into a tree shouldn't require a full
> >> rebuild of the entire tree which in some cases could take hours.
> > 
> > Git is not a build system, and I really dislike "full rebuilds", but for 
> > stability, before releasing anything, one should test it with a full rebuild.
> 
> I build all the time. Before and after every commit (merges are one type of
> commit). I rely on file timestamps to be an accurate indicator of when the
> file last changed *on my disk*.
> 

But you are silently assuming that the make files are correct: If a file is not 
being rebuilt, you might be using an old compile without noticing. There a full 
recompile will at least 1) either trigger an error (missing object file) or 2) 
build every file. So I really don't see that relying on file dates is much better 
than doing a full rebuild. That's specifically true if you pull a new tree: If I 
understand things right, EVERY file will have a current date, so you'll rebuild 
everything anyway. So you could also have the "real file dates" and then do "make 
clean; make all". I see no benefit from either approach.

Regards,
Ulrich
