From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sun, 01 Mar 2009 15:30:00 +0900
Message-ID: <20090301153000.6117@nanako3.lavabit.com>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
 <7vsklycct9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 07:33:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdfEr-0006rg-MJ
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 07:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbZCAGb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 01:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbZCAGb0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 01:31:26 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37513 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757484AbZCAGbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 01:31:24 -0500
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 4CA7511B885;
	Sun,  1 Mar 2009 00:31:19 -0600 (CST)
Received: from 2913.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id AOM1Q6Q3FA6U; Sun, 01 Mar 2009 00:31:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=daXopQlzVqxR0eGlyVfV5FlgMxXVeD4nAkdFUncJ0LG3grCioG7eGwuDZGNnbqFQ22FiNdt7GgfaJ4KJQtp9vIIwa+8+io1Y1UPH8MVcuNfQLdsH9nJU8riuSm6bFsJ4BzXQ7vFC/P4T7uSKBOj/orwVkDR3uz+d1cJEZQjZCT8=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vsklycct9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111819>

Quoting Junio C Hamano <gitster@pobox.com>:

> No matter what different default you choose, there will be people who
> complain about it as long as it is not exactly the default they want.
>
> The only thing I could think of offhand that you could do safely to remedy
> the situation is to make the command fail until you explicitly set your
> default via the configuration, but even then, it is not entirely safe.
>
> You will hear from angry people who use their own wrapper script to "git
> send-email" that gives all necessary options from the command line and now
> they are forced to add configuration to their repository, even though the
> config is never used because their script overrides it from the command
> line.
>
> So, I dunno.

Isn't it an option to introduce a new program, say 'git send', that
reimplements what 'git send-email' is meant to be used for, but has a
better implementation and a better default setting?

You have a precedence of doing so when you introduced 'git am'. You
contined to maintain 'git applymbox' to keep old people happy. You
taught new people to use 'git am', and waited until old people learn to
like the new command with a shorter name and a saner behavior. After a
certain period of time, you deprecated and removed the original program.

d1c5f2a42d7b5c0e3d3862212dea1f09809c4963 "Add git-am, applymbox replacement"
http://article.gmane.org/gmane.comp.version-control.git/44376
http://article.gmane.org/gmane.comp.version-control.git/47785

I don't know much about the technical details, but I saw there were a
few discussion threads about improving 'git send-email'; one of the
recent ones was this.

http://article.gmane.org/gmane.comp.version-control.git/109791

I also saw the original author (Greg?) said that one of the input
formats 'git send-email' supports is not worth supporting, or sth like
that. A reimplemention to introduce 'git send' may be a good time to
deprecate and remove that old input format.

Or is the migration plan like the one you used when you migrated 'git
applymbox' to 'git am' considered unacceptable by now, because git is a
lot more mature than it used to be back then?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
