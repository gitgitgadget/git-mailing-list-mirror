From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fw: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Wed, 29 Jul 2009 23:34:46 -0700
Message-ID: <7vy6q6k7ax.fsf@alter.siamese.dyndns.org>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
 <20090729161030.GA3848@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh ben Jore <jbenjore@whitepages.com>,
	"'git\@vger.kernel.org'" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jul 30 08:35:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWPEE-0001lz-UA
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 08:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZG3Gez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZG3Gez
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 02:34:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbZG3Gey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 02:34:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74F9016180;
	Thu, 30 Jul 2009 02:34:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA99E1617F; Thu, 30 Jul 2009
 02:34:48 -0400 (EDT)
In-Reply-To: <20090729161030.GA3848@localhost> (Clemens Buchacher's message
 of "Wed\, 29 Jul 2009 18\:10\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 170D284C-7CD3-11DE-BB66-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124444>

Clemens Buchacher <drizzd@aon.at> writes:

> Yeah, if process_entry leaves unmerged entries, write_tree_from_memory will
> return NULL. I can reproduce with the following script (same principle as
> t7405).

Your script does not seem to cause write_tree_from_memory() to be called
with an unmerged index while it tries to create a virtual commit.
