From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 15:38:48 -0700
Message-ID: <7vzle5ad8n.fsf@gitster.siamese.dyndns.org>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
 <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
 <20090424212856.GB14435@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxU4L-000749-Fd
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZDXWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbZDXWi4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:38:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbZDXWiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:38:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 03C631131E;
	Fri, 24 Apr 2009 18:38:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2791F1131D; Fri,
 24 Apr 2009 18:38:50 -0400 (EDT)
In-Reply-To: <20090424212856.GB14435@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 24 Apr 2009 17:28:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B13E4468-3120-11DE-87D3-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117505>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 24, 2009 at 04:49:34PM +0200, Michael J Gruber wrote:
>
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -76,7 +76,7 @@ If '--batch' is specified, output of the following form is printed for each
>>  object specified on stdin:
>>  
>>  ------------
>> -<sha1> SP <type> SP <size> LF
>> +<SHA-1> SP <type> SP <size> LF
>>  <contents> LF
>>  ------------
>
> Maybe it is just me, but I find the original for this one easier to
> read. Perhaps because <sha1> is really a variable name here (but for a
> human reader to interpret instead of a compiler), so I find the
> punctuation and capitalization distracting.
>
> I wonder if all <sha1> should simply be left as-is.

Or spell them using their official terminology "object name".

In all places in the documentation these two patches touch, that is what
matters.  They are computed by taking a hash over a defined format, and
the hash function we use happens to be SHA-1, but that is not important to
somebody who wants to use "cat-file" nor even to somebody who wants to
reimplement it.  I think hash-object should mention what the actual hash
function is, but even that should not stress the SHA-1-ness of the hash.
That's just too much implementation detail.

And sha1 and SHA1 are both accepted colloquial forms of "object name" in
the git world.  I think it is Ok to leave it in the IRC transcript "pack
heuristics" documentation (and I'd prefer that particular one left
untouched).  If we want to go formal in the documentation, I think
rewriting them to SHA-1 misses the point.
