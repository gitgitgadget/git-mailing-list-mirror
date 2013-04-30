From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 10:56:30 -0700
Message-ID: <7v1u9rewc1.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEn8-0001ui-GS
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab3D3R4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:56:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932423Ab3D3R4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:56:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C3618787;
	Tue, 30 Apr 2013 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CpBBSWwUH3GvWz8TZ4XUtiHrzVE=; b=FxU+Uf
	Mu4DTGTtPCGAhjH/cxWlAdWc6oWz216aNjc1dR9JldCgCI47TeQDSXOY+9jYWtMH
	9Q5rnr0oJX8qpPOyRtbFmD9Qxgr2PG0p/mH5Q4pGkKHhXglDqzJuvBsEdrwARs8T
	C6vvinNeGljXV/+4wh48os3jNYVDk8TgHJM0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SH/Jv4XjbUhVQRx8a5+bj9C4aHPlfE6S
	Up4egJf5a312I8pGVBa0fGdEQQ01jH3io4xmn03bylbhvGWhxlKcb1UZwmS63cYw
	ud7p4HINgSFix46oj4ClZ+T2NTRwYSeBi9kLpcHRVoGWVqMuC7ewMl4pIcsa+OK+
	ADKBu4/vpdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796B818785;
	Tue, 30 Apr 2013 17:56:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E52CE18783;
	Tue, 30 Apr 2013 17:56:31 +0000 (UTC)
In-Reply-To: <CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 30 Apr 2013 23:10:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A63F228-B1BF-11E2-AB02-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222974>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If you accept only "@" but not "master@", that behaviour needs a
>> wrong world model to understand and justify (one of which is "@ is a
>> synonym for HEAD").  If your rule is "In $anything@{$n}, you can
>> drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
>> becomes master@, and @{0} becomes @ naturally.
>
> Besides, you're going in the wrong direction this time.  You are
> trying to fit an explanation to something that is useless.  How is
> master@ useful?

How else would you explain why "rev-parse --symbolic-full-name @"
does not make sense and "update-ref @" does not update HEAD?
