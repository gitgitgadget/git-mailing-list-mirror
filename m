From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Thu, 19 Nov 2009 10:10:44 -0800
Message-ID: <7vlji2bd23.fsf@alter.siamese.dyndns.org>
References: <4B04B4A2.8090001@gmail.com>
 <20091119124040.6117@nanako3.lavabit.com>
 <32c343770911190651w3f1ac9b6i2d3b1a62a032489f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 19:11:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBBTD-0001mX-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 19:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbZKSSKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbZKSSKu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 13:10:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZKSSKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 13:10:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CA897F04F;
	Thu, 19 Nov 2009 13:10:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=h0jXI5Lb7RBEl8Bs4dEuIx00Er4=; b=jgbI3TQdtnxV+n6LXVIvJ65
	7yFA/M8sUdV/I4EQGsGsXYcElT6VC2zesG9RQaQlDz+XaX/H34aDUDZ+5kXUrNMC
	VbjXxFx2VrS3EZMC8A3zMV6ukaWLC1fhptjukpKBIAQ3TWAFyoyoRZHWdWY0XFQp
	2GiyxDJLoO6rvGRuavmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NQnEzHwbW0+Txg+NqAph49B+wKvZn5+NzjfmsrH/EwfVXWUAd
	eRLv9xWKIoKUarIgZT/BqPxvOG0gdnyQ9j++jz+RD8mijkFLXsrz1e6y2oUxHyGW
	ae9IHZb56ZXANze9D6c3bHDgABUaULytYgxI+pwu7iwaf/Gd4rZz7DWNp0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAB77F04C;
	Thu, 19 Nov 2009 13:10:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A1657F043; Thu, 19 Nov
 2009 13:10:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEDB8BC8-D536-11DE-87DE-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133239>

Tim Henigan <tim.henigan@gmail.com> writes:

> The original version of this patch [1] left the contents of the usage
> strings intact.  However, Junio expressed a preference to change
> them to use the generic <options>.  See this thread for the
> discussion [2].
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/133048/
> [2] http://thread.gmane.org/gmane.comp.version-control.git/132968/focus=133050

Sorry, but I think you misunderstood what I meant, then.  in [2], I said...

    > ... hunk to remove literal strings from builtin_remote_usage[] 
    > ... and replace them with REMOTE_BARE_USAGE, REMOTE_ADD_USAGE

    I am not sure about the value of reusing option string like this, and for

Here, please note that I was objecting to the use of _the same string_ in
both contexts ("reusing").

    all other subcommands the same comment applies.  For example, in the case
    of "remote add -h", you would use

    "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"

    from REMOTE_ADD_USAGE, but ...

    > ... hunk to give the builtin_remote_add_usage[] that  uses the same
    > ... REMOTE_ADD_USAGE to parse_options() 

    ... the options list is used to reproduce the information in a major part
    of that string already.  So I would prefer builtin_remote_add_usage[] to
    be something like:

        "git remote add [<options>...] <name> <url>"

I meant that we want to change "remote add -h" to show this here; and the
reason why I doubted "the value of reusing option string" was because I
wanted to do so without touching the concise list of the subcommands and
their options given by "remote -h".  Otherwise, it would have made perfect
sense to use preprocessor macros to share the two identical strings.

In your response to my above comment, you indicated that you wanted to do
the [<options>] thing as a separate patch (your original patch spelled
options in full).  I took it to mean that you would do that only for the
subcommand help, and did not respond, because

 (1) doing that to the subcommand help would be a good idea anyway; and

 (2) you will realize what I said in the message about "the value of
     reusing option string" was correct when you see the end result, which
     will regress "remote -h" output.

In this case, unfortunately (2) didn't happen before Nana pointed it out.
