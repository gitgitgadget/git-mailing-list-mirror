From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Mon, 12 Nov 2012 13:14:50 -0500
Message-ID: <50A13C9A.8070108@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com> <1352487385-5929-1-git-send-email-hordp@cisco.com> <1352487385-5929-4-git-send-email-hordp@cisco.com> <7vip9aiuk8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXyXL-0003Sr-IE
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 19:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab2KLSOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 13:14:53 -0500
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:49188 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2KLSOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 13:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1748; q=dns/txt; s=iport;
  t=1352744093; x=1353953693;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=3qSOyV94SKpIpEegg622eZQqGoPZRxSrTRFJ396gIOw=;
  b=NbXyUkE5by+RhE35Ey84WhqsdlMfJKlXL2d8vMm4W6vp3fvUvsU3wzyO
   q4CooDubY4PdI6pMoSUZgVn4cgboeN9xFjizpyw7NfyCa830NXUv3rdI8
   QqoxlPt0H4WvjiR0JcLCQfzj5uXp9sCayf3987ELj0A0Quo+YwD8++dx5
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAOY7oVCtJXHA/2dsb2JhbABEw1qBCIIeAQEBBBIBZQEQCxgJFg8JAwIBAgFFBg0BBQIBAR6HaJl0n3qSXwOIWo0ihWuIbYFrgw0
X-IronPort-AV: E=McAfee;i="5400,1158,6894"; a="141375544"
Received: from rcdn-core2-5.cisco.com ([173.37.113.192])
  by rcdn-iport-6.cisco.com with ESMTP; 12 Nov 2012 18:14:52 +0000
Received: from [64.100.104.138] (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core2-5.cisco.com (8.14.5/8.14.5) with ESMTP id qACIEpP5011349;
	Mon, 12 Nov 2012 18:14:51 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vip9aiuk8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121112131450960
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209506>

Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> State token strings which may be emitted and their meanings:
>>     merge              a merge is in progress
>>     am                 an am is in progress
>>     am-is-empty        the am patch is empty
>>     rebase             a rebase is in progress
>>     rebase-interactive an interactive rebase is in progress
>>     cherry-pick        a cherry-pick is in progress
>>     bisect             a bisect is in progress
>>     conflicted         there are unresolved conflicts
>>     commit-pending     a commit operation is waiting to be completed
>>     splitting          interactive rebase, commit is being split
>>
>> I also considered adding these tokens, but I decided it was not
>> appropriate since these changes are not sequencer-related.  But
>> it is possible I am being too short-sighted or have chosen the
>> switch name poorly.
>>     changed-index  Changes exist in the index
>>     changed-files  Changes exist in the working directory
>>     untracked      New files exist in the working directory
> I tend to agree; unlike all the normal output from "status -s" that
> are per-file, the above are the overall states of the working tree.
>
> It is just that most of the "overall states" look as if they are
> dominated by "sequencer states", but that is only because you chose
> to call states related to things like "am" and "bisect" that are not
> sequencer states as such.
>
> It probably should be called the tree state, working tree state, or
> somesuch.

I think you are agreeing that I chose the switch name poorly, right?

Do you think '--tree-state' is an acceptable switch or do you have other
suggestions?

Phil
