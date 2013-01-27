From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Behavior of stash apply vs merge
Date: Sun, 27 Jan 2013 11:12:53 -0800
Message-ID: <7vfw1mwibu.fsf@alter.siamese.dyndns.org>
References: <7vvcaiwltj.fsf@alter.siamese.dyndns.org>
 <2043716001.1806075.1359313796808.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzXfJ-0005PE-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab3A0TM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:12:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191Ab3A0TMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:12:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C663C2CD;
	Sun, 27 Jan 2013 14:12:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kct3BcBQEmwld7oNHplX1UPap1s=; b=hDQLij
	S+7v4SgG7KB24+uFwyENLBgLV7/0rywZRpQgADTbpYq9M1BGdB/hLKyC3/bf/DBf
	hgk/kxhccFuBVbgr3aEoBNHp7tJQbqemvmrSmvzVHOBxc4WxPF+bEz5UyDkZqTuU
	NEfi5gcPTnywZsB2taHcARH4UZxHvkMj/58po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wq1c2NpHA27q3B/7miwyKPi7MuS09+YW
	HXj3iGnl1M5CwaptwvLh2JjVQVFdwOC2gxL1JP06dsa38Uc8OokDKBX9/ofDNHHS
	cbzet4cvq6ZItaQ24Tr7Gn2EMNcgzASP6+wnbl5KFLEfGoxk/td6f/7a7CrZZgay
	w7hbX3FuBTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 203C7C2CC;
	Sun, 27 Jan 2013 14:12:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DA78C2C9; Sun, 27 Jan 2013
 14:12:54 -0500 (EST)
In-Reply-To: <2043716001.1806075.1359313796808.JavaMail.root@dewire.com>
 (Robin Rosenberg's message of "Sun, 27 Jan 2013 20:09:56 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D70D386-68B5-11E2-94F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214717>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Thanks. Feeling a bit studid now.
>
> I was actually thinking about using merge to implement stash apply
> in JGit. What we have is broken so I tried using merge to implement
> it and them compared to git merge --no-commit.. FAIL.

Do you have "cherry-pick"?

In short, "stash apply" is a "cherry-pick" in disguise.
