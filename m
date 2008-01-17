From: Charles Bailey <charles@hashpling.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 11:01:32 +0000
Message-ID: <20080117110132.GB12285@hashpling.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFSWK-0002Xa-No
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 12:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYAQLCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 06:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYAQLCU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 06:02:20 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:43494 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYAQLCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 06:02:19 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JFSV6-0003Wq-03; Thu, 17 Jan 2008 11:01:36 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0HB1WGJ012767;
	Thu, 17 Jan 2008 11:01:32 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0HB1Wim012766;
	Thu, 17 Jan 2008 11:01:32 GMT
Content-Disposition: inline
In-Reply-To: <478F3367.8050307@viscovery.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70846>

On Thu, Jan 17, 2008 at 11:52:23AM +0100, Johannes Sixt wrote:
> 
> I observed the same (on Windows). The reason is that above-mentioned
> commit introduces a call to parse_objects(). But by the time that
> fast-import calls write_ref_sha1() (and, hence, this new parse_objects())
> it has not yet written a pack file, and parse_objects() fails. I don't
> have a clue how to fix this short of reverting the commit.
> 

OK, so it's not just Mac OS X, then.  From your description and my
initial poke at the code,  I can't immediately see a good reason why
the test should succeed on Linux, though.
