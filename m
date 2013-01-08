From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enabling scissors by default?
Date: Tue, 08 Jan 2013 15:36:09 -0800
Message-ID: <7vr4lvb63a.fsf@alter.siamese.dyndns.org>
References: <50EC92C6.7090509@ubuntu.com>
 <7vvcb7b8lc.fsf@alter.siamese.dyndns.org> <50ECAAE2.2020507@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:37:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsij3-000832-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 00:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab3AHXgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 18:36:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab3AHXgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 18:36:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6096DA981;
	Tue,  8 Jan 2013 18:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOAmluv4vgjedFHQ27Xgm13GbAc=; b=B+8sjr
	O9HAB6j053jJe19/rRkapTirq3QOG1MW6/HW0n3+Y6aQh/xEnthGXkFEZnexuPAy
	29S9my/viqX9LsvbOEJ6bEOmPf/9lKMOEYl1k4At91MQXILtIxIu9BsGGdDFwEFU
	Qxouc7X+7oyJbrHOZ5yNtkjHbnuYo5JuTkMdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYqnyxsOrUj1xrwaF+FYUl8Wuh80e7FY
	SPe7Ebt0qIic9yvoRyH99ph2F95PQQSRuiub5qWPon/Wj/BYRalMOKBIMj2Pm41k
	34Y6Qu8vtwr7UUp+FBo2i7G8BnBJR6KA3YW35oDV/4JCUBPN7wN4HWUnbG7ZSi1i
	6A2UrsDLsIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55AB8A980;
	Tue,  8 Jan 2013 18:36:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB334A97C; Tue,  8 Jan 2013
 18:36:10 -0500 (EST)
In-Reply-To: <50ECAAE2.2020507@ubuntu.com> (Phillip Susi's message of "Tue,
 08 Jan 2013 18:25:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EDA48F2-59EC-11E2-97E4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213016>

Phillip Susi <psusi@ubuntu.com> writes:

> On 01/08/2013 05:42 PM, Junio C Hamano wrote:
>> It is very easy to miss misidentification of scissors line; as a 
>> dangerous, potentially information losing option, I do not think
>> it should be on by default.
>
> I suppose if it only requires one instance of >8 or <8 and one -, it
> might be *slightly* dangerous, but if it required a slightly longer
> minimum line length, it would be pretty darn unlikely to get triggered
> by accident, and of course, is easily disabled.

"Easily disabled" is never a good enough reason to change the long
established default of not doing anything funky unless the user
explicitly asks it to do things differently.

You could introduce a new configuration variable "am.scissors" and
personally turn it on, though.  Setting that variable *does* count
as the user explicitly asking for it.

> I often see patches being tweaked in response to feedback and
> resubmitted, usually with a description of what has changed since the
> previous version.  Such descriptions don't need to be in the change
> log when it is finally applied and seem a perfect use of scissors.

Putting such small logs under "---" line is the accepted practice.
