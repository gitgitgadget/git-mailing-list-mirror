From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when not
 running verbosely
Date: Fri, 29 Feb 2008 15:15:32 -0800
Message-ID: <7vfxvbbbhn.fsf@gitster.siamese.dyndns.org>
References: <1204323805-23185-1-git-send-email-mh@glandium.org>
 <20080229225331.GA8440@coredump.intra.peff.net>
 <20080229225816.GA24892@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:16:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVESo-0006Kt-Gd
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbYB2XPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbYB2XPu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:15:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbYB2XPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:15:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CDD03210;
	Fri, 29 Feb 2008 18:15:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7479D320B; Fri, 29 Feb 2008 18:15:40 -0500 (EST)
In-Reply-To: <20080229225816.GA24892@glandium.org> (Mike Hommey's message of
 "Fri, 29 Feb 2008 23:58:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75588>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Feb 29, 2008 at 05:53:31PM -0500, Jeff King wrote:
>> On Fri, Feb 29, 2008 at 11:23:25PM +0100, Mike Hommey wrote:
>> 
>> >  test_expect_success "virtual trees were processed" "git diff expect out"
>> >  
>> > -git reset --hard
>> > +git reset --hard >&3 2>&4
>> >  test_expect_success 'refuse to merge binary files' '
>> >  	printf "\0" > binary-file &&
>> >  	git add binary-file &&
>> 
>> Should this perhaps just be:
>> 
>>   test_expect_success 'reset state' 'git reset --hard'
>
> Is it really about testing git reset ?

No, it is about setting the stage to perform the test in
question, so it belongs inside.
