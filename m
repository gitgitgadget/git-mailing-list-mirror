From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: RFC: reflog for deleted branches
Date: Fri, 04 May 2012 00:10:56 +0200
Message-ID: <4FA30270.6000806@tu-clausthal.de>
References: <4FA2F7DA.6020108@tu-clausthal.de> <7vaa1pdjz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 00:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4Ez-0002bH-M3
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab2ECWLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 18:11:09 -0400
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:14661 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756469Ab2ECWLH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 18:11:07 -0400
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id ECFB928BE3A;
	Fri,  4 May 2012 00:11:05 +0200 (CEST)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id CE2A629A0D7;
	Fri,  4 May 2012 00:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=4TEZnP566Be4mVbBXmaf7mrkPag=; b=PzHdiHNIJr5hYetXlqah3OPtxXuh
	3rav9A6bzGk/uoAevtbD/Cr510s6SjkNqRJfE1OoBVlQAL9HTX7NHCvMf/hGPPk+
	uEruIDuEC/MKRFUbXIm7ooMb6Cp9qOqIIBxf3Ak6OmYpSrriKcy1Q3HOXlTKoYNA
	GrHrPKJ8rzfchFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=xbpbFoQT6IW9BHA+37ZVErVhz/BLti42zV4XKxWC+pp88l8w0TGDzwq
	aXQzP85ljOpC3E0Pfzgwa4itmhrEFc1KapI5K1aDlKrMHt4D1hdFIIgthPe7NCuV
	SceqVy1dkRNt+n0kHabLlZ6jPwlPDb3DXCChBGcY4+cVPeyGv/Y4=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 6BEB729A0CA;
	Fri,  4 May 2012 00:10:56 +0200 (CEST)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.5)
  with ESMTPSA id 31628456; Fri, 04 May 2012 00:10:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vaa1pdjz8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_900_999 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196966>

Am 03.05.2012 23:37 schrieb Junio C Hamano:
> The itch is legit, but I doubt a "special log for deleted branches" is a
> good design.  Why do you limit yourself only to a single "last" commit?

That was just the first idea ;)

> Wouldn't it be a better design to save away the entire reflog for the
> branch when a branch is deleted, possibly with expedited expire rule for
> such a reflog?

The "normal" reflog cannot be used if you just create and then delete a
branch - the reflog is empty in this case. A special "deleted" entry
pointing to the SHA1 of the branch is needed. Also the question is how
to handle the case that a user creates and deletes a new branch with the
same name.

All in all, I (and lots of other users) would be happy if this issue
could be addressed in one of the next releases. :)

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
