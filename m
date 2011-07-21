From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git-filter-branch honors replacement refs
Date: Thu, 21 Jul 2011 11:42:51 -0700
Message-ID: <7vhb6f326s.fsf@alter.siamese.dyndns.org>
References: <1311261052-16178-1-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:43:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyD7-0004ig-FL
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab1GUSm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:42:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab1GUSm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:42:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E41302B;
	Thu, 21 Jul 2011 14:42:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=avhKsVg5CQRV0vxA3nvXOlnlpSQ=; b=jV6rwG
	t4fc5rgbBZEDXh8QvghagaFqj3hsG/RhQoAU8O3HT45jOpV7gdHvgQDVYwAGq5cz
	5LRjiNuxq9QJKnUDA1meZgRBG/MJ+7VnF7qxHNwZX7aLF2gXpVSJ4Glosv6acYmL
	LePxYKTuKZ8MsnIfrB/v6y31A4DCjvguSzM8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzBhJEhopxjoObFZ7qiNvufKIooeLhOb
	qkP2k4UEG5d2xRNPa3uqOis02pplSBUvFM56jpJA95yaRT8LXptw1pBy7JutnKGz
	GPbuWoVvIteiA+8kC2l6Jb0Ky/+TAzgMY6ONilN2YcL1eVqZxyJkdQRMe3WH+jEr
	xm+uVyTp7qc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED533302A;
	Thu, 21 Jul 2011 14:42:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 532863027; Thu, 21 Jul 2011
 14:42:53 -0400 (EDT)
In-Reply-To: <1311261052-16178-1-git-send-email-peter@pcc.me.uk> (Peter
 Collingbourne's message of "Thu, 21 Jul 2011 16:10:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3ECBD412-B3C9-11E0-B89D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177608>

Peter Collingbourne <peter@pcc.me.uk> writes:

> Make it clear that git-filter-branch will honor and make permanent
> replacement refs as well as grafts.
>
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> ---
>  Documentation/git-filter-branch.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 9dc1f2a..0f2f117 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -32,8 +32,9 @@ changes, which would normally have no effect.  Nevertheless, this may be
>  useful in the future for compensating for some git bugs or such,
>  therefore such a usage is permitted.
>  
> -*NOTE*: This command honors `.git/info/grafts`. If you have any grafts
> -defined, running this command will make them permanent.
> +*NOTE*: This command honors `.git/info/grafts` and `.git/refs/replace/`.
> +If you have any grafts or replacement refs defined, running this command
> +will make them permanent.

Looks good. I think the second sentence can be further clarified,
though. One of the reasons you may want to run this command is to make
them permanent, so perhaps

	Use this command to make your grafts and replacements permanent.

or something like that.
