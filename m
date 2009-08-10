From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git export
Date: Mon, 10 Aug 2009 09:54:24 -0700
Message-ID: <7vk51b38zj.fsf@alter.siamese.dyndns.org>
References: <200908101822.59940.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Mon Aug 10 18:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaY9E-0002TA-M7
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbZHJQyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZHJQyv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:54:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbZHJQyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:54:50 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D19A5089;
	Mon, 10 Aug 2009 12:54:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAF315084; Mon, 10 Aug
 2009 12:54:41 -0400 (EDT)
In-Reply-To: <200908101822.59940.thomas@koch.ro> (Thomas Koch's message of
 "Mon\, 10 Aug 2009 18\:22\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 838AA2B6-85CE-11DE-A31A-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125488>

Thomas Koch <thomas@koch.ro> writes:

> could you please provide a simple solution to save a tree object into an 
> arbitrary location?
> I found some hints, that it would be possible by missusing either git 
> checkout-index or git-archive, but I think that it shouldn't require that much 

If you are talking about a tree object, then git-archive is what you want.
It was invented almost for this exact purpose, but unlike "export" that
would only copy to a directory, you can get a tarball out of it when you
do not want to expand the result into a directory; it is more versatile
form.  The manual page for the command has an example (look for
"/var/tmp") so I won't repeat the cut-and-paste recipe here.

If you are not talking about a tree object but is talking about the
contents recorded in your index, checkout-index with the --prefix option
may be what you want.  The manual page for the command has an example
(look for "--prefix=git-export-dir/") so I won't repeat it here.
