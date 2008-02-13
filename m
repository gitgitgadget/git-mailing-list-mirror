From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Tue, 12 Feb 2008 19:32:26 -0800
Message-ID: <7vy79py1it.fsf@gitster.siamese.dyndns.org>
References: <47B24D8A.5090703@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jmacd@cs.berkeley.edu
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Feb 13 04:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP8NF-0000xg-CJ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 04:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYBMDcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 22:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756567AbYBMDcq
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 22:32:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYBMDcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 22:32:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 798CB3B9C;
	Tue, 12 Feb 2008 22:32:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 5C8CE3B9A; Tue, 12 Feb 2008 22:32:28 -0500 (EST)
In-Reply-To: <47B24D8A.5090703@catalyst.net.nz> (Martin Langhoff's message of
 "Wed, 13 Feb 2008 14:53:14 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73740>

Martin Langhoff <martin@catalyst.net.nz> writes:

> So my question is what is a good format for the header? My thinking sofar:
>
>  - have a prefix to scan for, such as "xdelta" at the beginning of
>    the file, or after a newline/whitespace
>
>  - keep the <fromsha1> <tosha1> line
>
>  - \0 delimited filenames
>
>  - filenames as ambiguous bag'o'bytes or utf-8?
>    (should we have another flamewar on this? ;-) )
>
>  - keep file modes and perhaps support copy/move headers
>
>  - keep a/ b/ prefixes?
>
>  - last line in the header is length: <length-in-bytes>, followed by
>    a newline and the xdelta itself
>
>  - one or more newlines follow the end of the xdelta if there is another
>    header coming

I am lost as to your objective because you seem to be keeping a
whole LOT more than I would have imagined for a specialized
purpose file format.

If you want to reuse that much of git, maybe our binary patch
format is good enough for you?  We always produce two xdelta so
that we can apply in reverse, but it is Ok to add a one-way
option.
