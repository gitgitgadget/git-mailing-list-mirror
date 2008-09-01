From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 18:48:10 -0700
Message-ID: <7vhc901vs5.fsf@gitster.siamese.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org>
 <53906E21-DE02-4C85-8CC0-4E4AC53AE130@develooper.com>
 <7vljyc1wzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Schiele <rschiele@gmail.com>,
	Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 03:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZyXn-0002xh-8T
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYIABsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 21:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYIABsW
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:48:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYIABsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2008 21:48:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C27D6F2C6;
	Sun, 31 Aug 2008 21:48:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 507DD6F2BE; Sun, 31 Aug 2008 21:48:13 -0400 (EDT)
In-Reply-To: <7vljyc1wzg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 31 Aug 2008 18:22:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E23F8D4-77C8-11DD-8C5C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94523>

Junio C Hamano <gitster@pobox.com> writes:

> Ask Bj=C3=B8rn Hansen <ask@develooper.com> writes:
> ...
>>> This is an alternative to my previous patch that just declared Perl
>>> 5.8 to
>>> be the required version.
>>
>> +1 to that one.
>
> Now, would somebody volunteer to go everywhere our user base (who no
> longer read Release Notes) hang around, post a message saying that so=
me
> people on git development list are proposing to drop Perl 5.6 support=
, and
> if the proposal goes ahead, it is possible that the next release may =
force
> upgrading Perl for them, to make sure they won't complain saying they=
've
> never heard about the "incompatible change" beforehand?

Just in case before anybody overreacts without reading the mailing list
backlog; the above is meant to be a moderately bitter joke ;-)

I tend to think that everybody who needs to run git in their developmen=
t
environment (the deployment site could be running with ancient Perl for
all we care --- after all, git or any SCM is primarily to be run in the
development environment, and even if people use git to transfer the end
result from the development side, all they need is the really core part=
 of
history tranfer tools like fetch, push and checkout on the deployed sit=
e;
these tools do not depend on Perl) would be running 5.8 by now.  Grante=
d,
some development machine need to have the exact same version of everyth=
ing
as the intended deployment environment for testing purposes, and some
people may be developing a piece of software that is meant to run on Pe=
rl
that is no more recent than 5.6, but with virtual machines and all, I
think it would be rare to have such a setup --- it is a lot easier to
develop on a platform with more reasonably recent Perl that your
development tools (not limited to git itself) may depend on, and test o=
n a
virtual bochs with an ancient software configuration as the intended
deployment site.

So I personally think it is probably Ok to declare that we do depend on
5.8.
