From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-add--interactive: remove hunk coalescing
Date: Thu, 03 Jul 2008 14:46:03 -0700
Message-ID: <7vwsk2y738.fsf@gitster.siamese.dyndns.org>
References: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
 <7vtzf77wjp.fsf@gitster.siamese.dyndns.org>
 <7vod5f7w3f.fsf@gitster.siamese.dyndns.org>
 <200807032124.22037.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWkD-00067I-N7
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbYGCVqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756384AbYGCVqT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:46:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbYGCVqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:46:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3173412206;
	Thu,  3 Jul 2008 17:46:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 83ED112205; Thu,  3 Jul 2008 17:46:10 -0400 (EDT)
In-Reply-To: <200807032124.22037.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu, 3 Jul 2008 21:24:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7563C81A-4949-11DD-8FBB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87325>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> 
>> > Blindly concatenating the above two and feeding them to "git apply" *may*
>> > happen to work by accident, not by design.  This very much feels like a
>> > hack of "This works most of the time for me, your mileage may vary" kind,
>> > which we would want to avoid when we can.
>> 
>> Well, I changed my mind.  Let's run with this and see what happens.
>
> In support of this being a feature of git-apply, notice that it even
> handles the situation correctly where the context of a hunk has been
> influenced by previous hunks, as in...

That's what meant by my earlier "application is hunk-by-hunk in nature"
and we are in agreement.  The fact it works that way is not quite by
design and close to being "by accident", but I do not foresee anybody
changing it in the near future, so...
