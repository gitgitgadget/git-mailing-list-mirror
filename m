From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Mon, 07 Nov 2011 21:10:56 -0800
Message-ID: <7vsjlzyza7.fsf@alter.siamese.dyndns.org>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
 <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNdxi-0002Ry-9F
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab1KHFLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:11:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1KHFLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:11:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A915E64D5;
	Tue,  8 Nov 2011 00:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=humdoQ6vV+RIHaOf98e5wZBvrnA=; b=GASkX0
	QabjhJSSogGYLlJ+jonjrpiNN6Z3Xm9+Q96TTihhbHqzhxJbjE45JU2+A7QWgUKg
	czJcyt8sT5AoynJVCvh5GmZt/4x6U3hytzioyZzx9NxXxUqckdCIAmIThFHfe/lI
	zpQzQnsZLw8yEfbzhWjgK0rZfvUX0vzFBn3X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t0UVgezytSti32gKVP1mwiDoqgi0Jst1
	EZP/D/j1wxHknt468gZMq3CCF2C6ViEFhm86KpYyMVYrWW0xd6DsQxD3XtC5Tr8p
	zp8G7+Dbrf0sBYiGIYk1xTXNr2FuAp26RaXPcdicwQSgnpaQJSBaL6CtThS0w/NH
	pAIc9eEV2Fo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D92B64D3;
	Tue,  8 Nov 2011 00:10:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB8B464D2; Tue,  8 Nov 2011
 00:10:57 -0500 (EST)
In-Reply-To: <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 7 Nov 2011 20:20:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AF4D9D6-09C8-11E1-8F0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185065>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Nov 7, 2011 at 7:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This is a re-roll of the fourth iteration.
>
> Ok, this all looks fine to me.
>
> Clean series, and everything looks fine.
>
> The one thing I wondered about is what happens when you merge two
> signed tags. Maybe I read the patch wrong, but it *looks* to me like
> the code just appends them all together with nothing in between. Is it
> still parseable?

Eek.

The mergetag stuff is a dump of "cat-file tag" so if you have a line that
begins with "object " the parsing side (which does not exist yet) would
have trouble. We would need to devise e.g. adding number of lines at the
beginning, or something.
