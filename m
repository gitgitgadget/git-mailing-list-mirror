From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/4] tests: add new test for the url_normalize function
Date: Sun, 21 Jul 2013 23:45:38 -0700
Message-ID: <7v61w3qei5.fsf@alter.siamese.dyndns.org>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
	<185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 08:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V19sp-00068V-35
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 08:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab3GVGpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 02:45:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032Ab3GVGpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 02:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC572C5F6;
	Mon, 22 Jul 2013 06:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x4fVW/nwbhFfSqgXkSyOTaTYPYE=; b=r86LoQ
	VeglJ4mUawCLsX7TrxDUyVoH9NBxZ1EqIe4WSqFwWFp9WD9/kTJqOsscy0yAq7BE
	6uLRMbFYJk7UYJQdlnnYFf9shSBgdb3lzlqA7TItWgffNJfz3NTCJXqrN51/99sl
	SNFTZa60HO4ACAQmpz/1S/69FxwpLTHTVMc6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbUswmxN14yefEsPhYEyc/x0M/zVlbUo
	Z2I5yVezXh75J/O3/sDOAJ9FlS/Nyh80GPsNR9vGrRwA4ZjurlBahMvGwWqWwobd
	drASdCR9zLROsyXXI9h0jUftD7vyKRUPmmCYYjpduv9xqKF0Eh721mkxnWwb6EQq
	xHdy6Xq6af8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7090D2C5F5;
	Mon, 22 Jul 2013 06:45:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89BB32C5F1;
	Mon, 22 Jul 2013 06:45:39 +0000 (UTC)
In-Reply-To: <185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Sun, 21 Jul 2013 20:18:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5270C100-F29A-11E2-9B50-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230961>

I suspect that files under t/t5200/ were not suiable for e-mail
transmission.  Can you regenerate this after running:

    $ echo '/t/t5200/* binary' >>.git/info/attributes

or better yet with:

diff --git a/t/.gitattributes b/t/.gitattributes
index 1b97c54..6240ed2 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1 +1,2 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
+t5200/* binary
