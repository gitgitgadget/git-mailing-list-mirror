From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising 'git-describe --all --match' behavior.
Date: Thu, 19 Jun 2014 12:10:38 -0700
Message-ID: <xmqq38f0hg0h.fsf@gitster.dls.corp.google.com>
References: <87ionxxbz8.fsf@osv.gnss.ru>
	<xmqqr42khl3l.fsf@gitster.dls.corp.google.com>
	<87d2e4d8w7.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxhjd-0004UH-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 21:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934376AbaFSTKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 15:10:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57147 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039AbaFSTKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 15:10:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8EC3204A8;
	Thu, 19 Jun 2014 15:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XG8n5fr7pdkQRZVr212HypDGVTw=; b=M/3QZz
	kZXA3FArl8L7JN4oD3NMA/Goof4XMxCgeNPW2bTsZdgn93wnUJxdjsRrnQKjhjtG
	F60wmyx9ET6P97GyqCixnZsvQNIvFcPh8Wb8ECRHk+Lt4qQU4IQskmqoYSNV12QN
	9KCTCwtx+bD2Xo5UPPnJLVDWf+Uihl+mtb1HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0jzlLhnRWNzk7slBManL8Z3BM48p1TE
	Az4IlcOsp4/+XawsFV8+OU59EPXpqy26EwZhLP6o3ec7j5QsyRrxsv/eHkImuyyA
	S8Tp8OHenZdpZMcoarnFbPyYwokwfVyKsyZw7CBN+mraBYSE3xXLrLb0aRoagCjs
	w1ztvNC7XjE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C773D204A7;
	Thu, 19 Jun 2014 15:10:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6697204A5;
	Thu, 19 Jun 2014 15:10:35 -0400 (EDT)
In-Reply-To: <87d2e4d8w7.fsf@osv.gnss.ru> (Sergei Organov's message of "Thu,
	19 Jun 2014 22:58:00 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6489DA1A-F7E5-11E3-B724-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252173>

Sergei Organov <osv@javad.com> writes:

> Will something break if it won't helpfully prepend refs/tags/ once
> --all is given?

"describe --all --match 'v*'" will no longer match a tag v1.2.3, and
forces the users to say "describe --match 'refs/tags/v*'", and these
users will probably see it as a new breakage, I would imagine.
