From: Junio C Hamano <gitster@pobox.com>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 06 Mar 2009 00:58:33 -0800
Message-ID: <7vk573t4cm.fsf@gitster.siamese.dyndns.org>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
 <20090305104304.GA17760@coredump.intra.peff.net>
 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
 <20090305211120.GB20157@coredump.intra.peff.net>
 <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
 <20090306052318.GB3426@sigill.intra.peff.net>
 <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
 <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
 <7v1vtbw03h.fsf@gitster.siamese.dyndns.org>
 <76718490903060031u2bbc5c08k6a635dcdb1c8bc32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 10:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVud-0004vj-Lj
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 10:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZCFI6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZCFI6n
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:58:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZCFI6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:58:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 83F5D30D2;
	Fri,  6 Mar 2009 03:58:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B286730D1; Fri, 
 6 Mar 2009 03:58:34 -0500 (EST)
In-Reply-To: <76718490903060031u2bbc5c08k6a635dcdb1c8bc32@mail.gmail.com>
 (Jay Soffian's message of "Fri, 6 Mar 2009 03:31:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC4B0826-0A2C-11DE-94D4-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112408>

Jay Soffian <jaysoffian@gmail.com> writes:

> Yeah, that part is easy. I wasn't sure the best way to handle places
> where a constant date_mode is used e.g.:
>
> pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
> 		     encoding);

One approach that will be hated by libgit2 effort would be to keep the
date_mode an enum as before (sans DATE_LOCAL) and make the "tz_offset"
thing as a setting global to the process, defined in environ.c
