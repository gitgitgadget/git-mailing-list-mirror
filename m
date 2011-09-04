From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git push --quiet fails with older versions
Date: Sun, 04 Sep 2011 12:02:48 -0700
Message-ID: <7vty8syvtz.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>
To: Tobias Ulmer <tobiasu@tmux.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 21:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0HyT-0005RS-Si
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab1IDTDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 15:03:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab1IDTCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:02:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99685308D;
	Sun,  4 Sep 2011 15:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UEdVmtClv681YHVdnVBnCIyF44E=; b=I5elWX
	aoTiy7DjGPIW19f+46EAqAaGWhzycndeK92DN9HfETqI5NcnmztdSGkNmRVKClgG
	CI9JolbmaxPnA/ESlSRBRoCAuVGWXmIGysn3/nVqzdfXK94+3oewkMWyB2YIIDq3
	nIRkLMsJvMXt/m6Q3O1QKN41dboPERl3MHIic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/zQF4zc3YPOnTF75Gt4jEwF6+qYXDaM
	JapjN6x8FEx2Jgkx5H9gAiqwvhyyQtCIWK8aI4v4JpsLpAKYVuEnEKZmWG7FCnWj
	SWdqMNvYQyKX9H1ekW9sOGEL1UoiPBb1FBTDL1bEw2fLwJRoxtb7+ySRj/7+agnD
	lEu7mQo3Jiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911FF308C;
	Sun,  4 Sep 2011 15:02:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EB57308B; Sun,  4 Sep 2011
 15:02:50 -0400 (EDT)
In-Reply-To: <20110903105723.GA16304@tin.tmux.org> (Tobias Ulmer's message of
 "Sat, 3 Sep 2011 12:57:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C3A8A1E-D728-11E0-B551-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180694>

Tobias Ulmer <tobiasu@tmux.org> writes:

> my distro updated git to 1.7.6.1. Now git push --quiet, used in various
> scripts, blows up against 1.7.6.

This kind of regression is not acceptable not just for point maintenance
release, but for feature releases. 1.7.7 client must work with 1.7.6
server just fine without such a breakage. I should have been more careful
when reviewing.

Thanks for a report, Tobias, and thanks for a quick fix, Clemens.
