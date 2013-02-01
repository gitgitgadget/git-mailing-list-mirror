From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames
 with
Date: Fri, 01 Feb 2013 21:10:27 +0100
Message-ID: <510C2133.5070905@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org> <51032E96.2040209@tu-clausthal.de> <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com> <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org> <510C1872.3090304@tu-clausthal.de> <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:27:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1NCt-0006nA-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab3BAU1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:27:08 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:45583 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756267Ab3BAU1H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 15:27:07 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 0B87F289D33;
	Fri,  1 Feb 2013 21:27:05 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id AA61829A795;
	Fri,  1 Feb 2013 21:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=TmuNqItTMJJrC9+uSITfQs3/uxQ=; b=tvyt2qFyLu/G4SVabyQ4b2OyLglS
	Gcbo9O4sh0ElMLaFeCCUx8/3ODzOBsn7AL2tyIGjd0LkSo5evQiP9dwdCQDzpNn+
	4axdDAzaQdu4M5QJfdDyq2oIiiDVulSoLQm9sr1yO4Cv+1ropUwnWrhJ37dZMqZo
	7zi3zn+k5BnDp3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=YAoeYj3jfX2WLCMIxDCRFDn4AOcISk0ydB+/Ehq7DPsd73wKUDLW2V6
	ZQ69fBZqqCeNw6p7ILl+nZdLiXsf8BMog2eNcfCcgUP7id8hTOmpSAl/GjjJ9a71
	ZZZTypF3zRvRsxOOuEvH3Ko8NfoYiqjLVknwVhGATj87JxIkSZfo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 346AD25721;
	Fri,  1 Feb 2013 21:10:22 +0100 (CET)
Received: from [79.193.90.228] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43699778; Fri, 01 Feb 2013 21:10:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_200_299 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, SMALL_BODY 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215269>

Am 01.02.2013 21:07 schrieb Sebastian Schuberth:
> mergetools: Teach tortoisemerge about TortoiseGitMerge

This subject doesn't make any sense if we don't combine the two patches.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
