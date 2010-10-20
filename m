From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Wed, 20 Oct 2010 16:43:53 -0700
Message-ID: <7vy69stop2.fsf@alter.siamese.dyndns.org>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
 <87hbgh7paf.fsf@fox.patthoyts.tk>
 <AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
 <87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 01:44:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8iKJ-0005uk-2X
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 01:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab0JTXoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 19:44:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0JTXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 19:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED9A4E0E6C;
	Wed, 20 Oct 2010 19:44:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Y3tc+4MCpPEVDo/72sqTZDJcb4=; b=SkdGBA
	5d4dnlMzAdn4PayarN6q6tFntYOjdwdQuTBtsvha2aP9L5N0PL2VhSD38mhESFoK
	4dAsKuvwZjuhHEuiq2tLbNu6ZPNKdTnw3ur7lgHCLCvMcLJgEVPedvcO1NzpQLf4
	apRiqJ85x+pThVWh5oKjvZmlkPKSsrDrcb0Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKD/jbfYO4hMhf65VUoq/hDZ94ld/TR/
	x5ej9OpCovmiRVmvREuJksjCPFTrwC+hn5DW7jsWnwxI+dLiLSkLbl0xQaR2Orz3
	WF7jNDMw9lOca6xfjOY/R5M4qZBhW30PvecGEKpItEKwsYV6U+shj3ymBIF2yZMH
	jAp4ms2Pox0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB99E0E6B;
	Wed, 20 Oct 2010 19:43:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC36AE0E6A; Wed, 20 Oct
 2010 19:43:54 -0400 (EDT)
In-Reply-To: <87pqv4fqqz.fsf_-_@fox.patthoyts.tk> (Pat Thoyts's message of
 "Wed\, 20 Oct 2010 23\:05\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8B068F6-DCA3-11DF-849A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159452>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> This is a rather more complete implementation of whitespace highlighting
> according to the core.whitespace setting. The diff view whitespace
> highlights should match what you see with 'git diff' when color is
> enabled for all the whitespace rules except cr-at-eol where there is
> currently a rule to hide these.
>
> Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---

This might be a very stupid question, but isn't it an easier-to-maintain
option to let underlying "git diff" color its output and convert the ANSI
coloring to whatever Tcl wants to use, especially in the long run, instead
of trying to replicate the logic to check whitespace breakages here?
