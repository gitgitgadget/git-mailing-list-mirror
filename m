From: Junio C Hamano <gitster@pobox.com>
Subject: Re: list of files that have been added/removed
Date: Wed, 15 Apr 2009 14:43:54 -0700
Message-ID: <7vvdp5r3s5.fsf@gitster.siamese.dyndns.org>
References: <31043.1239831470@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 23:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuCvE-0001hg-RU
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 23:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbZDOVoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZDOVoD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 17:44:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbZDOVoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 17:44:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DAE3BF182;
	Wed, 15 Apr 2009 17:43:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 521A0F181; Wed,
 15 Apr 2009 17:43:56 -0400 (EDT)
In-Reply-To: <31043.1239831470@relay.known.net> (layer@known.net's message of
 "Wed, 15 Apr 2009 14:37:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86E26A8A-2A06-11DE-B57A-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116653>

layer <layer@known.net> writes:

>   I see the changes in the index with "git status" as "deleted" or
>   "added".  
>
> I meant "new file" here.  Of course I can process the output of "git
> status", but I was looking for a cleaner method, if there is one.

"Process" as in "Read in a script and have it act on the information"?

git diff-index --name-status HEAD

would be one Kosher way for the scripts, and if your scripting language
can handle NUL terminated string, giving -z option would make your script
more robust against funny pathnames.

git diff-index --name-only --diff-filter=A HEAD

if you only care about "new file" and nothing else.
