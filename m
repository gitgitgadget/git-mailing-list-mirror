From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 12:27:54 -0700
Message-ID: <xmqqsio0i9c5.fsf@gitster.dls.corp.google.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.14455.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 23 21:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnv8T-000251-C8
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaEWT2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 15:28:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58602 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbaEWT2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 15:28:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D466119E37;
	Fri, 23 May 2014 15:27:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMRW7WUmNN2vaLey6/KKIMbkleI=; b=jhkGcj
	iZDhwxkLTWdJwWlX1pLXizSGlkrVr4+FFFMksISZGrhTjpgzdDOV/wc8/6PM+XJp
	qFhb2bLoaX7LfIoY8sTEF0l+9JhL7m0AwotlCPvF7mgShycWPc5mEjarJMcQXL4e
	9J9PMz7WZa1ge41090nNluYXePklPi39ZYr0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cpju+B9gEcSLUGcsJLweMTrIe/9F1sT5
	73j8JNiljDNTc7FTwVLlIAvs+gN8NYxxOVNDYjkmNrttIiNcm2mvnFHhgGrjngH7
	qgoEZmrKLt2v3SsmOff1TtFxOOp6CBGCOnHF8uZo12y35HyWI3PZUPwgvbeprGlu
	J42PgX0IRBs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB71819E36;
	Fri, 23 May 2014 15:27:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC07119E2F;
	Fri, 23 May 2014 15:27:55 -0400 (EDT)
In-Reply-To: <20140522213307.27162.14455.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 22 May 2014 23:33:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 576786E2-E2B0-11E3-8EA1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250018>

Christian Couder <chriscool@tuxfamily.org> writes:

> The usage string for this option is:
>
> git replace [-f] --graft <commit> [<parent>...]
>
> First we create a new commit that is the same as <commit>
> except that its parents are [<parents>...]
>
> Then we create a replace ref that replace <commit> with
> the commit we just created.

Shucks.  An older version of this is already in 'next'.  I'll
postpone queuing the rerolled one until post-release when we will
rewind 'next'.

>
> With this new option, it should be straightforward to
> convert grafts to replace refs, with something like:
>
> cat .git/info/grafts | while read line
> do git replace --graft $line; done

Don't cat a single file into a pipeline.
