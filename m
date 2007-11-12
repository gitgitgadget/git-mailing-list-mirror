From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] add ref_abbrev_matches_full_with_rules()
Date: Mon, 12 Nov 2007 11:51:44 -0800
Message-ID: <7vve872qen.fsf@gitster.siamese.dyndns.org>
References: <1194789708646-git-send-email-prohaska@zib.de>
	<11947897083381-git-send-email-prohaska@zib.de>
	<11947897081278-git-send-email-prohaska@zib.de>
	<11947897083159-git-send-email-prohaska@zib.de>
	<11947897083265-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfKa-00027p-Co
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXKLTvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbXKLTvz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:51:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50466 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXKLTvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:51:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C24C22FB;
	Mon, 12 Nov 2007 14:52:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6088894FC7;
	Mon, 12 Nov 2007 14:52:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64694>

Steffen Prohaska <prohaska@zib.de> writes:

> +int ref_abbrev_matches_full_with_rules(const char *abbrev_name, const char *full_name, const char **rules)
> +{
> +	const char **p;
> +	const int abbrev_name_len = strlen(abbrev_name);
> +
> +	for (p = rules; *p; p++) {
> +		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

How about calling this simply "ref_abbrev_matches()" or
"refname_match()" which is even shorter?
