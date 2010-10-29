From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: create a config setting for reject control.
Date: Fri, 29 Oct 2010 09:20:49 -0700
Message-ID: <7vlj5h6kda.fsf@alter.siamese.dyndns.org>
References: <1288315650-2488-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 18:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBrhO-0003zg-RU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 18:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab0J2QU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 12:20:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0J2QU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 12:20:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B03916BA;
	Fri, 29 Oct 2010 12:20:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hX4hDFFYLzrQHj2+Z8xjt2NxJmU=; b=jlUXEZ
	RZmU7b1A91WRAy2eyq3gL/UZzbo8wsX6TC0OS5f8yq0YJIYDIe6+I3atXb7G33bf
	2FcVAWSSfpnaLBZgM8p0Civ3XpHYRsH9iMXDXX8AI3jh0rqrKexM1YUvE2+fCTSH
	VDwuA9YwIVgkbUNUkNi5L2TpYIEvBZtf2NQpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pL7f7aBDsXumwFsQPu3azGQJ9LELvwuS
	dpk+IP+UHbxq+1GpeJYhS6YiEvsryl2Y3fxiw4aU7F5lroAi1dRJWZp28Dz1HZwp
	xrFMbEKd0P510ldr/bzyAmuto11sLpbHOKZ22YEayli3iiwuX0RS4wCpLVq8AtTJ
	AtlcmusSiqw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65D9E16B9;
	Fri, 29 Oct 2010 12:20:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD76916B8; Fri, 29 Oct
 2010 12:20:50 -0400 (EDT)
In-Reply-To: <1288315650-2488-1-git-send-email-paul.gortmaker@windriver.com>
 (Paul Gortmaker's message of "Thu\, 28 Oct 2010 21\:27\:30 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 806186F0-E378-11DF-9354-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160338>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> git am already accepts a "--reject" switch, which basically means
> apply the bits you can, but you can't set it as enabled by default
> currently.

Does this work correctly with all four combinations of (have/do not have)
config, (have/do not have) command line option, when "am" stops in the
middle due to conflict and you say "git am --continue" after dealing with
the first such conflict?  The first choice needs to be remembered and
used.
