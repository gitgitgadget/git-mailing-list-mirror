From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 19 Jul 2008 14:13:29 +0900
Message-ID: <20080719141329.6117@nanako3.lavabit.com>
References: <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 07:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK4me-00018F-7s
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 07:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYGSFOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 01:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYGSFOD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 01:14:03 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58089 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbYGSFOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 01:14:01 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id EAC7EC888A;
	Sat, 19 Jul 2008 00:13:49 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id IBU7C92C7TER; Sat, 19 Jul 2008 00:13:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=iwobpVjEIumpBu43P5U25Se5rsP4aBfjAf9ruH8vi8CzOKDPaBm/Qrd4XYH0I91IB2Ei22bSt89Dtq98rC7rft/9t++TKqVLbwcBhuUyiRSKHRNlptDWFgYUXZUDCoAxcQBt3Jb99Ly5SiB4usSZh5nFwMFeqfJwDUkS9VHQttU=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89099>

Quoting Junio C Hamano <gitster@pobox.com>:

> I tried not to sound too negative when describing -Xours and -Xtheirs
> there, but actually I think "-s theirs" is even worse.  It is how you
> would discard what you did (perhaps because the other side has much better
> solution than your hack), but that can be much more easily and cleanly
> done with:
>
> 	$ git reset --hard origin
>
> Some poeple might say "But with 'merge -s theirs', I can keep what I did,
> too".  That reset is simply discarding what I did.
>
> That logic also is flawed.  You can instead:
>
> 	$ git branch i-was-stupid
>       $ git reset --hard origin
>
> if you really want to keep record of your failure.
>
> One big problem "-s theirs" has, compared to the above "reset to origin,
> discarding or setting aside the failed history" is that your 'master'
> history that your further development is based on will keep your failed
> crap in it forever if you did "-s theirs".  Hopefully you will become a
> better programmer over time, and you may eventually have something worth
> sharing with the world near the tip of your master branch.  When that
> happens, however, you _cannot_ offer your master branch to be pulled by
> the upstream, as the wider world will not be interested in your earlier
> mistakes at all.

Thanks for sharing your insight.  Perhaps the above can become a separate pargraph to explains why there is no "theirs" merge strategy somewhere in the manual?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
