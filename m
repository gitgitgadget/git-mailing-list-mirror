From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Sun, 08 May 2011 10:37:11 -0700
Message-ID: <7vk4e1t7p4.fsf@alter.siamese.dyndns.org>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
 <1304844455-23570-4-git-send-email-gitster@pobox.com>
 <20110508101925.GA19525@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 19:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7v2-0007Q8-KL
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 19:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab1EHRhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 13:37:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab1EHRhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 13:37:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A87D24E64;
	Sun,  8 May 2011 13:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45dzJPoBJ+JF0dUU5ec2HsLu8Bg=; b=jHLtSG
	YMFjb8jBZWsbKJZ1cJFDu617Dx8d3o1srIz/9GwvTgSVuay4zJWUSKIMF/UEx3ZA
	WAuhPMzenQozz+TeHesxLRg2ud2JVc8hvllP8TS1jy1GZzhIYaunbamiaer3+DOx
	65ete44d/ojCllxOXTO2Tn4YRLifLu7MoX/eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r8dytRILkAGFo1mdjIlC3GTBd5UWT8FJ
	6xrK2g5mzVZHjJn0bHPGIDV9NApZ3J7SgDgaS6a5pqmb6twUjKO5K23CQU/e0epC
	7f45OCYbnIKHFgmZmeLrtqCv6KOfmatOIOMMbDrNR0mkVb9K0sM/rVhU5sVSN/Kg
	ziKOTgJlJhA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 870524E63;
	Sun,  8 May 2011 13:39:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC3384E60; Sun,  8 May 2011
 13:39:17 -0400 (EDT)
In-Reply-To: <20110508101925.GA19525@do> (Nguyen Thai Ngoc Duy's message of
 "Sun, 8 May 2011 17:19:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AEB75FC-799A-11E0-961E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173166>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> By the way, is there any way we can mark an object in the pack as
> "non-compressed" so we can read it without inflating?

No. Such a packfile will be unusable by existing git, so I would suggest
you not even think about going there.  It will not happen.
