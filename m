From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 16:26:23 -0800
Message-ID: <7vtywvb9hs.fsf@alter.siamese.dyndns.org>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
 <loom.20091116T003914-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Weseloh <Peter.Weseloh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 01:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9pQV-0006lr-83
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 01:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZKPA02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 19:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZKPA01
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 19:26:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbZKPA01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 19:26:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 600C89EF7D;
	Sun, 15 Nov 2009 19:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AdNVAQBAX2EaaggkpLi5e20rKZI=; b=bvL9QBwJ3lZBF1oAXnp78NA
	pLAc4PvRsCQxRxQntQfSrQhBvDaY+JCcKblUv7eL5Gbdl858AnsYJLALAFBIVcYJ
	pE6awG+OqZAINesDgBEr/Ui2NNzVLj3mnIF6J2Ek17pl7YCA6PMTOVrTIR7N2b0A
	L0Q2zyOobEdTQux9Ma+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yfOOajqwdZyFqSNKryOPP0ao0zCjmO8LNZ0NiRk7QP/xKDZ4X
	/H05nuj/aAfhHWnUmylIkg6zP4c20qli/9Bg3ENgIuVjQV8qTDYb93OWcJbyiQNG
	YWQj+IE5VEW7EtlcVe7+U3tVYN7e7uo0jybpcPhe3xT/Pa7rwYRzquP4yU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C2AD9EF7B;
	Sun, 15 Nov 2009 19:26:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 457C19EF7A; Sun, 15 Nov 2009
 19:26:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE550B84-D246-11DE-93BA-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132976>

Peter Weseloh <Peter.Weseloh@gmail.com> writes:

> Does that mean this feature will not make it into 'master' any time soon? 

It does not mean anything about this _feature_, but it does mean this
particular _implementation_ is not likely to.

> Having the ability to do sparse checkouts only of the repo sounds like a
> way out.

There is a big difference between (a) a feature is desirable and (b) a
particular implementation of that feature does things right.

The change in the topic is very intrusive and I am hesitant to merge it
into even 'next'.  Before considering inclusion to 'next', it does not
matter that much if a topic realizes the feature as it advertises, but it
does matter a lot if it breaks things for people who do not need the
feature.  While 'pu' has carried this topic for quite a long time, we
haven't heard much success report from folks like you with the need for
the feature if this implementation worked well for them without breaking
things.

I am not convinced that it won't regress fundamental things for the common
codepaths when "sparse" is not used, and the latest update patch posted to
the list (I do not think I picked it up) seemed very likely to regress
things for the normal codepath.

> Another question: What's the timeline for 1.7.0? I couldn't find anything
> about it neither here nor in the wiki.

When it is ready.  But it is likely that there won't be 1.6.7.
