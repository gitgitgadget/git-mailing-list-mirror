From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Rewriting git history during git-svn conversion
Date: Tue, 4 Mar 2014 11:56:42 +0100
Message-ID: <CAEcj5uVOWzcCjrUO9NBuRvbPUaqigJyaOmG_8wCumznB+yTH4Q@mail.gmail.com>
References: <CAHd499DqoUEKeu4uM5w7Y6Tm-tE-oJMUdz4RxP9s6CpN=LS9Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKn1j-00015I-NM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 11:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbaCDK4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 05:56:43 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:38747 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbaCDK4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 05:56:42 -0500
Received: by mail-qg0-f41.google.com with SMTP id i50so14999909qgf.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l3Jlsa/GG3lRPSq05U050PQqbaU/D1OA2hkr7cZTY10=;
        b=eMZoa83EuXJHnCn2tOOtBxSV/3ToRXByCk8Jc/r0vUw2MdyAtkwZI4Jzaa4Ak3wBIc
         ZR7RRKwVakF+4j3We/1z/yAETvFnDRT0L2whdebjogtM7O/G91ZuwNvGmpS8TsZaraYV
         pPZyuMDYYnW8vT9O3LGlmdnMlbKVIkoraKdKI6IHM/0LJZBk1nHPQu9HCPgr8DN3KFXG
         igNJvfO3zNp404Yzl0QNGhsDlsI+6/A8qOUE1Axxkhhow+Qfiq+dy6hywICL0W+J7Ex2
         9PMKV1RacewNKCLxYzWYEanrczoGz4LuPqrcLUwd9kpsPyMpqNBkN88U5B6Y5oI3VWol
         91Mw==
X-Received: by 10.140.81.74 with SMTP id e68mr8559943qgd.99.1393930602230;
 Tue, 04 Mar 2014 02:56:42 -0800 (PST)
Received: by 10.140.81.75 with HTTP; Tue, 4 Mar 2014 02:56:42 -0800 (PST)
In-Reply-To: <CAHd499DqoUEKeu4uM5w7Y6Tm-tE-oJMUdz4RxP9s6CpN=LS9Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243338>

On Mon, Mar 3, 2014 at 7:38 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> Is it safe to do this while still using git svn fetch? Will it
> properly continue to convert SVN commits on top of my rewritten
> history? If not, what changes can I make after I run the commands
> linked by the URL above so that git svn continues to work normally?
>

I think it's OK. git-svn doesn't continuously verify the integrity of
history already converted, I believe.

Just try it out, it worked fine in a little demo setup I made
(although I used rebase -i instead of filter-branch):

git svn clone .. #maybe clone a little test repository to speed up the testing
git filter-branch ... #remove unwanted files
git svn fetch #this should work

On a related note, maybe you'll enjoy my git-svn demos & ideas here:
http://www.tfnico.com/presentations/git-and-subversion
