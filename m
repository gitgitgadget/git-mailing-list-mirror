From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Fri, 01 Apr 2011 15:21:03 -0700
Message-ID: <7vk4fdehps.fsf@alter.siamese.dyndns.org>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
 <201104010329.05299.johan@herland.net>
 <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
 <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mik-0004uW-BE
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584Ab1DAWVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 18:21:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab1DAWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 18:21:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4708483E;
	Fri,  1 Apr 2011 18:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LHfl0y5RQJC7jCKTiEUDWbestxc=; b=rRsB5N
	0/zMBZ/bMahybUaUR/gpMeW6GUQTWDR1SIHPw7H15zGaOCMjJFllcHBiwTVWZaZi
	VtLnEeWP+bfiZAl9OtzXK2bnMIZZum6Fy+Pnjn2hslKgUlTA5msUOza96th+xPGG
	Id9H7C6kfJ0mZi4GSXPIJQ/agvovM9aRej9do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+CjF5EIltApmureIuWPVQmTWFBwms5e
	CXw1q/f/I0ofYvahnfkweYJhL/nlia+NYAqx/fzgGbGWyFwLDZqQCTyGbVcA4pU6
	M+HGzh0kcpl3xf7fW9+GvYlY/RQLS6bG7GCIiD2qCJNNaUGfGgbHcQVCdgx2P/lp
	DBfp6H3+dYc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E55F483B;
	Fri,  1 Apr 2011 18:23:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4AA4483A; Fri,  1 Apr 2011
 18:22:55 -0400 (EDT)
In-Reply-To: <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
 (Shawn Pearce's message of "Fri, 1 Apr 2011 17:49:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B842578-5CAE-11E0-81B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170631>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Apr 1, 2011 at 17:39, Junio C Hamano <gitster@pobox.com> wrote:
>> While I am not sure if letting a clone proceed while there is a concurrent
>> push is even a good idea to begin with,
>
> What? Why?
>
> Are you suggesting that Git hosting sites disable readers while there
> is a push occurring?

This is an irrelevant comment isn't it?  Hosting sites coming via git
protocol will not suffer from this "in-progress .keep not readable" issue
at all.

I was responding to the motivation stated in the commit log message, the
file-based "cp -r" copy or cpio clone, which are _not_ a safe thing to do.

Because "leftover .keep" alone is a good justification, I was hinting to
drop that other motivation from the description altogether.
