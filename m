From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 11:50:01 +0100
Message-ID: <B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 11:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InB9Y-000241-AR
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 11:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbXJaKtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbXJaKtu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 06:49:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:55424 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbXJaKtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 06:49:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9VAmcdO006932;
	Wed, 31 Oct 2007 11:49:44 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9VAmbW5011919
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 31 Oct 2007 11:48:37 +0100 (MET)
In-Reply-To: <7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 31, 2007, at 9:45 AM, Junio C Hamano wrote:

>> - git push can be configuration to push only the current
>>   branch, as outlined below. This would certainly work. What
>>   I do not like is that you first need to do some configuration
>>   before you get a safe working environment.
>
> I would not doubt it would be safer for _your_ workflow, but you
> should consider the risk of making things more cumbersome for
> workflows of others by enforcing that policy.

Together with the '--create' flag it would be safer in all
cases, because it would always do _less_ than what git push
currently does. The safest choice would be if "git push"
refused to do anything until configured appropriately.

"safer" is independent of the workflow.

But I see that it may be more cumbersome depending on the
workflow.

I'm mainly interested in using git against a shared repo,
and make it as simple and as safe as possible to use in
such a setup. I suspect that git is more optimized for the
workflow used for the Linux kernel and for developing git,
which heavily rely on sending patches to mailing lists and
pulling fro read-only repos.


> In other words, don't change anything unless you have a very
> good reason to convince everybody else that it is universally
> a good change to the default.

What I can imagine would not be universally better, but it
would be universally safer. You'd need to either explicitly
tell git push how to act (e.g. '--current' or '--matching'
flags), or you could explicitly configure git to always act in
a specific way. But it would only start to act this way _after_
being configured appropriately.

	Steffen
