From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk: Failure of new tabbed preferences dialog
Date: Mon, 02 Apr 2012 09:19:00 -0700
Message-ID: <7vty12gl8r.fsf@alter.siamese.dyndns.org>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjyI-0002wp-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab2DBQTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:19:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab2DBQTC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:19:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A977FC9;
	Mon,  2 Apr 2012 12:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cdcuT4BAz4iZsXmj/ex92+N9rfI=; b=v3p7zE
	cL487W4hDPHn+g9ac3rdYQxZlqFxCK3WTI+Z6BsyGQEqCv1YuUDcIUDFRbApYCWM
	ghJll4cbV+IhdanWIFaHp9zQiQSGbPtoETyUEqXoxQpIK3Pv2OtTR0IKrUBIZsuU
	haAcHshprhZh6U5tsD3DuIJnOSKs+gl5fEDPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tbg/BdrvR3PVNzx2X2d6fMWeE+nHzD6V
	r3rnuRNgpyEDNRzV2QF0qBMHdz2A7X/ZBWZv+vmyYw3lpYRmvLhOIIBmDTnkivH3
	VSKkHx9nZDWXe0GVReDrCHK3a5yqyR65zzn8M3rmptWNZddssNjaxnoeMgTUU6QF
	19IiIIDxxdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EB497FC8;
	Mon,  2 Apr 2012 12:19:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B32007FC7; Mon,  2 Apr 2012
 12:19:01 -0400 (EDT)
In-Reply-To: <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Sun, 1 Apr 2012 23:00:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F0E3F52-7CDF-11E1-8210-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194528>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>> I just tried the new gitk (master @fae9d76) and, since I don't have
>> themed widgets, the preferences menu item uses the emulated tabbed
>> dialog code, which fails like so:
>>
>>     can't read "col": no such variable
>
> The issue here is that the incr command has changed between tcl 8.4
> and 8.5 and in more recent versions automatically creates the named
> variable if it did not exist. The fix you suggest is correct. I've
> also included another that I realised had been applied to msysGit and
> was not posted upstream.

This seems severe enough that we should put it in the coming release.
I can queue them directory to gitk tree (and later ask Paul to pull it
from me), and merge the result to expedite the roundtrip.
