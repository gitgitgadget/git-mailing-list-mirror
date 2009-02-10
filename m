From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix contrib/hooks/post-receive-email for new branch with
 no new commits
Date: Tue, 10 Feb 2009 08:30:57 -0800
Message-ID: <7vbptantj2.fsf@gitster.siamese.dyndns.org>
References: <1234273695-4981-1-git-send-email-pknotz@sandia.gov>
 <m3ab8uuwfg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Pat Notz" <pknotz@sandia.gov>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvXI-0001QL-1y
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZBJQbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbZBJQbI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:31:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbZBJQbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:31:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6098D2AD8C;
	Tue, 10 Feb 2009 11:31:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A92D92AD8A; Tue,
 10 Feb 2009 11:30:59 -0500 (EST)
In-Reply-To: <m3ab8uuwfg.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 10 Feb 2009 07:46:31 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 355FB18E-F790-11DD-8AD8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109266>

Jakub Narebski <jnareb@gmail.com> writes:

> +	this_branch=$refname
> +	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
> +               grep -v $this_branch)

This is still not quite right.  grep -F -v "$this_branch" perhaps?
