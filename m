From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Documentation/git-submodule.txt: Add Description
 section
Date: Wed, 16 Jul 2008 12:29:03 -0700
Message-ID: <7vej5tr5kv.fsf@gitster.siamese.dyndns.org>
References: <20080715183705.GD4379@zakalwe.fi>
 <20080716184248.6524.38463.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heikki Orsila <shdl@zakalwe.fi>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJChZ-0000RC-QS
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYGPT3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYGPT3O
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:29:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYGPT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:29:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B037B2EF03;
	Wed, 16 Jul 2008 15:29:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5BBA12EF02; Wed, 16 Jul 2008 15:29:08 -0400 (EDT)
In-Reply-To: <20080716184248.6524.38463.stgit@localhost> (Petr Baudis's
 message of "Wed, 16 Jul 2008 20:44:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 786087D2-536D-11DD-AFD5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88732>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 76702a0..87c4ece 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -16,6 +16,28 @@ SYNOPSIS
>  'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
>  
>  
> +DESCRIPTION
> +-----------
> +Submodules are a special kind of tree entries which refer to a particular tree
> +in another repository (living at a given URL).  ...

In the documentation, "tree" has a specific meaning.  Perhaps "a
particular tree state" is a better wording than another alternative "a
particular commit", because you mention "the exact revision" in the
following sentence.

I'd suggest dropping " (living at a given URL)" from here, though.

> ...  The tree entry describes
> +the existence of a submodule with the given name and the exact revision that
> +should be used, while the location of the repository is described in the
> +`/.gitmodules` file.

Strictly speaking, ".gitmodules" merely gives a hint to be used by
"submodule init", the canonical location from which the repository is
expected to be cloned.  I do not think this overview needs to go into such
a detail.  The description of "init" subcommand might need clarification,
though.

> +When checked out, submodules will maintain their own independent repositories
> +within their directories; the only link between the submodule and the "parent
> +project" is the tree entry within the parent project mentioned above.
> +
> +This command will manage the tree entries and contents of the gitmodules file
> +for you, as well as inspecting the status of your submodules and updating them.
> +When adding a new submodule to the tree, the 'add' subcommand is to be used.
> +However, when pulling a tree containing submodules, these will not be checked
> +out by default; the 'init' and 'update' subcommands will maintain submodules
> +checked out and at appropriate revision in your working tree. You can inspect
> +the current status of your submodules using the 'submodule' subcommand and get
> +an overview of changes 'update' would perform using the 'summary' subcommand.

Otherwise this is a nice write-up.  Will queue; further comments from
other submodule users are appreciated if there are any.  Thanks.
