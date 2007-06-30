From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Sun, 01 Jul 2007 08:27:10 +0900
Message-ID: <200706302327.l5UNRMta027974@mi0.bluebottle.com>
References: <Pine.LNX.4.64.0706301641000.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 01:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4mLh-00082x-1M
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 01:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbXF3X1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Jun 2007 19:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbXF3X1X
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 19:27:23 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:53733 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbXF3X1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 19:27:22 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5UNRMta027974
	for <git@vger.kernel.org>; Sat, 30 Jun 2007 16:27:22 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=AICW+tltW4xKbnLCvZ3tCtaxEsyzOv0b3l/rPOb+AdnYuJXlMoPhrcKptbLCUAk6I
	8F4c1E8mXmB/7OJkGpgPQeixG9AfyD8xuDFlYdJ1oAQGvtM9LYBTKNyrv5uW1Fk
Received: from nanako3.mail.bluebottle.com ([218.16.123.142])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5UNRFFl028614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Jun 2007 16:27:19 -0700
In-Reply-To: <Pine.LNX.4.64.0706301641000.4438@racer.site>
X-Trusted-Delivery: <0755f9932a12d9d6daecd3c5bc491cb1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51262>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,

Hello.

> On Sat, 30 Jun 2007, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=
=81=AA=E3=81=93 wrote:
>
>> diff --git a/git-stash.sh b/git-stash.sh
>> [...]
>> +	printf >&2 'Saved WIP on %s\n' "$msg"
>
> You have an awful lot of printfs in the code. Why not just use echos?

I just imitated other scripts.  I can change it to

echo >&2 "Saved WIP on $msg"

but after reading Junio's comments, I think I probably should not.

>> +list_stash () {
>> +	git-log --pretty=3Doneline -g "$@" $ref_stash |
>
> Wouldn't you want "--default $ref_stash" here?

I do not know, and I'm sorry I do not understand Junio's comments.

What does --default do in this case?

>> +apply_stash () {
>> +	git-diff-files --quiet ||
>> +		die 'Cannot restore on top of a dirty state'
>
> You meant "no_changes", right? I think you miss changes in the index=20
> otherwise.

After I read exchanges between you and Junio I do not know which way
is preferred.  Using no_changes does not forbid me from doing that,
but I think Junio's example will be forbidden.  The original scenario
was that I apply a stashed change to an unmodified state, and there is
no problem either way.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com
