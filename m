From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>
Subject: Fwd: [git-users] Highlevel (but simple to implement) commands
 provided by default for git
Date: Wed, 29 May 2013 15:11:25 -0300
Message-ID: <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 20:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhkr7-0001RY-AA
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184Ab3E2SMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 14:12:10 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34984 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964985Ab3E2SMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 14:12:07 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so8904982lab.21
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=NaVFhbMViw4edElVdEQinSTnx/YP5Mor/Mc9BvSoLJw=;
        b=qyyR3G/RqgAwf18UEbgg7TGou70BUmi8jBXFWrzCAmrNJpKVdCJgVyv6P0cXuBZpVr
         v7VehUJ5JgK3endD6eIEYDHYJmG3zkn+5Qe5mMurfIJXfEZVCL/BdnY18zwwvhQ0F6QP
         fJbS531hkXRIKiIlcNwRFCsve7wFVVofgA4q1X6PrDKYpO82xTKFIdVk/eG3uz7HftiK
         Z2neCLMiBw1POiZtlLDHqC9eZ7VXX7OEVxvIruYwRTBSO+oWw8RbAvmd+QnKj2uk1mER
         cEfMBYGAPxnIuomb/0lyZiylpxNYLrxgBU4qQUfqpwqUbO2kR5gvz4eBUsytSvOZhQMj
         D5fA==
X-Received: by 10.152.9.104 with SMTP id y8mr1963957laa.1.1369851125274; Wed,
 29 May 2013 11:12:05 -0700 (PDT)
Received: by 10.114.39.104 with HTTP; Wed, 29 May 2013 11:11:25 -0700 (PDT)
In-Reply-To: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225858>

---------- Forwarded message ----------
=46rom: Br=C3=A1ulio Bhavamitra <brauliobo@gmail.com>
Date: Wed, May 29, 2013 at 8:23 AM
Subject: [git-users] Highlevel (but simple to implement) commands
provided by default for git
To: git-users@googlegroups.com


Hello all,

One of the things I note about git is that is provides mostly
low-level and strictly necessary commands.
Many highlevel commands are then implemented as alias by users, after
a deep search on the internet.

Adding highlevel commands, even though it could be implemented by a
simple alias, would put git in another level
of user experience and create a new standard for newbie users.
What git developers think about this?

I have, as many other users, an enormous .gitconfig. I paste here some
highlevel commands of it, according to my judgement.
Mercurial provides many of these highlevel commands.

  root =3D rev-parse --show-toplevel

 upstream =3D !git for-each-ref --format=3D'%(upstream:short)' $(git
symbolic-ref -q HEAD)
 upstream-remote =3D !git upstream | sed -e 's/\\/.*$//g'

 out =3D !git fetch `git upstream-remote` && git l `git upstream`..HEAD
 in =3D pull --dry-run


 unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
 untracked =3D ls-files --other --exclude-standard
 staged =3D ls-files --staged
 modified =3D ls-files --modified
 deleted =3D ls-files --deleted


  head =3D !git l -1
 current =3D rev-parse --abbrev-ref HEAD

Source: https://github.com/brauliobo/gitconfig/blob/master/configs/.git=
config

regards,
br=C3=A1ulio

--
You received this message because you are subscribed to the Google
Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send
an email to git-users+unsubscribe@googlegroups.com.
=46or more options, visit https://groups.google.com/groups/opt_out.
