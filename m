From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree --root
Date: Fri, 12 Sep 2014 10:31:30 -0700
Message-ID: <xmqq61gsbv9p.fsf@gitster.dls.corp.google.com>
References: <20140912130607.GX4075@isis.sigpipe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roman Neuhauser <neuhauser@sigpipe.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSUh7-00025A-BY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbaILRbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:31:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53838 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaILRbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 13:31:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A98237918;
	Fri, 12 Sep 2014 13:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kDraBv8Vt1IxpmNTdqy1mJwJpb0=; b=XGQdN3
	o4wJPHbGD9UMRFn9GQXWFJhkIuV+4flQx2acjDS4RPyTHXyfLveCzIV4nMr8sZ4A
	FZlWyiheZXPFr7tbfPC9U4jjALt2z2vMQIxhiR46GSPQaHgbL42oM2f2hMPjcUGg
	w2ArM2YLQxj0Z0Msgg0bqtcFaiWVcpCHegOow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmxAtaN6dK5CdOM8DbeJDADoOkNeBzke
	b88dpgDeD7fz4rgpYq+14ofQ1YkycY22u0gQIb0AMQPyq0uO2Hl1I6Vk4wEuaESM
	+SiqTuGPoQycAJDP4EnW9Jci01JaJ/fJNIt8ltK2DAnVdzPQk2T9LWIKSm7Ei668
	/klzoGZLwqk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F94837914;
	Fri, 12 Sep 2014 13:31:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 179EF37913;
	Fri, 12 Sep 2014 13:31:32 -0400 (EDT)
In-Reply-To: <20140912130607.GX4075@isis.sigpipe.cz> (Roman Neuhauser's
	message of "Fri, 12 Sep 2014 15:06:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2F581C8-3AA2-11E4-96C9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256930>

Roman Neuhauser <neuhauser@sigpipe.cz> writes:

> git-diff-tree without --root is absolutely silent for the root commit,
> and i see no bad effects of --root on non-root commits.  are there any
> hidden gotchas?  IOW, why is the --root behavior not the default?

Because tools that was written before you proposed that change
expect to see nothing for the root commit, and then you are suddenly
breaking their expectations?
