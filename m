From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question about scm security holes
Date: Thu, 4 Mar 2010 21:03:08 -0500
Message-ID: <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 03:03:36 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnMt5-0006Wh-7F
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 03:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab0CECDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 21:03:30 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34052 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab0CECD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 21:03:29 -0500
Received: by gwb15 with SMTP id 15so1545232gwb.19
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 18:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jBcHBbbPtIIrUDmXr+rEoUoC233suFqnNwMNRRo2Ygs=;
        b=bUI6Ecx/pL4I3aYHbyF8S5obmHxhlR+0vds77wb7b63wuQe34AHUV2fZRhxC+ojEwT
         G8zyJRUhFTqw1hMfMnQF65K4ugCJuBSJaAOaOUpfPn4gc/SLQiFWrKpHjTLzw1dMCH2T
         DAM+M3O9STnL621AklwHx2GTBOfn0D+JH7sfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vT6yzRXk/hxUF8ZhMLOITOGpCFWWvyBvgUankCTfH7f22ndChs8Xty101uiFuuVJDC
         RZSdqB02IXIZBHCFCZRrs92YSDUp2mO0n88scLgSHEUq6irH/ZNWdshsJUoW0FcaupzO
         kwKKZnEMKM1+zrZoHnHScu1mMXfHd2UWCN2i4=
Received: by 10.150.117.19 with SMTP id p19mr441292ybc.275.1267754608108; Thu, 
	04 Mar 2010 18:03:28 -0800 (PST)
In-Reply-To: <hmp427$d6h$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141553>

On Thu, Mar 4, 2010 at 3:09 PM, walt <w41ter@gmail.com> wrote:
> I can't tell from the article if Perforce is any worse than any other scm
> for security holes, in fact it seems to imply that others haven't been tested in
> the same way.
>
> Just curious if anyone here has any thoughts about how the article may or
> may not have any relevance for git (git being the scm I use most, by far, which
> is the reason I'm interested).

The attack was uninteresting.  The paper seems to go on and on about
different ways that an attacker can steal source code by accessing a
poorly-secured SCM server.  This discussion is kind of moot for git,
where every single developer workstation has a complete copy of the
entire project history anyway.

An attack in which someone untraceably modified the repo to contain
modified code would be a little more interesting.  git makes this sort
of thing pretty much impossible to do without it being *noticeable* at
least.  Traceable, not so much, because you can create a commit with
whatever committer/author names you want and then push them in.
Commits aren't GPG-signed, only tags are, so there are lots of ways to
forge a commit from someone else and mess up the audit log.  At least
you can't edit old commits without people noticing, though.

Have fun,

Avery
