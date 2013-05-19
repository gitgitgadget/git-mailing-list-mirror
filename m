From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-index man page
Date: Sun, 19 May 2013 00:46:00 -0700
Message-ID: <7vhahzza2v.fsf@alter.siamese.dyndns.org>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Albert Netymk <albertnetymk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdyJn-0007Ip-AK
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3ESHqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:46:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3ESHqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:46:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BAE61BAE7;
	Sun, 19 May 2013 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iWfm/ZtbKzeQv0g15YLAcxlB0NY=; b=NH5ipP
	by7HcQTh73mAtCXSUWdUb0EP8k5EzXEAml+Osi1pD1AVXu9cVJGb7bgTtOu+6bBU
	RYLoCi8XEZWNf5eopG6OWWClEHt9UCGMk42kwS3SvcuNwjcuOMuWLgICQ2HTzoRB
	F6Zo0tYBI4t0KLU7uud731kXS5kdgrraUKNnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qO78/nryVrYZXIOWc1Eeb1HfgKyYWeH4
	lu4j9hDhWA+VsVSSA39cFhXPTWGMnX0bwwcGiJ69kNX0jUpdu8tvX94rnIyzi4ap
	xVVsJKC+143nKIqd50Xrsaw6/J4qw0W650bk0fdCLzO7dpHA3jV/PXi8rd0xSYTn
	DRCoQ32sHIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AC321BAE5;
	Sun, 19 May 2013 07:46:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 890721BAE4;
	Sun, 19 May 2013 07:46:02 +0000 (UTC)
In-Reply-To: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
	(Albert Netymk's message of "Sat, 18 May 2013 18:26:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 280687DE-C058-11E2-8945-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224825>

Albert Netymk <albertnetymk@gmail.com> writes:

> Hello,
>
> The man page of git-diff-index:
> http://git-scm.com/docs/git-diff-index
> states that
> `git-diff-index - Compares content and mode of blobs between the index
> and repository`.
>
> However, in fact this command compares between files on disk and
> repository by default. It's explained clearly in here:
> http://git-scm.com/docs/gitdiffcore
>
> Maybe the man page could be updated to reflect this in NAME section:
> `git-diff-index - Compares content and mode of blobs between files on
> disk and repository or between the index and repository`

Surely; we need to keep it fit on a single line, though.

> In DESCRIPTION section:
> `Compares the content and mode of the blobs found via a tree object
> with the content of the files on disk by default, and could be
> compared with index only using cached option. ...`

Yes, mentioning both mode is a good change.  The above exact text
may give a false impression (with that "by default") that it is
somehow more preferrable to compare tree with working tree through
the index, and only weirdos would use "--cached" to compare tree and
the index, though.

Patches welcome.  Thanks.
