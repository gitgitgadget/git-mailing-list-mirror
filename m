From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 12:06:25 -0700
Message-ID: <7veheqi09a.fsf@alter.siamese.dyndns.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
 <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
 <7vip42jldt.fsf@alter.siamese.dyndns.org>
 <CAMP44s22KDoWVApwnVcGBH=EVDV+wnCQUAdEp=SRLQeb9E0J=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpUw-0006Gv-At
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764305Ab3DDTG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:06:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764270Ab3DDTG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:06:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1D213F4E;
	Thu,  4 Apr 2013 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SFS6/5zFgX/KeCeALYbpM0gsl6s=; b=GtLmZ6
	9nAbRD71OJ8vEjAHgJtadlTdOV5lLwcZ4IsBbAc0y62cmfLJL4MgfIRfusYOZPeD
	ZgvSg03FgNQfI/Z4vgsqaSRACVUg6iOJqhv54b4nigjPayTIo3RNTYhU04tknM4+
	yMfxbClPvUPeSQsnQ0FZMSK655BXdZkto/Yks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Md6APwx2Z/4X28OioF3CYdKXk2Dg7f6R
	psmqV8ov2h03Lly8uWHrGXb3/nYvJ0tvqjBvDQ0P1FTJ40X3b4bwNG/TykBTBsgU
	W8uSRDcL35KeQwn1FkhaOaSZ8p4fZndBzPllEFjQK0vP85Wj55KbMg3ajP3AHf9K
	/ywcI79IulI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C9F13F4D;
	Thu,  4 Apr 2013 19:06:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25BB913F4C; Thu,  4 Apr
 2013 19:06:27 +0000 (UTC)
In-Reply-To: <CAMP44s22KDoWVApwnVcGBH=EVDV+wnCQUAdEp=SRLQeb9E0J=g@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 4 Apr 2013 12:56:39 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C031799A-9D5A-11E2-9E5B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220072>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 4, 2013 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Ideally we shouldn't do this, as it's not recommended in mercurial
>>> documentation, but there's no other way to push multiple bookmarks (on
>>> the same branch), which would be the behavior most similar to git.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> In the previous round you wanted me to exclude this one to force
>> split head at the remote, and I saw you and Max Horn discussing
>> (rather, shouting at each other ;-) why it is needed/desirable.
>
> No, that was "don't update bookmarks unnecessarily", and it seems you
> skipped it appropriately.

OK.
