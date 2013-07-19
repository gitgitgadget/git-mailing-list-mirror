From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] diff: deprecate -q option to diff-files
Date: Fri, 19 Jul 2013 00:24:32 -0700
Message-ID: <7vip07ypu7.fsf@alter.siamese.dyndns.org>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
	<1374107406-14357-1-git-send-email-gitster@pobox.com>
	<1374107406-14357-7-git-send-email-gitster@pobox.com>
	<20130719033126.GA27853@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 09:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V053Q-0002bC-L7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 09:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759806Ab3GSHYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 03:24:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759770Ab3GSHYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 03:24:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 472D92DDF6;
	Fri, 19 Jul 2013 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vqMD8JM5zUBhvmUYcr312Z8p/R4=; b=cUcQbA
	xG/xqltIZCQkUZ09k6V31AkPu8V1i84jtSOatsw5EecP0/II4jUUsTKcO5YO5WFW
	9IAsOEgFneNnksyFhF7NbPXkWj8/OgeLqn5YNZ+UCTs33Q3QKDQGuQgJxUpl+WK7
	fQ6sK2irVkWuywCaO8O5mcjDQTa8Yi0Ok4I1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVp7Pwlr4wTF0yjtbMqVtUF0midUcpsC
	3/x4ZrYeF0C+sl+XK3cD2IYnfh4A29VhHZFbCkFuhkfOR55Jd2EPwikQEy1goPZa
	mzXWxydjBnQow4hgUOYVjB6sNEnP948WztIVo1d5EFWPajE73wrqgqO66RXmNu25
	E/jtepuuzz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AFDB2DDF5;
	Fri, 19 Jul 2013 07:24:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 959C62DDF4;
	Fri, 19 Jul 2013 07:24:35 +0000 (UTC)
In-Reply-To: <20130719033126.GA27853@google.com> (Jonathan Nieder's message of
	"Thu, 18 Jul 2013 20:31:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 438C0D96-F044-11E2-8840-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230783>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> We should remove the support for "-q" in Git 2.0.
>
> Nooooo.  I hope you are teasing.
>
> I don't mind seeing support for "-q" dropped, but I really don't think
> it's worth delaying git 2.0 for that.  Would s/in Git 2.0/in some
> future release/ be ok?

I do not think keeping the support for "-q" in is any huge burden.
We do not have to remove it, forever, for that matter.

The option is so obscure that (1) I would suspect that only a few
very old scripts would use it, (2) even the users who use such a
script every day would not know what the script is doing with the
option, and (3) we would not know if such scripts exist until a long
time passes after we include patches up to this step in a released
version.

That is why the patch 7/6 rolls the removal into a version bump at
which we promised to have a bunch of backward incompatible changes
to people.
