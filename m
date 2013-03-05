From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Tue, 5 Mar 2013 23:16:03 -0000
Organization: OPDS
Message-ID: <D9E55432793A444F941789A493F97B1C@PhilipOakley>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com> <7vtxoqx3s1.fsf@alter.siamese.dyndns.org> <201303052118.r25LIoAC000463@freeze.ariadne.com> <7vy5e1sf6b.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Dale Worley" <worley@c-66-31-108-177.hsd1.ma.comcast.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 00:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD15n-0007HT-ND
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 00:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3CEXPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 18:15:53 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:65399 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931Ab3CEXPw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 18:15:52 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvEKAN55NlFZ8rke/2dsb2JhbABEjiO2QgEDAYFxF3OCJgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGHcAMJCqwuhjgIiV+OBh5eC4JmYQOINoVlhGuUMoMI
X-IronPort-AV: E=Sophos;i="4.84,791,1355097600"; 
   d="scan'208";a="410969397"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with SMTP; 05 Mar 2013 23:15:50 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217494>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, March 05, 2013 9:35 PM
> Dale Worley <worley@c-66-31-108-177.hsd1.ma.comcast.net> writes:
>
>>> From: Junio C Hamano <gitster@pobox.com>
>>>
>>> I think this is to be expected for "git rebase", as it does not even
>>> look at merges.  It is a way to find non-merge commits that haven't
>>> been applied yet, and apply them to the upstream to create a new
>>> linear history.
>>
>> I disagree. "git rebase" is not characterized as ...
>
> The intention has always been "I have these patches, some were
> applied upstream already, now what do I have left?".

Given that many folk appear to trip up with their rebase mindset, does
this suggest that a few tweaks to the manual may be in order to stop
such misunderstandings?

Perhaps:
    git-rebase - Forward-port local commits, not in upstream,
     to the updated upstream head

and to avoid "hidden" asides, add a few more paragraph breaks into the
description texts, and perhaps bring the "Note that any commits in HEAD
which introduce the same textual changes as a commit in HEAD..<upstream>
are omitted" sentence nearer the start.

That is, don't let folks get a too simplistic view of rebase, missing 
its
hidden powers.

>
> You do realize that you are disagreeing with somebody who designed
> the original "git rebase" (before the --preserve-merges was added),
> do you?

However the broader userbase brings with it a better class of fool ;-)
