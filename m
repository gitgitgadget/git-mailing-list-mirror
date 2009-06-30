From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Tue, 30 Jun 2009 19:26:11 +0200
Message-ID: <4A4A4AB3.8030107@suse.cz>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz>	<7vws6t8zhv.fsf@alter.siamese.dyndns.org> <7vskhh8yxf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLh6A-0007bS-QL
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 19:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbZF3R0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZF3R0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 13:26:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:41319 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbZF3R0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 13:26:15 -0400
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DBA9C93B4B;
	Tue, 30 Jun 2009 19:26:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
In-Reply-To: <7vskhh8yxf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122524>

Junio C Hamano napsal(a):
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michal Marek <mmarek@suse.cz> writes:
>>
>>> git request-pull called inside a terminal prints part of the output to
>>> the terminal and other parts are piped through the pager. Fix this.
>> Hmph, I have always thought this was meant to be a feature.
>>
>> That is, you run it to yourself, instead of piping it to a file or "| mail
>> torvalds", in order to sanity check before you actually do the latter.
>> When the request is larger than a screenful, you would want a pager while
>> reviewing.
> 
> Sorry, I take it back.
> 
> If it _were_ a single call to a paging command what I said may make sense,
> but with many separate calls to shortlog, we wouldn't know which output is
> too large (and uses pager).  I agree your patch makes things better.

Yes, this is what I dislike, it prints parts to the terminal and parts
are paged (separately). Paging the whole output would be a nice
improvement, but probably not worth the effort.


> I should have read your commit log message after finishing my coffee ;-)

:-)

Michal
