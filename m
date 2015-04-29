From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git show' with multiple revisions
Date: Wed, 29 Apr 2015 09:08:14 -0700
Message-ID: <xmqqpp6m6hox.fsf@gitster.dls.corp.google.com>
References: <loom.20150428T120412-982@post.gmane.org>
	<20150429020452.GA873@peff.net>
	<loom.20150429T174544-7@post.gmane.org>
	<xmqqtwvz53t7.fsf@gitster.dls.corp.google.com>
	<loom.20150429T175626-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 18:08:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUX8-0008AM-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 18:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbD2QIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 12:08:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753666AbbD2QIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 12:08:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CF754CD6E;
	Wed, 29 Apr 2015 12:08:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jUKS/ImoNDIM/eIfE2VmQYZXTFQ=; b=O7c6TY
	6xVwx1yHCUDhDZl7RJHKyabkVvbybavNKm7OQ9es3wavdRc2r32eu5Wf4g0Wt66v
	/YLnlYHMiF91vO+WgoU+nesCmfoY12pq0oOy7yPB0yA2We5bsOjrBNcuYmzgez8A
	Q58iLkCM+ytXGLvQH35tiUsU7RF5UJ8ret9Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kEfoU8zJ/+gEKfC3Mm09VVZ4n3F1+4M9
	z3K3flgqTqd2VITLkRE6bOdWzvefbku5lViN4awRmt+4QbJhZIOc5KyZs/M2kQZm
	rOXyaZrXA2qhvPAZ02gt36N9dYuHp4G6mVJuKYSqZ6n8TfL5jgp92wwFyXq6ibQd
	uw6P+NeBKo8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 409D14CD6D;
	Wed, 29 Apr 2015 12:08:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B10B54CD6A;
	Wed, 29 Apr 2015 12:08:15 -0400 (EDT)
In-Reply-To: <loom.20150429T175626-211@post.gmane.org> (Ed Avis's message of
	"Wed, 29 Apr 2015 16:01:41 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F17CDE54-EE89-11E4-BBBC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267981>

Ed Avis <eda@waniasset.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>>"cat-file --batch" will give you the objects in the order you ask.
>
> Thanks, that makes it easy to deal with.  In fact, I might prefer to use
> git cat-file --batch-check and then use some other library to fetch the blob
> contents.

If all you need is a translation from extended SHA-1 object name
like HEAD~243:Documentation/README to the raw 40-hex object name,
"rev-parse" may turn out to be more suitable tool than that.

It of course depends on your use case.
