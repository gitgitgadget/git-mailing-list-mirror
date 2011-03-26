From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_WORK_TREE and GIT_DIR with git clone
Date: Sat, 26 Mar 2011 12:40:58 -0700
Message-ID: <7vtyep3c1h.fsf@alter.siamese.dyndns.org>
References: <20110326125818.GA2621@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Sat Mar 26 20:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3ZMJ-00033e-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 20:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab1CZTlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 15:41:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab1CZTlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 15:41:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67593420E;
	Sat, 26 Mar 2011 15:42:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VCKAYt2dty1iIWaaxcO31u+pmZg=; b=ES5dYr
	tt7ZHU7MtbgmWTwG0QhJIx2zmV3jcb+1XxN2CMyfVyKMgKJ3IZJc6TPN2romZupJ
	d7XQ+74zWJn6NAWxwbT/qKHsN4yKG51pujgRPx8vdip5efyrGsTmBE/tMzCXDDkw
	Ntd0GOygN7FePv4qsPIFGCYtSux0FxOnG2fO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VvcgWI+vKQ/JZ9I3zjHMtoNECo/E8OA5
	MsU3/9pgkZL7UyxWxQeQO5UGPCIvj6UTtmh7Cb4jY/kHp5tZpj4cktSpkQUqsqC8
	dO5gZqFwzEI+47qoj+b840sgu0FpmRzbV35xQZIuW6Jei0aPSaa7VNfjn/KfJFbx
	TJEJgXvcmD0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4559A420D;
	Sat, 26 Mar 2011 15:42:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6708C420C; Sat, 26 Mar 2011
 15:42:44 -0400 (EDT)
In-Reply-To: <20110326125818.GA2621@camk.edu.pl> (Kacper Kornet's message of
 "Sat, 26 Mar 2011 13:58:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39EA4648-57E1-11E0-922E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170071>

Kacper Kornet <kornet@camk.edu.pl> writes:

> Is there a reason why git clone does not respect GIT_DIR
> variable.

Are you sure it does "not respect GIT_DIR"?  When you are running clone
locally, like that:

> GIT_WORK_TREE=repo GIT_DIR=repo/.git git clone <path>/repo.git

you have _two_ repositories that the command operates on on your system,
the one that you are cloning _from_, and the new one that you are
creating.

Which repository does your GIT_DIR talk about?
