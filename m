From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 02 Jun 2016 12:33:33 -0700
Message-ID: <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
References: <146489432847.688.11121862368709034386@typhoon>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YNB-0007i0-BB
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbcFBTdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:33:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751360AbcFBTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:33:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD5391F9BE;
	Thu,  2 Jun 2016 15:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IfNYIpkCMb7UUwGRZh774n6Ddy4=; b=Ejxb19
	6Rc73Vq2ilpdBaLRcHy6ohFnkB44/BSwAAUwV6FW2aoQtMWIF1RVfDduALfcGGUA
	zSLtSRLVMpWTvX7N6O43fmzaBPYrfTfgK0XwoRDz+Mm5d8ogFrUVZ5CSM+wAbsBg
	AWb4pkgt6MazOKey8Jp76i9p45wuLdEHFgOqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IZV1PCzoyadcnDdSvlBMOMbmNZYKFVIB
	OnE4TDM+6tZw5mGuVBxfA73Z+jeOC5H1Hs3a3iQYlbbHLjeuLDt71K8WjIGWvRl+
	TN6TLz5i/NHRTiN+j8nAg3X7eSnY97n4L2TYoe5LaVi9Nfy91LhoZtbEdBv83hny
	8wIpfXNKkPI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5D6F1F9BD;
	Thu,  2 Jun 2016 15:33:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24C5D1F9BC;
	Thu,  2 Jun 2016 15:33:35 -0400 (EDT)
In-Reply-To: <146489432847.688.11121862368709034386@typhoon> (Lukas
	Fleischer's message of "Thu, 02 Jun 2016 21:05:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5AB7BD0-28F8-11E6-A929-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296227>

Lukas Fleischer <lfleischer@lfos.de> writes:

> When running `git push`, it might occur that error messages are
> transferred from the server to the client. While most messages (those
> explicitly sent on sideband 2) are prefixed with "remote:", it seems
> that error messages printed during the automatic householding performed
> by git-gc(1) are displayed without any additional decoration. Thus, such
> messages can easily be misinterpreted as git-gc failing locally, see [1]
> for an actual example of where that happened.

Sounds like a sensible goal to me.
