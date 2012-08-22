From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/16] GSOC remote-svn
Date: Wed, 22 Aug 2012 13:54:08 -0700
Message-ID: <7v1uiy7imn.fsf@alter.siamese.dyndns.org>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4HwR-0002B0-4p
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 22:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337Ab2HVUyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 16:54:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933298Ab2HVUyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 16:54:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD02A85D2;
	Wed, 22 Aug 2012 16:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXcLjnI6qUZJqTF785ns4LmAgBs=; b=wYwB+l
	vmo2luVU23dElpLX3sP3Zx1qMTTE82Nm/JcX/PJVH4MzWC7D6m8KlYzoKuW5J/Oi
	p7uKFaK1tcX/0kr6f5sHKtQzD0vXKvdhbXJtHu1SuofTDnT2I8l/q6pkVgMBeyJL
	T8L+Hyfl+JMN3BAXa2WQYSqx1aQrv4hp5J79c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=icW+8/M+vXKYpy5Ahj5svjirwzt1cXq1
	mPkxU7KpnecLWpbhk3NZZ1eAbExjSJbF7uDShdt3n5NiMcmpZCurKVvrULuP5hhg
	tRMmRBIGJMdyXIF/G+lZi0gjkQ8/SxtF9TMKsCWtYzzBWahLCEoxY0f1jK+5ZCYV
	z378Z8rJUWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97E085D1;
	Wed, 22 Aug 2012 16:54:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D5AC85D0; Wed, 22 Aug 2012
 16:54:09 -0400 (EDT)
In-Reply-To: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Wed, 22 Aug 2012 21:15:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85703AFA-EC9B-11E1-8E76-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204093>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Another improved series with fixups by Junio, and a little by me.
> Diff:
> - fix inconsistend indent in Documentation/git-remote-helpers.txt
> - remove trailing newline in Makefile
> - fix argument list and usage of regenerate_marks(void) in remote-svn.c
>
>
> [PATCH v6 01/16] Implement a remote helper for svn in C
> [PATCH v6 02/16] Add git-remote-testsvn to Makefile
> [PATCH v6 03/16] Add svndump_init_fd to allow reading dumps from
> [PATCH v6 04/16] Add argv_array_detach and argv_array_free_detached
> [PATCH v6 05/16] Connect fast-import to the remote-helper via pipe,
> [PATCH v6 06/16] Add documentation for the 'bidi-import' capability
> [PATCH v6 07/16] When debug==1, start fast-import with "--stats"
> [PATCH v6 08/16] remote-svn, vcs-svn: Enable fetching to private
> [PATCH v6 09/16] Allow reading svn dumps from files via file:// urls
> [PATCH v6 10/16] vcs-svn: add fast_export_note to create notes
> [PATCH v6 11/16] Create a note for every imported commit containing
> [PATCH v6 12/16] remote-svn: Activate import/export-marks for
> [PATCH v6 13/16] remote-svn: add incremental import
> [PATCH v6 14/16] Add a svnrdump-simulator replaying a dump file for
> [PATCH v6 15/16] remote-svn: add marks-file regeneration
> [PATCH v6 16/16] Add a test script for remote-svn

It seems that only 15/16 needs to be replaced, so I'll do that and
rebuild 'pu' before pushing it out, which I was about to do with the
patches from the last round.

Thanks.
