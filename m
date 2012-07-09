From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 09 Jul 2012 15:43:20 -0700
Message-ID: <7v8vesk12v.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org> <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org> <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org> <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoMfw-0006K7-EN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 00:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2GIWnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 18:43:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2GIWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 18:43:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903D799A8;
	Mon,  9 Jul 2012 18:43:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fFsg4fdaeyhyu51WEeHTB6Cv+pk=; b=A4jJRH
	Th9XpwFEz2eWnCW9let3G7Wg3NeB2jlRO5zbljVrGXNoSFb+nWGJA5rzMbV6YvLT
	Bg7SVOxO68BmdSO2Qve5kuqnP4ss6RIuZufx0DuIngzJYdNT7CFmTgiorLCeiRX/
	TwKItuLcsJNWSa+xTeDsU2HwB4XVluZk48o50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DvyjeJ8BYMdTb+xtOuo++Djjpz1b2fAX
	97QMcO1DgK4s+z4mBfNIpIYsrdvUybF4BQVfmrD1JbLOpi1HWkun43Iq0/OK8mdi
	//8J58O+5dcYPu79HrO+d279FaP/wok3PU3IDQaIHWh8hKB8fmuPSpCoW9ocj0Yg
	oEgyyVaG0Fk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E2899A7;
	Mon,  9 Jul 2012 18:43:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1828899A6; Mon,  9 Jul 2012
 18:43:22 -0400 (EDT)
In-Reply-To: <20120709220321.GE30213@beczulka> (Marcin Owsiany's message of
 "Mon, 9 Jul 2012 23:03:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C964B1E-CA17-11E1-89F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201230>

Marcin Owsiany <marcin@owsiany.pl> writes:

>> This makes my idea to do the same to "my something else instead of
>> master" much less attractive. In fact I don't think such behaviour would
>> be useful.
>> 
>> I think with the suggested patch git-svn works as I would like it to:
>>  - creates "master" at initial checkout - consistent with git clone
>>  - using a different "tracking-like" branch is possible with "dcommit"
>>  - does not re-create "master" on fetch - so the annoying part is gone
>
> Any comments?

Not from me.  Even though I'd love to hear Eric's opinion, your "I
don't think such behaviour would be useful." gave me an impression
that you would justify the change in a different way (i.e. a rewrite
of proposed log message) or tweak the patch (i.e. a modified
behaviour), or perhaps both, in your re-roll, the ball was in your
court, and we were waiting for such a rerolled patch.
