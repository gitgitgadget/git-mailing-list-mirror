From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Fri, 10 Dec 2010 15:08:45 -0800
Message-ID: <7vipz1b4zm.fsf@alter.siamese.dyndns.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino>
 <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
 <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
 <20101210190332.GA6210@burratino>
 <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRC5R-0008BI-Oj
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab0LJXJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 18:09:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0LJXJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 18:09:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F19123858;
	Fri, 10 Dec 2010 18:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BtWGUD5cmGPW2bKRj/yDLabIn5U=; b=HY4Uai
	VL3Uz9MO05VbVpPA5au6XbTGSPIQWvWrY/e4h+ZAXPznOuztBm4eKaD8J5/bc8eq
	pKW/tNskqdpDGhc2m45FMCWl9sYWby7lpsNJXOvf8UmQA4dvECYK0UQ5a1ocZVfr
	4FFlI5Uzxn76GwmhJvdcfg1APf7a/tvvtH3Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X14dcizC8pY3Hj336VtoQZcu57hf3IfY
	6DiUsF8DaRN7Ueu7j7Z9Gq1dhlUoHQVJGcpZC6RGIX1mYjGyrpG7sMK4s66LLnO/
	oruZzPCATuvgQeVac2Rp8AFHYPbTPwoAs6T2ZGCyFFQWT1tDjy56zH6un5VYy1nX
	W/cRrhWypBo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8135F3852;
	Fri, 10 Dec 2010 18:09:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D4D33851; Fri, 10 Dec 2010
 18:09:11 -0500 (EST)
In-Reply-To: <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org> (Kevin Ballard's
 message of "Fri\, 10 Dec 2010 13\:21\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85B31DD4-04B2-11E0-B089-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163447>

Kevin Ballard <kevin@sb.org> writes:

> On Dec 10, 2010, at 11:03 AM, Jonathan Nieder wrote:
>
>> - What is the intended use for this family of modifiers?  I sort
>>   of understand ^{:i/... } for people that forget what case they
>>   have used, but why the :nth and others?
>
> In my particular case, I was glancing through the logs, and I wanted to grab
> the second branch that someone else had made that was merged into pu. I would
> have loved to be able to run something like
>
>   git merge origin/pu^{:nth(2)/nd/}
>
> While we're speaking of modifiers, could we use one that says "only search
> the first parent hierarchy", e.g. something equivalent to git log's --first-parent
> flag?

Both feels like a very made-up example to me.

The reason you can so sure that you can to give nth(2) not nth(3) nor
nth(1) and run "merge" in the example is probably because you looked at
the output from "git log --first-parent --oneline origin..origin/pu", no?

  d414638 Merge branch 'rj/msvc-fix' into pu
  e5f5e49 Merge branch 'ak/describe-exact' into pu
  439932d Merge branch 'jn/svn-fe' into pu
  d60b33b Merge branch 'pd/bash-4-completion' into pu
  09cbbde Merge branch 'tf/commit-list-prefix' into pu
  1b2ea00 Merge branch 'mg/cvsimport' into pu
  c6d41f4 Merge branch 'nd/maint-relative' into pu
  81f395e Merge branch 'ab/i18n' into pu
  9f5471f Merge branch 'nd/setup' into pu
  06f74a4 Merge branch 'yd/dir-rename' into pu
  d8a2ec8 Merge branch 'en/object-list-with-pathspec' into pu

After looking at this output, do you really want to say ":nth(2)/nd/"
instead of 9f5471f?

To come up with the "(2)" part you need to carefully scan the other lines
and make sure that there is only one "nd/" after what you want, and the
string does not appear in an unexpected places.
