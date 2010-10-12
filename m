From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: dependencies for vcs-svn tests
Date: Tue, 12 Oct 2010 16:22:08 -0700
Message-ID: <7vmxqjngin.fsf@alter.siamese.dyndns.org>
References: <20101010055032.GA23100@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5oAt-00059b-FI
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0JLXWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 19:22:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0JLXWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:22:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C2F1CCD;
	Tue, 12 Oct 2010 19:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aMBCKq7xcdOUXx5QXV3mmIp2qcw=; b=t39PSO
	rJDwOSgnlkdz1/66nMFdOlGByXlkMIUx2t1/zUteIHIfmGuC8LudNWTENoPaPxYI
	mQBhhIXAr1bY/q2zijwgp4ciGgEWH/3vr13bZK1wwGQZL0m+jaouF+NYYqkf2GwO
	KhRgmj67wCyWBaA/Jf3M9joXiQBmk15Ni3yMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2zWafqgkHo1dJThPhov3A4gpa6Y6zmP
	9JYEbQeFcrs4h2pWXLh8dcjFLlvx1/FXJUSPzb1+rl2eajFwwie+E4PdfKbqfEK6
	yvyipqzv2hnH92SDAVU6M6jyF+sOx6DIlfi+9crOAyqdZucXE3ZvpGoa2xEm66wz
	itqow7G41mA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD561CC8;
	Tue, 12 Oct 2010 19:22:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF1011CC4; Tue, 12 Oct
 2010 19:22:10 -0400 (EDT)
In-Reply-To: <20101010055032.GA23100@burratino> (Jonathan Nieder's message of
 "Sun\, 10 Oct 2010 00\:50\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C90171C-D657-11DF-B0FE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158896>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The vcs-svn tests (test-treap.o et al) depend on the vcs-svn
> headers for declarations and inline functions.  Declare the
> dependency.  While at it, declare a dependency of the vcs-svn
> objects (vcs-svn/string_pool.o et al) on $(LIB_H) to reflect use
> within the vcs-svn library of git-compat-util.h and cache.h.

Thanks.

>
>  Makefile |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d3dcfb1..1bd1823 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1762,6 +1762,8 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
>  	xdiff/xmerge.o xdiff/xpatience.o
>  VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
>  	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
> +VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
> +	test-line-buffer.o test-treap.o
>  OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
>  
>  dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
> @@ -1885,10 +1887,12 @@ xdiff-interface.o $(XDIFF_OBJS): \
>  	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
>  	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
>  
> -$(VCSSVN_OBJS): \
> +$(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
>  	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
>  	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
>  	vcs-svn/svndump.h
> +
> +test-svn-fe.o: vcs-svn/svndump.h
>  endif
>  
>  exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
> -- 
> 1.7.2.3
