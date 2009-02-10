From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with an 
	asterisk
Date: Tue, 10 Feb 2009 08:59:57 +0100
Message-ID: <adf1fd3d0902092359o43427e89j2005e3653766723f@mail.gmail.com>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
	 <20090210000321.78025483@crow>
	 <7viqnjrveb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 09:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnYf-0006jg-6d
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 09:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbZBJIAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 03:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbZBJIAA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 03:00:00 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41021 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZBJH77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 02:59:59 -0500
Received: by bwz5 with SMTP id 5so2299034bwz.13
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 23:59:57 -0800 (PST)
Received: by 10.103.226.10 with SMTP id d10mr2242088mur.35.1234252797396; Mon, 
	09 Feb 2009 23:59:57 -0800 (PST)
In-Reply-To: <7viqnjrveb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109186>

2009/2/10 Junio C Hamano <gitster@pobox.com>:
> Mark Burton <markb@ordern.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> Let's hope that nobody's scripts rely on a single star in front of the
>>> local HEAD...
>>
>> I don't know if I have any scripts that rely on a single star in front of
>> the local HEAD or not (I'm sure some people must have them), but I do
>> think this new feature would be very confusing, especially when used
>> with -a.
>
> People use "git branch | sed -ne 's/^\* //p' in their scripts (you can say
> "against recommendation" but I think it is a sign that the recommendation
> against use of Porcelain in the scripts is not loud enough).  I do not
> think anybody greps in "git branch -a", though, for that purpose.
>
> The current "branch -a" output is a mess.  It omits "remotes/" even though
> it includes the local ones in the output.  Perhaps with remotes/, the
> output may become a bit more readable:
>
>    $ git branch -a
>    * master
>      next
>      pu
>    * remotes/dscho/master
>    * remotes/origin/master
>      remotes/origin/next
>      remotes/origin/pu
>    * remotes/spearce/master
>
> which may still be too loud with asterisks, but at least there is no
> confusion.  Or perhaps like this:
>
>    $ git branch -a
>    * master
>      next
>      pu
>      remotes/dscho/HEAD -> master
>      remotes/dscho/master
>      remotes/origin/HEAD -> master
>      remotes/origin/master
>      remotes/origin/next
>      remotes/origin/pu
>      remotes/spearce/HEAD -> master
>      remotes/spearce/master
>
> with an obvious twist when there is no mixed output:
>
>    $ git branch -r
>      dscho/HEAD -> master
>      dscho/master
>      origin/HEAD -> master
>      origin/master
>      origin/next
>      origin/pu
>      spearce/HEAD -> master
>      spearce/master

For me it makes sense.

Also this type of output for symrefs "-> master" makes even more sense
in the verbose output.

Santi
