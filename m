From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git pull' fails with 'not uptodate' message despite 'git reset 
	--hard'
Date: Wed, 29 Jul 2009 20:44:32 +0000
Message-ID: <32541b130907291344u3c2b7df8ld848a79ec38197a6@mail.gmail.com>
References: <20090728230842.GE22281@clouds> <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com> 
	<20090729203637.GF22281@clouds>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jody McIntyre <scjody@sun.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWG1G-0003H3-Be
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 22:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbZG2Uoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756019AbZG2Uox
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 16:44:53 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:53541 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZG2Uox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 16:44:53 -0400
Received: by yxe36 with SMTP id 36so387886yxe.21
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Cnu1ge7BswYRVP7e8Lw3nyTYsytlPySlVhl4ZFkJ/mE=;
        b=Nf/e5oSwaMSUarEF38WSGpJ1hGPZYYH5DmP0g6wm3/4d/3xumj/87YUjBljhUq4hcu
         buIwX/AC906gluAucAbx9c8o5l1K7nUAiWYCcxjVX2rgz+FSXe08lJV1g79nOww1VuNu
         k7ZW2Rf1FJfNNUbsC6aPfsBjwtQjHYi9oYGD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LaaE41Uej7Dv2Ju/pIs3URbaFVcx5RNFVH5YF04CWEmZtrzpYaSY7aTXFBcsyUjVhh
         pUtHJ7OTFBs3sRIP+UJSH+53X0gLTfSnHvHH/O6Dm4AdXuEBpp4ZHXwl89ibbHVZnpID
         on+UT1AIgptpYhTMWuLusPaPCpC9EZQX8Mtf4=
Received: by 10.150.191.10 with SMTP id o10mr549806ybf.167.1248900292230; Wed, 
	29 Jul 2009 13:44:52 -0700 (PDT)
In-Reply-To: <20090729203637.GF22281@clouds>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124386>

On Wed, Jul 29, 2009 at 8:36 PM, Jody McIntyre<scjody@sun.com> wrote:
> On Tue, Jul 28, 2009 at 08:19:54PM -0400, Avery Pennarun wrote:
>> Usually a 'git status' will fix it. =A0In any case, if it doesn't,
>> please send the output of 'git status' :)
>
> This is again a bit strange:
>
> $ git status
> # On branch master
> # Your branch is behind 'origin/master' by 484 commits, and can be fa=
st-forwarded.
> #
> nothing to commit (working directory clean)
> $ git status CREDITS > /tmp/git_status.txt
> $ wc -l /tmp/git_status.txt
> 26063 /tmp/git_status.txt

Okay, that's extra strange: when I've had this problem, 'git status'
has fixed it right away; it just goes away after that.  It might be
that recent changes to git have added an "optimization" that makes
this not happen for some reason.

You can always try the thermonuclear option:

   mv .git/index .git/index.bak
   git reset HEAD    # note, don't use --hard here
   git status   # should show only files you have *really* changed

Of course, if this fixes it than it's *definitely* a bug somewhere.

Good luck.

Avery
