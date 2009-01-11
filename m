From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack
 and git-receive-pack.
Date: Sun, 11 Jan 2009 02:21:35 -0800
Message-ID: <7v1vvata6o.fsf@gitster.siamese.dyndns.org>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
 <1231595452-27698-3-git-send-email-prohaska@zib.de>
 <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
 <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de>
 <7viqomx5iq.fsf@gitster.siamese.dyndns.org>
 <E976B246-AD14-4B03-B204-F6A1014071DF@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 11:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxTJ-0001jv-Nt
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbZAKKVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbZAKKVq
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:21:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZAKKVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:21:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A1E91C3D7;
	Sun, 11 Jan 2009 05:21:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2323E1C3D6; Sun,
 11 Jan 2009 05:21:36 -0500 (EST)
In-Reply-To: <E976B246-AD14-4B03-B204-F6A1014071DF@zib.de> (Steffen
 Prohaska's message of "Sun, 11 Jan 2009 11:04:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5048D54-DFC9-11DD-81EE-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105159>

Steffen Prohaska <prohaska@zib.de> writes:

>> Hmm, I actually was thinking about applying that (and that one only)
>> early
>> to my tree, to make sure it is regression-free.
>
> Does "early" mean that you want to wait and see how the discussion
> about the other patches evolves before you consider applying them,
> or does "and that one only" mean that you tend to not apply the
> other patches at all?

My initial impression after reading 1/6 was that no matter how the actual
runtime prefix detection logic that is implemented in the later parts of
the series for particular platform will turn out to be, the update to the
Makefile that is done by 1/6 won't have to change.  If I apply 1/6 first
without applying anything else, we can make sure that it would not regress
for Unix people (and catch regressions early if any), while Windows people
polish the platform specific parts of the implementation in the later
parts of the series that can be replaced.

Because changes to Makefile variables tend to have unexpected side effects
(people have their own definition to override them in their build
procedures and you can easily break them unless you are careful), I wanted
to make sure the common part is solid before waiting for the other part.

But if you think it is better not to apply any one, until other parts
mature, it is Ok by me, too.
