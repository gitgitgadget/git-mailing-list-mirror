From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of
 Pthreads API
Date: Wed, 04 Nov 2009 15:58:27 -0800
Message-ID: <7viqdpg7vg.fsf@alter.siamese.dyndns.org>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5pkT-0000S8-PO
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbZKDX6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbZKDX6f
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:58:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032AbZKDX6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:58:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F731737CD;
	Wed,  4 Nov 2009 18:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=z3mzoP+VqfMhfQUHl+DLAvzyLjY=; b=a2OoANDolptvcOYk4t2MVN4
	9XW9SDw8iK6TZbjH95+kCISADAFiJ3MGfwpKTLOtAeen3P2deRJIP4/cIpdrMZON
	QH9AgmhXYaFyDaWNaBVXHZ7WyqLuA5KQC4x5FnDyLez1jHqwmT/k9jyp4Rlw4Z+n
	xUAUDMhxWeuzWrLwEP9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DxZ89+GPHqVa9uqo36HtA/5No1QYKLr4mp7GuJ/TNGPrP2MW8
	iJ6b8sNn6mfARW07svC7skGYYsUP2GqypvJfn1wCXEculbnHgzGCdkIyda6/y0xj
	kZ5HFwQtC33TmDhnPc06bRizo0DbhP3WftyiGSq6SHr3KBxuZiB6gVPEs0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 081CC737CB;
	Wed,  4 Nov 2009 18:58:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A69E737CA; Wed,  4 Nov
 2009 18:58:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F67BB8E2-C99D-11DE-9152-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132176>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:
>
>> +	NO_STATIC_PTHREADS_INIT = YesPlease
>
> Let's not go that route please.  If Windows can't get away without 
> runtime initializations then let's use them on all platforms.  There is 
> no gain in exploding the code path combinations here wrt testing 
> coverage.

Hear hear.
