From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 12:19:29 +0100
Message-ID: <510118C1.9080704@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, davvid@gmail.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 12:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyKqb-0001Cy-Us
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 12:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab3AXLTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 06:19:36 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:53548 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752916Ab3AXLT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 06:19:29 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 2BC7142E27A;
	Thu, 24 Jan 2013 12:19:27 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 03A04422069;
	Thu, 24 Jan 2013 12:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=bWPb58YVl6SgdGMvUSKksJkYQ4g=; b=st7+rKuWtb/SUTWAW3R7lp3sdiK2
	G+sk2lBKGPfEvurI0eMINB4WHpZE1Ncez1sYWHDY3owFLQ18n8rXH/iGnwMTXoDK
	4RY95iImR9sbGaXTjQAtIOdTwKhEXCTb1PD9UmjcFYPXyy22NWs3azVqPDYVa4fN
	0dxpf+OyyTAi3eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=aoEHYXCOCCZNY8hQ3pjSsLoTgxJNGwVO+Pd/spIc4SZgAQpG5Kn3Jh2
	Ru2ps/oYzi4y4klT5iRPFfkIphbTd6ICYykbdvZbR9iJUNK9RyZ5omvlcAb62mVj
	8nSvEGREbZYGF7tYtOUc1CAHwSjfzKzDWLnhibxE2nijJTwdnFWk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id AADDC422060;
	Thu, 24 Jan 2013 12:19:26 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43294654; Thu, 24 Jan 2013 12:19:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <50FCFBBB.2080305@tu-clausthal.de>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_700_799 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214427>

Am 21.01.2013 09:26 schrieb Sven Strickroth:
> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>   (starting with 1.8.0) in order to make clear that this one has special
>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>   version.
> - The tortoisemerge mergetool does not work with filenames which have
>   a space in it. Fixing this required changes in git and also in
>   TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.
> 
> The new tortoisegitmerge helper was added so that people can still use
> TortoiseMerge from TortoiseSVN (and older TortoiseGit versions).

Any comments for this patch?

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
