From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Re[2]: [PATCH] userdiff: match Pascal class methods
Date: Tue, 11 Jan 2011 22:50:59 +0300
Message-ID: <1093185322.20110111225059@mail.ru>
References: <1294736039-5912-1-git-send-email-zapped@mail.ru> <7vipxv45ky.fsf@alter.siamese.dyndns.org>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckFj-0001ka-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab1AKTvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:51:05 -0500
Received: from smtp2.mail.ru ([94.100.176.130]:48018 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622Ab1AKTvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=I8QmGBmxTxESajcID1MLFmV7OwLxsJ+ObwlstcUgZGI=;
	b=wuvdmu+kyI/gV2ehtEO2kS2+YQ0WuRIcY6XVb+fMz+V2rHgCDVdQmxwdwuJBqvrIX5CptQQKg90Gq7owYFzoWeHM/Y2ouEu3PLdzek+sbqirxcq0jX2yV+JwcCTT8XTQ;
Received: from [85.140.106.43] (port=28329 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp2.mail.ru with asmtp 
	id 1PckFB-0003rx-00; Tue, 11 Jan 2011 22:51:01 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <7vipxv45ky.fsf@alter.siamese.dyndns.org>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164983>

JCH> Alexey Shumkin <zapped@mail.ru> writes:

>> Class declarations were already covered by the second pattern, but class methods have the 'class' keyword in front too. Account for it.

JCH> Too long a line (which I could re-wrap locally but I'd rather not be in
JCH> the business of doing that for everybody).
Ooh, I'm sorry

>>  PATTERNS("pascal",
>> -      "^((procedure|function|constructor|destructor|interface|"
>> +      "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
>>               "implementation|initialization|finalization)[ \t]*.*)$"
JCH> Earlier we took "^procedure frotz", "^function frotz", etc. and now we
JCH> also take "^class procedure frotz", "^class function frotz", but not
JCH> "^class constructor frotz"---am I reading the patterns correctly?
Yes, you're reading correctly. 'class' keyword might precede only
'procedure' or 'function' keyword but not the other ones
