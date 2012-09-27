From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring the location of ~/.gitconfig
Date: Thu, 27 Sep 2012 10:16:10 -0700
Message-ID: <7vzk4bqtd1.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
 <7v6270t2tb.fsf@alter.siamese.dyndns.org>
 <CAD1m08Wz7WqP8Yxgc6xuhBSntQ0PS6hGOzHWrcd0VAbARmkuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Anurag Priyam <anurag08priyam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:16:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHhI-0007Ne-GV
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab2I0RQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:16:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2I0RQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:16:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF8D9658;
	Thu, 27 Sep 2012 13:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//QURlsJTe6JdGmfNAEJYKQfxGs=; b=hfnxU4
	5amSL1ke3dJPnXvyH5CO4PCgEfaz8apbiC5MqtElAp4ciodu2aGSYpgZvDxo53kV
	wjwAPL0l/oamNsuhWw0raEydUMFqpsKxxA8QF1R62Bl0fMjjS7MsvPS9Up/fNf7p
	0YvQyfPMdSwyR0ftVoSRSvkzmKPyx1DlrxCVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVfe1MFltx3SR0BEKHE3ldeQ1iH3As6o
	YfyKLle1R6D9xeeAfwnd40WjjzIynVFS9JDWgQReYLjlIxs2BwtkjcSa+gUUEaKh
	eTmTn7GfAHDq5x62s6qntT4ZF+ZZMe5tao9nVwOX3toG5JNSFppRDkTvGNUq3lD9
	5mJ7y9uWTM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1979657;
	Thu, 27 Sep 2012 13:16:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E05709656; Thu, 27 Sep 2012
 13:16:11 -0400 (EDT)
In-Reply-To: <CAD1m08Wz7WqP8Yxgc6xuhBSntQ0PS6hGOzHWrcd0VAbARmkuUA@mail.gmail.com> (Anurag
 Priyam's message of "Thu, 27 Sep 2012 12:10:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0921D934-08C7-11E2-AB51-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206490>

Anurag Priyam <anurag08priyam@gmail.com> writes:

>> Not me. For that particular use case, my approach (long before I
>> switched the vcs that controls my dotfiles to git) have always been
>> to have ~/src that is version controlled, with a Makefile that
>> builds/adjusts dotfiles appropriately for each box and installs them
>> in the proper place.
>
> Makefile is what I wanted to avoid when I suggested Ram that maybe Git
> could _optionally_ read the location of global gitconfig from an
> environment variable that can be exported in zshenv or bash_profile.

Where exactly do the "zshenv" and "bash_profile" you mention reside,
and how are their contents kept up to date?  I am guessing it is
/net/srv1/home/ram/.bash_profile on machines that mount user home
directories from srv1 NFS server and it is to have a string like
"export GITCONFIG_FILE=/net/srv1/home/ram/dot/gitconfig" or on those
machines.  The contents of ~ram/dot/gitconfig may be able to stay
the same across boxes, but how is ~ram/.bash_profile is set up?
Manually?

Again, I am not personally interested; I think aversion of Make is
the root cause of the disease.
