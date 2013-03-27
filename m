From: Junio C Hamano <gitster@pobox.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 08:03:58 -0700
Message-ID: <7v1ub0rijl.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <1364340037755-7580771.post@n2.nabble.com>
 <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jZcoA9sy+ixXmy8uj2E9E4Q6W2pLQVFStZMgH9eRoo6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Fromm <richard_fromm@yahoo.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKrtx-0003xI-B3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab3C0PED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:04:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3C0PEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:04:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 626E3AB01;
	Wed, 27 Mar 2013 11:04:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SkQ57IK0yOa65u7Pc2UjlziBVAk=; b=PxTNm750lCVBMbBRuHic
	hMZKkNoNVJhJ8O7mgd50RDdFOdejI4uLv95sJ880tDeg+BT5CpOmxH43gUmNSsRI
	UmgSohG5Ol3lSS5bmgWHCAp+jQtD0MXurwFw75JbykKoNQChAOjPw50ET9vmNY2j
	6bDnKAAckaLokFb6kGyTxFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aSnO9OfVFStxu4osXwF3tfK+alcbZaCfwnq0RVkwHKWgyI
	7TCvWWrKv/rI4s4xtSQ9WyCz0l1LCECZQm7x22F0GQu/FWsrP71C7cD2RvokuNwd
	gCBsa1sJcKb8GVvI5J3+mI8Wvwd0pdI2IK8suqcbZ5GmOLhyYkY56Do9lqBvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C68AB00;
	Wed, 27 Mar 2013 11:04:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4F9AAF9; Wed, 27 Mar 2013
 11:04:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E60E598-96EF-11E2-831E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219253>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On Wed, Mar 27, 2013 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> To be paranoid, you may want to set transfer.fsckObjects to true,
>> perhaps in your ~/.gitconfig.
>
> do we have any numbers on the overhead of this?
>
> Even a "guesstimate" will do...

On a reasonably slow machine:

$ cd /project/git/git.git && git repack -a -d
$ ls -hl .git/objects/pack/*.pack
-r--r--r-- 1 junio src 44M Mar 26 13:18 .git/objects/pack/pack-c40635e5ee2b7094eb0e2c416e921a2b129bd8d2.pack

$ cd .. && git --bare init junk && cd junk
$ time git index-pack --strict --stdin <../git.git/.git/objects/pack/*.pack
real    0m13.873s
user    0m21.345s
sys     0m2.248s

That's about 3.2 Mbps?

Compare that with the speed your other side feeds you (or your line
speed could be the limiting factor) and decide how much you value
your data.
