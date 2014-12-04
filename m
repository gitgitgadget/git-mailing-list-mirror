From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Thu, 04 Dec 2014 11:33:24 -0800
Message-ID: <xmqqd27ztdkr.fsf@gitster.dls.corp.google.com>
References: <20140324213814.GA1267@achilles.my.domain>
	<20141202193243.GA2999@charon.olymp>
	<20141203023419.GA10519@dcvr.yhbt.net>
	<xmqqk328k6ya.fsf@gitster.dls.corp.google.com>
	<20141204192245.GA3386@charon.olymp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwc9b-0001cY-7B
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbaLDTd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:33:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932315AbaLDTd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:33:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD65823277;
	Thu,  4 Dec 2014 14:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xP1hBcqAxRdoodzE5WIOc8OAJpE=; b=kZiLwJ
	FmhN3aHrbplH26Gh88Uj86O8U+BLpVfy+x+LrJuPnHkUSju8aTW38bF0bG/KsRwZ
	AY0nGrb3y+bJSnHgAZGnzJnlx+Xvyf8nyxhCNG8+rrU3tAxxIGLg9Cfugc9YST7t
	cI1dbo+SpSFlnLZ2SkDH08jRJO8JnQGFa/KDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XnFtCLbYQMyWL2rSgQ2lVnaFwbvDglbD
	9l1vP/V9Shc4XhIy8rpjcMrmOr3Dd9J0kjYppfisyY5Ov0QZT3ho6zbiqasWHspY
	YeI1OffJ9OQcFgcWQONxNtlh6Tow6D3ufTwrhfUTAsphr59G4r3RZ/mmZAfRmMe7
	53dcxfk0q+E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D49DA23275;
	Thu,  4 Dec 2014 14:33:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F8F423274;
	Thu,  4 Dec 2014 14:33:25 -0500 (EST)
In-Reply-To: <20141204192245.GA3386@charon.olymp> (Luis Henriques's message of
	"Thu, 4 Dec 2014 19:22:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A44CFCE-7BEC-11E4-97AD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260787>

Luis Henriques <henrix@camandro.org> writes:

> On Wed, Dec 03, 2014 at 08:56:45AM -0800, Junio C Hamano wrote:
>
>> I actually do not think this is a good idea from debuggability.
>
> Do you think this could be merged with yet another switch?  I can't
> think of a name for the switch, something like... "--hide-msgid"?

In case it wasn't clear, by "this" I meant the removal of
"X-Mailer:", iow, "Adding --no-xmailer option is a bad idea from
debuggability's point of view".

Not adding message-id is not an option; MSAs are supposed to always
add one if they want to be RFC compliant, aren't they?
