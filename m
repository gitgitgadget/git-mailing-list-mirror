From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: optimized checkout+rebase?
Date: Sat, 15 Mar 2008 11:39:55 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080315103954.GD14769@ins.uni-bonn.de>
References: <20080312191041.GF3198@ins.uni-bonn.de> <47D8D5B8.70809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 11:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaTod-000836-PK
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 11:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYCOKkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 06:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYCOKkA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 06:40:00 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:52876 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYCOKkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 06:40:00 -0400
Received: from localhost.localdomain (xdsl-87-78-111-54.netcologne.de [87.78.111.54])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 49AB6400002D8;
	Sat, 15 Mar 2008 11:39:59 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JaTnv-0004Oy-AV; Sat, 15 Mar 2008 11:39:55 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <47D8D5B8.70809@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77319>

* Johannes Sixt wrote on Thu, Mar 13, 2008 at 08:20:24AM CET:
> Well, what you could do is:
> 
>    for branch in $my_topic_branches; do
>      git rebase master $branch
>      # occasional fixups here...
>    done
> 
> But it seems that even then rebase first does the checkout $branch, and
> then the checkout master right after that.

Exactly.  The amount of typing is not an issue, but the trees are large
so it's not uncommon that each checkout takes tens of seconds.  No idea
how much of that is range computations and patch formatting though.

Thanks,
Ralf
