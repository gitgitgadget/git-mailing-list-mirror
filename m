From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Fri, 23 Nov 2007 20:53:41 +0300
Message-ID: <87lk8orgpm.fsf@osv.gnss.ru>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 18:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivckb-0002c9-HP
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 18:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbXKWRzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 12:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbXKWRzS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 12:55:18 -0500
Received: from javad.com ([216.122.176.236]:1570 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbXKWRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 12:55:17 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lANHrlH60070;
	Fri, 23 Nov 2007 17:53:47 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Ivcij-0003sS-HC; Fri, 23 Nov 2007 20:53:41 +0300
In-Reply-To: <7vr6ikk6rf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 20 Nov 2007 12\:21\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65906>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> [...]
>>> Oops, forgot to say "no need to resend".  I asked only because I
>>> wanted an independent datapoint for Emacs diff mode breakage.
>>
>> I bet I can damage any patch using any editor ;)
>>
>> More interesting is what version of Emacs it was?
>
> To be fair and honest, I do not think there is a simple fix for
> this, although it probably is possible to fix it.
>
> What is causing the "breakage" is the fact that format-patch
> output ends with the signature delimiter line "^-- $" that
> immediately follows the patch text.

Exactly. What causes breakage is the fact that the '-' character (as
well as '+', ' ', '!', '#', and '\'), being the first symbol of a line
has special meaning in the diff format.

Therefore it seems that format-patch should better put one empty line
after the last diff hunk and before the signature. Any objections?

-- 
Sergei.
