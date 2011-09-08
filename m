From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase fails with: Patch does not have a valid e-mail
 address.
Date: Thu, 08 Sep 2011 10:15:52 -0700
Message-ID: <7v7h5jx8dz.fsf@alter.siamese.dyndns.org>
References: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:11:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nlD-0003FO-I3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab1IHXLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:11:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab1IHXLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:11:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 073AA4415;
	Thu,  8 Sep 2011 13:15:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k0Q9Rk8Ef1ACWQFL5MgLwLZT8VE=; b=EEEaZ2
	djfMXXM4+eT1ca+CCf0qDJVT38Z3bUnAiAmVDUPk/W5T/ApBfg5hjUBBmjBMEmse
	gg3WsnVxw+w8G3CYpcznbM+j+8zIzfG5Gs5A4RZF8LGu465exNjlLP5DQgDoXGO7
	SjX/u8rpsx/7pDE+To5PSjob3uGrSKNtSwhno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kc+A1zG9iHhdzn1G5jAWPp0Hj+oVIgPS
	MQeRhNVcLxdsToVn7KOqQlXHQn44L3Q0YvKVEJ+dg0xfLdnO7A7XBDPTis8Xg5pZ
	v31o2oU095oKRQeShIqsQo0wZ/aOxCen03+uSNH5b/8/P7SnsA688v/Hh0GzXvjS
	rMIKhwUKc5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38474414;
	Thu,  8 Sep 2011 13:15:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 877544413; Thu,  8 Sep 2011
 13:15:53 -0400 (EDT)
In-Reply-To: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com> (James
 Blackburn's message of "Thu, 8 Sep 2011 12:47:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35265E28-DA3E-11E0-A7C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180999>

James Blackburn <jamesblackburn@gmail.com> writes:

> I'm trying to rewrite some history and git's telling me:
>
> -bash:jamesb:lc-cam-025:33079> git rebase
> 7f58969b933745d4cb9bb128bbd3fa8d441cdb92
> First, rewinding head to replay your work on top of it...
> Patch does not have a valid e-mail address.
>
> Now it's true there isn't an email address for the author - the author
> no longer works for the company, and the email address was removed
> during the conversion.  Therefore the repo contains "Author <>".
>
> Given git doesn't ordinarily complain about this, should this prevent
> rebase from working?

Perhaps you used "filter-branch" for conversion and your "doesn't
ordinarily complain about this" refers to it? If so, I have to say that it
is filter-branch that needs to be fixed to error out.
