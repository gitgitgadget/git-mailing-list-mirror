From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: finding $(prefix)/etc/gitconfig when prefix = /usr
Date: Sun, 07 Jul 2013 15:47:05 -0700
Message-ID: <7vmwpy2djq.fsf@alter.siamese.dyndns.org>
References: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
	<382862830.1053811.1373235806136.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 00:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvxje-0003Hk-EH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab3GGWrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:47:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab3GGWrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:47:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 409632F304;
	Sun,  7 Jul 2013 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKJj6xnMy8IUHQKFms+xHY/tvL4=; b=Uu/cdb
	0u5CZvetNEcsKtCE8t8L/1DNCDy/vEh3Y1tbyLSVmdErNI0J3Lk/OMweh0500EDH
	rWA4Ohjw5OMBgknmTMMLxsfMsODRjWLrWb9yTmt55n7sFBH8/F/mGTvHsOTy4vxN
	ybO1kwVM51s+9IrJxLDYTnUe3VJ2TTiGKLMa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pEdVn3MifXdtoDsG0mj06NffyoguJ8VT
	WD0t33vuBiVEaDosaBKJ5A8rvCrYxs6nQ5rfzst8JZot/iJcWGdb9witLOGR5hh3
	nvi+36kgmMlEJuVHImB9BKiPQSOso4pozUbHKZSN1cY3PJDEJ34fufgz2CQ2pzpN
	atmlNXFlTH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357682F303;
	Sun,  7 Jul 2013 22:47:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BC412F300;
	Sun,  7 Jul 2013 22:47:07 +0000 (UTC)
In-Reply-To: <382862830.1053811.1373235806136.JavaMail.root@dewire.com> (Robin
	Rosenberg's message of "Mon, 8 Jul 2013 00:23:26 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26E3C684-E757-11E2-BF2C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229817>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> I guess this isn't true either. Anyone has a better way of
> specifiying where the system wide config file is read from,
> or a user-parseable definition of $(prefix) ?

	... the system-wide configuration file (typically
	/etc/gitconfig), rather than the repository specific
	configuration file (.git/config)

should be sufficient.

>
> -- robin
>
> ----- Ursprungligt meddelande -----
>> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
>> ---
>>  Documentation/git-config.txt | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-config.txt
>> b/Documentation/git-config.txt
>> index 9ae2508..3198d52 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -107,7 +107,8 @@ See also <<FILES>>.
>>  
>>  --system::
>>  	For writing options: write to system-wide $(prefix)/etc/gitconfig
>> -	rather than the repository .git/config.
>> +	rather than the repository .git/config. However, $(prefix) is /usr
>> +	then /etc/gitconfig is used.
>>  +
>>  For reading options: read only from system-wide
>>  $(prefix)/etc/gitconfig
>>  rather than from all available files.
>> @@ -214,7 +215,8 @@ $XDG_CONFIG_HOME/git/config::
>>  	file was added fairly recently.
>>  
>>  $(prefix)/etc/gitconfig::
>> -	System-wide configuration file.
>> +	System-wide configuration file, unless $(prefix) is /usr. In the
>> +	latter case /etc/gitconfig is used.
>>  
>>  If no further options are given, all reading options will read all
>>  of these
>>  files that are available. If the global or the system-wide
>>  configuration
>> --
>> 1.8.3.rc0.19.g7e6a0cc
>> 
>> 
