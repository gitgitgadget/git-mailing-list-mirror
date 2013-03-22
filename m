From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7600: merge tag shoud create a merge commit
Date: Fri, 22 Mar 2013 07:48:37 -0700
Message-ID: <7vr4j78p8a.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: y@quest-ce.net
X-From: git-owner@vger.kernel.org Fri Mar 22 15:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3HN-0000KF-PN
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584Ab3CVOsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:48:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933564Ab3CVOsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:48:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CCCB519;
	Fri, 22 Mar 2013 10:48:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+vfgDByOHM3oLA34pQwJIoEby9o=; b=eV0lU0
	hAnPLdAvqQ6p62i0naKDWqxhDModF2jKGfL5dsrMN0149atOYyA584A9FAMWtetf
	Kj1xa5dNj6vIYCY36gEZ/vjiGe5360wr2xBUwm/hZ9fvBUvabsdbtJEzQbRj+tcZ
	N/XPuhJeU5ZUg4cxIE9dSLU/VYDsbM/N09sSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fT/HaKNQ+oJHRjD23Qyyt+dNtflu7Dkt
	6DPLA+9Rd4PTPtOCXhRP1CFn7u80ESf5SMcfl4YIfCPt89oQkllLyz9WjqjX9aOd
	/yQZc4AXT/p/GKiRFJ5HIwV1hRDS0/QravgMTeCnOw5PSBtVWnoFAFlMoM3Gjw3s
	v0qsWsuPxeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DCA3B518;
	Fri, 22 Mar 2013 10:48:39 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C885DB516; Fri, 22 Mar 2013
 10:48:38 -0400 (EDT)
In-Reply-To: <1363949850-11927-1-git-send-email-y> (y.'s message of "Fri, 22
 Mar 2013 11:57:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94FA7232-92FF-11E2-9754-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218804>

y@quest-ce.net writes:

> From: Yann Droneaud <ydroneaud@opteya.com>
>
> This test ensures a merge commit is always created
> when merging an annotated (signed) tag without --ff-only option.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>
> Here's a proposition for a test tath check the creation of a merge commit
> when merging a tag.
>
> It's not in final shape: the line 
>
>     EDITOR=false test_must_fail git merge signed

Because test_must_fail is a shell function, single-shot environment
assignment like this should not be used.
