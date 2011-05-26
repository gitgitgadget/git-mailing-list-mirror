From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add additional build options for Interix, and remove
 obsolete ones.
Date: Thu, 26 May 2011 11:06:00 -0700
Message-ID: <7vboypxrp3.fsf@alter.siamese.dyndns.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-2-git-send-email-mduft@gentoo.org>
 <4DDDF339.4000703@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Duft <mduft@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 26 20:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPexc-0001Nu-8y
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab1EZSGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:06:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1EZSGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB9AB5BFB;
	Thu, 26 May 2011 14:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51MI1jl5uNgX159UePXQUR8DUcY=; b=Q66izU
	0PXfv7+2jvrGviPMAGsMrTULuI4INXeqrZzzN/Nk4Zgd4NAnVVYCzOrU/BQphyfM
	FILWDfeTZL2DGKa4mGuO8iP5DpCHUNXSDeX8T7qx+GQ/KeuUvParymsVTfw0Sp6h
	1s3WNvyIH+XoYp8GHditucKXH3COitTJw8HFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSGIfGgtV3jd7dAQc/LW4glx+YD0LpDp
	Rls6RNeQNaUcEOknTZ2Y9/Wld/5KUMfNYp8hMTPplIey5C0PQsRzYKWq1ZuTNrXc
	C9s1Cs9gIHOz56/HtbUIODvhF5CGIhysbCCwhMXPwPkaa999DduLJEOe2SiHArT+
	+t1YJ52HVlo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A80585BF9;
	Thu, 26 May 2011 14:08:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF6F15BF8; Thu, 26 May 2011
 14:08:09 -0400 (EDT)
In-Reply-To: <4DDDF339.4000703@gentoo.org> (Markus Duft's message of "Thu, 26
 May 2011 08:29:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ECA4928-87C3-11E0-B81C-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174553>

Markus Duft <mduft@gentoo.org> writes:

> On 05/25/11 16:15, mduft@gentoo.org wrote:
>
> (sorry for actually replying to the wrong mail - wasn't subscribed to the list (but am now.))
>
>>> The removed options are obsolete, because interix support now
>>> depends on libsuacomp.
>>
>> and linkage with -lsuacomp happens automatically without any change in the
>> Makefile for anybody?  Just asking, as I do not have an access to (nor any
>> particular desire to get an access to) an Interix to figure it out myself,
>> and the only think I care about in this patch is if it helps only your
>> installation or it will help everybody who has Interix but not necessarily
>> with the same set of additional configuration as you have.
>
> Yes. suacomp installs itself as libc.{a,so}. Of course the path to the
> suacomp prefix needs to be told to the compiler. Without it, interix (at
> least the newer versions) are near unusable,...

You are much more familiar with Interix than I am, and if you were the
only person who uses Interix with git, I would buy that argument
unconditionally.

How has one built and used git before suacomp days? Are these users
extinct? Are there users who do not still use suacomp and for whatever
reason do not want to use it, but still want to use git?

What I am getting at is that I have to come up with a description in the
release notes, and I cannot decide what the entry for this change should
say, and if I can stand behind that statement.

Here is one version, based on my reading of what you said so far:

 * The build procedure for Interix now requires use of suacomp. Older
   versions of Interix that are incompatible with suacomp are no longer
   supported. The Makefile does not automatically tell "the path to the
   suacomp prefix" to the compiler, so you would need to do that yourself.

Doesn't sound pretty, and I hesitate to stand behind such a statement.
Abandoning obsoleted versions of obscure platform nobody cares about is
fine, but at least we should make it clear who are being abandoned by
saying which version. Also "needs to be told to the compiler" part needs
some end-user explanation in Makefile ("set HAVE_SUACOMP=/usr/lib/suacomp
when building on/for Interix", or something).

Here is another possible version (you would need to update your patch to
support both):

 * On Interix, it is preferrable to use suacomp to build git, but the old
   way is still supported. Give HAVE_SUACOMP=/path/to/suacomp to Make (or
   override it in your config.mak) when building git.

That is more easily justifiable, but I cannot tell from this exchange with
you how important to keep supporting the old way is (or if it is even
possible).
