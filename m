From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 19:02:07 +0900
Message-ID: <20090311190207.6117@nanako3.lavabit.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
 <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
 <20090310230939.GB14083@sigio.peff.net>
 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
 <20090311020409.GA31365@coredump.intra.peff.net>
 <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLIr-00065L-GN
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbZCKKCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 06:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbZCKKCw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 06:02:52 -0400
Received: from karen.lavabit.com ([72.249.41.33]:51668 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404AbZCKKCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 06:02:51 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id DFD6611B8BC;
	Wed, 11 Mar 2009 05:02:46 -0500 (CDT)
Received: from 1522.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id RXSRYKK0DB0T; Wed, 11 Mar 2009 05:02:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=cA0oODwbqAiDAjJRmc9zPmwtr4Yy0YqWpfj2kS9y7JPplw2nL3WNtJlcBbcvse9cJCUWas1v6cZWLV1mUA1xHizFqLDf/XXe3DCnupb3MvlzXvVfL9jAO1E584YQN1ntxzwA/q52sXiB+yHg+0kxj6+WW3istKD/JSMqCftMSwo=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112901>

Quoting Junio C Hamano <gitster@pobox.com>:

> The only use case I've heard in this thread and nearby is where you are
> the one who started the history of the branch, and pushed it into a public
> repository as a new branch, making the result _the_ most authoritative
> one.  After that, everybody else will be able to have a local branch that
> tracks the authoritative one with "branch --track frotz origin/frotz", and
> you will be the only one left unable to do so because you already have
> that frotz branch.
>
> And for that use case, I find it sensible if we had a way to easily say
> "This branch hasn't been tracking anything so far (because it is the
> originator of the history), but now it will give up its authority and
> start tracking the one it is pushing into", and it would make sense to
> somehow link that to the invocation of "git push".
>
>     Side note.  I would also accept "It is only one person in the world,
>     who can edit .git/config and be done with it; why bother complicate
>     the UI for other people" as a valid argument against it, though ;-).
>
> In that "my private branch gave autority to the branch at my public
> repository" case, it is of course easy to re-clone (or "branch -m" away
> and then re-fetch) like everybody else, but then you would lose the reflog
> from the time before the branch went public, so it is not a solution but a
> poor workaround.

I'm sorry, but I don't understand why you want to keep the entries in the reflog that were made before you pushed your branch to make it public in this scenario.

Especially because you are relinquishing the authority to the public repository by wishing to be able to "track" it, you can't rewind the branch beyond the point you initially pushed out any more. At that point, wouldn't it make more sense to drop the old reflog data and pretend as if the branch were fetched from the branch from your public repository it now follows, just like everybody else does?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
