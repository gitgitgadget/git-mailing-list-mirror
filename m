From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 12:41:23 -0800
Message-ID: <7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
 <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
 <4D407099.4010805@web.de>
 <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
 <4D407875.7080607@web.de>
 <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:41:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCBR-0003kF-MR
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab1AZUlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:41:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1AZUlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55A53347D;
	Wed, 26 Jan 2011 15:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jT+Tk5ZwHwYsgkUrkaw0xENxM74=; b=l27pFY
	9lHTd+utfM4Gqrvmjb+8p/NgS/fyZXcv5GbARKe2zmq9OLpZl+M21f5YNa3xfQfg
	Er2aBep89pdZtfzLJP/09aYr/siJzKHBedzqQFGVn72ZKk31keglgY16zOkqZ8g+
	JjKwGSHM3lys7pJN5PxvtZm3NT+PnUI78hpaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+NO9YBao5kac83dk5oz2mMKiKyq3Wwr
	x7IJvWSjWbnpV+ISqfIVdhsOAH15CZ93pMU7kxdKu3Aho9o/E02I7Nhf0jwOq88z
	UPL1dAHhg/mhR3uUfpImSv8fvvdFmShbbTRqqRzJpHZthwhzW0cSxzy0YwLjNFBW
	t/EL0gj8zkU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20C5B3478;
	Wed, 26 Jan 2011 15:42:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C1A63471; Wed, 26 Jan 2011
 15:42:13 -0500 (EST)
In-Reply-To: <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
 (Julian Ibarz's message of "Wed\, 26 Jan 2011 14\:48\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C48B9E42-298C-11E0-B2F7-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165539>

Julian Ibarz <julian.ibarz@gmail.com> writes:

>> Hmm, looks like I lost you here ... you want to bisect in B although
>> you know what commit you want there? Care to explain a bit more?
>
> In B I have a feature to integrate in master branch. This feature is
> in branch old_feature. But this branch is really old. To try this
> feature I need to rebuild it at this version. To make the build
> success I need also to revert back the submodule C because B is
> dependent on it. But finding the good version of C that match
> old_feature version is a pain... Is it clear?

That sounds like bisecting in C with a frozen checkout of B to see which
version in C works well with that target commit in B you know you want to
use.  Why do you need to bisect in B???
