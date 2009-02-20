From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-commit hook
Date: Fri, 20 Feb 2009 08:25:52 -0800
Message-ID: <7v63j5t6r3.fsf@gitster.siamese.dyndns.org>
References: <20090220091127.GA7415@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:27:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYDq-0003BA-0N
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbZBTQ0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZBTQZ7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:25:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZBTQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:25:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 44C0C9BF74;
	Fri, 20 Feb 2009 11:25:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29BF49BF70; Fri,
 20 Feb 2009 11:25:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 270A83EC-FF6B-11DD-87FF-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110858>

bill lam <cbill.lam@gmail.com> writes:

> The pre-commit hooks as follows.
>
>  10 # This is slightly modified from Andrew Morton's Perfect Patch.
>  11 # Lines you introduce should not have trailing whitespace.

That's a sample hook from an ancient version of git.  We do not ship that
version anymore since late last June.  You should be able to replace it
with the version shipped with v1.6.0 or later if your git is recent
enough.

    #!/bin/sh
    #
    # An example hook script to verify what is about to be committed.
    # Called by git-commit with no arguments.  The hook should
    # exit with non-zero status after issuing an appropriate message if
    # it wants to stop the commit.
    #
    # To enable this hook, rename this file to "pre-commit".

    if git-rev-parse --verify HEAD 2>/dev/null
    then
            against=HEAD
    else
            # Initial commit: diff against an empty tree object
            against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
    fi

    exec git diff-index --check --cached $against --

Perhaps a time to upgrade?  People should be running at least 1.6.0 these
days ;-).
