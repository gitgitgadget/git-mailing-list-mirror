From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/completion: remove parentheses from prompt
Date: Fri, 22 Apr 2011 15:32:27 -0700
Message-ID: <7vk4elnchw.fsf@alter.siamese.dyndns.org>
References: <20110422143248.1f4f84c0.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Kim Phillips <kim.phillips@freescale.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDOu3-0004lk-93
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab1DVWch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 18:32:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab1DVWcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 18:32:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1F38426B;
	Fri, 22 Apr 2011 18:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NHkvMXUbavu2+R41nFgBGu01e68=; b=HIi2RQLR2iA0NtDx4o4O
	LzDu9qxrzwSVV/vRQS30aOnS60w8yFhvbKslFjWtTu4ifzBimIwWWGMG1fflJsIX
	YeF8wAdX9pNTORotOKi9ewnRL7IL9AiEgVMJFjm5q0HSKOkN23ToeMkAmT/AxfhO
	2a4NQnrEP3a8EZWOEf4kUgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vzBIBxT58YcBx6frjoEZEbmMjXSNOEtfrMf8TNPxLIoTha
	/13UxXN/OaEfHRkfP/iXm7xxPxwF8oBt465js9ubiOsSvrijMkLyuJHv3TdZTot4
	otdn/LuVzUwHRTA6+RzKlhzcTjYB18/O+iDebPpWhZWBVR++OgmorMNuUd7Ak=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFE82426A;
	Fri, 22 Apr 2011 18:34:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D59984269; Fri, 22 Apr 2011
 18:34:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B22C5222-6D30-11E0-926B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171945>

Kim Phillips <kim.phillips@freescale.com> writes:

> Save horizontal terminal line real estate by removing parentheses from
> the prompt branch display.  The branch is already sufficiently visually
> delimited by the preceding space character.

That changes behaviour and makes people who like the current output
unhappy, no?  For example, I have

	PS1=': \h \W$(__git_ps1 "/%s"); '

and from it I get these output:

	: host git.git/master;
	: host git.git/(v1.7.5-rc3);
        : host git.git/(63e4ee5...);

I do like the fact that the tagname v1.7.5-rc3 is parenthesized---it makes
it very clear that I am not on any branch while being detached.

Of course that is _my_ personal taste, but I wonder if you can remove the
parentheses by changing the way you use __git_ps1 in your PS1 definition.
