From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/14] Add data structures and basic functions for commit trailers
Date: Thu, 06 Feb 2014 15:46:05 -0800
Message-ID: <xmqqvbwrx0sh.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.80557.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 00:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBYe8-0006St-UN
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 00:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaBFXqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 18:46:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaBFXqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 18:46:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D341B6A953;
	Thu,  6 Feb 2014 18:46:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FwFkAM0B8WexFOPdbMuSuM8oafM=; b=DcoxB2
	VllHOCxCY4cfpWbwU8kJAH8ZNFNpeHKBK5cdzJ1WGlQ5pjggXICNRA3xfJStUYeY
	5fFuM29BKSjmyjFIV/xUe/nbAqvo/APfwk+RLrmbKpcHZzYtHMLVWtYGPfWT3Q65
	FQ6s/VPQFx7shZRJ60wBzgqDlYu2619QjgUBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yl9BsvbMYySZhALeK9ooQmzK+IjvlWoS
	pIaWRfcYjRQGFnAUnxdC1PJV1mLgLPquZbHhks353TQeVy8IRa0SOW9MTqGjfZk/
	vxdGpIanGqotJ7Dz2RE5RrFMJA8PX3rMYTtPmeBPjaKdA/Ckz5YZB5zNwI873B0o
	UMATjv9Y588=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6CDE6A952;
	Thu,  6 Feb 2014 18:46:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6808B6A950;
	Thu,  6 Feb 2014 18:46:08 -0500 (EST)
In-Reply-To: <20140206202004.325.80557.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9E2E10A-8F88-11E3-A67C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241749>

Christian Couder <chriscool@tuxfamily.org> writes:

> +	enum action_if_exist if_exist;
> +	enum action_if_missing if_missing;

Probably "if_exists" is more gramatically correct.

	if (x->if_exists) {
        	... do this ...
	}

would read well, but not "x->if_exist".                
