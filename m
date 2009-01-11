From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v5 1/1] more cache effective symlink/directory
 detection
Date: Sat, 10 Jan 2009 16:48:15 -0800
Message-ID: <7vljtivfao.fsf@gitster.siamese.dyndns.org>
References: <1231527954-868-1-git-send-email-barvik@broadpark.no>
 <1231527954-868-2-git-send-email-barvik@broadpark.no>
 <49687440.5090506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 11 01:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLoWT-0008Eo-Vj
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 01:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbZAKAs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 19:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZAKAs0
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 19:48:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbZAKAsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 19:48:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 126238F24C;
	Sat, 10 Jan 2009 19:48:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D7AE28F24B; Sat,
 10 Jan 2009 19:48:17 -0500 (EST)
In-Reply-To: <49687440.5090506@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat, 10 Jan 2009 11:11:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D002B78-DF79-11DD-AB56-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105147>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Kjetil Barvik schrieb:
>> - Also introduce a 'void clear_lstat_cache(void)' function, which
>>   should be used to clean the cache before usage.  If for instance,
>>   you have changed the types of directories which should be cached,
>>   the cache could contain a path which was not wanted.
>
> Is it possible to make the cache detect these situations automaticall=
y
> by saving track_flags along with the cache contents?  Not having to
> clear the cache manually would be a major feature.

> Also, it's probably worth to split this patch up again.  First switch=
ing
> to your improved implementation of has_symlink_leading_path(), then
> introducing has_symlink_or_noent_leading_path() and finally adding
> LSTAT_FULLPATH and the fourth parameter of lstat_cache() etc. and usi=
ng
> this feature in entry.c seems like a nice incremental progression.

Both are reasonable suggestions.  Thanks.
