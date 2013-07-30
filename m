From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Tue, 30 Jul 2013 06:48:49 -0700
Message-ID: <7vwqo8xiny.fsf@alter.siamese.dyndns.org>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
	<7v8v0p2z45.fsf@alter.siamese.dyndns.org>
	<CACsJy8DxSv7zP+EL0yZnkTztEm7taS0VQxcQ6XPQHMvVMLtVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 15:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4AIL-0005bn-NX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 15:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab3G3Nsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 09:48:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab3G3Nsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 09:48:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AEA834A9F;
	Tue, 30 Jul 2013 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsFafkobyXolA20+oPLInhAD/wo=; b=BFuLjp
	zCRvGOv9mwz0P0mRjVdAW+m/+vzFIH20ud5MANep8sUNJjAOSUFonzjdDV4/y6P0
	k4nhfex5bSPKLNMgD3NawpuHbiNZoH3G5XQhb/6IZXLMZr24pwP8ifZ0kyfOtY1i
	drSFzHfiOlmlmmRUA4dcS5w4Q13woXTd2yOtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsRE+BUKv/Y/EpeldyNvwRYggAqw+cz7
	3P9fOmB7JIXzrbmw/3Z8DQPg+DRkhak5cKphZ/ySNaaxQ4ORVVuXZ+UPn6nWMTwr
	94c3fd/F15AdWk3Ouh3SmzYqtrXhuET0W+hwJKSfKfxBPUGs5R2U9db5UsDHfXkK
	M01534iIzNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 173E534A9B;
	Tue, 30 Jul 2013 13:48:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6430734A97;
	Tue, 30 Jul 2013 13:48:51 +0000 (UTC)
In-Reply-To: <CACsJy8DxSv7zP+EL0yZnkTztEm7taS0VQxcQ6XPQHMvVMLtVqg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 30 Jul 2013 07:27:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C46B0628-F91E-11E2-BFC3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231360>

Duy Nguyen <pclouds@gmail.com> writes:

> The idea is the same, but my patch is a bit different (use of realpath
> instead of real_path, I didn't remember git has real_path). I'm fine
> with Ram being the author.

Thanks, both of you, for clarification.

>> Compared to not being able to edit, it may be a small price to pay
>> for those who do need to suffer the broken editor, but the patch
>> makes those who do not need this workaround to pay the price.
>
> Does looking at the edited file's path happen often? I have never done
> that before. I ask because in order to avoid the price for those
> users, the code could get a little bit more complicated (detecting if
> the given relative path traverse backward outside a symlink..). To me
> it seems like a good trade off in favor of simpler code.

Yeah, I was being my usual cautious self, as somebody has to play
that role.  I think the code as-is would be an OK trade off.
