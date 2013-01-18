From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 19:35:01 +0000
Message-ID: <20130118193501.GE31172@serenity.lan>
References: <20130118180639.GD31172@serenity.lan>
 <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHj1-0007Ct-ON
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab3ARTfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:35:17 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42627 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3ARTfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:35:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 07E1022F0A;
	Fri, 18 Jan 2013 19:35:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXTG4jYBxCDy; Fri, 18 Jan 2013 19:35:14 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 604AB22F4E;
	Fri, 18 Jan 2013 19:35:13 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 272D3161E577;
	Fri, 18 Jan 2013 19:35:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urMRaZUrfbNj; Fri, 18 Jan 2013 19:35:13 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 862A7161E575;
	Fri, 18 Jan 2013 19:35:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213931>

On Fri, Jan 18, 2013 at 11:04:15AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 69f7e9b..baf3b41 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -179,6 +179,22 @@ For C programs:
>>   - Use Git's gettext wrappers to make the user interface
>>     translatable. See "Marking strings for translation" in po/README.
>>  
>> +For Python scripts:
>> +
>> + - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
>> +
>> + - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
>> +
>> + - Where required libraries do not restrict us to Python 2, we try to
>> +   also be compatible with Python 3.  In this case we use
>> +   `from __future__ import unicode_literals` if we need to differentiate
>> +   Unicode string literals, rather than prefixing Unicode strings with
>> +   'u' since the latter is not supported in Python versions 3.0 - 3.2.
> 
> "In this case"?  In what case?  This document will stay effective
> long after you settle one particular backward incompatibility Python
> 3 introduced, namely, the unicode literal issues.  It is just one
> "example".

I meant "in the case where you are supporting Python 3" but I suspect it
would be better to move the unicode_literals sentence to a new bullet.
Or maybe we should just remove it - I haven't seen a case in the current
Git source where we need Unicode literals.

> That example somehow tells me that early versions of Python 3.x
> series may be too buggy and not worth worrying about, and we may
> want to set a floor for Python 3.x series, too, with something
> like:
[snip]
> I am not actively advocating to disqualify early 3.x; I am just
> suggesting that doing so may be a viable escape hatch for us that
> does not harm real users.  If you and others who know Python better
> think there isn't any problem that makes it too cumbersome to
> support both late 2.x and 3.0/3.1, there is no reason to set the
> floor at 3.2.
> 
> I just have this feeling that we might be better off treating them
> as 0.x releases of a new software called Python3, that happens to be
> similar to the Python we know.

I originally thought about putting a floor of 3.3 (which is where
Unicode literals were reintroduced) but that was only released in
September and as far as I'm aware Unicode literals are the only reason
to have a restriction on Python 3 versions, given that we support Python
2.6 - standard library features should be equivalent.

I don't think Python 3.0 is any less stable than any other 3.x release,
it's just that it was the first release which attempted a clean break
from backwards compatibility.  From the point of view of features
supported, Python 2.6 and 3.0 should be roughly equivalent - they were
released together with the intent that 2.6 should make it possible to
write code that ports to 3.0 easily, using 2to3.

As more people have started trying to support Python 3 in the wild, it
has become clear that it is often easier to have a single codebase that
works with both Python 2 and Python 3, and not use 2to3.

It is for this reason that the Unicode literal prefix was reintroduced.
From the specification reintroducing it [1]:

   Complaint: Python 3 shouldn't be made worse just to support porting
   from Python 2

   This is indeed one of the key design principles of Python 3. However,
   one of the key design principles of Python as a whole is that
   "practicality beats purity".


[1] http://www.python.org/dev/peps/pep-0414/#complaint-python-3-shouldn-t-be-made-worse-just-to-support-porting-from-python-2


John
