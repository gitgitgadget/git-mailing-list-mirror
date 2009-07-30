From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone ignores GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Thu, 30 Jul 2009 13:04:31 -0700
Message-ID: <7vab2maqeo.fsf@alter.siamese.dyndns.org>
References: <20090730175833.GV12813@osiris.978.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Ristuccia <brian@ristuccia.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 22:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWbro-0004xf-6M
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 22:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZG3UEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 16:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZG3UEg
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 16:04:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZG3UEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 16:04:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EBDF1A4E3;
	Thu, 30 Jul 2009 16:04:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 987661A4E1; Thu,
 30 Jul 2009 16:04:32 -0400 (EDT)
In-Reply-To: <20090730175833.GV12813@osiris.978.org> (Brian Ristuccia's
 message of "Thu\, 30 Jul 2009 13\:58\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34068936-7D44-11DE-8B45-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124481>

Brian Ristuccia <brian@ristuccia.com> writes:

> Is this behavior intentional for some good reason I've overlooked, or have I
> stumbled on a bug?

Most likely not a bug.

When you talk about "clone", you need to realize that there actually are
two repositories (and two object databases) involved: cloned source and
destination.

Which repository should GIT_ALTERNATE_OBJECT_DIRECTORIES affect?

If you are making a clone from a remote over the network, and if you
already have another local repository of a related project that has
necessary objects, you may want to look at

    "git clone --reference"
