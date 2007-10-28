From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 8/8] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Sun, 28 Oct 2007 09:20:53 +0100
Message-ID: <F12160CA-1778-499F-A3D7-42711FB8B2CC@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <11935038084055-git-send-email-prohaska@zib.de> <11935038084130-git-send-email-prohaska@zib.de> <11935038083116-git-send-email-prohaska@zib.de> <11935038083335-git-send-email-prohaska@zib.de> <7vfxzvwvde.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im3NJ-0008KW-T2
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbXJ1ITt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXJ1ITt
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:19:49 -0400
Received: from mailer.zib.de ([130.73.108.11]:64636 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXJ1ITr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:19:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S8JRIo014313;
	Sun, 28 Oct 2007 09:19:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S8JQi9026673
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 09:19:27 +0100 (MET)
In-Reply-To: <7vfxzvwvde.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62538>


On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> git push reports errors if a remote ref is not a strict subset
>> of a local ref. The push wouldn't be a fast-forward and is
>> therefore refused. This is in general a good idea.
>
>> This commit teaches git push to be quiet if the local is a strict
>> subset of the remote and no refspec is explicitly specified on
>> the command line. If the --verbose flag is used a "note:" is
>> printed for each ignored branch.
>
> What happens to the summary reporting after such a push?  Does
> it say "branch foo was not pushed because you did not touch it
> since you fetched and it is already stale with respect to the
> remote side which has updates since then"?

It says nothing, it's quiet, as promised in the commit message ;)
That's the point of this patch.

But I see your point. Maybe it should say something like
"ignored 2 branches, which are strict subsets of remote."
"use --verbose for details."
?

> How does this interact with the "pretend we have fetched
> immediately after we pushed by updating the corresponding remote
> tracking branch" logic?

I doesn't change a remote tracking branch. I'll add a test
confirming this.

	Steffen
