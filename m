From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Tue, 12 Aug 2008 11:33:22 -0700
Message-ID: <7vod3yqe19.fsf@gitster.siamese.dyndns.org>
References: <200808080148.27384.trast@student.ethz.ch>
 <200808081614.44422.trast@student.ethz.ch>
 <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <200808082037.49918.trast@student.ethz.ch>
 <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
 <20080812081851.GK32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyhX-000406-MH
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYHLSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYHLSdc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:33:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYHLSdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:33:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 861B056765;
	Tue, 12 Aug 2008 14:33:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5AC1856747; Tue, 12 Aug 2008 14:33:24 -0400 (EDT)
In-Reply-To: <20080812081851.GK32184@machine.or.cz> (Petr Baudis's message of
 "Tue, 12 Aug 2008 10:18:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A08CF6E-689D-11DD-B3B0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92129>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Aug 08, 2008 at 06:25:05PM -0700, Junio C Hamano wrote:
>> Perhaps --full-history is needed to the rev-list call (and the recent
>> invention --simplify-merges that will hopefully appear sometime after
>> 1.6.0)?  See recent discussion of --full-history and the default merge
>> simplification between Linus and Roman Zippel.  I suspect that back when
>> the original cg-rewritehistory was written, not many people understood the
>> issues explained in that thread.
>
> Just as a historical note, --subdirectory-filter was actually not part
> of cg-admin-rewritehist.

Ok, that sounds more plausible.  Recent addition whose wrinkles have not
been ironed out.
