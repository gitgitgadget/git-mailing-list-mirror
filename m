From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] git-grep: Bail out when -P is used with -F or -E
Date: Mon, 09 May 2011 23:11:25 -0700
Message-ID: <7v4o53m6eq.fsf@alter.siamese.dyndns.org>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1304977928-7142-7-git-send-email-michal.kiedrowicz@gmail.com>
 <7vfwonmikr.fsf@alter.siamese.dyndns.org>
 <20110510072439.6b288715@mkiedrowicz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:11:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJgAc-0007u2-VO
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 08:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab1EJGLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 02:11:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1EJGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 02:11:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4D525DCA;
	Tue, 10 May 2011 02:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=++C5kgE6YQ1i9/OdUY/ewd+Xfa0=; b=OxBXKC
	bJ+90avCbe7Fh+Jy+0PXYhh+McL4+NeVT1LoS6WDLBtwr2oVQEvFaXqNyFOZ/Pt2
	cDgHP4HMkLL2fAWaLeuev6wW6wdcoN8wwALkd4eMC3gKccchJTldHWRDEW33wazZ
	3oHvEjyRDh/WRAMHckoQeZ/mKJtOTaZ9DRoh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5rOfD8jq/2YhxlTace30WZARhtZDGXX
	dX46dVc5ApecchdMmd3tiw7AtmIM82zRlUzw4YF+HQ4GiO6k/P1JiFZqVW4Qx6on
	vdLviRl6+8zlkwmzjVkmAL+EiMWVKWtclk7m9qArfihhaH0JAc/4EzOK0G/Bscig
	/jmKSZwxIPM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82FCC5DC9;
	Tue, 10 May 2011 02:13:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6D245DC6; Tue, 10 May 2011
 02:13:31 -0400 (EDT)
In-Reply-To: <20110510072439.6b288715@mkiedrowicz> (Michal Kiedrowicz's
 message of "Tue, 10 May 2011 07:24:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5CAC8F2-7ACC-11E0-97CF-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173314>

Michal Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

>> We would need some tests for "grep -P", no?  
>
> What about those in patch 5/6?

There are some, but we would also want to see negative cases where
compilation detects an incorrect regexp.

>> Please throw in the
>> "last one wins" and "command line defeats configuration" when you add
>> one.

> +test_expect_success LIBPCRE 'grep -P -i pattern' '
>
> in patch 5/6 :). Or perhaps it doesn't work for you?

These I overlooked.  Will remove the "-i -P does not work yet".

Thanks.
