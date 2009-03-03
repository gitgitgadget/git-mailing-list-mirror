From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-add and index
Date: Tue, 03 Mar 2009 00:00:52 -0800
Message-ID: <7vprgzf32j.fsf@gitster.siamese.dyndns.org>
References: <20090303072008.GB7478@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePa8-0001GO-26
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZCCIA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZCCIA7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:00:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbZCCIA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:00:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 094421268;
	Tue,  3 Mar 2009 03:00:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 641361267; Tue, 
 3 Mar 2009 03:00:54 -0500 (EST)
In-Reply-To: <20090303072008.GB7478@b2j> (bill lam's message of "Tue, 3 Mar
 2009 15:20:08 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D3DD998-07C9-11DE-8213-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112020>

bill lam <cbill.lam@gmail.com> writes:

> I have 2 questions related to index
> 1. Is it safe to just git-add (without commit) for local changes made
>    before checkout or switch to another branch?

As long as the other branch does not touch the same path, it should be kept
in the index during the branch switching.

"Is it safe" and "does it work like this" questions are easier to answer by
a bit of experimenting in a toy repository these days ;-).

> 2. How to checkout the changes as recorded in index from git-add that
>    not yet commit to the working tree?

"git checkout -- path"?  If you do not have a revision that can be referred
to as path (iow the file you are trying to check out of the index is not
e.g. "master"), you do not have to say -- and just "git checkout path"
should suffice.
