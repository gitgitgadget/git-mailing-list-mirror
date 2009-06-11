From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been removed from CVS
Date: Thu, 11 Jun 2009 08:49:46 -0700
Message-ID: <7vr5xqixd1.fsf@alter.siamese.dyndns.org>
References: <4A1F1CF5.8030002@yahoo.co.uk>
	<e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
	<4A311053.5060802@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEmXT-0001Mg-OG
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 17:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023AbZFKPtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 11:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbZFKPtq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:49:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59937 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZFKPtp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:49:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611154948.NNFW20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 11 Jun 2009 11:49:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2fpn1c0024aMwMQ04fpnk8; Thu, 11 Jun 2009 11:49:47 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=BAjMoHc70cUA:10 a=UCtxeOKJ4AkA:10
 a=BrDiTsk0AAAA:8 a=zBK5yZjOAAAA:8 a=DQq1zK7Z02fwcaArBRQA:9
 a=u_7ALdtO300zZUSXfeQ8tZcC6PIA:4 a=jCX6CI3P4pcA:10 a=-hJg1tCh9CgA:10
X-CM-Score: 0.00
In-Reply-To: <4A311053.5060802@yahoo.co.uk> (Nick Woolley's message of "Thu\, 11 Jun 2009 15\:10\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121344>

Nick Woolley <nickwoolley@yahoo.co.uk> writes:

> Mike Ralphson wrote:
>> Hi Nick, I'm seeing intermittent failures since your new test was
>> added to 'next' on AIX 5.3
>> 
>> cvs commit: Up-to-date check failed for ` space'
>> cvs [commit aborted]: correct above errors first!
>> * FAIL 15: re-commit a removed filename which remains in CVS attic
>> * failed 1 among 15 test(s)
>> 
>> Is there a possibility this test has a race condition?
>
> Hm, I have thought not, but what sort of a race condition did you have in mind?
>
>> Let me know if there's anything I can do to help debug it.
>> 
>> It could be a bug in the ancient CVS I have here (1.11.1p1) though.
>
> I wouldn't be surprised.

I just saw this on a k.org machine that runs Fedora 9 (Sulphur); 1.11.22
is the version of CVS that comes with it.

But it does seem to be repeatable; I wouldn't rule out a race condition.
