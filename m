From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with Git 1.6.3
Date: Fri, 08 May 2009 01:43:51 -0700
Message-ID: <7vljp80yt4.fsf@alter.siamese.dyndns.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	<1241708714-20326-2-git-send-email-spearce@spearce.org>
	<200905080102.44053.robin.rosenberg@dewire.com>
	<alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
	<7vprekbfik.fsf@alter.siamese.dyndns.org>
	<20090508004741.GU30527@spearce.org>
	<81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com>
	<alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 10:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Lh0-0001HG-NS
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZEHInw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZEHInw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:43:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38550 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZEHInv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:43:51 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508084351.CGKL20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Fri, 8 May 2009 04:43:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id owjr1b0044aMwMQ04wjrYC; Fri, 08 May 2009 04:43:51 -0400
X-Authority-Analysis: v=1.0 c=1 a=Hwtzs_DYo44A:10 a=QdEgTBmxRvwA:10
 a=Ng913K55o-m2r0hhMykA:9 a=57fMcNTOdP8CZ2KnRuYA:7
 a=BzHILaPxvvJ0x4aok4obSTh2YjIA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Fri\, 8 May 2009 10\:04\:35 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118589>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> There must be at least some deprecation period during which
>> also the old .lock lockfiles are considered and created.
>> Just imagine someone modifying the ref with an older version,
>> which knows nothing about ..lck.
>
> As lock files are only supposed to be created by Git itself, and have a 
> maximum lifetime until the end of the process, I think we do not need a 
> grace period at all.

Could there be people with slightly older git and shiny new jgit (or the
other combination) working on the same repository?
