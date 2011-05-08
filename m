From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/48] i18n: git-pull eval_gettext + warning message
Date: Sun, 08 May 2011 13:19:06 -0700
Message-ID: <7v1v09rlmt.fsf@alter.siamese.dyndns.org>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
 <1304857280-14773-17-git-send-email-avarab@gmail.com>
 <20110508165254.GA20654@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sun May 08 22:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJARx-00039Y-Oh
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab1EHUTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:19:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1EHUTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:19:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27AA6593B;
	Sun,  8 May 2011 16:21:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0EyRuGBzB/Tj1vEAnNMCLzqNkRU=; b=RiNXPz
	AELZzEO88j+xMi/Zq2w++eAv51bc8xf7hhpjiHT3/wJFJYF/lGGlSXCCSs5NrvMb
	aLDarpTmlyP8eTM/f4cSDS7GNJyjOF0rrwHaVnvf2k7udJgpDWxNHsi5xiLtdb9I
	bWsUgd5OxlcoJqdg2zhs85O2OZilRurm+H3KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxTkdcxGteWxmxKvBQ5C3+87Bkdj5Cc6
	GdiD3lldwSa053q7wK9u82q4Nc+uwfrnSNKqRC9XrrvtIBDIldVJwgi37xasog8a
	1gnjzBwhR+EAVEJfphof52s5b2sxfVcESwchJC7jG/d2SA1wfZxR31RBmSt0sDP7
	/ANwt3k/Rhw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E93DF593A;
	Sun,  8 May 2011 16:21:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E25525936; Sun,  8 May 2011
 16:21:12 -0400 (EDT)
In-Reply-To: <20110508165254.GA20654@pcpool00.mathematik.uni-freiburg.de>
 (Bernhard R. Link's message of "Sun, 8 May 2011 18:52:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA59B430-79B0-11E0-9B37-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173177>

"Bernhard R. Link"  <brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
writes:

>> +	echo >&2 "$(eval_gettext "Warning: fetch updated the current branch head.
>> +Warning: fast-forwarding your working tree from
>> +Warning: commit \$orig_head.")"
>
> echo "$(...)"
>
> sounds quite wasteful and harder to read than necessary.
> The same also happens in later patches.

A very good point.  Just letting eval_gettext write out to >&2 should be
both sufficient and inifinitely more readable.
