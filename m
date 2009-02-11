From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Wed, 11 Feb 2009 13:24:10 -0800
Message-ID: <7vab8sd5vp.fsf@gitster.siamese.dyndns.org>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <20090210110330.GB12089@coredump.intra.peff.net>
 <20090211085256.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tuncer Ayaz <tuncer.ayaz@gmail.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMaZ-0003Gy-89
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbZBKVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbZBKVYT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:24:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbZBKVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:24:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4435E2AEE8;
	Wed, 11 Feb 2009 16:24:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EAF02AEE7; Wed,
 11 Feb 2009 16:24:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 568EFDC2-F882-11DD-9EC8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109532>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Bug?   FWIW, the original patch from October shows:
>>
>>     M changed
>> M   M changed-again
>> M     changed-staged
>>     D deleted
>> D     deleted-staged
>>
>> (where changed-again has both staged changes and further changes in the
>> work tree).
>>
>> The gap between these two are to show the rename similarity index, which
>> we could do without.
>
> I have a question. Why do you have the gap for the rename similarity
> between the two but not between the second status and the filename?

There can be renames between the HEAD and the index, but by definition
there can never be renames between the index and the work tree, because
we do not use untracked files in the work tree for comparison, which means
there is no "new" files when comparing the index and the work tree.

For this reason, there is need for similarity indices for the second one.
