From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Wed, 30 Dec 2009 00:45:59 -0800
Message-ID: <7vd41w4zp4.fsf@alter.siamese.dyndns.org>
References: <4B0F8825.3040107@viscovery.net>
 <20091127082624.GA19875@glandium.org> <4B0F92E7.8090403@viscovery.net>
 <20091127085802.GA21217@glandium.org>
 <7v7htbom95.fsf@alter.siamese.dyndns.org>
 <20091230080002.GA31088@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPuEM-0003g6-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbZL3IqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZL3IqK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:46:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbZL3IqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:46:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 574BB8CDE3;
	Wed, 30 Dec 2009 03:46:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4bFbcu+1xhLge8Jyf/y5pVR4s4=; b=yXGSCL
	7CPNcAwRKpytC6VPRF+jbSb3jiqsyaDGm+hoSJRFZITWyx+Nby4u95X8NzcGz7G4
	LtDmw1zLpzNrFsBiTkIoXudrnqenx5WrwSJLnVkSAhXUBYpcw+9hk2/tv/yLDhzb
	0KXKn+fdgqPySFRnKl4r1SOBTc1WPNOGeKTM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9VuhrENIU9upX2nJJv+OMHenP1tzkeh
	SIl1EQjOknUdSbNisKw4PYVcBDkbxJoruPtMwyh5hZbmfkW56yxANZ1v28sbivV8
	ViJXAzq5VZj+51dS1GZ5Q+7VRs0jVt9IewKnNO+EhJB9ij2xNRl98Bz/2UKb8nWz
	XzX77MLK4F0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C1978CDE2;
	Wed, 30 Dec 2009 03:46:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3489A8CDE1; Wed, 30 Dec
 2009 03:46:00 -0500 (EST)
In-Reply-To: <20091230080002.GA31088@glandium.org> (Mike Hommey's message of
 "Wed\, 30 Dec 2009 09\:00\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C41B7BD2-F51F-11DE-B63B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135872>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Nov 27, 2009 at 10:28:38AM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> ...
>> > Then it's fine. But shouldn't that be noted somewhere, like in the
>> > INSTALL file ?
>> 
>> Surely.  Please make it so.
>
> I had another idea in the interim. If GNU make is necessary, why not
> make the Makefile an explicit GNU make only Makefile, by renaming it
> GNUmakefile ?
>
> That wouldn't remove the need to add a note in the INSTALL file, though.

I think you answered the question yourself.

Personally, when I am dealing with other people's projects, I dislike ones
that do not name their own Makefile "Makefile", as I traditionally have
done my local customization by having a higher precedence Makefile
("makefile" in the old world order, or "GNUmakefile" for gmake) that sets
things up and then call into upstream "Makefile".  For this project, since
I am the upstream, I do want to keep the file named "Makefile".
