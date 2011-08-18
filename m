From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] push: Don't push a repository with unpushed
 submodules
Date: Thu, 18 Aug 2011 13:32:26 -0700
Message-ID: <7v4o1ea2at.fsf@alter.siamese.dyndns.org>
References: <1313312613-2647-1-git-send-email-iveqy@iveqy.com>
 <20110818192157.GA10598@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu9GW-0005NB-2h
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab1HRUcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 16:32:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab1HRUca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 16:32:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488CD4282;
	Thu, 18 Aug 2011 16:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5PGwMveSeVxrKgxXRTBacYLVrAE=; b=GhCQrO
	Kqk4mc3cHs8p5uE7boyS1j1jKgGxtuU9CDGPDlOyT5A30RW+P3/7/+ODT4SwZstg
	fOz1pzgDtRp1VPoSD1hBBmS+khTX2dnG2Rl/g4XmrsoeKrgzuYsyK1yLYDRosh7B
	NlENPmRmErPXKYPvMb1c16NzHG5dmfXDS5Nf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaFagqH9Uz29jKF4gvbaq3I/HY7FC7+y
	hFNwbEpQ7nG1KAnKpTkMbCV3DzuZOYNQ8UpSPu6i3CE1bHhXEiT744vD02VpXuIT
	5WDCWdZl/PlHgXlJebgFf8DbKpvGbsK33E3R3kLhm2m3nZbLmnO6uczmQZFPM5hd
	O0Gs8izqbLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C354281;
	Thu, 18 Aug 2011 16:32:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C37D1427E; Thu, 18 Aug 2011
 16:32:28 -0400 (EDT)
In-Reply-To: <20110818192157.GA10598@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 18 Aug 2011 21:21:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30FD7522-C9D9-11E0-8B18-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179626>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Sun, Aug 14, 2011 at 11:03:33AM +0200, Fredrik Gustafsson wrote:
>> When working with submodules it is easy to forget to push a
>> submodule to the server but pushing a super-project that
>> contains a commit for that submodule. The result is that the
>> superproject points at a submodule commit that is not available
>> on the server.
>
> Since I do not see thisi in pu maybe you missed this? There was a series
> containing the same patch send before which Jens asked to ignore but
> this was the one which was meant to be included.

Hmm, this is how the messages look like in my threaded MUA:

  [  34: Fredrik Gustafsson     ] [PATCH v4 0/2] push limitations
   [ 377: Fredrik Gustafsson     ] [PATCH v4 2/2] push: Don't push a reposi...
   [  35: Jens Lehmann           ] Re: [PATCH v4 0/2] push limitations
  [ 377: Fredrik Gustafsson     ] [PATCH v4 2/2] push: Don't push a reposit...
   [  14: Heiko Voigt            ] 

where Jens says "Please ignore this series, it slipped by accident" in the
third one. And the second [PATCH v4 2/2] message that you are reminding me
of (thanks!) has the identical proposed commit log message and patch text
as the other [PATCH v4 2/2] message.

So I am not sure what is going on here.

Also I vaguely recall that I said something about the command line parser
for this new option during the review of the previous round. Has that been
resolved/corrected?
