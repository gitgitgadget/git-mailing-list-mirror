From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature suggestion: new 'git add -i' command to discard working
 copy changes
Date: Tue, 18 Dec 2012 13:34:38 -0800
Message-ID: <7vvcbzdoy9.fsf@alter.siamese.dyndns.org>
References: <50D0DA19.5030606@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:35:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl4oX-0006w2-J2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 22:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab2LRVeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 16:34:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203Ab2LRVen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 16:34:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E82A54F;
	Tue, 18 Dec 2012 16:34:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hm/hGm/BzLUePxlJ052ryc82DVo=; b=yIaU8k
	uA9HMtNaTZIWhGYHZKl0n+HG45ooEm2wr0aDmLdsYmpb9xotg+Ctj6O0VIlf54Hn
	p3sBS4p6Yxhl+Ia4MEVgZfZEkp0XASzzaPm8r9MLVqytehKJYZDyqvm3kw6pTSrG
	2rJtQe42aGCJ/uZQANqBYFYiF8/6xhDUHrfwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cA6d/EOnrc2dLL79DYVa0jUWwud8roTH
	KbK+KEl7MAUFOVlXGhQxZq+F7yg9rel2rUQGqS4ukOfGVlE5dfKBPdjcnz8WQ8dp
	t0HlcowHEFrpyr3HrZlb0q9uk2J/eYZqVsCPzOFTN96sp7rYaUM00VEMG3WRi2n2
	HWzP6QzqIVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DBD5A54C;
	Tue, 18 Dec 2012 16:34:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 729F6A541; Tue, 18 Dec 2012
 16:34:41 -0500 (EST)
In-Reply-To: <50D0DA19.5030606@cs.wisc.edu> (Evan Driscoll's message of "Tue,
 18 Dec 2012 15:03:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB6DF298-495A-11E2-9662-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211787>

Evan Driscoll <driscoll@cs.wisc.edu> writes:

> It's not infrequent that I want to discard changes I've made locally to
> files ('git checkout file.txt') and find myself wishing that this was an
> action available from the 'git add --interactive' UI; it feels like it
> would fit in.

Hrm, not really.  "git add" is about manipulating the index and its
promise is that it won't touch working tree files.  And people rely
on that promise.

I can see how it would be useful to have a UI that is more
interactive than CLI that shows you a list of paths and lets you
pick from the list to run "git checkout" on, but I think "git add"
is a bad match to it.
