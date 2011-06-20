From: Junio C Hamano <gitster@pobox.com>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 14:46:08 -0700
Message-ID: <7voc1sb2hr.fsf@alter.siamese.dyndns.org>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmIU-0005ar-DX
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab1FTVqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:46:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1FTVqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:46:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71BC664D7;
	Mon, 20 Jun 2011 17:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ioK+1EPZKEu246lfKwzkjwuf8XQ=; b=grDwVx
	YpGq7sFI9mb9KaqzxD/WKq2xNt+gdU9ppEwBj+NwmEQb7Id5G5BNoMDqMf/ulaTP
	YdSrbeV5t2DVq/VzTfUUXCDEMNyNoXt/0QAXb5kxIrdSEpuDQS3liBOKrwxpRrM1
	eHTf4TPtmUu1DzdXjbKT2tMv3g433QhnHJGCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtW0yqdYTJDqlCGc2n6AMDnQD0fKCSzW
	W3XGgIqP+2ywlXCCEHTL2DGX+2xVhDYg15i+nQuDI+zSuSN+aGtgk6c3+/jrWbao
	4/0N1Z5FU0NGAPkr/zN3dYxH7ChCGGClGuVtsMhMJYyD9Tj2X6V3dmM9obpi+i5a
	UFqzjs2QROw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B58A64D6;
	Mon, 20 Jun 2011 17:48:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 829A164D5; Mon, 20 Jun 2011
 17:48:22 -0400 (EDT)
In-Reply-To: <4DFF19C4.5070003@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 20 Jun 2011 11:58:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04DA8DB6-9B87-11E0-8519-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176096>

Thanks for noticing. Let's do this.

 t/t7810-grep.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 69bd576..6379ad6 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -658,9 +658,9 @@ test_expect_success LIBPCRE 'grep -P -v pattern' '
 '
 
 test_expect_success LIBPCRE 'grep -P -i pattern' '
-	{
-		echo "hello.c:	printf(\"Hello world.\n\");"
-	} >expected &&
+	cat >expected <<-EOF &&
+	hello.c:	printf("Hello world.\n");
+	EOF
 	git grep -P -i "PRINTF\([^\d]+\)" hello.c >actual &&
 	test_cmp expected actual
 '
