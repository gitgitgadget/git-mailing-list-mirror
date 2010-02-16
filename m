From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git Submodule Usage Pattern
Date: Tue, 16 Feb 2010 12:48:16 -0500
Message-ID: <32541b131002160948h317e71f5m2d2cb839470a38f1@mail.gmail.com>
References: <c115fd3c1002160639m113a3604wa6686bc613a7c202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 18:48:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhRXP-0004gM-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140Ab0BPRsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 12:48:38 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:61542 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858Ab0BPRsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 12:48:37 -0500
Received: by yxe38 with SMTP id 38so4424622yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ysl1ES272E5ZpEbODfYPON8N63it1gypbqvpZa/YnSE=;
        b=IFN8QeKN/jNOQADjzqZuv9YVZg2eXoZRLb2u93jZpANwkbO/gYjkvPR4pyLXeel1pR
         wjJvB7J6k3s/SlzrL4yyuuaSAPPUfO5Ke4XBfg+EUDt7JozhYLENDqxd4oF9u2jtiMek
         HCq120yUaKxIr0TH4NhLATm3mLtPffCEwcBxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DanKlBw0l9YHJo1YJLdN78p5ztxK6wVEw556+j2gzXNf+8DPMtC8DcK+x8VOZUJSxn
         iOe5bvNO4HH17gAjKKICcFV5V/7vEx4l5al5hYml5nD0Q4qm87f631Zs98k0CHnUvxFq
         TFK5l0ki7Ed344jwwdnJCGZUIAfESA0rk7Vek=
Received: by 10.150.47.11 with SMTP id u11mr8381306ybu.140.1266342516234; Tue, 
	16 Feb 2010 09:48:36 -0800 (PST)
In-Reply-To: <c115fd3c1002160639m113a3604wa6686bc613a7c202@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140132>

On Tue, Feb 16, 2010 at 9:39 AM, Tim Visher <tim.visher@gmail.com> wrot=
e:
> Apparently, submodules are not configured on a per-repo basis, unless
> I'm totally misunderstanding something. =A0The .gitmodules file wants=
 to
> be checked in just like .gitignore, etc. =A0I don't know if submodule=
s
> will work correctly without syncing that between repos, either. =A0Wh=
at
> I need is to have the submodule at work point at a different repo tha=
n
> the submodule at Home to avoid firewall issues. =A0Or for someone to
> suggest a different work flow that would allow me to have my main hom=
e
> repo point at GitHub using my private git:// address and the
> zen-and-art repo using it's public git:// clone address and then have
> my Work repo clone from GitHub around the firewall (or somewhere else=
,
> GitHub's http cloning is still pretty Janky) but then push to the
> Stick.

Three suggestions I can offer:

1) After running 'git submodule init', look in .git/config.  You can
change which repos the submodules point to from there, on a per-repo
basis, and not affect other people's checkouts.

2) Try using relative repo paths (like ../foo.git) in .gitmodules.
Then as long as your repositories are siblings of each other, if you
can check out one you can check out the other.

3) git-subtree (http://github.com/apenwarr/git-subtree) does not
exhibit this problem.

Have fun,

Avery
