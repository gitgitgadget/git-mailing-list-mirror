From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: send individual mails
 to recipients
Date: Wed, 12 Nov 2008 10:18:20 -0800
Message-ID: <7v3ahwq043.fsf@gitster.siamese.dyndns.org>
References: <E1L0ITB-00Bv9t-72@intern.SerNet.DE>
 <7vfxlwq1gn.fsf@gitster.siamese.dyndns.org>
 <E1L0Jyh-00Bzdi-7r@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Michael Adam <obnox@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KKI-0002Qj-31
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYKLSTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYKLSTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:19:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYKLSTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:19:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20A9D16868;
	Wed, 12 Nov 2008 13:19:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AB0C916838; Wed, 12 Nov 2008 13:18:22 -0500 (EST)
In-Reply-To: <E1L0Jyh-00Bzdi-7r@intern.SerNet.DE> (Michael Adam's message of
 "Wed, 12 Nov 2008 18:58:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65671FE8-B0E6-11DD-956B-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100798>

Michael Adam <obnox@samba.org> writes:

> Junio C Hamano wrote:
>> Michael Adam <obnox@samba.org> writes:
>> 
>> > This changes the behaviour of post-receive-email when a list of recipients
>> > (separated by commas) is specified as hooks.mailinglist. With this modification,
>> > an individual mail is sent out for each recipient entry in the list, instead
>> > of sending a single mail with all the recipients in the "To: " field.
>> 
>> Why can that be an improvement?
>
> My use case is that I have a repository where I want to send
> commit messages to an "official" mailing list and to a private
> recipient list that might not want to be seen on the official
> mailing list.

Ah.  What you want is a capability to add Bcc:, not a misfeature to run
the log formatter repeatedly wasting cycles only to generate the same
message contents.
