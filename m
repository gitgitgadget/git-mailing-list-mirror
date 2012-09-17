From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Mon, 17 Sep 2012 16:49:39 -0700
Message-ID: <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDl4b-0003sj-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 01:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599Ab2IQXtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 19:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2IQXtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 19:49:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE63E93F6;
	Mon, 17 Sep 2012 19:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vgVUfl8T/ykxiQ7nZKwnt1zNWTg=; b=MqTVqg
	VbDYHJxzj6CH7Qm2XV3KJ/LGat1i0rwK9PJXirgngo/MqGyZEBJHN0jjW8DMK5mx
	WFgMYlVa0v5HoFUUIu3byY1z5DWMblDxYzkiSjm+/Gi+0tHssIGXsvLvMvUk3utz
	kkkEvCd9q3UU8XvPEr8kfz9tkAtnXAElrALro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUMdu1bcdpmjTciAYKvYArF9NqTp/iLV
	ebA0LNxNPuWfqveotwo3hZC9Tt/d8tPCxgpkErAlaE3CluwRmCSq8jrHLkDmlbg1
	c4TYuAcnRbfh/UteH/eEDcD+6fi+dycalg3toRLee1VO/8GRnQVT0g0rpXZiClDY
	rrg1LfgFIg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC1BC93F5;
	Mon, 17 Sep 2012 19:49:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335C793F4; Mon, 17 Sep 2012
 19:49:41 -0400 (EDT)
In-Reply-To: <98180D4AA94C468887029389CC535D4F@PhilipOakley> (Philip Oakley's
 message of "Mon, 17 Sep 2012 23:55:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 593C55CC-0122-11E2-BF23-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205769>

"Philip Oakley" <philipoakley@iee.org> writes:

> I then applied it (using git am) to a temp branch to see what it
> produced, and could repeat the cycle until the patches looked right.

That's another obvious and valid way to prepare your series.  It all
depends on how comfortable you are to directly edit patches.  Some
people fear it.  Some don't.  Some can do it with their eyes closed ;-).

> However, when it came to creating the series, with comments, I
> couldn't see a way of having my comments within my local commits, but
> preparing a patch series that would properly include the '---'
> separator.

An unofficial trick that works is to write the

    ---

     * This is an additional comment


yourself when running "git commit".  That will be propagated to the
output from format-patch.  You will have another "---" in front of
the diffstat, but nobody is hurt by that.

But when doing a big series that deserves a cover letter [PATCH 0/n],
you will use editor on the output from format-patch anyway, and I
find it simpler to do the follow-on comments at that point myself.

Personal preferences vary, so whatever makes you feel comfortable
with and works well for you is good.
