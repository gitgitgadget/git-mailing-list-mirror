From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Enhance tortoisemerge to work with
Date: Sat, 26 Jan 2013 01:58:45 +0100
Message-ID: <51032A45.1030308@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyu6w-0007LW-GQ
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab3AZA6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:58:50 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:33162 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753527Ab3AZA6s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 19:58:48 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 9D992289CFC;
	Sat, 26 Jan 2013 01:58:41 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 80991272D7E;
	Sat, 26 Jan 2013 01:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=lw28oyBywefyYYhCDs6pM1CQS9E=; b=HSAdddEzhF/oVk/Q635PrZXJHjwL
	FMsegE8EtJOsBWe9vJQd3AMFqBDBwd6RsHl2r37daMQnndOepob9th8AQFp7G/HD
	QA4JTvKl2mE1kPrquONRRPabkngj7lqYDeXiAYFEj2pvh4BgCSy+i77vJ9uz50N7
	5OuuXJf5yM3jL9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=zj28gTzl/YjGj1irNZb5Q0GpxGZLI6B60vWd0gia6f+/YIzhEk/8+8q
	My5vPXkXV8fZ6fCRsocxGGUL6s9hb1kWExIdvgePsFJAROInk2aUjFXHWoyfbDLz
	FLEyMHQN6pl3/H4WGYOVqAAyKkc8BuP/u7lHlJjtSu3qoq1cLq6c=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id CD03C272D5A;
	Sat, 26 Jan 2013 01:58:40 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43384638; Sat, 26 Jan 2013 01:58:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v622l5d87.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1100_1199 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214604>

Am 25.01.2013 19:28 schrieb Junio C Hamano:> Sven Strickroth
<sven.strickroth@tu-clausthal.de> writes:
>
>>  TortoiseGitMerge and filenames with spaces
>
> ??? ECANNOTPARSE.
>
> ... ah, wait.  Is this a broken-off tail of your subject line?

Yes.

>> +		touch "$BACKUP"
>> +		basename="$(basename "$merge_tool_path" .exe)"
>> +		if test "$basename" = "tortoisegitmerge"
>> +		then
>> +			"$merge_tool_path" \
>> +				-base "$BASE" -mine "$LOCAL" \
>> +				-theirs "$REMOTE" -merged "$MERGED"
>> +		else
>> +			"$merge_tool_path" \
>> +				-base:"$BASE" -mine:"$LOCAL" \
>> +				-theirs:"$REMOTE" -merged:"$MERGED"
>
> Hmph.
>
> How was the support for "names with spaces" added in this new code?
> I do not spot what is different between this "else" clause and the
> original body of the merge_cmd (which only supported tortoisemerge).
>
> They seem to be doing exactly the same thing.

Erhm, no. As already stated and also mentioned in the commit log:
TortoiseMerge has cli parameter key-values separated by colons,
TortoiseGitMerge has key-values separated by spaces.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
