From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7501: always use test_cmp instead of diff
Date: Tue, 09 Sep 2008 17:02:09 -0700
Message-ID: <7vljy03m2m.fsf@gitster.siamese.dyndns.org>
References: <1221003666-17115-1-git-send-email-vmiklos@frugalware.org>
 <20080909235414.GA4768@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdDB6-000315-Jr
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 02:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYIJACS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYIJACS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 20:02:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYIJACR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 20:02:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD1545C91A;
	Tue,  9 Sep 2008 20:02:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C43B5C919; Tue,  9 Sep 2008 20:02:12 -0400 (EDT)
In-Reply-To: <20080909235414.GA4768@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Sep 2008 19:54:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BACA6C9E-7ECB-11DD-89E6-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95470>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 10, 2008 at 01:41:06AM +0200, Miklos Vajna wrote:
>
>>  test_expect_success \
>>      'validate git-rev-list output.' \
>> -    'diff current expected'
>> +    'test_cmp current expected'
>
> We seem to use the convention of
>
>   test_cmp <expected> <actual>
>
> elsewhere, rather than
>
>   test_cmp <actual> <expected>
>
> as you have here.  Most noticeably, that means the diff will show
> deviations from expected, rather "what should be done to make this as
> expected".

Yes, please.  I am glad to see somebody noticed it (I've been fixing these
whenever I touched vicinity of the ones that had comparisons swapped).
