From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Sat, 08 Sep 2012 11:54:34 -0700
Message-ID: <7va9x0uyz9.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BtZzgi32kxVTbGC7eAjFG41bdae=MaK==sKq=9ohf8_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 20:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQB5-0001oV-8v
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 20:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab2IHSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 14:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228Ab2IHSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 14:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73F257136;
	Sat,  8 Sep 2012 14:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mk6CNVrpaLIdmdSWnN1m+ErsnA8=; b=GDKrFz
	GDaLiKjt+fbtmDEsHWzgAMK2TQLJRhXytFyC3m8b4BfVlRGN8/+wvUDWw7B3lmBk
	f0x9Puw/9YZ2bjdE5mzhpmsWv7zsgzllgN5F8kSVUoHno8RBwjgJmuShJVPsmQuf
	lv9H338FpnDeSAxk17ALN7wsvG7ZxFu09lwq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=naOzAdlQ6B40NwEWPuN71ZvKqRmHBPz8
	/E9koogA7XCCFgAyrn5sgAEYGds2tnPqR6WIJ28lzujurptIkze+3JjhGfcLIs1F
	EBeDmkEswmjTUq/RyXIn1wrt0YgEW2EpmyI0+udHeqAw6Hbavvc7GHMvZd5ArP4D
	P40vdSQFwCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627627135;
	Sat,  8 Sep 2012 14:54:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4F5A7133; Sat,  8 Sep 2012
 14:54:35 -0400 (EDT)
In-Reply-To: <CAB9Jk9BtZzgi32kxVTbGC7eAjFG41bdae=MaK==sKq=9ohf8_w@mail.gmail.com> (Angelo
 Borsotti's message of "Sat, 8 Sep 2012 16:55:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2468B7C-F9E6-11E1-8054-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205024>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> It makes quite clear that the command accepts wildcards
> (not expanded by the shell), which was is not clear in the current
> man page (although one could imagine that <path> could also be a
> wildcard).
>
> P.S. In the man page there is also a <pathspec>
>
>     "*git checkout* [-p|--patch] [<tree-ish>] [--] <pathspec>...
>
> that should perhaps be a <path>

That's backwards.  Saying <path> as if it means a plain vanilla
pathname is a cause of confusion.  The command takes pathspec, which
is a pattern (see "git help glossary"). The places in the text that
say <path> may need to be fixed.

It just happens that you do not realize that you are using pathspec
when you say "git checkout hello.c", as the pattern "hello.c" only
matches the one pathname "hello.c".
