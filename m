From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 23:07:33 +0100
Message-ID: <5101B0A5.1020308@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, davvid@gmail.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 23:07:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUxf-00089p-SC
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab3AXWHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 17:07:33 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:41366 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754838Ab3AXWHc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 17:07:32 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 28C61289CDC;
	Thu, 24 Jan 2013 23:07:30 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 0ECA6272FC9;
	Thu, 24 Jan 2013 23:07:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=oqrC/NW1K0lGj+2OAf4Dp++cV+w=; b=GkhYovz5rXR9/beb26vI6xAK2mNo
	M8tSvrIt1xQahEB0kEWC546Dw9kBoUBRM4ysF5sKVCR442qSpXhgDoIbC7ta/NcX
	xElI+82HwUOGBpUtuBn0XndMz2f+5YUjvcSmsBeCp5m6gBkR+LOZSQQj3UculyfC
	pcVmVe6HgJy8Rfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=gz4oJaJyAEubuvSLxOHqlnEJt0ZoW37Ntgk/NM6RVte7fASICYE2QLW
	g4jUiTd8hrBusrOq0bb7wR1B1hxtR+m1rrkLm+UTmplcOasejgQSqH3uvrjEl2h5
	7+ZRlegp2x4Jo2v8i6OLmTt1cWVeecBtO1vPaKs+isVUbKPFoHHQ=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id C8810272E58;
	Thu, 24 Jan 2013 23:07:29 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43325774; Thu, 24 Jan 2013 23:07:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214464>

Am 24.01.2013 20:51 schrieb Junio C Hamano:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
> 
>> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>>   (starting with 1.8.0) in order to make clear that this one has special
>>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>>   version.
> 
> Wouldn't it make more sense in such a situation if your users can
> keep using the old "tortoisemerge" configured in their configuration
> and when the renamed one is found the mergetool automatically used
> it, rather than the way your patch is done?

That was also my first idea, however, TortoiseMerge uses parameters as
follows: '-base:"$BASE"'. TortoiseGitMerge uses values separated by
space from keys: '-base "$BASE"'. So both are incompatible (the first
approach has problems with spaces in filenames, the TortoiseGitMerge
approach fixes this).

>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>> index 4314ad0..13cbe5b 100644
>> --- a/Documentation/diff-config.txt
>> +++ b/Documentation/diff-config.txt
>> @@ -151,7 +151,7 @@ diff.<driver>.cachetextconv::
>>  diff.tool::
>>  	The diff tool to be used by linkgit:git-difftool[1].  This
>>  	option overrides `merge.tool`, and has the same valid built-in
>> -	values as `merge.tool` minus "tortoisemerge" and plus
>> -	"kompare".  Any other value is treated as a custom diff tool,
>> +	values as `merge.tool` minus "tortoisemerge"/"tortoisegitmerge" and
>> +	plus "kompare".  Any other value is treated as a custom diff tool,
>>  	and there must be a corresponding `difftool.<tool>.cmd`
>>  	option.
> 
> So in short, two tortoises and kompare are only valid as mergetool
> but cannot be used as difftool?  No, I am reading it wrong.
> merge.tool can be used for both, kompare can be used as difftool,
> and two tortoises can only be used as mergetool.
> 
> This paragraph needs to be rewritten to unconfuse readers.  The
> original is barely intelligible, and it becomes unreadable as the
> set of tools subtracted by "minus" and added by "plus" grows.

But I think this should not be part of this patch.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
