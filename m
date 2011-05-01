From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Sun, 01 May 2011 11:15:05 -0700
Message-ID: <7vbozmthhy.fsf@alter.siamese.dyndns.org>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:15:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGbAx-0006HU-LE
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760862Ab1EASPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 14:15:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab1EASPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 14:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B321A4CE6;
	Sun,  1 May 2011 14:17:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wVDeMl8GE6A+DARrk8YZBEsgAio=; b=CS27ZFIrW5YDCyXsJdye
	QdxQW7S64nyO1YN3s0dWRq82in75Y1AG4NTpPhv6dnQImAjsc5ruvDrfIlET8n7o
	53HgVmpMDPos/WBTdhE5bAqReVUqwR2nI/+lA5HNo4OQfDRKAbb9FlDkQkoEBj0p
	SQ2zh62oN+WrfXPxvhLvRl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EUaAxG1VBfeiB7z7Rm2casIdOYw4VdSL88wbRwzjzP8cSf
	86gKe6kVpCXw7fP9dv9XTvXQ/ZwU0XUutZFlJDQeb6JyiFsza4C6TbcTUUSqafvj
	Sb5SfPSMFFJ6tmAiPszwtIUUXdRXmuIS8WaV+ExAHylwe67aN+1z9mMFfkdfE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8324C4CE0;
	Sun,  1 May 2011 14:17:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 76A4D4CD4; Sun,  1 May 2011
 14:17:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E06C6D4-741F-11E0-9687-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172540>

Jon Seymour <jon.seymour@gmail.com> writes:

> To better support git extensions provided by 3rd parties
> which would like to install their own man pages and Info files
> in the same place as git's own man pages and Info files
> add support for --man-path and --info-path options.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---

This an improvement that is pretty much independent from the issue of
third party extensions. In fact, even people who would oppose to the idea
of any third party crap [*1*] contaminating the install directories owned
by git may want to this patch.

It is useful to have these options even for read-only users. Cf. 89a56bf
(add --html-path to get the location of installed HTML docs, 2009-04-05).

I'll rewrite the proposed commit message before queuing this to 'pu'.

Thanks.


[Footnote]

*1* Not all extensions may be crappy, but some extension will be, and you
may find out the crappiness only after installing it, but at that point it
already has contaminated your git directories.
