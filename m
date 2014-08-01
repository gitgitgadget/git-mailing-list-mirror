From: Nico Williams <nico@cryptonector.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:55:23 -0500
Message-ID: <CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:55:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJrO-0004kC-Ub
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbaHAUz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:55:27 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:56121 "EHLO
	homiemail-a34.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754966AbaHAUz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 16:55:26 -0400
Received: from homiemail-a34.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTP id A24CC10062
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=DunSs8UK41CaIa9YStHR
	jOGuQrQ=; b=YAqURPROcKJRuJImpjo7v8me1dHsRlUifsfueIBZXdQU4MR6cBPz
	iPBQFtAgNSmaKLdA0+2C0zq4ztMAV+pYUHyn9802DOm/MwGArMlx7gC56T74Mn3x
	AvFjUkYc4U208nSQgcipTr8mJ69GtrafhWwqbKYrrKd71fN5wDsKtqo=
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com [209.85.212.177])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTPSA id 4FA7A1005D
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 13:55:25 -0700 (PDT)
Received: by mail-wi0-f177.google.com with SMTP id ho1so2007812wib.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 13:55:24 -0700 (PDT)
X-Received: by 10.194.103.38 with SMTP id ft6mr11464288wjb.18.1406926524026;
 Fri, 01 Aug 2014 13:55:24 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 13:55:23 -0700 (PDT)
In-Reply-To: <20140801205040.GT12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254664>

On Fri, Aug 1, 2014 at 3:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>
>> Do you mean that "git merge" should be aware of what changes you have
>> already cherry-picked?
>>
>> It isn't, and that's deliberate
>
> That said, when today's "git merge" fails to resolve conflicts, it's
> easily possible that we could do better at resolving the merge by
> walking through both sides and understanding what happened.

It would help if cherry-pick history where recorded somewhere (beyond
the reflog)...

Cherry-picks should record two parents, like merges.

(Of course, it does no good to know about an unreachable parent, when
a commit with two parents is pushed to a repo that doesn't have one of
those parents, which can happen when topic branches aren't pushed
upstream.)

Nico
--
