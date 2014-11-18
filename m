From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 12:15:06 -0800
Message-ID: <xmqqvbmcuuyd.fsf@gitster.dls.corp.google.com>
References: <1416339408.3899.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpBF-0004Yd-1X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbaKRUPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:15:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932124AbaKRUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:15:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 986C11E9F9;
	Tue, 18 Nov 2014 15:15:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ci61zJ6U96GxaeVVGd64dGbCL0=; b=wpn3Lp
	QemYWnkqLkbvM41pu7OhOofXzOqgryZ/iYPtsOTlwKM4vEKmcsJNY5+S5q91gNmu
	JUQlUNuvz9fOaOWYmiK+7/hymGWTeb38IZX1ZSuKalTEFwsTPNYDV5JLdP6kaO8u
	bxajQ1XSP+kVn8aHnIFMLHKgC+NgSJS74r4+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ucilfDEVbVDCnWcYInbJQHQvKuL8j9q+
	Au530mfs1E5mG6m5uvuSSs4XEQXucf8MkttJR4vauIp6Ou7ivdot+fjlQIm/2lj1
	psqUyyfGpiy+2WwezdC72jYunt13b/EBOWBfrTWgYAEO0SWMgB5zxgPjI6Kv8qsr
	WLIet4k+BlM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FAD71E9F8;
	Tue, 18 Nov 2014 15:15:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C9541E9F3;
	Tue, 18 Nov 2014 15:15:09 -0500 (EST)
In-Reply-To: <1416339408.3899.22.camel@mad-scientist.net> (Paul Smith's
	message of "Tue, 18 Nov 2014 14:36:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9897A8A4-6F5F-11E4-B0CD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> Getting rid of ls/wc was not as simple as I'd hoped,

I didn't say ls/wc was not portable.  Assuming that a directory for
which the output from "ls -a" has two entries is empty may be.
