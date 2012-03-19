From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 17:36:16 -0700
Message-ID: <7vy5qxbf5r.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <20120317140030.GA27369@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:36:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9QaG-0003kn-IP
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 01:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150Ab2CSAgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 20:36:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009Ab2CSAgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 20:36:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E135F76D5;
	Sun, 18 Mar 2012 20:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HuQKLM+mxqbKklkMLWadD3X3IZI=; b=nFExZh
	rAixZMZDnTJEuHKqhODl0GZoGB7VAbaiW3h+s5I1/zS5wdnqoDfo/6uj8wt3pF6r
	RQgSSHoz5me6RFQ8t/9NquvIDTLRBRZQkMKo5+XGgJMf3k3ZxYLnmI7yYlYgmKNF
	30f6XtBwU+QIYeW37tZhpdY0WcvNjwn/nRPuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHuEikYP/ik3oMcxJfpYmtMhyllCiXaM
	ZMJXSUPsiP61fgKVwniD2r5xmWRhxlf4yWuiAM8oqP0Ofa5/fGZMgx+/MsfllhXW
	CJBRFRjT9g2ShQrt7akqpazgdboYNgDgBwqql7rQokptzeE6GanCJY8yfj9IYYnt
	tOPIq0GKUr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7C4B76D4;
	Sun, 18 Mar 2012 20:36:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9519576D2; Sun, 18 Mar 2012
 20:36:17 -0400 (EDT)
In-Reply-To: <20120317140030.GA27369@gnu.kitenet.net> (Joey Hess's message of
 "Sat, 17 Mar 2012 10:00:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A6D76F0-715B-11E1-B38B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193404>

Joey Hess <joey@kitenet.net> writes:

> ... I know this
> will be confusing, because with current git, users have to be instructed
> to push these branches *once*, to get the tracking set up.

Well, a tool like git-annex is not the primary audience to choose the
default behaviour for "git push" without configuration. Instead of
instructing "to push *once*", you can easily instruct to install
remote.$name.push that covers the primary and subsidiary branches.

Alternatively "git annex push" could drive the underlying "git push" in
whatever way it wishes. Notice a branch is being pushed, and then add its
subsidiary branch to the set of refs to be pushed (because it, not Git, is
the one who knows the correspondence between the primary branch and the
subsidiary branch).
