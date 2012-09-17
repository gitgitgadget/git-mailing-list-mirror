From: Junio C Hamano <gitster@pobox.com>
Subject: Re: status of git interop with other VCS
Date: Mon, 17 Sep 2012 13:40:40 -0700
Message-ID: <7vmx0otmbb.fsf@alter.siamese.dyndns.org>
References: <1347795904.22408.20.camel@chianamo>
 <CALkWK0knJKGK=jD=_dBUn+idVSEs+KxwvQJWc7oS_BvzPR9jJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Wise <pabs3@bonedaddy.net>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDi7f-0005Ew-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab2IQUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:40:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab2IQUkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:40:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2548E8301;
	Mon, 17 Sep 2012 16:40:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QJ6U+IBwcLiVxIRjs1lqdnlH0ak=; b=H6m6kf
	jt4CdljMJgAzK4VdROpIqXPPN+koskyKAJDUMA1Nuac9Ff3MUFyIyiFuhETISP4W
	Al7Gh2O+aKwycbFJR1XN9saIUV/roOzv2r9ZmvJKfhO+F3oLlLnfDTN8fwxwVeFF
	l2hD6L98outWYNlpzSl5gzSVQ5V5YytRj6L0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iIdbkA+GE+44wFlOwWe8B9HDRj/Ka9E4
	VlXGGPybnt8Et4q5T+CefXKkaYGC1q9vDllNDhKUvF788btIgU2Jk95I+658dftc
	QEWYRg8utLcq+oRlxy2UyWc/wFndA3tjXzLvi1mmka+9bbtPiLkJd0T8mEscyvIt
	d5RxTi8Sap0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 134128300;
	Mon, 17 Sep 2012 16:40:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B11482FF; Mon, 17 Sep 2012
 16:40:41 -0400 (EDT)
In-Reply-To: <CALkWK0knJKGK=jD=_dBUn+idVSEs+KxwvQJWc7oS_BvzPR9jJw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 17 Sep 2012 22:21:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2348508-0107-11E2-8711-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205743>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Paul,
>
> Paul Wise wrote:
>> svn: there was a gsoc project for this but it was never merged:
>>
>> http://git.wiki.kernel.org/index.php/SoC2011Projects#Remote_helper_for_Subversion_and_git-svn
>
> I wouldn't give up on that yet. What is the status of fa/remote-helper?

An excerpt from recent "What's cooking":

    * fa/remote-svn (2012-08-28) 16 commits
     - Add a test script for remote-svn
     - remote-svn: add marks-file regeneration
     - Add a svnrdump-simulator replaying a dump file for testing
     - remote-svn: add incremental import
     - remote-svn: Activate import/export-marks for fast-import
     - Create a note for every imported commit containing svn metadata
     - vcs-svn: add fast_export_note to create notes
     - Allow reading svn dumps from files via file:// urls
     - remote-svn, vcs-svn: Enable fetching to private refs
     - When debug==1, start fast-import with "--stats" instead of "--quiet"
     - Add documentation for the 'bidi-import' capability of remote-helpers
     - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
     - Add argv_array_detach and argv_array_free_detached
     - Add svndump_init_fd to allow reading dumps from arbitrary FDs
     - Add git-remote-testsvn to Makefile and .gitignore
     - Implement a remote helper for svn in C
     (this branch is used by fa/vcs-svn.)

     A GSoC project.  Looked promising.
     Waiting for comments from mentors and stakeholders.


    * fa/vcs-svn (2012-08-28) 4 commits
     - vcs-svn: remove repo_tree
     - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
     - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
     - svndump: move struct definitions to .h
     (this branch uses fa/remote-svn.)

     A GSoC project.  Looked promising.
     Waiting for comments from mentors and stakeholders.
