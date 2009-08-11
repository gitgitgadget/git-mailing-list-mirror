From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: parse arbitrary commit-ish in SHA1 field
Date: Mon, 10 Aug 2009 22:13:23 -0700
Message-ID: <7vtz0fndak.fsf@alter.siamese.dyndns.org>
References: <f7e6f82a33aa8496de81262d641953534089e980.1249742874.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGR-0000RC-7P
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZHKMGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbZHKMG3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:06:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZHKMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:06:28 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A97E6FF8;
	Tue, 11 Aug 2009 01:13:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8D2A6FF7; Tue, 11 Aug
 2009 01:13:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B46E7E68-8635-11DE-8C4C-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125523>

Thomas Rast <trast@student.ethz.ch> writes:

> +	} else {
> +	    if {[catch {set id [exec git rev-parse $sha1string]}]} {

"--verify", or "--no-flags --revs-only"?  Examples of possible bad input
strings that you may otherwise not catch are:

	master..
        --merge -- a
