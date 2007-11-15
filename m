From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BULLS**T PATCH] Allow Git to work at Insane Bank Corp
Date: Wed, 14 Nov 2007 19:36:11 -0800
Message-ID: <7vlk9089jo.fsf@gitster.siamese.dyndns.org>
References: <20071115015227.GA2116@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 04:36:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsVX1-0005WL-8C
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 04:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbXKODg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbXKODg1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 22:36:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33490 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbXKODg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 22:36:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A69012EF;
	Wed, 14 Nov 2007 22:36:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1936795EE9;
	Wed, 14 Nov 2007 22:36:44 -0500 (EST)
In-Reply-To: <20071115015227.GA2116@spearce.org> (Shawn O. Pearce's message of
	"Wed, 14 Nov 2007 20:52:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65049>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Because Insane Bank Corp is one of the largest banks in the world
> all 3rd party software vendors must comply and correct their
> applications to not fail when they encounter Desktop.ini in an
> application's internal data directory.  Or they will lose their
> contract with Insane Bank Corp.
>
> This patch must be applied to Git, since Git is a 3rd party software
> product and its global assets are much smaller than those of Insane
> Bank Corp.  If not applied Git won't be permitted for use.  Git could
> lose all of its software licenses and support contracts.  Git shall
> do as Insane Bank Corp requests.

.gitignore?	... ducks ... then comes back.

> +#ifdef WORK_FOR_INSANE_BANK_CORP
> +static inline struct dirent *gitreaddir(DIR *dirp)
> +{
> +	struct dirent *r;
> +	while ((r = readdir(dirp))) {
> +		if (!strcasecmp(r->d_name, "Desktop.ini"))
> +			continue;
> +	}
> +	return r;
> +}
> +#define readdir gitreaddir
> +#endif

Something like this could be used as an emulation layer for
case-corrupting filesystems ;-)
