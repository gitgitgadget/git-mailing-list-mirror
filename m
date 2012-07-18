From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Tue, 17 Jul 2012 22:49:26 -0700
Message-ID: <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com> <20120717233125.GF25325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrN8h-0008Ce-HE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 07:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab2GRFtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 01:49:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2GRFt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 01:49:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FE36C99;
	Wed, 18 Jul 2012 01:49:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxQcTENsQd7gOiQMASkB8MuPSto=; b=a1yhsG
	Kv9zhNmJ7wCinIe2ZQdAqwXWj16ioJJjPuAkbFCOAO5LxyBYnY22C6YvBIG9nm9a
	NXnJHapYNA0vs1V6LyUIgMN5r/Tuv2Nyw5T9Kre/6XdO7dXkRWelMZOJ06W2LGhx
	Fx/9A2C9fB5wQJX8D+PYN6Kb9n/UDarzE9zTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aotz+XtUv6Tf0NkeHBbW3q/SCriF7kyj
	8/4V9zIxy/BcaUzP6c09NlQdoGrdHBa8O1DT0FC/Jg69EisL34nmkmVs1DeuTwjQ
	lRFsW0r0UIDiq5ossw2pCbiE/0RmRRscXSoBvou7LVxNCKOrz5ggWL3qP3+qJKGK
	atj7YhNuOwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06F8D6C97;
	Wed, 18 Jul 2012 01:49:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 118CA6C96; Wed, 18 Jul 2012
 01:49:27 -0400 (EDT)
In-Reply-To: <20120717233125.GF25325@burratino> (Jonathan Nieder's message of
 "Tue, 17 Jul 2012 18:31:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5665EB3A-D09C-11E1-ADB7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201647>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The mailing list archive at
> http://news.gmane.org/gmane.comp.version-control.git might be
> useful for seeing some examples of how it plays out in practice.

By allowing people to easily publish a completed work, and making it
easier for them to let others peek at their work, Git hosting
services like GitHub are wonderful.  But I am not conviced that
quality code reviews like we do on the mailing list can be done with
existing Web based interface to a satisfactory degree.

Patches with proposed commit log messages are sent via e-mail,
people can review them and comment on them with quotes from the
relevant part of the patch.  The review can even be made offline,
yet at the end, the list archive is an easy one-stop location you
need to go to see how the changes progressed, what the background
thinking was, etc. for all the changes that matter.

Look at recent ones (randomly, $gmane/199492, $gmane/199497,
$gmane/200750, $gmane/201477, $gmane/201434), and their re-rolls,
and admire how well the process works.

I've played with GitHub's in-line code comment interface, but
honestly, it is cumbersome to use, for one thing, but more
importantly, you have to click around various repositories of pull
requestors, dig around to see in-line comments, and I do not see how
we can keep a coherent "discussion" like we do on the mailing list.

There may be a hosting site with better code review features, but
all the code review of Git happens on this mailing list, and that is
not likely to change in the near future.


[Footnote]

$gmane stands for http://thread.gmane.org/gmane.comp.version-control.git/
in the above description.
