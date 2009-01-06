From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] unpack-trees: remove redundant path search in
 verify_absent
Date: Tue, 06 Jan 2009 00:19:00 -0800
Message-ID: <7viqoskft7.fsf@gitster.siamese.dyndns.org>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <1230843273-11056-3-git-send-email-drizzd@aon.at>
 <1230843273-11056-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7B0-0007rh-JE
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbZAFITG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZAFITF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbZAFITE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A1C38DE94;
	Tue,  6 Jan 2009 03:19:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA4748DE91; Tue,
  6 Jan 2009 03:19:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE3EE2DC-DBCA-11DD-B3D6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104658>

Clemens Buchacher <drizzd@aon.at> writes:

> Since the only caller, verify_absent, relies on the fact that o->pos
> points to the next index entry anyways, there is no need to recompute
> its position.

I suspect that the original reasoning of this behaviour might have been in
anticipation of other callers, but I agree with your reasoning especially
because I do not think of a good reason to want to receive the number of
entries to skip as the return value and not have o->pos pointing at the
right place.

Thanks, queued.
