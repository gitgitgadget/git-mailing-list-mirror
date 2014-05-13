From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bash prompt "namespace" issue
Date: Tue, 13 May 2014 11:52:21 -0700
Message-ID: <xmqqoaz1o6je.fsf@gitster.dls.corp.google.com>
References: <20140513081849.5dql886xw080ww88@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: szeder@ira.uka.de
X-From: git-owner@vger.kernel.org Tue May 13 20:52:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHol-0003Sa-09
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaEMSwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:52:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64329 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbaEMSwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:52:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1881617F81;
	Tue, 13 May 2014 14:52:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SVPpJlHpqUv0U7hS1u0xW4yqnYU=; b=iUDszw
	70dzCBhwHnBXty1SgXt1WCXadLjhkA0/ch6jftZXyBK4iRMWEaxyLZK7dSQDzVXw
	BcIZ/Uce+dR/FZne3kKpp3xFD5crgB6J4u67oeZ6jqA9xwdr5TbIxDPsbOiWxeYc
	zwesuSMb0dCMHykojYvMtHI+k1LhUFTOyEhnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c8+ImmQ67kcSNbQtQvi3Tp7eF0r4vTzV
	oLgjAK905LdJQwHgypWWWGtQseloWQjJVgmtTGGbmGMOsN3VGB8N+nPny8AMHB5q
	btw4gfQS30F6KxGQ9VtE6ZJAlWEyNf8QnHymEbM+EMoxQsR8UtKcbb5YRIvM0d9L
	rOxHts9JUzY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AED417F80;
	Tue, 13 May 2014 14:52:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD7D917F61;
	Tue, 13 May 2014 14:52:22 -0400 (EDT)
In-Reply-To: <20140513081849.5dql886xw080ww88@webmail.informatik.kit.edu>
	(szeder@ira.uka.de's message of "Tue, 13 May 2014 08:18:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B7D54818-DACF-11E3-AE25-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248804>

szeder@ira.uka.de writes:

> Commit 59d3924fb (prompt: fix missing file errors in zsh) added the  
> helper function eread() to git-prompt.sh.  That function should be in  
> the git "namespace", i.e. prefixed with __git_, otherwise it might  
> collide with a function of the same name in the user's environment.
>
> It's already in master and I don't have the means to send a patch  
> fixing this ATM, sorry.

Thanks.  I think the patch Felipe posted to rename it to __git_eread
is a reasonable regression fix, so I'll queue it on top of the
problematic commit 59d3924f (prompt: fix missing file errors in zsh,
2014-04-11) and merge the result to 'master'.
