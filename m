From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 00:18:37 -0800
Message-ID: <7vd434v0rm.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDw2Y-00028W-2c
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZK0ISm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZK0ISm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:18:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZK0ISl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:18:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63F6CA20C4;
	Fri, 27 Nov 2009 03:18:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfZ2lSN2YcsrJS/RSAEix8jlQfE=; b=kk7t3y
	3tSN66PWHlnTvNw512iZY3/JCF4+9Jjs/W6EAOR8BmsCaW9LW+VrvvtjkPuPzdN9
	0VNSGl/nGlUlxpqfNYpT+2+8EZ5adfXTcTXZmwODxknqGT4n/hwI4sUDeeFWsShE
	vTCUmWCcH3anBnxciV/UDLpjwmMg2ovQoXMPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0N9W6xnBygitvQCFiV0bif5BRSHrvd8
	a/f5fInVjTx2dxumtTyPoE0dm884vf1l3GP50cGCaXPUjSWHotHWQLRe6yzq5NnM
	NAM1pt4ZWQmFO/ZZYPOULWFsm14+GDu+XL5ZXtgOkgIUziqx1hsJd4fICoIQY/yq
	eNag4UjZUV8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33E3CA20BE;
	Fri, 27 Nov 2009 03:18:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C92BDA20BC; Fri, 27 Nov 2009
 03:18:39 -0500 (EST)
In-Reply-To: <20091127062013.GA20844@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 27 Nov 2009 01\:20\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A6D811C-DB2D-11DE-8887-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133874>

Jeff King <peff@peff.net> writes:

> ... And I don't want to speak for Junio,
> but he seemed to agree that what you most want would depend on the repo
> organization (though I think he may disagree that it is important enough
> to merit the hassle of a config option).

Oh, I totally agree with you that what's convenient is different per
<project, the role I play in the project> pair.

In my day-job project, I almost always work in a directory four levels
down from the toplevel ("src/lib/u/<something>") and almost always what to
run grep from near the top ("/src" in the strawman syntax to grep from
that directory).  I have similar preference when playing with projects I
am not very familiar with---hack in a limited area somewhere deeper, but
grep a lot more widely.  So it is very tempting to say that I would want
"full-tree" configured as default in these repositories.

But the conclusion I draw from that observation is that it should be
equally easy for me to invoke both behaviours from the command line, and
not "I want to freeze which default is used for the project by setting a
configuration variable", because I know "the role I play" part changes
from time to time (note that I didn't say "changes over time"---that can
be addressed by "Then you should flip the config when the day comes").

At first sight, git.git is too shallow for "full-tree" vs "current
directory" distinction to make any meaningful difference, especially
because it is very top heavy and I almost always am at the top level
directory.  But even there, I can clearly see that I have need for easy
access to both modes.  I sometimes play a contributor who is interested in
and is very familiar with a specific area (hence I know in which files to
find strings without resorting to full-tree grep), and other times play a
reviewer role who tries to follow what an area expert, who is much more
familiar than me in some parts of the system, did in his patch.  In the
latter case, I would not know in which files to grep offhand, and would
benefit from "tree-wide" option, in order to find out what is done by that
obscure function the area expert used in his patch.

A repository-wide configuration would not help me at all, but a way to
invoke either mode from the command line that is short-and-sweet would
consistently give me the desired result without having to remember what
the default-of-the-day (or default-in-the-repo) is.

But the above is mostly about "Peff wants config, Junio thinks it won't
help him", and is not really a disagreement.  As long as we don't use the
existence of configurable defaults as an excuse for making/leaving it very
cumbersome to invoke the non-default mode from command line, "it won't
help some users" is not a reason to block it.

I suspect a per-repo configuration _might_ confuse new people (and people
who help them), and I brought it up as a potential issue myself.  That
could be a more valid reason to object to configurable default, but I
haven't formed an opinion how serious a problem it would be in real life;
I should sleep on this one and wait for others' opinions.

Regardless of the above, there are unresolved issues in the --full-tree
patch as posted.

We've been saying that even if the default were changed to grep in the
full tree, limiting to the current directory is easy with a single "." at
the end, but I do not think it is entirely true.  I often want to grep in
only "*.h" files but they are spread across the directories.  If you do

    $ git grep -e frotz -- "*.h"

it finds in paths that match the pathspec in the current directory with
today's default, but after we flip the default (either globally or with
your configuration per-repo), it won't be possible to limit the search to
header files in the current directory and under.  It will find in header
files spread over in the whole tree.

Also the --full-tree option I did at the beginning of this thread doesn't
work with the above command line example, as it only kicks in when there
is no pathspec.

Maybe these are not worth solving, and we should keep the current default
and just tell ourselves to go up to the level we want to grep from.  That
would be simple, robust and the easiest to explain.
