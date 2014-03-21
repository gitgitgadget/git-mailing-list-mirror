From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 10:31:59 -0700
Message-ID: <xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
	<CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
	<20140321034334.GA29683@sigill.intra.peff.net>
	<CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:32:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3Ij-0005Q4-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977AbaCURcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:32:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374AbaCURcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:32:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD36769AE;
	Fri, 21 Mar 2014 13:32:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HDUN/iM3nNNGKPeqG2UX2K8W8Kg=; b=HWhMVV
	9hLHJa0rz4SzPHZdSLF+QDuoV6ZeZdllO0dunZfZ9SfQinwOevXYmpvcdt/Rsu+t
	4qlc4N1UbGOLnSivJ5PSE9dxT0uNutXU81gwNZ4JUNJZ7tjiW5uANsazsjqPL1Rb
	Z95SEmWmhY6V1MYzLiiD6rDh4Ncwti7y1pVaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gr8WRrmn64RcGOgQC1RvjPMqhchHvq+U
	R4DY5nhurCmuO5Yjlf/+ed3hKzJzfidEC6zvJzcaSjshY1KeclgDYyqFkQK6gi+b
	l7rl15+znxMivJ4lPWBA9OFkav7FfHq+I4tY8u4+HwLgGJfV/Mf5QDot4lDOT7Kn
	X3Wv7wubEDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 182BF769AD;
	Fri, 21 Mar 2014 13:32:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52575769A7;
	Fri, 21 Mar 2014 13:32:01 -0400 (EDT)
In-Reply-To: <CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
	(Chris Angelico's message of "Fri, 21 Mar 2014 15:07:08 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6192844-B11E-11E3-A310-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244705>

Chris Angelico <rosuav@gmail.com> writes:

> On Fri, Mar 21, 2014 at 2:43 PM, Jeff King <peff@peff.net> wrote:
>> Thanks, the new text looks good to me. Please follow SubmittingPatches
>> (notably, you need to sign-off your work, and please send patches inline
>> rather than as attachments).
>
> Ah, didn't see that file.

It appears that we might need to be more explicit in that file,
though.

>
> From 6e1fc126ece37c6201d0c16b76c6c87781f7b02b Mon Sep 17 00:00:00 2001

Never paste the above line to your e-mail message.  It is only used
to separate individual messages/patches in the format-patch output.

> From: Chris Angelico <rosuav@gmail.com>
> Date: Fri, 21 Mar 2014 10:45:08 +1100
> Subject: [PATCH] Explain that third-party tools may create 'git config'
>  variables

You _may_ paste these in-body pseudo-header lines at the beginning of your
e-mail but (1) then these must be the first lines of your message,
not after doing random discussions at the beginning of the message
(you may separate that with scissors marker "-- >8 --", though),
and (2) do so only they are used to correct what appears in the real
header lines in your e-mail message.

 * "From: " is useful only when you are forwarding a patch written
   by somebody else; otherwise your authorship can be taken from the
   e-mail "From: " header.

 * "Date: " is the same way; "Date :" header in your e-mail is
   closer to the time wider world saw the change for the first time
   than when you made the commit, so it is usually not desired to
   see in-body pseudo-header.

 * "Subject: " is used a lot more often than the above two,
   especially when you send a patch to an on-going discussion thread
   as a "how about doing it this way?" patch and do not want to
   change the e-mail Subject: (which may break the discussion
   thread).

Also I'd title the commit with the area it touches, i.e. starting it
with "Explain blah" is suboptimal.

Will queue with a minor tweak, with retitling the change and
rephrasing the "ideally" part, which invites people to say "well it
may be so in the ideal world but the rule does not apply to me".

Thanks.

-- >8 --
From: Chris Angelico <rosuav@gmail.com>
Date: Fri, 21 Mar 2014 15:07:08 +1100
Subject: [PATCH] config.txt: third-party tools may and do use their own variables

Signed-off-by: Chris Angelico <rosuav@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..a1ea605 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -131,8 +131,13 @@ Variables
 
 Note that this list is non-comprehensive and not necessarily complete.
 For command-specific variables, you will find a more detailed description
-in the appropriate manual page. You will find a description of non-core
-porcelain configuration variables in the respective porcelain documentation.
+in the appropriate manual page.
+
+Other git-related tools may and do use their own variables.  When
+inventing new variables for use in your own tool, make sure their
+names do not conflict with what are used by Git itself and other
+popular tools, and describe them in your documentation.
+
 
 advice.*::
 	These variables control various optional help messages designed to
-- 
1.9.1-443-g8f4a3d9
