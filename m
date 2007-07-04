From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Thu, 05 Jul 2007 08:18:27 +0900
Message-ID: <200707042324.l64NOp8J019289@mi0.bluebottle.com>
References: <20070704074444.GA5687@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 01:24:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6EDP-0004Go-9g
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 01:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbXGDXYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Jul 2007 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbXGDXYx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 19:24:53 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:49137 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311AbXGDXYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 19:24:52 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l64NOp8J019289
	for <git@vger.kernel.org>; Wed, 4 Jul 2007 16:24:51 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=PBz+IzTI+tvyXJ7LxVj6qbSAPFyW8t/T4O82rbiKFNlNMf8BuK9pgYyIlG0mVmty9
	iUw3iJ4JtSVMWW+wcB+qOrJiDWy7IGc3KK7EupPCN+rcwiYgkyPBiOWLsI2Vhz8
Received: from nanako3.mail.bluebottle.com ([222.133.3.213])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l64NOiBW013206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2007 16:24:49 -0700
In-Reply-To: <20070704074444.GA5687@informatik.uni-freiburg.de>
X-Trusted-Delivery: <7940fad0bc47e028cd98adc9cdc335e1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51648>

Quoting Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de>:

> Junio C Hamano wrote:
>> I noticed another thing.  The entries shown in "git stash list"
>> look like this:
>>=20
>> stash@{0}: js/stash: e1d32c1... Teach git-stash to "apply --index"
>> stash@{1}: master: 5be6007... Rewrite "git-frotz" to "git frotz"
>> stash@{2}: master: 36e5e70... Start deprecating "git-command" in fav=
or of "git command"
>> stash@{3}: master: 3b0d999... Merge branch 'jo/init'
>>=20
>> But each of the stash is _not_ about these commits, but is about
>> some change that happens to be on top of them.
>>=20
>> So risking to make it a tad longer, how about doing this on top?
>>=20
>> -	git update-ref -m "$msg" $ref_stash $w_commit ||
>> +	git update-ref -m "WIP on $msg" $ref_stash $w_commit ||
>
> I like that.  I already wondered about that, too.  But not as much as
> thinking about an alternative.
>
> So:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>

I am sorry to join the discussion late, but I think it is much better t=
o let
the user give a short reminder message from the command line.  For exam=
ple,

  $ git stash add customized message to stash

When I say "git stash list", I want to see which branch I was on when I=
 was
in the middle of doing something, and what that something was.  It is n=
ot
interesting which commit on that branch I started that change from.  Af=
ter
creating a stash without a message, and then another stash with a messa=
ge, I
want to see:

  $ git stash list
  stash@{0}: On master: add customized message to stash
  stash@{1}: WIP on master: 36e5e70... Start deprecating "git-command" =
in favor of "git command"

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
