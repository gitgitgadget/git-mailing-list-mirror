From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: fix clone @all regression
Date: Sun, 13 Mar 2011 12:54:29 -0700
Message-ID: <7vk4g2hk3u.fsf@alter.siamese.dyndns.org>
References: <20110312162246.GA8509@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 20:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyrNI-0007oa-UG
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 20:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130Ab1CMTyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 15:54:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab1CMTyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 15:54:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 28FCD363A;
	Sun, 13 Mar 2011 15:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Pgmmcex9Jb5nImzbPkIGtCSuty0=; b=dwtq/b69duSdFfvbv0rx
	++QeJlHrnV7m6MBmTTYpljx5N9ZijMqDWwxRIgTaYl96kW1sXAqAo0hkIMz7wFd0
	GOz6udW9l8/BOiLtrK5m0M3DqgORkNBJ3i+hyCBO0sdaityap7PQLdhlA9L4Gn8h
	jgKfnN8PQOORVmObWBiD0pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=T62fRShQpDp60f9FVJ9DpBfT6KCGk8g41JkylKtVDUXH5J
	PAaosB+lyYK5mVo0g1jWqYJNpmFBCoiYyurVqie59pzHJsABc9P5wmiWjz9mfBWu
	/f87FF11g7WHbuW0oFWVJ+5+s8qwzs2zHNgRyXflxReXi+7r3SywOemeFD3aY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA6F43636;
	Sun, 13 Mar 2011 15:56:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 574303635; Sun, 13 Mar 2011
 15:56:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0EF6BBA-4DAB-11E0-9608-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168978>

Pete Wyckoff <pw@padd.com> writes:

> My commit e32e00dc88948a730b8b1f3b8129f30c313713e7
> "git-p4: better message for "git-p4 sync" when not cloned"
> broke clone @all.  This fixes it per Tor Arvid's patch
> and adds a test to make sure it doesn't happen again.
>
>     git-p4: fix clone @all regression
>     git-p4: test clone @all
>
>  contrib/fast-import/git-p4 |    2 +-
>  t/t9800-git-p4.sh          |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletions(-)
>
> Please queue to maint.  Thanks,

The buggy e32e00d itself is not in maint, even though the branch it is on
whose tip is at 3820007 (git-p4: support clone --bare, 2011-02-19) could
be merged to maint if we really wanted to.  But it doesn't look like that
the changes on the branch are all fixes, so it is not entirely clear if we
want to.

In any case, will merge the result of applying these two on top of 3820007
(git-p4: support clone --bare, 2011-02-19) to master.

Thanks.
