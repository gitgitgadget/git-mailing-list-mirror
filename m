From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Tue, 30 Oct 2007 11:53:45 +0100
Message-ID: <49830F09-FFBF-4195-9D12-ED7B7F56A142@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <472706DB.1040106@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImoiR-0000Ib-7j
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbXJ3Kwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbXJ3Kwg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:52:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:50150 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbXJ3Kwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:52:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9UAqJVU010915;
	Tue, 30 Oct 2007 11:52:19 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9UAqIfD017474
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 30 Oct 2007 11:52:19 +0100 (MET)
In-Reply-To: <472706DB.1040106@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 30, 2007, at 11:26 AM, Andreas Ericsson wrote:

> Steffen Prohaska wrote:
>> My strange rule 10/10 adds a check that verifies if the local
>> side has something interesting to push. Only in this case a
>> pull make sense. If you do not have something new, a pull will
>> be a fast-forward, and just a waste of time.
>
> Err... fast-forward pulls are not a waste of time. What a strange
> notion. Perhaps I misunderstood, but this sentence jumped out at
> me and immediately got filed under "decidedly odd".

If the local branch is a strict ancestor, a pull is only
interesting if you want to start to work on such a branch
locally. But pull is a waste of time if you're only goal is to
push. Push suggests to pull first. So you pull; and then you
push again; and the result on the remote is the same. Only
the error message is gone that could have been avoided in the
first place. -> waste of time.

If you _pull_ it would be interesting to learn that you probably
want to merge to more than the current local branch. At that
time you expressed the intention to integrate new changes from
the remote. And it's probably a good idea to integrate changes
on all local branches that are set up to automatically merge
from the same remote you just pulled.

But if you push you want to push. You'd probably only interested
in pulls that add immediate value to the push. That is if the
result of a subsequent push modified the remote.

	Steffen
