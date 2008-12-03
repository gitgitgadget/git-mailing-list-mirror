From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Tue, 02 Dec 2008 23:54:39 -0800
Message-ID: <7vej0pheww.fsf@gitster.siamese.dyndns.org>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 08:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7mab-00053E-Km
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 08:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbYLCHyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 02:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYLCHyq
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 02:54:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbYLCHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 02:54:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E4BBD18007;
	Wed,  3 Dec 2008 02:54:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC83C17FDD; Wed, 
 3 Dec 2008 02:54:41 -0500 (EST)
In-Reply-To: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com> (Tuncer
 Ayaz's message of "Wed, 3 Dec 2008 05:06:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A645CD96-C10F-11DD-860E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102222>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> This is needed on top of the fetch/pull -q/-v changes
> to make
> $ git pull --rebase -q
> as quiet as expected.

I am not sure if this is worth it, in the sense that it is not really
quiet enough (iow, it is not what I expect even though you claim "as
expected" here), and in another sense that making it really quiet may not
be what we want anyway.

How are you dealing with messages from the actual replaying of each local
commit on top of what is fetched?  In order to be able to tell where you
are when one of them fail in conflicts, you cannot stay silent while doing
so.
