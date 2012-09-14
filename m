From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add diff.context option to specify default context
Date: Fri, 14 Sep 2012 14:06:25 -0700
Message-ID: <7vobl82u26.fsf@alter.siamese.dyndns.org>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Muizelaar <jmuizelaar@mozilla.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:06:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCd5z-00014k-R5
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab2INVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 17:06:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab2INVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 17:06:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 959E89F51;
	Fri, 14 Sep 2012 17:06:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CYJlzs7XLAfbtU6PMdm59HVmja4=; b=fRwwWQ
	vSVRAh/DZbaYkKMJQ9u9620RzTrkyg2GLHapOdedbmPynEm3t9MVuasEhvUOfU2B
	g6WEsz9BY1m3Aj4Su+pnMIxbpJB6kfQB7OfMw7tE7O88wLRd9p0ssefFAUPF6I+e
	m04HtJnNdJnQQIBSguabfbCb3hVIMKC2TqVuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZMDlSBYHA8qmqaL8v1atcIYUqkGxSvAT
	IdxGjN7Xi+ollsem0Ozfw1AYKSDuPE2Pdtq1OxXsn5kFqkAMovc1dgM2xFUGTNgx
	qFs3ieTQTwU38L4YT/RPIWcOIujqpbIqFzhf+TuJFg84Eyqqqzgg9VlePzGDO50J
	iPKdQZ+/qkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B9B9F50;
	Fri, 14 Sep 2012 17:06:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C48C49F4F; Fri, 14 Sep 2012
 17:06:26 -0400 (EDT)
In-Reply-To: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com> (Jeff
 Muizelaar's message of "Fri, 14 Sep 2012 14:16:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1381CC-FEB0-11E1-8F6E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205530>

Jeff Muizelaar <jmuizelaar@mozilla.com> writes:

> This adds a diff.context config option to allow specifying
> the number of lines of context. This is similar to Mercurial's
> 'unified' option.

Random thoughts.

* Please refer to Documentation/SubmittingPatches.  Saving your
  message in a mbox and applying it would produce this crap:

    commit ba4c972eacb91058f1317dbcd4ff77b471fa938e
    Author: Jeff Muizelaar <jmuizelaar@mozilla.com>
    Date:   Fri Sep 14 14:16:03 2012 -0400

        Add diff.context option to specify default context

        This adds a diff.context config option to allow specifying
        the number of lines of context. This is similar to Mercurial's
        'unified' option.

        commit 1bd81c75de6824c39852bc8516acd0733737ed83
        Author: Jeff Muizelaar <jmuizelaar@mozilla.com>
        Date:   Fri Sep 14 13:55:02 2012 -0400

            [PATCH] Add diff.context option to specify default context

            This adds a diff.context config option to allow specifying
            the number of lines of context. This is similar to
            Mercurial's
            'unified' option.

  which is not acceptable.

* Sign-off your patch.

* Citing similaritly to options in other systems does not add much
  value for people who read the proposed log message.  In this case,
  I think the first sentence is written clearly enough that it is
  sufficient without such clarification.  If anything, it should
  instead say:

	diff: diff.context configuration gives default to -U

	Introduce a configuration variable diff.context that tells
	Porcelain commands to use a non-default number of context
	lines instead of 3 (the default).  With this variable, users
	do not have to keep repeating "git log -U8" from the command
	line; instead, it becomes sufficient to say "git config
	diff.context 8" just once.

  or something like that to make it clear that it is related to our
  -U option.

* That relationship with the -U option may worth mentioning in the
  documentation, not just in the log message.

* The configuration is read only in diff_ui_config and not in the
  lower-level diff_config.  What the patch does is the right thing.

  It however needs to be documented in the patch to diff-config.txt
  that it affects only the Porcelain commands, and does not break
  plumbing commands.

* Tests?  Minimally, the cases you may want to check are:

  - What happens with various values set to this variable, and does
    the code properly diagnose errors?

    [diff]
	context ;# boolean?
        context = no
        context = 0
        context = -1
        context = 8

  - What happens when the variable is set and the command line gives
    a different value with -U?

    git config diff.context 8
    git log -U4 -1

  - Does it really keep plumbing intact?

    git config diff.context 8
    git diff-files -p


Thanks.
