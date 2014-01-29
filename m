From: David Kastrup <dak@gnu.org>
Subject: Re: C standard compliance?
Date: Wed, 29 Jan 2014 21:52:45 +0100
Message-ID: <87eh3q5x42.fsf@fencepost.gnu.org>
References: <87iot25y0r.fsf@fencepost.gnu.org>
	<xmqqwqhiikpg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 21:53:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8c8d-0004Ip-F9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbaA2Uxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:53:30 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:54623 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaA2Uxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:53:30 -0500
Received: from localhost ([127.0.0.1]:53665 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W8c8X-0007zo-2t; Wed, 29 Jan 2014 15:53:29 -0500
Received: by lola (Postfix, from userid 1000)
	id 95298E06B7; Wed, 29 Jan 2014 21:52:45 +0100 (CET)
In-Reply-To: <xmqqwqhiikpg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jan 2014 12:42:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241226>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Hi, I am wondering if I may compare pointers with < that have been
>> created using different calls of malloc.
>>
>> The C standard does not allow this (inequalities are only allowed for
>> pointers into the same structure) to allow for some cheapskate sort of
>> comparison in segmented architectures.
>
> Hmm... if you were to implement a set of pointers in such a way that
> you can cheaply tell if an unknown pointer belongs to that set, you
> would use a hashtable, keyed with something that is derived from the
> value of the pointer casted to uintptr_t, I would think.

The types intptr_t and uintptr_t are optional in ISO/IEC 9899:1999
(C99).  So it would seem that I'd be covering fewer cases rather than
more in that manner.

I should think that architectures providing uintptr_t/intptr_t would
have very little incentive _not_ to offer pointer inequalities
equivalent to either the uintptr_t or intptr_t type conversion.

-- 
David Kastrup
