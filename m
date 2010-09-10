From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] install-webdoc: keep installed RelNotes-*.txt
Date: Thu, 09 Sep 2010 17:00:14 -0700
Message-ID: <7vbp86lb75.fsf_-_@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1009062026330.19366@xanadu.home>
 <20100907020109.GI1182@burratino> <7vzkvup3l3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:00:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otr2b-0006Hq-Tc
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab0IJAAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 20:00:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084Ab0IJAAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 20:00:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E86FDD43E1;
	Thu,  9 Sep 2010 20:00:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ELduUehBQrW+AQ97MuHLCgp2c2Y=; b=K5KwlQ
	UwJXLuesE+R76IO7LZYhsnx79fGKQ6wJn5KyZawFB1RQn17qLaB/elXfa8vcxLAn
	z0V+uaYmGjFmFvYAaUEq2LnAHHVHG0RPDAyIg78vbKW4XFJJ5xUOL/xp1c+hHwZN
	0HVcphhTYSW4JEPyMa42KO11mgsxclJtKQExA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CtDX90M5YrAQM4iexFVMKFInAxLazQtE
	IEPhfZnRzmBFxytNUBZtFsruWbiTQe0VFe1+bG0lEL8NvJbRRxHgVhwG2TQqPrGZ
	cBGqpvppFzQzNLEJYrLqaDgzjvWF7BQX0S9EZbKHdyk87RyM5lJyQGpH0KUuPSoM
	HkUg0fGVRDs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB176D43D7;
	Thu,  9 Sep 2010 20:00:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9A8DD43D6; Thu,  9 Sep
 2010 20:00:15 -0400 (EDT)
In-Reply-To: <7vzkvup3l3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 06 Sep 2010 21\:42\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6683B6F8-BC6E-11DF-81B9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155912>

Otherwise URLs in the wild that point at older release notes will become
dangling.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> this would invalidate old URLs like
>>
>> 	http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.2.3.txt
>>
>> , no?

  Perhaps grandfathering the old URLs with a patch like this may be
  sufficient.

 Documentation/install-webdoc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index e5c1cbe..76d69a9 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -30,7 +30,7 @@ for th in \
 do
 	h=`expr "$th" : "$strip_leading"'\(.*\)'`
 	case "$h" in
-	index.html) continue ;;
+	RelNotes-*.txt | index.html) continue ;;
 	esac
 	test -f "$h" && continue
 	echo >&2 "# rm -f $th"
-- 
1.7.3.rc0.183.gb0497
