From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 13:34:48 -0700
Message-ID: <7vd33mkyhj.fsf@alter.siamese.dyndns.org>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
 <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <500D8C30.9010807@web.de>
 <7v7gtumj88.fsf@alter.siamese.dyndns.org> <500DADEE.9060700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:35:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPLJ-00085A-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab2GWUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:34:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab2GWUex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A34C9752D;
	Mon, 23 Jul 2012 16:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vu2HOIQpjo0FAoTRU8WE2sNUpbM=; b=jmfG2U
	CXnWokAdbvrx2bi7uhgMETSZWAyYbPzQXPU/Q8vF2XTJGJ41nAJMMqehC4dRc/og
	zwxS7gCU1ZMPoDyhtlnlJbA/OPxnqvNLsl1L4+IXwfntpWaScxCybC3qrcntLl4w
	9KApNgh13r313gUi1y2SzhllIYCTwoy/ppQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDt/F5GkKv+h8qjEdK6g7bc2IUK3l6Cr
	h44POyhYwDr3QwI9GkdxhINKlS04Ce5oW4tqolkQj08yIfgbFLkaGr03dueBJ5mG
	pY3YabGyzPqPkqTe9O9SWskrqFnyAMoy/s1H9wRtqz5AZSyTqNFyvSbuX8muZydN
	5Hb5eXGX5yA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C93752C;
	Mon, 23 Jul 2012 16:34:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13233752B; Mon, 23 Jul 2012
 16:34:49 -0400 (EDT)
In-Reply-To: <500DADEE.9060700@web.de> (Jens Lehmann's message of "Mon, 23
 Jul 2012 22:02:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9A540AA-D505-11E1-801C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201974>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> We could get rid of the core.worktree setting by assuming that the
> directory a gitfile was found in is the root of the repo's work
> tree (unless configured otherwise).

Now you lost me.  If you have .git that is not a directory but is a
gitfile, then you do not need GIT_DIR nor GIT_WORK_TREE in the first
place, no?
