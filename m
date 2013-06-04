From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] git send-email suppress-cc=self fixes
Date: Tue, 04 Jun 2013 10:40:51 -0700
Message-ID: <7v4ndd93ks.fsf@alter.siamese.dyndns.org>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjvER-0000SS-CK
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab3FDRlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab3FDRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:41:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC8025287;
	Tue,  4 Jun 2013 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xgn5ZN64whgU/yD39cf9DvS9NpM=; b=RXPHgs
	ff4s0hTokc9V+oH9D7Od4Fhcx3KwVx7/9UxcwjoZG1fS20/mP8nAWgpS7eYNs4+Z
	hYyspJGucM+fjxDvB9kHeCeDoDDqoDkMmAtKaLTIybhz0Gr0WtWYAM2iXhFebzKA
	vDz1muhrerANpDCdY3y3RQ9Fw1sgAYShCg4k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMTBQUARAJZcL8nlJfOU24/YCBfpebED
	IXKUuNl5SpeZfeRgeFdqyCUISKrFCfKoSaW08YYAsgneHhOI9YzWuVBOicB2+Mxj
	BCTwlcXRjnZr9c0N2KvqvVFKLrqoALNAEi0w7NH8U2roPZYh2jlV97N9IgG058rs
	dcjhBjPfMPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F09AD25286;
	Tue,  4 Jun 2013 17:41:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B7A25270;
	Tue,  4 Jun 2013 17:40:53 +0000 (UTC)
In-Reply-To: <1370332482-12329-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Tue, 4 Jun 2013 10:55:59 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E74B815C-CD3D-11E2-B7E4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226385>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This includes bugfixes related to handling of --suppress-cc=self
> flag. Tests are also included.

Hmph, flipped the patches without test-applying first?

2/6 adds two lines to test_suppress_self_quoted helper function, but
that is introduced only at 4/6.

>
> Changes from v2:
> 	- add a new test, split patches differently add code comments
> 		 to address comments by Junio
> 	- rename example addresses in tests from redhat.com to example.com
> Changes from v1:
>         - tweak coding style in tests to address comments by Junio
>
>
> Michael S. Tsirkin (6):
>   send-email: fix suppress-cc=self on cccmd
>   t/send-email: test suppress-cc=self on cccmd
>   send-email: make --suppress-cc=self sanitize input
>   t/send-email: add test with quoted sender
>   t/send-email: test suppress-cc=self with non-ascii
>   test-send-email: test for pre-sanitized self name
>
>  git-send-email.perl   | 23 +++++++++++++++--------
>  t/t9001-send-email.sh | 34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 9 deletions(-)
