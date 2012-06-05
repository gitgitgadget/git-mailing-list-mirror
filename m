From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Script to install, delete and clear a MediaWiki
Date: Tue, 05 Jun 2012 09:48:01 -0700
Message-ID: <7vhauppuwu.fsf@alter.siamese.dyndns.org>
References: <4FCE07A5.9020001@ensimag.imag.fr>
 <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	peff@peff.net
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:48:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwvQ-0006W2-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab2FEQsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:48:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab2FEQsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:48:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0532B9816;
	Tue,  5 Jun 2012 12:48:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=08DTtLnS4jFPCQ4iE3ynagO7b0M=; b=V9D5qe
	PKCt8XRb+bVU5VIL9pzgYylM6QYIhJtyvVG968opbMCU73qD0+3XKF7/OXH8h0Tk
	Ws1AKV2FlFG5JDMmIHzs0T+PlnQUYnx3vflN+mnoG+v68ocXVzjI9bD8N/SZbSN0
	doWeFmpEgDhQwe6ayehkObxnLInhmhXahvB0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2LWU9dcwUlIsiSB8A1SKIE28qwHed2G
	oRV6gCHLp29VoxSjcIXENBrTjV17Vk5fyroS3asraqHrNyjfoFWEuaXI/zmhvtSw
	oHjZ0YlLs7p5ug5VDDtCaHQKJ2wdzIppOJZ8/aSm0Sq4SFBF3nTPAzbzeapdAVsw
	+2/LR5O05vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE3B99814;
	Tue,  5 Jun 2012 12:48:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB339812; Tue,  5 Jun 2012
 12:48:03 -0400 (EDT)
In-Reply-To: <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr> (Simon
 Cathebras's message of "Tue, 5 Jun 2012 15:25:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3780D782-AF2E-11E1-866A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199264>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>
> install_wiki.sh expects the first argument to be 'install' or 'delete'
> 'install' installs a MediaWiki on the web's server with SQLite3
> 'delete' deletes the previously created wiki.
> Note those functionnalities are made to be used from the user command line in
> the directory t/
>
> install_wiki also defines a function wiki_reset which clear all content
> of the previously created wiki. Note this functionnality is made to be
> used only by our test function in a subdirectory of t/
>
> Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
> Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
> Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
> Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
> Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
> ---
>  t/install-wiki.sh                |  38 ++++++++++
>  t/install-wiki/LocalSettings.php | 129 ++++++++++++++++++++++++++++++++
>  t/install-wiki/db_install.php    | 110 ++++++++++++++++++++++++++++
>  t/test-gitmw-lib.sh              | 154 +++++++++++++++++++++++++++++++++++++++

Hrm, I see my name on the Cc: list, but is this meant to go into my tree?

The t/ directory is a very strange place to put an installation
procedure for anything.  Is this because later test scripts that
test mw-to-git gateway need to have a mediawiki instance that runs
locally?

I am wondering why it is not sufficient to structure the MediaWiki
related tests more like existing tests that require a running HTTP
server, namely, t/lib-httpd.sh that allows such tests to proceed
only if a suitable server is available, but we do not ship a script
to install Apache for that.

>  mode change 100644 => 100755 t/test-lib-functions.sh
>  mode change 100644 => 100755 t/test-lib.sh

Why?
