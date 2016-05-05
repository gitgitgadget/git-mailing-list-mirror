From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] test-parse-options update
Date: Thu,  5 May 2016 14:50:53 -0700
Message-ID: <20160505215056.28224-1-gitster@pobox.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:51:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRAm-0001s6-EU
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbcEEVvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:51:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755959AbcEEVu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:50:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CE8D194FF;
	Thu,  5 May 2016 17:50:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Narc
	ocVLXJ3XDnfFwz3S3tNES8g=; b=c3vR5jazaJh7DC3Qn7CjAE3sMJLvoDentMbL
	eGenGt4M0eNh3opcxHsOHeTSHVdLdYls86eSR4AHj/Oribv7jvfsDpW5mWhptbIS
	TwhYECL7pOjXM4k8jHEFz6sD9w473NDa+Q9s7W0+WGdDhZtl3PEo+XzXxXqpHRN+
	yDMQ/G8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BHy2IM
	eNJ05vdgAwZka+j/g1fzJ9SR6J+RxD5MDPhXboleKhSwfJ1bKyJ51AqNreD/hJJS
	jAOItMKWqwGuIV+jEKtEpKula/cGznMTjaCMQHY7ZGKmKXClKIP+ViK4ozAVHeVr
	fMHs441K75EUAS+Gwtzx0LUlayf/a2H/cghNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 956A5194FE;
	Thu,  5 May 2016 17:50:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A892194FC;
	Thu,  5 May 2016 17:50:58 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-505-gdbd0e1d
In-Reply-To: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 734A4C7C-130B-11E6-9EE0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293706>

During the review of Pranit's "commit.verbose" series, I noticed an
overly verbose input and output used to drive test-parse-options
helper in t0040.  Here is a patch to teach the program to allow us
to write the test in a more concise way.

I'll leave it as an exercise to the readers to actually use this to
convert tests in t0040.  That needs to wait until Pranit's series
is merged and the dust settles.

Junio C Hamano (3):
  test-parse-options: fix output when callback option fails
  test-parse-options: hold output in a strbuf
  test-parse-options: --expect=<string> option to simplify tests

 t/t0040-parse-options.sh |   5 +--
 test-parse-options.c     | 110 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 97 insertions(+), 18 deletions(-)

-- 
2.8.2-505-gdbd0e1d
