From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to make devs write better commit messages
Date: Tue, 06 Dec 2011 18:28:01 -0800
Message-ID: <7vaa75cdzi.fsf@alter.siamese.dyndns.org>
References: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
 <4EDEA2E2.3030002@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joseph Huttner <huttnified@gmail.com>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 03:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY7F1-0003tP-CR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 03:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab1LGC2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 21:28:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab1LGC2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 21:28:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B25117693;
	Tue,  6 Dec 2011 21:28:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Zpsn/tEgf37BRJOXgn9YblCQ74=; b=De8+WA
	V5AJ4FdCMNxLP7QLge0jRIo5Ybd2eIbybv4Chf20Zt/69nCRu88hT6xyPi8SilX1
	WiaRLQM8TNur5dNg0qhddJeNjXjWCXft8BAQ52fL1tfw82LxiM6x0XrRh7xJzzVG
	e7ySvWrzSQZjZvt2WP6xXY2NtBWfpKMuxkUhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QBqtRkWi06MxVmFXV+W9c0yioQaehzGJ
	mKq/1uTD0UGwC2fGWZ2OlOjIPhC+I5SY6dXE9qall0EL7CQKa1xAQRD7FZYMrrJh
	A7IarbmvVV5wz1Mk4ER0frm8yWDPh0PFZ0CVSja0Fsam+bPPPdFa9R9PwBAqym9h
	RyCgOi0QeUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 700B17691;
	Tue,  6 Dec 2011 21:28:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B7A57690; Tue,  6 Dec 2011
 21:28:02 -0500 (EST)
In-Reply-To: <4EDEA2E2.3030002@elegosoft.com> (Michael Schubert's message of
 "Wed, 07 Dec 2011 00:18:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16631886-207B-11E1-A080-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186415>

Michael Schubert <mschub@elegosoft.com> writes:

>> What are your thoughts?
>
> If it's no social issue but just due to lack of a reminder you
> could provide a template for commit.template. Either way: you
> still would have to force people to set it.?

While that would be a good first step, I think people will learn best when
they feel by their skin how good log messages help them in the long run.

Pick a recent bugfix in your project, analyze why the code was broken by
the bug in the first place, and view the log message of the commit that
introduced the code that was broken by the buggy commit. You will often
notice that the original commit did not explain why the code needs to be
that way sufficiently, risking later breakage, and the buggy commit that
broke the code did not justify the change any more than "This happens to
make something work for me in a particular narrow case".

And then look at the log message of the bugfix. Does it explain why the
broken change was bad, and the fixed code _has to be_ that way?

Do this for a handful of examples, and you will start noticing patterns,
and what makes good messages that become useful in the longer term. Have
your people learn from good ones _as well as_ the bad ones.

Have fun.
