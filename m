From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP] completion: complete git diff with only changed
 files.
Date: Wed, 18 May 2011 13:00:11 -0700
Message-ID: <7voc2zbwz8.fsf@alter.siamese.dyndns.org>
References: <4DD30F87.2000807@gmx.de>
 <7v8vu4efvj.fsf@alter.siamese.dyndns.org> <4DD3C814.8000100@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Paul Ebermann <Paul-Ebermann@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 18 22:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMmux-0006Gt-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 22:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1ERUAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 16:00:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1ERUAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 16:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64E5045FF;
	Wed, 18 May 2011 16:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rotKm9PGp+AzLH3XTkDqojefJw=; b=nm11eh
	zcIsCOV5loAsA2PQbD0YaLoSMYnNcy6djqEHeKnNwK/O4Kd87sH064oWlhCuLsBY
	8uiYcqykYyCx/SwyGppjPrRsSh/3DdrMmhfX40Y1NLFxluTtLOIzG6Lh3xfKY5Yp
	ddZr3GyGKlrYr+YLNYFyKibIx8S6RA0QqxlY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Px5lE6AvXEvTCJqMKPOiNNoi9UYrct2y
	a8QHyuOjxlpNvtTJaorBPfyNgbQgz4Rkhm3R1DR69yLvA4CxsXZNqlLJMHgblcdg
	7S+V0Hz1n3gEMIy9Dgf8GCWbxR/swzCepcwwYEaKloBRC2WrV4p+7syptHk6w2ef
	GCSzzLbxSis=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31C6345FE;
	Wed, 18 May 2011 16:02:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 07C2F45FA; Wed, 18 May 2011
 16:02:19 -0400 (EDT)
In-Reply-To: <4DD3C814.8000100@gmx.de> (Paul Ebermann's message of "Wed, 18
 May 2011 15:22:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF4E9EFC-8189-11E0-B87A-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173899>

Paul Ebermann <Paul-Ebermann@gmx.de> writes:

> I'm normally using (for differences to head) git status first, and then
> have a look at the files I really want to see. Then completion of only
> the changed files seems useful.

By the time completion offers you the choices, you already have spent
enough extra cycles to compute the paths, which is half the cost of
generating the diff itself.

I have this nagging feeling that you are trying to solve a problem that
does not exist.  Perhaps you have too many things going on in your working
tree at once, and if git helped in such a way that your workflow does not
have to touch so many (possibly unrelated) things at once, you do not have
to worry about unconstrained "git diff" output overwhelming you?
