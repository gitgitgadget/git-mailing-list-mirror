From: Michael Olson <mwolson@gnu.org>
Subject: Re: [spf:guess,iffy,mismatch] Re: [PATCH/RFC 2/2] git-svn: Don't 
	allow missing commit parent to stop git-svn
Date: Wed, 28 Apr 2010 08:51:12 -0700
Message-ID: <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> 
	<1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> 
	<4BCF8E07.9080507@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 28 17:51:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O79Y6-0007pM-7M
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 17:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0D1Pvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 11:51:36 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53494 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0D1Pvf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 11:51:35 -0400
Received: by vws19 with SMTP id 19so370964vws.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 08:51:34 -0700 (PDT)
Received: by 10.220.123.95 with SMTP id o31mr5490454vcr.23.1272469892260; Wed, 
	28 Apr 2010 08:51:32 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Wed, 28 Apr 2010 08:51:12 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <4BCF8E07.9080507@vilain.net>
X-Google-Sender-Auth: baa027999d4eb687
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145997>

On Wed, Apr 21, 2010 at 4:45 PM, Sam Vilain <sam@vilain.net> wrote:
> Michael Olson wrote:
>> Interestingly, I see people reporting the same problem in the thread
>> "git svn clone of subversion's own code failing". =C2=A0So it's not =
just
>> related to patch 1/2 of this series. =C2=A0At least that thread has =
a
>> public-facing repo so the problem should be easier to reproduce for
>> a real fix.
>
> Oh, right ... I remember that issue now. I'm currently testing the
> below change to see if it breaks the test suite; any issues and I'll
> post an update.
>
> Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear =
history
>
> The expression 'BASE^..TIP' is only defined when BASE has parents. =C2=
=A0It
> actually does what it intends only when it has one parent.
>
> Allow for more complicated revision list arguments than a range by
> splitting any space-containing arguments on the way into _rev_list,
> and check the parents of the bottom commit so that we may use the
> correct revision list specifier.
> ---
> =C2=A0git-svn.perl | =C2=A0 22 +++++++++++++++++++---
> =C2=A01 files changed, 19 insertions(+), 3 deletions(-)
>
> [snip]

This change works great on my private repos, so it should supersede my
version which only did an eval.

--=20
Michael Olson  |  http://mwolson.org/
