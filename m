From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 01/10] push: change push to fail if short refname does not exist
Date: Tue, 30 Oct 2007 09:56:43 +0100
Message-ID: <AD10F15D-0F77-42BB-86CA-6404063C784B@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <7vwst5m2eq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Immt2-0006xJ-3D
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbXJ3Izd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbXJ3Izc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:55:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:39715 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbXJ3Izc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:55:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9U8tGLV029702;
	Tue, 30 Oct 2007 09:55:16 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9U8tGcK018614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 30 Oct 2007 09:55:16 +0100 (MET)
In-Reply-To: <7vwst5m2eq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 30, 2007, at 9:29 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Pushing a short refname used to create a new ref on on the
>> remote side if it did not yet exist. If you specified the wrong
>> branch accidentally it was created. A safety valve that pushes
>> only existing branches may help to avoid errors.
>
> On the other hand, if you specified a wrong branch that exists
> on the remote end accidentally, it still was pushed.  Do we want
> to have a new "--i-really-want-to-push" option to make it safer?

Maybe not a bad idea ;)

But not as a command line flag but after printing the results
of a '--dry-run' and than asking the user for confirmation:
"do you want to push this?".


> I do not think so.  Why should a new branch be treated any
> differently?

Because "updating an existing branch" and "creating a new branch"
are two slightly different tasks.

If git provides a way to make this difference explicit, it
would be safer to use.


> Will drop 1/10 and 2/10 for now.

Then they'll be dropped and I'll rely on the the --dry-run flag.

Or someone else needs to step in and support my point.

	Steffen
