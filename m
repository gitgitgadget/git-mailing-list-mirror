From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 02:19:40 +0200
Message-ID: <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 02:20:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2vlb-00084T-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 02:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801Ab0DQAUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 20:20:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:37305 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab0DQAUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 20:20:01 -0400
Received: by fg-out-1718.google.com with SMTP id d23so569604fga.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=vjUZHMj1PH7Ig5ZQTeVRvUow4MiS9+5CRR2lnFCT7aA=;
        b=dlqgnrTn1sKYin/1vVLpc9cti6CTDMwzjGIDNquc9ftsmUC1mOX3t/xdPzlLMLwfOM
         TgTSGQxCdgtenGKdlGecc03I4PV4Ga7r7bRnq1TcRSeRUCih1N5IZQvh+fgsACbKdXzI
         O1w94i/06eWc6GNkiwwG3a1EeWIiEbsrQAh38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=w1qdEYjR0RFzfU9c+J21FGSPl1WHBvNNUSzFEo9lAFZT8VVrAELNI/ZAGc+1cYcfFU
         GXglY8uDcXBi4tLcgelK2J+5vbSXo4+51ZVhKjPVLlOi3T4nHLvXmOQC7jjbX5GVGK0b
         2DCTaS0MVIL6QLQ4u7erEbYSqGm+dZrfOkAng=
Received: by 10.103.168.14 with HTTP; Fri, 16 Apr 2010 17:19:40 -0700 (PDT)
In-Reply-To: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
Received: by 10.102.15.13 with SMTP id 13mr1511950muo.91.1271463600083; Fri, 
	16 Apr 2010 17:20:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145100>

Heya,

[-wikitech-l, if they should be kept on the cc please re-add, I assume
that the discussion of the git aspects are not relevant to that list]

On Sat, Apr 17, 2010 at 01:47, Richard Hartmann
<richih.mailinglist@gmail.com> wrote:
> This data set is probably the largest set of changes on earth, so
> it's highly interesting to see what git will make of it.

I think that git might actually be able to handle it. Git's been known
not to handle _large files_ very well, but a lot of history/a lot of
files is something different. Assuming you do the import incrementally
using something like git-fast-import (feeding it with a custom
exporter that uses the dump as it's input) you shouldn't even need an
extraordinary machine to do it (although you'd need a lot of storage).

> As of right now, I am trying to import on my local machine, but
> my first, rough, projections tell me my machine will melt down at
> some point ;)

How are you importing? Did you script the process that does something
like 'move next revision of file in place && git add . && git commit'?
I don't know how well that would work since I reckon the worktree will
be huge. Speaking of which, it might make sense to separate the
worktree by prefix, so articles starting with "aa" go under the "aa"
directory, etc?

Anyway, other gits might have more interesting things to say, cc-ed is
Avery, who has been working on a tool to back-up entire harddrives in
git. Also cc-ed are Nico and Shawn who both have a lot of experience
with the object backend and the pack implementation. Also, Sam, who
has worked on importing the entire Perl history into git, not sure how
big that is though, but they have a lot of changesets too I think.
There's a bunch of people that have worked on importing stuff like KDE
into git, who might have interesting things to add, but I don't know
who those are.

Hope that helps, and if you do convert it (and it turns out to be
usable, and you decide to keep it up to date somehow), put it up
somewhere! :)

-- 
Cheers,

Sverre Rabbelier
