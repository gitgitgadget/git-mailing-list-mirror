From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] CodingGuidelines: give an example for redirection
Date: Wed, 30 Apr 2014 15:14:07 -0700
Message-ID: <xmqqsioucvo0.fsf_-_@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:14:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfcld-0001DA-2b
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498AbaD3WOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 18:14:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbaD3WOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 18:14:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F267F0BC;
	Wed, 30 Apr 2014 18:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eaDezVrljdOTBfUaHR51wBgIts=; b=TWImDO
	UHjC75E+OYcEbZcYJTIk6rZqDBzPio6uCU+VLw6o7Dyc6s4TEb5X35gB/iTueNC4
	iQZtBafL2FkjOVRnIa63JnhSNU74t5ux9Ed8R7759irAre147xXBvwhT7kwsVLmd
	R+SK8DtjLE4BXbj8T+w/YH2yxrkOUIlQT1nPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPRjoCamx5jn1WnHqfz4qL+brXDHiqrt
	fasOVZwweJ/IGa1rH35ppxISDIJQeRH0YdAGmUpaBUR8w5Sv9Tb/83lvnyW0lbgy
	JoA3kz28q4S4cbjEMi7tuOIh0RoKDo4zOlPLOQQ0+2IWfVY4PaQuwlok0GhPZMXW
	s0OhxJZBuZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7B47F0B9;
	Wed, 30 Apr 2014 18:14:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E2347F0B2;
	Wed, 30 Apr 2014 18:14:09 -0400 (EDT)
In-Reply-To: <1398894312-30763-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 30 Apr 2014 14:45:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C06D4C34-D0B4-11E3-B621-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247797>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Instead of using trailing "# correct" comment on each of the
   one-liners, group the good ones and the bad ones into two groups
   and give (incorrect)/(correct) header like the other patches as
   suggested.  How does this look?

   The only reason I originally did these differently is because
   these are two independent examples, and I thought it would make
   the difference stand out better to the readers if we showed
   good/bad pairs of "cat" and "echo" that way.  But as long as we
   are not going to add more examples here, I think the result is
   not too bad.

 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 6a8e94b..6bfe96e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -61,6 +61,14 @@ For shell scripts specifically (not exhaustive):
    redirection target in a variable (as shown above), our code does so
    because some versions of bash issue a warning without the quotes.
 
+	(incorrect)
+	cat hello > world < universe
+	echo hello >$world
+
+	(correct)
+	cat hello >world <universe
+	echo hello >"$world"
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
2.0.0-rc1-355-gd6d6511
