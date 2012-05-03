From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: RFC: reflog for deleted branches
Date: Fri, 04 May 2012 01:39:15 +0200
Message-ID: <4FA31723.8020705@tu-clausthal.de>
References: <4FA2F7DA.6020108@tu-clausthal.de> <7vaa1pdjz8.fsf@alter.siamese.dyndns.org> <4FA30270.6000806@tu-clausthal.de> <7vwr4sdfw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 01:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ5sJ-0003om-30
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 01:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab2ECXzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 19:55:50 -0400
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:11404 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756672Ab2ECXzt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 19:55:49 -0400
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 44A4528B2F6;
	Fri,  4 May 2012 01:55:48 +0200 (CEST)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id DE64023E98;
	Fri,  4 May 2012 01:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=MajqFBm/A7ifyvhdcN8Jg5EGXak=; b=ded0YOJpo3/Cgy3lgYZEWZRek6rh
	d4E4jsRnqwGkGoazIBtuu48fgtIjfTU4nw+IlaHe0DW4k9N6KTiCEUbQHNX3Pn+w
	Y1WYapgzLeeJpBflZ3iEJJA8pWW6I7TWrHgHOCAAbmPQgCWGJlQ2MIhvBuKw6u2K
	8UTx8cDbhJSNV7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=PbGqQW84sIFau0Qe3da3d2YQp6/iL3pVx+GDqHPrQ/06EKDtpgs2VFz
	JRgKU79hoOqNCezN9Hiz16w7mV66CEWT3rWjsLsCgo/iLukpHXkXnfwP1H5gdv6a
	4NT6BoF4xujFIHFAYke18lGLXq/IoA2UYp60YUpvk/kAq0JJy7oQ=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id DF01D23E71;
	Fri,  4 May 2012 01:39:15 +0200 (CEST)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.5)
  with ESMTPSA id 31632178; Fri, 04 May 2012 01:39:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vwr4sdfw7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196979>

Am 04.05.2012 01:05 schrieb Junio C Hamano:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
> 
>> The "normal" reflog cannot be used if you just create and then delete a
>> branch - the reflog is empty in this case.
> 
> I somehow thought we discussed about the lack of "creation" event.
> Perhaps it is sufficient to create a reflog entry for such then?

I suppose an entry for deletion should be sufficient.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
