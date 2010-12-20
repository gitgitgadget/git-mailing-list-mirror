From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'show' pretty %B without a diff
Date: Mon, 20 Dec 2010 01:05:17 -0800
Message-ID: <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
References: <20101220073842.GC10354@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Mon Dec 20 10:05:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUbgT-0004kB-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 10:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab0LTJF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 04:05:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0LTJFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 04:05:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B92C725C5;
	Mon, 20 Dec 2010 04:05:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dtXhkzdfiTzE2wMMmPTOukwz3U=; b=kDdiea
	SOtbEXPbzHh+QXhGMR+9rXRBNoWdBCFfzzzHwxtx7pJ0WcV3w7bWvKh7sVFBtAUW
	G0Mw+WPuNLARvVt1TiJd64safq1lA1wWMmHz5tqQw3VOfxVzvHD8K6ZQ7Hj6egwD
	l07D8CXZRPo/n9bFMMm4BMpgDgXlfkPbu8Ggw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mf7Jp+7hqWqIZ3ga4Az/+zjAxw37f1/7
	0mN7caroTU0sFsn73Ks1cZPM7m0D/JrXG6fs2B4pYPSH+MQhQLrIQSkpazimyfrX
	gfi+A91Abui+pqoGCzZqEnkFpulrPgAZORdiZgJhVwDa4Ohal34c1+NwbUi4cqCl
	wazed0+GqI4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 964D025C4;
	Mon, 20 Dec 2010 04:05:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C297325C1; Mon, 20 Dec 2010
 04:05:46 -0500 (EST)
In-Reply-To: <20101220073842.GC10354@external.screwed.box> (Peter
 Vereshagin's message of "Mon\, 20 Dec 2010 10\:38\:42 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56C75BBC-0C18-11E0-9C9B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163991>

Peter Vereshagin <peter@vereshagin.org> writes:

> Hey Mr(s) git show some good to me!
>
> I'd like to output a comment in my script.
> Thus, I try: 'git show --format="%B" commitId'
> There is always diff in the end of the output. No matter what format I specify, even when it is empty.
> How can I avoid diff output in the 'git show'?

The best answer to "avoid" it would be not to use "git show"; after all
the command is about showing the change it introduces when it is used on a
commit.

Especially if you are doing a script, you probably should be using
"cat-file commit" anyway, no?
