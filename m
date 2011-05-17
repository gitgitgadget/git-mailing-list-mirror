From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG
 does exist
Date: Mon, 16 May 2011 22:32:59 -0700
Message-ID: <7v39kdj3hw.fsf@alter.siamese.dyndns.org>
References: <201105142137.16541.jnareb@gmail.com>
 <20110514210603.GA11502@elie> <201105151153.08826.jnareb@gmail.com>
 <201105161153.24382.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMCvB-0001R4-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab1EQFdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:33:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1EQFdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:33:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEE4B35A7;
	Tue, 17 May 2011 01:35:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQSYfRmjJHLgYo3xfypD2IjOXWg=; b=Nai4HO
	ld1mR9K93Yt1w5EO7dPoX4auQ6w6IXsO4Z1/AuaQ6amSaaSSD3H7qI3q8zpE8sIx
	0Wjs9Ftc8FHKb2S5ISPesTWnVwdkCEqErHHFh8Sdx72A/KoBwpeZeyl++s9KJBeg
	lr/rBucnUzeX0s4dkG3ogJHzkmsD/dKyNIgnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TtJ5rB7k+3iS8vA3KVdppc7iIToclx6q
	QWOEF0HC0NONHmoBnGwjunRVWk1B0JDISYXfjvdFLBmauoGbFzBv1x3e8dgJ05Rc
	ucs9p0baHI/IyaffweyC6SX/7zK7YGlS96oMbGSG8OVZz3xP0cRVP+xJDWcsD9Tv
	NoE7I5l7G+g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 900E435A6;
	Tue, 17 May 2011 01:35:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B988C35A5; Tue, 17 May 2011
 01:35:07 -0400 (EDT)
In-Reply-To: <201105161153.24382.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 16 May 2011 11:53:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 716BE872-8047-11E0-A85C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173785>

Jakub Narebski <jnareb@gmail.com> writes:

> This commit changes gitweb behavior so that configuration in
> per-instance configuration file can _override_ settings from
> system-wide configuration file.
>
> Note that strictly speaking it is backwards incompatible change.

I am not sure if we gain enough from this change.  As the system-wide one
can be arbitrarily overriden by per-instance one, the goal of this change
cannot be to make sure that the system administrator can enforce the
system wide policy over all the gitweb instances.

I think the goal is to let per-instance configuration have an easy way to
inherit from a common sane default, but if that is the case, wouldn't it
be a lot safer and more backward compatible way to just instruct people to
include that common default configuration at the beginning of per-instance
configuration file instead?  After all, you would need to give some advice
like this ...

> Check your resulting gitweb configuration, please.

... either way.
