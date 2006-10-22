From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 16:48:11 +0200
Message-ID: <845b6e870610220748q681984e8ld371c64a37b99544@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <453A7D7E.8060105@utoronto.ca>
	 <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	 <200610221105.26421.jnareb@gmail.com>
	 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	 <87zmbozau2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Jan Hudec" <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 17:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbeq6-0001Yr-6L
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 17:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWJVPCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWJVPCL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 11:02:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:39402 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751090AbWJVPCK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 11:02:10 -0400
Received: by nz-out-0102.google.com with SMTP id z3so484701nzf
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 08:02:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RaMZ6kTAze4GFwvcQAYSQnWMV/VkQqw+sR3sPni7nNtN6PFiJfHZ1ZU+3OFBlp0XgLwvqA815iirFugH+zBbccJHi0AO4lNR8jq7/JJ+JHmdJbnNlzUYh57Tuxv+wzq6tNgsp6X691MJmrqlOmMiFtIf6t+YVOOjHbRkyiAMjhw=
Received: by 10.35.18.4 with SMTP id v4mr4740000pyi;
        Sun, 22 Oct 2006 07:48:12 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sun, 22 Oct 2006 07:48:11 -0700 (PDT)
To: "Carl Worth" <cworth@cworth.org>
In-Reply-To: <87zmbozau2.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29759>

Thanks for this mail, this makes me happy to see. The tools are pretty
much the same but have some different view on how to do things..

On 10/22/06, Carl Worth <cworth@cworth.org> wrote:
>
>         git log --no-merges mainline..featureA
>
> The mainline..featureA syntax literally just means:
>
>         the set of commits that are reachable by featureA
>         and excluding the set of commits reachable by mainline
>
> It's an extraordinarily powerful thing to say, and its exactly what
> you want here. And it's more than a "show mainline" thing, since
> theses sets of commits can consist of arbitrarily complex DAG
> subsets. This syntax is just a really useful way to slice up the DAG.
>
> And this syntax is almost universally accepted by git commands. so yo=
u
> can visualize a chunk of the DAG with:
>
>         gitk mainline..featureA
>
> Or export it as patches with:
>
>         git format-patch mainline..featureA
>
> I haven't been able to find something similar in bzr yet. Does it
> exist?

If I understand you correctly, you'll get the same thing with "bzr miss=
ing".

$ bzr missing ../mainline/
You have 1 extra revision(s):
------------------------------------------------------------
revno: 2
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: newbranch
timestamp: Sun 2006-10-22 16:43:10 +0200
message:
  hepp


You are missing 1 revision(s):
------------------------------------------------------------
revno: 2
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: mainline
timestamp: Sun 2006-10-22 16:42:53 +0200
message:
  hej

You can also run "bzr missing" with "--theirs-only" or "--mine-only"
to get only one way.

To get the patches you can run "bzr bundle ../mainline", but then
we're back to the discussion that it currently gives a "big patch" for
viewing, but when you merge it, you get each revision separately.

/Erik
