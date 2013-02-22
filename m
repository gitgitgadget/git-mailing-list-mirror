From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] hash-object doc: "git hash-object -w" can write
 invalid objects
Date: Fri, 22 Feb 2013 15:07:20 -0800
Message-ID: <7vtxp4aqxj.fsf@alter.siamese.dyndns.org>
References: <kg8ri2$vjb$1@ger.gmane.org> <20130222230132.GB4514@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91iY-0000ru-Fb
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945Ab3BVXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:07:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724Ab3BVXHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:07:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38846B125;
	Fri, 22 Feb 2013 18:07:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fsj4GHF9NvxqLcvMD5NDez421wQ=; b=jm2S8p
	YCEE8USFC/54BYprFXD8JrCosF9eB7q1WlMT4wW5SUhbqDnBAIOF/Kix1MRSDDtA
	vJXH6SkQLuR/hoUxhjuTcI1zGthdeh9jnlpD+ZmB4//vFvBt8WnQ2BH5q9zgYEIT
	oXD2LYSiZU4npd14GaYibk8p829mWnp909rkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aogHDW474gzuIZXhgEoKf5doxprGQpGb
	OnWykosdb+mVyxxWsdkE9E0WLEx3BKtA8w3xa1q0+/0RnIB8YEhX1kgYISVohbkV
	17em5f931S07s61Zk+29jI4kN23Z5A4WgYR4umyNshPGtbnwpseycHui4WrwHKg5
	7HKvom6sBPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C70EB124;
	Fri, 22 Feb 2013 18:07:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 993ADB120; Fri, 22 Feb 2013
 18:07:21 -0500 (EST)
In-Reply-To: <20130222230132.GB4514@google.com> (Jonathan Nieder's message of
 "Fri, 22 Feb 2013 15:01:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CCB903E-7D44-11E2-9C8E-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216877>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Perhaps by default hash-object should automatically fsck the objects
> it is asked to create.

Yes, and let the experimentors to override when they are trying to
invent a new object type, finished a reader but not a writer (that
is why they are exprimenting with hash-object) nor updated fsck,
with an explicit command line option to "hash-objects".

Then we do not have to say "-w by default can create an invalid
object" in its documentation.  In a sense, allowing to create any
garbage (by the definition of then-current fsck and the rest of the
Git) is the raison d'etre of the command.

Thanks.
