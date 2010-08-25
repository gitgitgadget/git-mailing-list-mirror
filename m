From: "Todd A. Jacobs" <tjacobs@si2services.com>
Subject: Re: How to query the version of a file?
Date: Wed, 25 Aug 2010 09:27:44 -0400
Message-ID: <AANLkTi=_LaHnuZ7AYDW_TCD7fhSFFdcm_hX3GHRyvwEi@mail.gmail.com>
References: <AANLkTi=upbiD5EBumxNxG0YvSRZN0mDfvu7LeU0y0Zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Edmond Halley <halleyinvent@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 15:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoG19-0005RJ-QT
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 15:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab0HYN1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 09:27:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33094 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0HYN1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 09:27:46 -0400
Received: by ewy23 with SMTP id 23so226538ewy.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 06:27:44 -0700 (PDT)
Received: by 10.216.1.208 with SMTP id 58mr7360200wed.22.1282742864451; Wed,
 25 Aug 2010 06:27:44 -0700 (PDT)
Received: by 10.216.229.164 with HTTP; Wed, 25 Aug 2010 06:27:44 -0700 (PDT)
In-Reply-To: <AANLkTi=upbiD5EBumxNxG0YvSRZN0mDfvu7LeU0y0Zpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154445>

On Wed, Aug 25, 2010 at 2:33 AM, Edmond Halley <halleyinvent@gmail.com> wrote:
> I have a standalone repository.
> File a.cpp has 3 versions.
> For example, I checked out version2(HEAD^).
>> git checkout HEAD^ a.cpp
> After a few days, I forget which version I have checked out.
> Is there a git command that can query which version is checked out?

There may be an easier way to do this, but the way I do it is (sort
of) documented in
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#Finding-comments-With-given-Content
(should be "commits" instead of "comments", but oh well!) and can be
tweaked to suit yourself:

    git log --raw --abbrev=40 --pretty=oneline |
    grep -B 24 `git hash-object a.cpp`

There may be other, and possibly more efficient, ways to do this, but
it generally works for me.
