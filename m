From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Mon, 29 Aug 2011 14:05:37 -0700
Message-ID: <7vd3fo53oe.fsf@alter.siamese.dyndns.org>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7v62lg6tr3.fsf@alter.siamese.dyndns.org>
 <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy91q-0003iV-Gl
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab1H2VFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:05:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab1H2VFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:05:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9374B42C6;
	Mon, 29 Aug 2011 17:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=An84mpW1PkSaP7qOEknZPDWbJzA=; b=OUvrwY
	wapxpdL/BTCemL8Q7OUl1GiG04k1VcGUa1SHmP9dRE9LsoPMqICUDRokeB0OrRFO
	MoB4pdBhIXbFwMQexCfUxuVfA+rWT8xORu+MmxPnwUfZHJcUJkn1S4mJ2V/bpv8G
	5vDyBLFCGui+PxKWEI5J4OZhUWWZH/8GiBF6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T3obM+96kiMhVvyWbnMUvmTw987HQttd
	aE+z080r2SCBQHpGYKfD1Z6bR0pNPuVkwp/uMMKeE5+/focmPXXq0EsnOnjswyU8
	7NULCb/5vrjBgaJlvK1BhBHpSuiA/i6LDWFlM8nzUkb18rGsvOpdfnJgV6cwyC/m
	TEioJ38FNWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8963242C5;
	Mon, 29 Aug 2011 17:05:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2065642C4; Mon, 29 Aug 2011
 17:05:39 -0400 (EDT)
In-Reply-To: <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
 (Giuseppe Bilotta's message of "Mon, 29 Aug 2011 19:51:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5DD2FAC-D282-11E0-A5EE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180352>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Nope, it doesn't have index .... lines. Still, the patches seems to
> apply correctly. Well, the couple of patches I tested did, at least,
> even though they were marked as diff --git and they were lacking the
> index ... lines.

Does "am -3" do the right thing when the patch does not apply cleanly, for
example? What about renaming patches?

Until we are reasonably sure that we can grok it reasonably well, I'd
sleep better if we stripped " --git" part from a patch that is known to be
produced by somebody that does not fully re-implement "git diff".
