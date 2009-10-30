From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Fri, 30 Oct 2009 14:35:23 -0700
Message-ID: <7vhbtgk1k4.fsf@alter.siamese.dyndns.org>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, sasa.zivkov@sap.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3z8N-0003K9-DK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbZJ3Vfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbZJ3Vfc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:35:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbZJ3Vfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0AB28BBDF;
	Fri, 30 Oct 2009 17:35:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7l7zxs8GyFEb5jv6kDtpHxBBq4I=; b=VmKKuQ
	+/H9RIFHXmJc6DLJRhrHWdqQGXhqqx/smgeuc1m6M7wQ4UT+7biGomF6EdHM4hXl
	R14NaA+uAnsVH+ZQayEUXCpXKOY7KxtSpjBndUGl4ge3QL9DGpx5KoVQCTC/u400
	N3nb5vpP7BfUfR61wngyjduIDC7s3GJAD0vkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQvkZCxP0cIxUmI+iHZ7xxeVop86yk+c
	qN+Y4+b5jowcRy2c9L3ejTXBqqIDrwk6HMd/tucx/UmCCCecoS3Qn/MFq7hWaPI0
	t6pBA9DMSqgpN17Nxe9kwBFTbhjZrLiKKMA0Len6KRXsk6ppYj6CVJLQuvP8Eyq2
	ivVacWFx1Rg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9356B8BBDE;
	Fri, 30 Oct 2009 17:35:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0481E8BBDC; Fri, 30 Oct 2009
 17:35:24 -0400 (EDT)
In-Reply-To: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Fri\, 30 Oct 2009 18\:20\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25B0FC7C-C59C-11DE-A3C6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131755>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Git itself does not even look at this directory. Any tools that
> actually needs it should create it itself.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  templates/branches-- |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>  delete mode 100644 templates/branches--
>
> Shawn and other wants to stop JGit from creating this directory on
> init with the motivation that newer Git version doesn't create it
> anymore. This patch would make that assertion true.

Cogito now seems really dead ;-).

Unless somebody complains I am Ok to queue this for 1.6.6.

>
> -- robin
>
> diff --git a/templates/branches-- b/templates/branches--
> deleted file mode 100644
> index fae8870..0000000
> --- a/templates/branches--
> +++ /dev/null
> @@ -1 +0,0 @@
> -: this is just to ensure the directory exists.
> -- 
> 1.6.5.2.102.g1f8896
