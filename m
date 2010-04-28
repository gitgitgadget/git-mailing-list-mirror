From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [patch 06/16] diff-test_cmp.patch
Date: Wed, 28 Apr 2010 04:51:59 -0500
Message-ID: <20100428095159.GD1394@progeny.tock>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135833.403548000@mlists.thewrittenword.com>
 <20100427171531.GA15553@progeny.tock>
 <20100428090045.GD36271@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:52:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O73wG-0000bQ-8p
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab0D1JwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 05:52:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58701 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0D1JwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:52:08 -0400
Received: by vws19 with SMTP id 19so130841vws.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4BaH7BhjTWjmQsqFlnoHmsJxTtqWogOdNalGjFrFYVs=;
        b=IeoxoEBRkQiNJt7UpLizwIArDkOxnjD0LjsdjEonGYGXOlg6uju9/CP3a2d47qHU/U
         KVIa7NjT0Uv08iRArAfq23iA3Co6pbtFr36jm0VvqE3obFaxj6W4P9Zq4AcBautI333Y
         M71/CF/i0shUr1nA3JxEPq3Sgnmpko3Nf6QuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rgUTZEuR+J4JWz9JllI5tkZjmqnfXscOCdVL/dzc6lEuK8yA5Ym4+QLm9OloMgygCK
         nKoHseUydzlaE6w0UmLEgZJ8QD/4JMki2hPZ2eJAwXINRt+Nkv9PrG6MSJAAYGicEF9J
         HFENa06sabYH43GMRTAb13kYyrNYbLs+1NzE4=
Received: by 10.220.107.8 with SMTP id z8mr5090825vco.74.1272448325125;
        Wed, 28 Apr 2010 02:52:05 -0700 (PDT)
Received: from progeny.tock (c-76-28-252-211.hsd1.wa.comcast.net [76.28.252.211])
        by mx.google.com with ESMTPS id m13sm29162606vcs.13.2010.04.28.02.52.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 02:52:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100428090045.GD36271@thor.il.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145984>

Gary V. Vaughan wrote:

> Can I add a Sign-off message to each patch subthread?  Or do you need
> me to resubmit the entire series?

I think one sign-off for the whole series would be good enough; then
the person applying the patches can forge your signed-off-by lines.

I pointed it out mostly for future patches.

> On Tue, Apr 27, 2010 at 12:15:52PM -0500, Jonathan Nieder wrote:

>> And is it possible to change your mailing script to use more
>> meaningful subject lines?
>
> Sure.  What is preferable?  As short a sentence summarising the fixed
> issue as I can muster?

Yep. :)  It need not be a sentence (and should skip the full stop).
You can see some example subject lines by looking at the "shortlog"
from git or Linux release announcements or running
git log --oneline --no-merges.

Something like =E2=80=9Ctests: Use test_cmp when appropriate=E2=80=9D w=
ould do.

> (Like SuSE Linux, we use quilt to manage and
> submit our patch stacks... git seems to require hosting the entire
> history of each project which is too heavyweight for the 1000's of
> packages we build - if git provides the means to store just the head
> of an upstream release branch along with our patch stacks on local
> disk, I would love to be proven wrong here).

The most general way:

 curl http://address/of/tarball.tar.gz | tar -xf -=20
 git init *
 cd *
 git add .
 git commit -m "upstream release"
 ... use git like normal

You can automate some of those steps by

 wget http://address/of/tarball.tar.gz
 git init project
 cd project
 perl /usr/share/doc/git/contrib/fast-import/import-tars.perl tarball.t=
ar.gz
 git checkout import-tars
 ... use git as usual

If upstream uses git, there is also the shallow-clone facility:

 git clone -b master --depth=3D1 git://repo.or.cz/git.git/
 cd git
 ... use git as usual, except history is cauterized

It has one rough edge you may run into: push is not supported.  If that
is a problem for you, let me know and maybe I can try to help fix it.

Honestly, I=E2=80=99m okay with quilt, too.  The main difference I noti=
ce is that
=E2=80=98git diff=E2=80=99 uses the equivalent of the diff -p (--show-c=
-function)
option by default.

> Maybe in combination with the missing Signed-off-by: headers and
> unsuitable Subject headers I need to amend and resubmit the whole
> patch series again?

I think the cognitive load on reviewers is lighter if you send small,
isolated changes until you think it is as ready as it is going to get
for the current round, and only then resubmit the series.

Thanks for the hard work.
Jonathan
