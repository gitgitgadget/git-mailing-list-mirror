From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JTQsNC90YfQtdC90LrQvtCy?= 
	<adanchenkov@gmail.com>
Subject: =?UTF-8?Q?aliases_causing_=E2=80=9CPermission_denied=E2=80=9D_error_in_git?=
	=?UTF-8?Q?_v1=2E7?=
Date: Fri, 4 Nov 2011 12:09:07 +0400
Message-ID: <CALUFZ3n9cpHw3r3rcGriDqvJ+UM83L3Q19m=0YeAy51LBJzosA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 09:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMEpw-0006KR-QD
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 09:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1KDIJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 04:09:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56151 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab1KDIJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 04:09:08 -0400
Received: by wwi36 with SMTP id 36so3087201wwi.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yVWmruZ+NqGz4iseIQ/+SHYEXpe0hOf9zW3RPANj5o8=;
        b=OmqwbiuKslOuIREdQ9xqEPXM+4Bi8pDw0Vcu2hHaNIO0Um3GC8ZsV0hh4pKnArbJZw
         trXJ9Pc5JKdNInuzGdzlJOo0U+fiwuXbVKqO39eUNKywOn4TqIf1TIdfDKiliDlfuHaJ
         MUmulXIONSvtu82OoqNjDDqKWKOYOn88PsvuU=
Received: by 10.180.101.97 with SMTP id ff1mr368255wib.42.1320394147342; Fri,
 04 Nov 2011 01:09:07 -0700 (PDT)
Received: by 10.180.85.195 with HTTP; Fri, 4 Nov 2011 01:09:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184761>

Hi!

$ git co -b newbranch
$ git co oldbranch

results in "fatal: cannot exec 'git-co': Permission denied" error.

In the same time, things like

$ git checkout -b newbranch
$ git checkout oldbranch

and

$ sudo git co -b newbranch
$ sudo git co oldbranch

work as expected. Ownership rights for the .git die are set for the user
and 0755/0644 are the mode for .git dir/subdir/files. There are no git-co
script anywhere in the system (as it is an alias to git-checkout, which
resides in /usr/libexec/git-core).

Aliases are defined in .gitconfig of the home dir:

[alias]
co = checkout

There is no difference in git config for root or normal user.

Things work well as expected when I install git v1.6. Going back to 1.7
gives me the same error.

What am I missing?

---

Gentoo / kernel v3.0.6 / git v1.7.3.4
