From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 13:11:36 -0500
Message-ID: <eaa105840902271011u19375ba4j4a765ed2707ebb3b@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <49A50EB2.80300@drmicha.warpmail.net>
	 <20090225232442.GC4573@raven.wolf.lan>
	 <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com>
	 <20090227165812.GA14187@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 19:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld7Cw-0001Zi-MH
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 19:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbZB0SLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 13:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbZB0SLn
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 13:11:43 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:44617 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZB0SLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 13:11:42 -0500
Received: by ewy25 with SMTP id 25so1411941ewy.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 10:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2mGjSESzKcnqmgWCo/2GvXIHy1EHfh8BZpOTrFyRYug=;
        b=XS390C0t54ey7ztZX+RLk35qYJEwCprC7Ej5evc1+HO5yNxhlnjGzmgMzPK63RAFXs
         Sh7Mdcrp5FLFCaDD07tWaeTHkVNSXPsQo/LhKsHsSWZnPva5m4H+5jOB1nzKsN1wUQIt
         gJOTGmNY06zgpOLSvBOR/NE6AqVbLTG6ZwetE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nwaAy63dE5yWlzTKBF0BNVPZnt6Ccq/ivEfLAnXJrlAh7epuVaIlYrjFcz8ToFP2Zs
         xWv/TjjuZY9xicgl+UgsdVuc5ICvcS8mog0h5h7CuupbtIxF1BehPaRwdAqsgBS74BTG
         21F+zT5YmvyEdjE6yABtX3uklA5ANe4dlD7NU=
Received: by 10.220.85.9 with SMTP id m9mr1111469vcl.40.1235758296932; Fri, 27 
	Feb 2009 10:11:36 -0800 (PST)
In-Reply-To: <20090227165812.GA14187@raven.wolf.lan>
X-Google-Sender-Auth: 68be6fc802cc1d81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111691>

On Fri, Feb 27, 2009 at 11:58 AM, Josef Wolf wrote:
> On Wed, Feb 25, 2009 at 08:02:45PM -0500, Peter Harris wrote:
>
>> No need to coordinate clones, aside from each clone
>> needing to know how to work in a "commits will be rebased by upstrea=
m"
>> type of environment (which isn't unique to git-svn).
>
> Hmm, what does that exactly mean? =A0Chances are that the reason for =
my
> problem is that _I_ am the one who don't know that...

See, for example,
http://kerneltrap.org/mailarchive/git/2008/8/23/3056824 and
surrounding thread.

The consensus is "Pester upstream until they stop rebasing".
Unfortunately, Subversion is an application, not a human, so your
pleas will go unheard. :-) The rest of that thread contains hints for
working with a rebasing upstream.

git-svn will actually never rebase anything once it is in Subversion.
So, for example, when they say 'linux-next' in that thread, you could
read "any branch that isn't in Subversion yet", since you know that
branch will be rebased at least once.

>> Oh, and make sure
>> you're using a recent git; older git-svn didn't have the incremental
>> index rebuild.
>
> jw@raven:/home/jw> git --version
> git version 1.6.0.2
> jw@raven:/home/jw>
>
> Is that OK?

2beec8973 is the commit in question. Unless I'm mistaken, it first
appeared in 1.6.1.0, so you may want to upgrade each cloneN to at
least 1.6.1.

Peter Harris
