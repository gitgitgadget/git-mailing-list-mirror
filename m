From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Tue, 02 Sep 2008 17:44:55 -0700
Message-ID: <7v7i9udpmg.fsf@gitster.siamese.dyndns.org>
References: <20080901011259.GA31696@zakalwe.fi>
 <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
 <20080902115848.GA1252@jolt.modeemi.cs.tut.fi>
 <7vwshuglq1.fsf@gitster.siamese.dyndns.org>
 <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
 <20080903001254.GA12263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heikki Orsila <shd@modeemi.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KagVk-0006Cz-D9
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYICApG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYICApG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:45:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbYICApE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:45:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 904535BB08;
	Tue,  2 Sep 2008 20:45:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D607B5BB07; Tue,  2 Sep 2008 20:44:59 -0400 (EDT)
In-Reply-To: <20080903001254.GA12263@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 2 Sep 2008 20:12:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BCD5958-7951-11DD-B7AA-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94753>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 02, 2008 at 04:55:39PM -0700, Junio C Hamano wrote:
>
>> "filedirstat" is simply too long to type, and it has a certain "Huh?"
>> factor --- is it about file, or is it about directory?
>
> I had the same thought when I saw the original patch...
>
>> This option essentially is just the dirstat but with different logic to
>> compute how big the damage is.  Conceptually, the original one gives one
>> "damage point" to each added or deleted line.
>> 
>>         $ git show --dirstat=<one-point-per-line>
>
> ...and I thought of --dirstat-byfile. So maybe:
>
>   --dirstat=byfile
>
> and
>
>   --dirstat=byline
>
> defaulting to byline (or by-line if preferred).

As Heikki points out (and I missed this initially myself), --dirstat[=x]
already exists and it gives the cut-off-point.

Perhaps "--dirstat-by-file" that implies "--dirstat" (with the
understanding (and documentation) that "--dirstat" is a shorthand for
"--dirstat-by-line" that does not exist)?
