From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Tue, 10 Nov 2009 20:42:35 -0800
Message-ID: <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net> <20091111040715.GA44672@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, paulus@samba.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 17:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8G2f-0005JN-1Q
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113AbZKKQ1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbZKKQ1W
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:27:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZKKQ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 11:27:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A16D59A4EF;
	Wed, 11 Nov 2009 11:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+559NSMKX/Alx3bXh/aH9ia0kQ=; b=fAfpzx
	Hze8HvLwXujg6tZzIyAk9XLSaSMPgEPR7NBS0rv/EFoLLmEjsGmQkqjs+/PhR4e+
	njboMjoTetgDeAvIE7HObeNKowbWLroJPiNRGm6GMcRigYOVr8pCmr+R7S0XeUIW
	8zkIROhkqsKMqeUo+HT37bF5Vouo3tmQwZQeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbmtOlISnbIyBfKU3z3OVflWVrw6aaCc
	N5d3Y6tKObNGApT0Hse2ZfDO+PTb8F83Qo/DGIWW/30X248nTMjfhulb4A4TFlsj
	1BQ8Imq3NCWmlMwG1yx4Ow8OG5/bu8vXzBzNqER5/X4oU0LaQ609rFgc2uUJDP1z
	CiCQOwS3eJY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6373C9A4DC;
	Wed, 11 Nov 2009 11:27:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 760FA9BF04; Tue, 10 Nov 2009
 23:42:37 -0500 (EST)
In-Reply-To: <20091111040715.GA44672@gmail.com> (David Aguilar's message of
 "Tue\, 10 Nov 2009 20\:07\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 176AE208-CEDF-11DE-9DDE-B888BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132669>

David Aguilar <davvid@gmail.com> writes:

> That said, if there's a consensus that the path doesn't matter
> much than we could change the behavior.  I was just trying to be
> careful.

If we are not honoring GITK_TMPDIR and suddenly start paying attention to
it, that already is a change in behaviour.  Why is it better than paying
attention to TMPDIR?

But why does gitk, which is primarily a read-only history browsing tool
(yes, I know it can do "checkout" and stuff), needs to write anything to
anywhere in the first place?
