From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sat, 14 Dec 2013 11:33:20 -0800
Message-ID: <7vvbyrgrcv.fsf@alter.siamese.dyndns.org>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
	<CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
	<beee32a53ece8b839578703deb851eaa@matos-sorge.com>
	<CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paulo Matos <paulo@matos-sorge.com>, git <git@vger.kernel.org>,
	git-owner@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 20:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vruxx-0001ex-FI
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 20:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab3LNTd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 14:33:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791Ab3LNTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 14:33:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860EE58D19;
	Sat, 14 Dec 2013 14:33:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kx/IeCZhwKMsM7JXMxdsUvF9f6E=; b=qiPN6U
	ogOT0/3SyqRm3PO5DOiw7tirHVOo3JTbGfpD5KTDKLFq3rLpt9YPpB036sPvtICv
	Mq3r3T5OPqawo0oYT7xPdUrUb/KSUEsntiqvPyt7zh0aHKW65xdAKwNezzP4mBRy
	uaFtUCpPX1SDN5eGXyqHNkbJyj4ct0QsRpTJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EU0b1WuodK+c3AqSqtkq5Ov8JKAQkv4y
	Gvc0sd6w7rT2z6AU0+1Z+f0aYtU6gTmS8I3dSH6eU+AM5BMg5aWsjeqYoSAonyLX
	pnj41kQ9Ng55874HRKpT6J/4foE9vWNymcN2aY0Ye80GFgwMWCEIFX1dgbB3PIcS
	0ioUhNvT2+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C9758D18;
	Sat, 14 Dec 2013 14:33:22 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7848358D16;
	Sat, 14 Dec 2013 14:33:21 -0500 (EST)
In-Reply-To: <CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
	(Antoine Pelisse's message of "Sat, 14 Dec 2013 10:40:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 9756AF90-64F6-11E3-928F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239312>

Antoine Pelisse <apelisse@gmail.com> writes:

> If you only want to see the diff applied to master, you
> should run:
>
>     $ git diff --ours

Does "git diff HEAD" have the same/similar effect?

> You can also have a look at what is currently being applied:
>
>     $ git diff :1:gcc/tree-ssa-threadedge.c :3:gcc/tree-ssa-threadedge.c
>
> By the way, does anybody know a better way to do that ?

In a merge, you can say "git diff ...MERGE_HEAD" (three-dots).  You
should be able to tell "git show" the commit you are trying to pick
during a cherry-pick, I think.
