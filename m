From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: rerere.enabled overrides [ -d rr-cache ]
Date: Sat, 7 Jan 2012 02:42:39 +0100
Message-ID: <87boqge19s.fsf@thomas.inf.ethz.ch>
References: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch>
	<7vfwfsk24y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 02:42:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjLJ6-00009K-7f
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 02:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759225Ab2AGBmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 20:42:44 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:44791 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035Ab2AGBmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 20:42:43 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 7 Jan
 2012 02:42:36 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 7 Jan
 2012 02:42:40 +0100
In-Reply-To: <7vfwfsk24y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 06 Jan 2012 12:27:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188059>

Junio C Hamano <gitster@pobox.com> writes:

> The manual page for "rerere" talks about "configuration variable
> rerere.enabled"; perhaps it should also refer to git config manual page to
> make it more discoverable?

Maybe, but it already says you should set the variable in two different
places.

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> ... OTOH the
>> auto-creation of rr-cache can cause strange behavior if a user has
>> rerere.enabled unset and tries it once, as in
>>
>>   git config rerere.enabled true
>>   git merge ...
>>   git config --unset rerere.enabled
>
> That is because the last one should be
>
> 	git config --bool rerere.enabled false

I definitely meant --unset.  If the user knows the distinction, and
wants to return the variable to the state it had before his test
(perhaps so that a future --global setting might take effect), he would
use this sequence.  He might then be somewhat surprised to see that
rerere is now permamently enabled for this repo.

Probably I'm worrying too much about a weird fringe case though.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
