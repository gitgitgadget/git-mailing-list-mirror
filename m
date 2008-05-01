From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tracability in git commits
Date: Thu, 01 May 2008 12:03:47 -0700
Message-ID: <7v63txzw18.fsf@gitster.siamese.dyndns.org>
References: <1209473739.5642.31.camel@dax.rpnet.com>
 <m3lk2vodw4.fsf@localhost.localdomain>
 <1209551520.5010.20.camel@dax.rpnet.com>
 <46a038f90804301826xaf5d73bl1d29a07bc930a716@mail.gmail.com>
 <46a038f90805010034y3ffd3eb5hbee7c2200912eef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Richard Purdie" <rpurdie@rpsys.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jre5F-0007H0-LR
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763442AbYEATD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763412AbYEATD6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:03:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763408AbYEATD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:03:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D88F04A21;
	Thu,  1 May 2008 15:03:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2667249DF; Thu,  1 May 2008 15:03:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59791444-17B1-11DD-AF01-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80932>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Thu, May 1, 2008 at 1:26 PM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>>   4 - A script "pushes" commits from the "incoming" repo to a
>>  "verified" repo after checking that they are backed by a GPG-signed
>>  list. For ease of use, this can happen on the server ASAP, and it can
>>  be validated independently by any party. Notably, it is probably a
>>  good idea that it is validated shortly before a release is tagged.
>>
>>  This way, you keep the flexible/fast properties of git
>
> Note that with this, you *can* also keep the ability for someone to
> push commits that they are not the author or committer for. This is
> actually added flexibility - you can merge from a 3rd party tree, and
> push it to the central repo, as long as you GPG-sign the list
> including those commits.
>
> I highlight "can" because the wrapper on the developer side and the
> script on the server side can prevent this, or force extra steps in
> such case.
>
> cheers,

I suspect that, with the "push to incoming, vet there and move to
verified" workflow, you do not need a special GPG-signed list.  You can
instead have the pusher sign the tip using the usual signed-tag mechanism,
which would sign the whole history leading to it, and have him push that
tag to the incoming together with the tip update.  You obviously do not
need nor want to move that signed tag to the final area.
