From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Puzzled by a t9500 test failure
Date: Mon, 13 Oct 2008 17:13:24 -0700
Message-ID: <7vhc7g8257.fsf@gitster.siamese.dyndns.org>
References: <7vljws83nd.fsf@gitster.siamese.dyndns.org>
 <20081013234851.GY4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 02:14:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpXYh-00084D-VY
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 02:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810AbYJNANc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 20:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757933AbYJNANb
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 20:13:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635AbYJNANb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 20:13:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E2AF78AE86;
	Mon, 13 Oct 2008 20:13:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E75978AE81; Mon, 13 Oct 2008 20:13:26 -0400 (EDT)
In-Reply-To: <20081013234851.GY4856@spearce.org> (Shawn O. Pearce's message
 of "Mon, 13 Oct 2008 16:48:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE075814-9984-11DD-A0C4-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98167>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> With recent tip of 'master':
>> 
>>     $ make
>>     $ mkdir t/trash
>>     $ cd t && sh t9500-*.sh -i
>> 
>> fails at the very first test.  Can anybody figure out why?
>
> Hmmph.  Near as I can tell its because gitweb.log has this in it:
>
> $ cat gitweb.log
> [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in scalar chomp at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 1811.
> [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in addition (+) at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 3772.
> HASH..
>
> The test does a grep for '[[]' and if it matches, fails.  I'm not
> sure why this started showing up now.  Obviously I merged something
> that failed the test suite, but I was pretty sure I had run the full
> set before publishing anything.

Nothing as far as I can tell changed while you were the pumpking.

I was just wondering why the presense of that extra, should-be-unused,
t/trash directory affects the outcome of the test.
