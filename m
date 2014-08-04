From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Mon, 04 Aug 2014 10:42:22 -0700
Message-ID: <xmqqtx5srw1t.fsf@gitster.dls.corp.google.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-2-git-send-email-pclouds@gmail.com>
	<xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com>
	<xmqqtx5wuma8.fsf@gitster.dls.corp.google.com>
	<53DD2A54.1030403@web.de>
	<CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 19:42:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEMHO-000454-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 19:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbaHDRme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 13:42:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53310 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbaHDRmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 13:42:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF8622DE24;
	Mon,  4 Aug 2014 13:42:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31kcHVawiG5k0cyraxuNR93Dd8w=; b=jpNk4H
	60miv5CaRZ4NV8MRG0aTN9p1JjFX60VC2RzWX7bMHaL1xbJWErqabtCwUKj0GlI5
	EuD4/uPbB3s9V7Tl2Vv/P/JeOYboLY9ToiLsc3qOXaZoRtUYyve59xJ7fcx27MQ8
	U0Jjilyn0W7ZxCOb59IafGmB0O0ZbVrC4tmy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqYEd+OrF8LvLgnWpWYEG6pyK7EDwF4p
	Cwm3zVQQ8e6hBUSPgtUSnx3l6g6XSV5xjEHGIyMtdRFO8xIouaxJ1dVDFCCck9+B
	U6WjxNvBBcfI8Qssf3KwrWjxmzBcOvjno6Qcu1W1jzYKrB4HjeDfVgviOGHTPjuG
	gO9qd5pmRQk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4AD92DE23;
	Mon,  4 Aug 2014 13:42:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 328E42DE0C;
	Mon,  4 Aug 2014 13:42:24 -0400 (EDT)
In-Reply-To: <CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 4 Aug 2014 17:13:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B189D0E4-1BFE-11E4-B8D0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254747>

Duy Nguyen <pclouds@gmail.com> writes:

> I didn't realize Mike is making a lot more changes in lockfile.c, part
> of that is converting lk->filename to use strbuf [1]. Perhaps I should
> just withdraw this series, wait until Mike's series is merged, then
> redo 3/3 on top. Or Mike could just take 3/3 in as part of his series.

During the pre-release freeze I would like to see new topics be
calmer ;-)  Serializing or not, inter-developer coordination is
always very much appreciated.

Thanks.
