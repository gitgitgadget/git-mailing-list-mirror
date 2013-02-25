From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/13] Help.c: add list_common_guides_help() function
Date: Mon, 25 Feb 2013 15:55:51 -0800
Message-ID: <7vehg4ne2g.fsf@alter.siamese.dyndns.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-6-git-send-email-philipoakley@iee.org>
 <7vmwuu5bm1.fsf@alter.siamese.dyndns.org>
 <4AEE9909C70D4810A228A367FB888AF4@PhilipOakley>
 <7vk3px3qzp.fsf@alter.siamese.dyndns.org> <512BF72F.9030404@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA7uE-0003dV-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 00:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab3BYXzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 18:55:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635Ab3BYXzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 18:55:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22DB5B7AC;
	Mon, 25 Feb 2013 18:55:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hs12dNB6k+ObMEzvpW/Mb2BRfDA=; b=ZBIxvG
	YAoXEgIeQRYx+UnkRjFnI5ZNIdzfdiiyMekl2TuhzVW5faP8Spx6iY30xpAFNLNd
	rwf9r/vcobLhbzkArTnkGoSV5iJN65MofZjPHs1fbytmlQ2RSOxcphHxjONK3qYW
	v9C9wa1gUekkys7A3SaXzKMY/nJDNM3iQ38VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7HhuKUxpgZUvw7A/6ziiW2w263FE2QL
	RpML3ppR0+mNJXaXqO1+RvgsRecIjo9ur/Ai6UJJN+kI0Z4WsLz9oblb5XKP56T4
	/G62XribrQB43uTC9dpyhm8Hj1BgkGA0ymWv1SV9s/CLS6WyshZnyFsgYA8RhlFg
	rZTK+67etdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17608B7AB;
	Mon, 25 Feb 2013 18:55:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 792EAB7A8; Mon, 25 Feb 2013
 18:55:52 -0500 (EST)
In-Reply-To: <512BF72F.9030404@iee.org> (Philip Oakley's message of "Mon, 25
 Feb 2013 23:43:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E30BE440-7FA6-11E2-9D56-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217122>

Philip Oakley <philipoakley@iee.org> writes:

>>> The first comment line fortells of patch 6 which can generate this .h
>>> file.
>>
>> The Huh? was about that one, not about reuse.  I do not want to see
>> a build artifact kept in the history without a good reason.
>>
> I'd copied it from generate-cmdlist.sh which is a common-cmd.h
> dependency and was introduced by
>
> commit a87cd02ce02e97083eb76eb8b9bfeb2e46800fd7
> Author: Fredrik Kuivinen <freku045@student.liu.se>
> Date:   Thu Mar 9 17:24:19 2006 +0100
>
>     Nicer output from 'git'
>
>     [jc: with suggestions by Jan-Benedict Glaw]
>
>     Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>

Looking at the change again, I do not see us adding a build artifact
(in the case of that patch, common-cmd.h) to our history.  Only the
recipe to generate that file exists there, which is the right thing
to do.

Why do we want common-guides.h which is clearly marked as "A
generated file" at its top in our history?  That was what made me
say "Huh?".
