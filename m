From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #04; Sat, 9)
Date: Mon, 11 Feb 2013 08:01:51 -0800
Message-ID: <7vr4kmon4g.fsf@alter.siamese.dyndns.org>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <vpqliavxlep.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:02:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4vph-0000wn-JU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab3BKQBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:01:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607Ab3BKQBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:01:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83637C4C5;
	Mon, 11 Feb 2013 11:01:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cgiGaoCvea9K2DVtcocEbrOPvXU=; b=hkI4BV
	NA+XVrxrimm723XK8woxY0gakfdmuFbbEgr5DB/EQyacdvOSJ0PTwIBmoZWIXAf+
	q49SkRp5ANzTKb6JBNPFu8IcTHqPHW4R/YFMPFrX04NBJAkCnXuZromSU+UDWgOY
	1rU1KZa8q2A8MS8HVK7kMk5ALs75f9F75pBu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XIKwbCcSdFZR2F7Rp2wfRWH7wLuojQxP
	aupfWULbo8EBTcLBcsVv5epFOiBCrOUAae2kUGcQHP5yyJvYrOrls92qcs88xtx8
	LAjv/LFxBTibmTI5HKqSaPq6FAOkfFWaoi2gefX+Owah68VEKqDaE0N4ebWzUN3A
	Q+3sGPuYgDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78261C4C4;
	Mon, 11 Feb 2013 11:01:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E45F9C4C2; Mon, 11 Feb 2013
 11:01:52 -0500 (EST)
In-Reply-To: <vpqliavxlep.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 11 Feb 2013 10:14:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59F6F1CE-7464-11E2-BC76-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216038>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/allow-contrib-build (2013-02-07) 2 commits
>>  - perl.mak: introduce $(GIT_ROOT_DIR) to allow inclusion from other directories
>>  - Makefile: extract perl-related rules to make them available from other dirs
>>
>>  Will merge to 'next'.
>
> These two patches do not make much sense without the 3rd one:
>
>   [PATCH 3/4] Makefile: factor common configuration in git-default-config.mak
>
> because perl.mak uses $(pathsep) that is defined in Makefile, hence
> unreachable from external callers.
>
> You can either drop the series (I still think it's a good thing to make
> the toplevel Makefile more modular, but I have no longer a personal
> interest in it since the original goal is already reached by
> mm/remote-mediawiki-build), or continue the discussion on [PATCH 3/4].

Ahh, you are absolutely right.
Thanks for reminding me.
