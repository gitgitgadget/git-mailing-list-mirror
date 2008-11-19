From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] On how to manage tags fetched from remote?
Date: Tue, 18 Nov 2008 18:43:59 -0800
Message-ID: <7vzljwsads.fsf@gitster.siamese.dyndns.org>
References: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "rae l" <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2d4m-0003Mi-Ra
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 03:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYKSCoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 21:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYKSCoa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 21:44:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYKSCo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 21:44:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96DCB1701A;
	Tue, 18 Nov 2008 21:44:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8CF551701E; Tue,
 18 Nov 2008 21:44:01 -0500 (EST)
In-Reply-To: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
 (rae l.'s message of "Wed, 19 Nov 2008 10:27:37 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC4BCE02-B5E3-11DD-9481-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101311>

"rae l" <crquan@gmail.com> writes:

> I use one git working tree to track many remote git repository:
> ...
> 2. Store a no-tags config item to the remote config, which like:
>   [remote "linux-iscsi"]
> 	url = git://git.kernel.org/pub/scm/linux/kernel/git/mnc/linux-2.6-iscsi.git
> 	fetch = +refs/heads/*:refs/remotes/linux-iscsi/*
> 	fetch-tags = false
>   when git fetch read the no-tags config, it will disable tags from this remote;

Slurping very many (possibly unrelated) projects into one repository is
your choice (I wouldn't comment if it is a sane choice -- I do not have
time to ponder the pros and cons.  If it suits your needs, that's good
enough) If you do not want tags from some repositories but do want from
some others copied to that repository, per remote configuration feature is
exactly how it was designed to be used.
