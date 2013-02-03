From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #01; Fri, 1)
Date: Sat, 02 Feb 2013 21:44:34 -0800
Message-ID: <7vlib69cjh.fsf@alter.siamese.dyndns.org>
References: <7vwqur8z4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>, John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 06:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1sOC-0002my-Jl
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 06:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab3BCFov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 00:44:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3BCFot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 00:44:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42B2183A3;
	Sun,  3 Feb 2013 00:44:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNTjO8IGdjqfK/Mq74yo7fd2hoM=; b=Is2MxH
	ul1eB+wL1G30KUO8xYJS8GdMIWn5FiAfWsBXeCbaAdPdXqT9bvnqYGCmZgJHMAbr
	CRaNa38QcVg9+rP2hIDZsmO5MS8wKFsrGl42J/9aV1uesOq6mr8gw/oqu/s7P0RM
	XXEiojNEVuiW+sZE3GbitFn8TPnTzxyBrgCnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qe70scudRRTUeoefXuiZKf/UvnLM3k9H
	zK1YeWUO6nCDOaFaDzHg0V/iyMMtLRixxZbU6jze9sIE8AAJxt18pmNQnt71Qhbf
	1IRcALT582LNHEqMDcI6/6PkKaMJOuY6/QcZ+dGA/Wym9Kwz9RE+mxcPiG+zdxa4
	1xjSFufStj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3787783A2;
	Sun,  3 Feb 2013 00:44:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F01E83A1; Sun,  3 Feb 2013
 00:44:38 -0500 (EST)
In-Reply-To: <7vwqur8z4s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Feb 2013 14:09:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC4F72CE-6DC4-11E2-9D7E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215299>

Junio C Hamano <gitster@pobox.com> writes:

Regarding these two topics....

> * da/mergetool-docs (2013-01-30) 7 commits
>  - doc: generate a list of valid merge tools
>  - mergetool--lib: list user configured tools in '--tool-help'
>  - fixup! doc: generate a list of valid merge tools
>  - fixup! mergetool--lib: add functions for finding available tools
>  - mergetool--lib: add functions for finding available tools
>  - mergetool--lib: improve the help text in guess_merge_tool()
>  - mergetool--lib: simplify command expressions
>  (this branch uses jk/mergetool.)
>
>  Build on top of the clean-up done by jk/mergetool and automatically
>  generate the list of mergetool and difftool backends the build
>  supports to be included in the documentation.
>
>  Will merge to 'next', after squashing the fixup! commits from John
>  Keeping.
>
>
> * jk/mergetool (2013-01-28) 8 commits
>  - mergetools: simplify how we handle "vim" and "defaults"
>  - mergetool--lib: don't call "exit" in setup_tool
>  - mergetool--lib: improve show_tool_help() output
>  - mergetools/vim: remove redundant diff command
>  - git-difftool: use git-mergetool--lib for "--tool-help"
>  - git-mergetool: don't hardcode 'mergetool' in show_tool_help
>  - git-mergetool: remove redundant assignment
>  - git-mergetool: move show_tool_help to mergetool--lib
>  (this branch is used by da/mergetool-docs.)
>
>  Cleans up mergetool/difftool combo.
>
>  This is looking ready for 'next'.

Do the tips of these two topics look reasonable to both of you, or
are there anything you sent but I missed?
