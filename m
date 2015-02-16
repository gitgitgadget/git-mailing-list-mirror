From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: ask confirmation if given encoding name is very short
Date: Mon, 16 Feb 2015 14:34:14 -0800
Message-ID: <xmqqiof14hax.fsf_-_@gitster.dls.corp.google.com>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
	<20150205114914.GA10126@stefanha-thinkpad.redhat.com>
	<54D38B73.4060803@redhat.com>
	<xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
	<20150205195758.GC15326@peff.net>
	<xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
	<20150206193349.GB4220@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Blake <eblake@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, Jeff King <peff@peff.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 23:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNUFC-0004z5-MY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 23:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbbBPWeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 17:34:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751548AbbBPWeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 17:34:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCBBF37FF5;
	Mon, 16 Feb 2015 17:34:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; s=sasl; bh=zGOv5qwarBo/QQNtBvEs9cxPx
	pU=; b=QZbeVrLK96gIivLI2dHMiRcHJYNfQQ8FFKqdxwla7XLp8UtoRPta4L13D
	Fpz/T0Q170W4aHm97749fLiF1P34Gu1CdIpgg9AAMih7XLhX7M0FwKCV5IcIKiEZ
	ytZN3hcHIK6TaCkWiTeMyxyuv8KKeUyOmyIofrW8PKsuTaqhIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; q=dns; s=sasl; b=LJglxbNV1CblvhbZBLX
	7cs1ZsAGyG9f0FU7xkpMx245Pqm7Zvq7ipOpdWzEMyWmbp+XxH9t1a9gK7xEFUpz
	9AoJkXhJ9im+zsvqXUmrycLRS2m8eQCTJnUgG3GTcBkovFITvYrCHK1UWm+lWG96
	kITW/oWhqzcFKpN2z31qZ1nI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFE3137FF4;
	Mon, 16 Feb 2015 17:34:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D2E237FEF;
	Mon, 16 Feb 2015 17:34:15 -0500 (EST)
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
 <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
 <54D38B73.4060803@redhat.com>
 <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
 <20150205195758.GC15326@peff.net>
 <xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
 <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
In-Reply-To: <20150206193349.GB4220@peff.net> (Jeff King's message of "Fri, 6
	Feb 2015 14:33:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFDC2DCA-B62B-11E4-A9CF-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263920>

Sometimes people respond "y<ENTER>" (or "yes<ENTER>") when asked
this question:

    Which 8bit encoding should I declare [UTF-8]?

We already have a mechanism to avoid accepting a mistyped e-mail
address (we ask to confirm when the given address lacks "@" in it);
reuse it to trigger the same confirmation when given a very short
answer.  As a typical charset name is probably at least 4 chars or
longer (e.g. "UTF8" spelled without the dash, or "Big5"), this would
prevent such a mistake.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Will mark to be merged to 'next'.

 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index fdb0029..eb32371 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -733,6 +733,7 @@ sub file_declares_8bit_cte {
 		print "    $f\n";
 	}
 	$auto_8bit_encoding = ask("Which 8bit encoding should I declare [UTF-8]? ",
+				  valid_re => qr/.{4}/, confirm_only => 1,
 				  default => "UTF-8");
 }
 
-- 
2.3.0-282-gf18c841
