From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] git remote improvements
Date: Tue, 16 Feb 2016 13:36:47 -0800
Message-ID: <xmqqio1omj68.fsf@gitster.mtv.corp.google.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
	<1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVnIk-0008Jb-SX
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbcBPVgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:36:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755561AbcBPVgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:36:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A74D045C6A;
	Tue, 16 Feb 2016 16:36:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7D6TxeMTkGQ8E4WDdjtuJKmUlYQ=; b=g6dDYI
	jQAlx5W6Smh4aK2t5qDRNKCqQyX27e9H4lx5iRnmyxUaTb5oT8xGfQZREUFip4B5
	EVDoi720a8C0yhUgJ6IGbriozBdenRjpuF0w9C8rcDvRJLgxrUtT+0jIqjTUoXMI
	YOorR47qsCtpEEJSuIMvEHzbD9kVP0ZCUDSQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=INg/6++GgE/QXEJPw/BhNU5ZUi8FxmY6
	RK+LEAJUmW6CL8TpGgvT+KM0XzW81GJ7aYgqwDefO8aXYGL3BP5PrNg3/khSjMoO
	/mCOJlerE1fC5DjOD/tR15D8qGkEkKLV2c9KeBLL7hc3cL/KhpXadzg53ksKw5dR
	bso3SnQxS4I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E43345C68;
	Tue, 16 Feb 2016 16:36:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0098245C67;
	Tue, 16 Feb 2016 16:36:48 -0500 (EST)
In-Reply-To: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Tue, 16 Feb 2016 10:47:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 628DC62E-D4F5-11E5-945A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286436>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Previous rounds are at $gmane/286214 and $gmane/286278.  Thanks to
> Peff and Eric for the reviews on the previous round.
>
> This version changes two checks in [1/4], and uses test_config in the
> tests instead of calling git config directly.

Thanks; I agree that 1/4 is a noisy patch but the culprit of the
noisyness is that the old code, when doing tons of comparisons with
fixed strings that begin with a dot, did not think it was crazy not
to increment the "subkey" before doing so, and the resulting code is
much easier to follow.

Thanks.
