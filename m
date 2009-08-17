From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-config: Parse config files leniently
Date: Mon, 17 Aug 2009 12:49:10 -0700
Message-ID: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
 <a812f567b4541ce55e9c60037a047488a0893c36.1250262273.git.git@drmicha.warpmail.net> <7veirejhqq.fsf@alter.siamese.dyndns.org> <4A89A5B8.9040405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Cx-0002f5-Eq
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbZHQTtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZHQTtX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:49:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbZHQTtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:49:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB67B2DEB5;
	Mon, 17 Aug 2009 15:49:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C66D2DEB4; Mon, 17 Aug 2009
 15:49:11 -0400 (EDT)
In-Reply-To: <4A89A5B8.9040405@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 17 Aug 2009 20\:47\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E72F656-8B67-11DE-90BF-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126263>

Michael J Gruber <git@drmicha.warpmail.net> writes:


> Junio C Hamano venit, vidit, dixit 14.08.2009 21:52:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> ...
>> But I may be being overly cautious.
>
> My first version had the lenient mode for "git config -e" only, which
> required a new global int (or, alternatively, changing all callers).

Without looking at the actual patch, that "single global that is only used
by builtin_config() when using -e" sounds safer.

But still I think I may be being overly cautious.

>> By the way, why did you have to change s/echo/printf/?  Can't you give two
>> lines in a single argument without "\n" escape?
>
> Because "printf" is more portable then "echo -e". At least I hope so ;)
> [ One could use a "here document", of course. Is that preferable? ]

What I meant was to give literally two lines, like this:

    check section.key 'warning: bad config file line 2 in .git/config
warning: bad config file line 2 in .git/config'

I do not see a need for a here-doc.

The rest is tangent you can ignore.

>>> Instead, issue a warning only and treat the rest of the line as a
>>> comment (ignore it). This benefits not only git config -e users.
>> 
>> ... a broken sentence in the middle?  I would have expected the "not only"
>> followed by "but also"; the question is "but also what?"
>
> I don't see any broken sentence here. "Benefit" is a verb as well as a noun.

Yes, and I think you read me correctly.

s/broken/chopped in the middle, missing 'but also X'/;

and you just explained that you meant "everyone else" by that X in the
missing part of the sentence.
