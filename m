From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4
 make on Solaris
Date: Fri, 02 Mar 2012 11:46:59 -0800
Message-ID: <7vfwdqdbv0.fsf@alter.siamese.dyndns.org>
References: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com> <7vhay6etqc.fsf@alter.siamese.dyndns.org> <4F5118CF.6030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:47:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3YRa-0006mL-FG
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 20:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541Ab2CBTrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 14:47:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932360Ab2CBTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 14:47:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A069C72E8;
	Fri,  2 Mar 2012 14:47:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HpxjCmF4A7a2XkAaLIW4LdWRq70=; b=LysTgy
	kv5q8mYwzoloJrj5IR084EmkFKG1fLjPyLco8wCripRzc4qJD7Tg3ZS2GAxkk7QY
	cF4osZUs0V0RrQUSmZJ28kv9eGUplkmZ12BUwYf2viHe3HDqZWPXXLjRfriCHQWR
	8ZFIDT8FE4H7ddMyRjdnKX20fPgMIlZDJhac8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWogtBlHkdzkmtOpwZ8JZ73daeQtlu7p
	qolSIxCbdNB77eD0AizQ6NIpnrQBaZTFz1GWrPJRCJVscJ/yiP8130jW74hCV78S
	MMt7utyFxG5xDJCzGjcwGiesjpA6nFaHiVcPrwKB8NIMRuxHAa+bNcsgtwiq5Apa
	z8NAWzVgG2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D8A72E7;
	Fri,  2 Mar 2012 14:47:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2579072E6; Fri,  2 Mar 2012
 14:47:01 -0500 (EST)
In-Reply-To: <4F5118CF.6030402@gmail.com> (Stefano Lattarini's message of
 "Fri, 02 Mar 2012 20:00:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A9051AC-64A0-11E1-ACD1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192067>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> configuration of the Git tree using the the autoconf-generated configure
> script (as I do), he wants configure to Do The Right Thing automatically
> in this regard too
> $PATH before /bin and /usr/bin, and setting up an appropriate default for
> SANE_TOOL_PATH in 'config.make.autogen' accordingly.
>
> What would you think of a patch in this direction?

Yeah, that was exactly what I was suggesting, but it may not have been
obvious.

As I consider autoconf merely a secondary mechanism to set config.mak,
whenever I say "that is solved by local tweak in config.mak", letting
./configure to do that tweak automatically is already covered by that
suggestion.
