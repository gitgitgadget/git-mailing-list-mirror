From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Document the semantics of hideRefs with namespaces
Date: Tue, 03 Nov 2015 13:09:29 -0800
Message-ID: <xmqq8u6edc3a.fsf@gitster.mtv.corp.google.com>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
	<1446537497-13921-2-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztipk-0000x9-HG
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008AbbKCVJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:09:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750753AbbKCVJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:09:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2658429927;
	Tue,  3 Nov 2015 16:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=blVNblrgxnzhJInJ76/iwGjUqFw=; b=ukSFhS
	bb/AkOzFi4y8rSwFt3sNJqCF1fVZEdr4Dwt9JHuV0gbc5goV/9IFWJVIpU/1qt3y
	R7dJnJziL3Vi163lfsWrhI2TCpR5abmIGEGVwl405axZ92eQzc+TkY/p6C6adjhU
	pgH0i1rMeRlS/5K5LJy26rAbez5IUWGKZTcV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4Ymurs+liMMz87/INuwV2ZkkN8kwtiM
	ZaG+ELzXmElsgYzGRFTgts8eEPAYFrA7G5yZF4HPfu6Y2MDqfV3ueHUQ/cvzBU2+
	EsVR1LHVqE/UnWE37mMqgxbf8vI3vFP5jtEPTb7HODtUXLLiR68W2JD17qheVlvw
	cphUrE7+aUc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EA0C29926;
	Tue,  3 Nov 2015 16:09:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9939A29923;
	Tue,  3 Nov 2015 16:09:30 -0500 (EST)
In-Reply-To: <1446537497-13921-2-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Tue, 3 Nov 2015 08:58:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CA15DB0-826F-11E5-8FDA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280818>

Lukas Fleischer <lfleischer@lfos.de> writes:

> ++
> +If a namespace is set, references are stripped before matching. For example, if

The first sentence is probably not understood by many readers, as
you do not define what is "to strip references".  The namespace
prefix is stripped from the reference before a reference is matched
against the hideRefs setting.

> +the prefix `refs/heads/master` is specified in `transfer.hideRefs` and the
> +current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` is
> +omitted from the advertisements but `refs/heads/master` and
> +`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
> +"have" lines.
