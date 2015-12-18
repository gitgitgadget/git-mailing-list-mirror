From: David Greene <greened@obbligato.org>
Subject: Re: (unknown)
Date: Fri, 18 Dec 2015 11:35:23 -0600
Message-ID: <nngr3ij3bj8.fsf@lnx-dag.us.cray.com>
References: <1450234966-28796-1-git-send-email-greened@obbligato.org>
	<xmqqsi33djfl.fsf@gitster.mtv.corp.google.com>
	<20151216084406.GA3241@pks-pc>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net,
	Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri Dec 18 18:36:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9ywh-0003tf-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 18:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbbLRRfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 12:35:55 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60335 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932568AbbLRRfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 12:35:54 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=lnx-dag.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.1:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a9ywS-0001hp-NQ; Fri, 18 Dec 2015 11:35:44 -0600
In-Reply-To: <20151216084406.GA3241@pks-pc> (Patrick Steinhardt's message of
	"Wed, 16 Dec 2015 09:44:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282709>

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Dec 15, 2015 at 09:57:50PM -0800, Junio C Hamano wrote:
>> David Greene <greened@obbligato.org> writes:
>> 
>> > - If new option --keep-redundant is specified, invoke cherry-pick with
>> >   --keep-redundant-commits.
>> 
>> This came up in the past several weeks, I think; you would need to
>> disable patch-equivalence based commit filtering if you really want
>> to do a --keep-redundant that is reproducible and/or reliable.
>
> Here are the links to the previous proposal [1] and following
> discussion [2] (see 'ps/rebase-keep-empty') if you are
> interested.
>
> Patrick
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/281515[2]: http://thread.gmane.org/gmane.comp.version-control.git/281917

Thanks.  That makes total sense.

I actually would prefer a behavior where cherry-pick would just drop
redundant commits rather than stopping and asking the user to reset.
The problem is that rebase --preserve-merges seems to force the drop to
use cherry-pick and cherry-pick doesn't behave well (from a scripting
perspective) in the presence of redundant commits.

As it is, it's difficult to rebase as part of a scripted operation due
to this issue.

Any ideas on how to teach cherry-pick to automatically drop such
commits?

                           -David
