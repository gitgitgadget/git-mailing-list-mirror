From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH 1/2] t3404: extra checks and s/! git/test_must_fail git/
Date: Sat, 21 Jun 2008 07:18:12 +0900
Message-ID: <20080621071812.6117@nanako3.lavabit.com>
References: <20080620190037.GE7369@leksak.fem-net>
	<alpine.DEB.1.00.0806201407230.6439@racer>
	<1213986614-19536-1-git-send-email-s-beyer@gmx.net>
	<X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil>
	<20080620190037.GE7369@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 21 01:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9pgq-0006Dj-3y
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 01:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbYFTXFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 19:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbYFTXFc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 19:05:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:40386 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663AbYFTXFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 19:05:31 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 06482C79F8;
	Fri, 20 Jun 2008 18:05:23 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id AZHG37X0PEU4; Fri, 20 Jun 2008 18:05:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=imOE/UiBHou25aaLJ+71ev5tKNNEsBLqHA1e50faSOM1boZzOutqL8SfJXnJ9dXDjNqKKMVd6Gy/45Kh2/jf5//wgEjFrQ98MuxeXxI7BrOqX3R07OR1CngQvQX37XPPxtoWWh5ncC9ozucNwQCVwZomzSjrTagBDAeaZU26Ji8=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Stephan Beyer <s-beyer@gmx.net>;
In-Reply-To: <20080620190037.GE7369@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85681>

Quoting Stephan Beyer <s-beyer@gmx.net>:

> Hi,
>
>> > @@ -380,7 +397,7 @@ test_expect_success 'interrupted squash works as expected' '
>> >  	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
>> 
>> These can be converted to use test_must_fail by using a sub-shell
>> as Junio demonstrated:
>> 
>> 	(
>> 		FAKE_LINES="1 squash 3 2" &&
>> 		export FAKE_LINES &&
>> 		test_must_fail git rebase -i HEAD~3
>> 	) &&
>
> Perhaps I'm not consequent, but I thought that it's not worth it ;-)

Doesn't that logic make the other s/!/test_must_fail/ changes
also not worth it?  What is the reason behind the change?

I think your subject line and the message is worse than your
previous one.  You are saying *HOW* you changed it, without
saying *WHY* nor *WHAT FOR*.

I may have written your log message like this:

	Subject: t3404: tighten git-rebase tests

	In preparation for rewriting git-rebase in C, replace the way a
	failure is currently detected with "! git" to use test_must_fail
	so that we do not confuse a broken rebase that dumps core with a
	correctly failing one.

although I do not know if you are rewriting git-rebase in C
(^_^).  The point I learned from this project is to say why it
is done that way, not how you did it.  The latter can be seen in
the diff.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
