From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames
 with
Date: Fri, 01 Feb 2013 21:17:42 +0100
Message-ID: <510C22E6.6010500@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org> <51032E96.2040209@tu-clausthal.de> <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com> <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org> <510C1872.3090304@tu-clausthal.de> <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com> <7va9rnaiz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1NIJ-0002XA-9t
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab3BAUcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:32:45 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:49575 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757090Ab3BAUco (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 15:32:44 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 03DE5289D33;
	Fri,  1 Feb 2013 21:32:42 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C4C4A26D27E;
	Fri,  1 Feb 2013 21:32:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=V3fnoa3JqZ9ykJljRt+sLMzQf7s=; b=CtFW9JPtWcL8CI34l4Oedl8WRyno
	tTgPDPcSFel0oY4n3a5LQ5Jx3N1/0gV1HIrQkQ9Dc87RdF76U4ZtoN6i9TGeAKLe
	RW/5VKCqbu6h/9Qj2CPUj7CpSuvgBwilH1WkmHHxtp5bYJHOS8t+rrne+PlYPcZf
	zZnkIJ5icAKryIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=esYAVS1y+raK5KjtbYeafMv8NU7ImWpSBvBvd8fuKe0+J8D462JSJtJ
	DHMFubSafnOn/j6KptCOQBqeuyqIYyJaF5Wj1WPhR2pX+1Lim/D6g7AvqC1idtdJ
	B04YCU4Jx5GOm3Dql+XWNgYs9kJOu3oqW/KdcmP31RkZOhVdgKsk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id EB06B299C03;
	Fri,  1 Feb 2013 21:17:37 +0100 (CET)
Received: from [79.193.90.228] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43701489; Fri, 01 Feb 2013 21:17:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7va9rnaiz4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_900_999 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215270>

Am 01.02.2013 21:15 schrieb Junio C Hamano:
>> TortoiseGitMerge is an improved version of TortoiseMerge specifically
>> for use with Git on Windows. Due to MSYS path mangling [1], the ":"
>> after the "base" etc. arguments to TortoiseMerge caused to whole
>> argument instead of just the file name to be quoted in case of file
>> names with spaces. So TortoiseMerge was passed
>>
>>     "-base:new file.txt"
>>
>> instead of
>>
>>     -base:"new file.txt"
>>
>> (including the quotes). To work around this, TortoiseGitMerge does not
>> require the ":" after the arguments anymore which fixes handling file
>> names with spaces.
>>
>> [1] http://www.mingw.org/wiki/Posix_path_conversion
> 
> Sven?

I just mailed a new patch. Thanks to Sebastian for pointing this out!

@Junio: Feel free to optimize the commit message.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
