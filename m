From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] imap-send.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon, 21 Jul 2014 11:00:59 -0700
Message-ID: <xmqqegxek2w4.fsf@gitster.dls.corp.google.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<1405941145-12120-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Hti-0000s2-7T
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 20:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbaGUSBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 14:01:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57521 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933022AbaGUSBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 14:01:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 277932B165;
	Mon, 21 Jul 2014 14:01:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B4vQiPEmSp0A6FgenS8ZsxobBtU=; b=sm1hpd
	ViRMTyzmwizeZPEULDro4y2Meov/CS076xONcz0NUITXscWYvsSboji1WR7g1hp7
	ZTj/KpQjJ5WvsdUhNW+uKu4zv/aJ7bypmAEY0H7BABUCRz3H6jOnurIBrx5CfKAE
	9VPIX7BzaMpptM83kW1Sk1Tbh7sLCc/wCw8+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9mHOTRpOkoDzvTj/6GGEaM3/LZlQaYC
	JlpinQ/zegAdYxlcbee63mK5j1Ac5Gw8Z9O9x6V06jdbcDDF6XxiIc/A7AgAZuXN
	p6QhIbab2y8BLJsPvNTlVb6sw7/AkJDfpP/icrOQVl/VGDiEkMXq9PxK6I+GcaGI
	t+CoSi3e3bk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D53C2B164;
	Mon, 21 Jul 2014 14:01:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9FB2F2B15B;
	Mon, 21 Jul 2014 14:01:01 -0400 (EDT)
In-Reply-To: <1405941145-12120-4-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 21 Jul 2014 04:12:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9D777F6-1100-11E4-8CF2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253983>

Tanay Abhra <tanayabh@gmail.com> writes:

> +	git_config_get_string("imap.folder", (const char**)&imap_folder);

The same "why (const char **)--is that an API mistake?" question
applies here and other calls to git_config_get_string() in this
patch.
