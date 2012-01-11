From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 18:28:32 -0800
Message-ID: <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 03:28:54 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rknvp-0007qW-Gr
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 03:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700Ab2AKC2g (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Jan 2012 21:28:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757035Ab2AKC2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2012 21:28:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5566C559E;
	Tue, 10 Jan 2012 21:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hi9EpfGDQ2UDe3VFo/eiPeMtwM8=; b=CT53k6
	2u/lA8wzpKKzVCsSLX6Edxel5DIfoVi0hfLx5lkt9RXhp3xLSuHS1VqkALeJ75pf
	+q0pcbDo2spNSY/DYa2JlBNg8sk/RPMXinlhQ+aux31wNmZgCzXPKDBDOEQX2jri
	CjeMrPeS9biGhfnRejWea3RyBP1OsL5Bx1tmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1X1J/hjLOPaxESq/G2QsUbo6hU/gnBn
	FWlkKGYSv8KjNCKdd/E3IZ9aei41sv6pJQXrTKosJtq+j6mBH1ydV4KXWg0Rttb2
	ZmUme64MzvhyQsx5U+wUg3n6+F1Un8gnZ871pcUxs5E2J2iyZbAwJdDFh2EwnIgI
	zWijQOmoRIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B4E8559C;
	Tue, 10 Jan 2012 21:28:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEE27559B; Tue, 10 Jan 2012
 21:28:33 -0500 (EST)
In-Reply-To: <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 10 Jan 2012 14:54:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F55ED0DE-3BFB-11E1-8BC7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188311>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Addid junio and git to the cc just to bring up this issue of bad UI
> once again. I realize it could break old scripts to start up an editor
> window, but still..

It is a non-starter to unconditionally start an editor. We would need a
good way for users to conveniently say "I am doing this unusual merge that
needs to be justified, and I want an editor to write my justification".

Obviously, "git merge -e regulator/for-linus" would work and is just three
keystrokes, which can be said "convenient enough" once the user gets used
to, but I think this is still inadequate as a solution, as the real
problem is it is _too_ easy to forget to give the option.  Until the user
becomes _aware_ of the issues, it will not even occur to the user that
s/he _has_ to justify a merge (or not create a merge at all) in certain
circumstances and directions.  After all, you have been repeating the "do
not make meaningless merges" for the past five years on the list. UI tweak
alone will not fix that.

If we are to rely on user's conscious action, I think it may be something
like a set of configurations that say things like:

 - This branch is for advancing a specific topic, and not for merging
   random development that happen elsewhere;

 - This branch is for merging works by people downstream from me;

 - This remote tracking branch (and by extension that branch at that
   remote that uses this as its remote tracking branch) is my upstream and
   I should not be merging back from it; and

 - This remote tracking branch is my downstream, and I should freely merge
   it when I heard it is ready.

and depending on the combination of what is being merged into what, toggle
the --edit option by default for "git merge" when neither "--edit" nor
"--no-edit" is given, just like "git merge" defaults to "--edit" when
merging an annotated tag.
