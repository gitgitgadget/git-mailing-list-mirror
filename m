From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: EOL handling (EGit/svn/Windows)
Date: Wed, 11 Feb 2015 16:51:27 +0100
Message-ID: <CAA01CsrJv8HmtNG6XAHZm5Hk8x8S_vFCYPz8vCtwBwd9-GAykg@mail.gmail.com>
References: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
	<54D99BED.8010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:51:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLZZd-0000Y1-TX
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 16:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbBKPva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2015 10:51:30 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51900 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbbBKPv3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 10:51:29 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so4744893wid.5
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 07:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IwAuOQgP7R+c1GbmjATmdxlXdcHnFqzqb1mEWrU2Waw=;
        b=bwT0eSJCoyDKUVFW/p0bCydaO/TlPL7X4d4kNral72Wql4quakHHn7NrJrfhEm3HcV
         Up93khnAt8we4tHEsd1F875R9A3+D0nXf4Bfjx5mvOJqrQ/hWtAr6eA56mh1qAZOeYQk
         dPLMvZ35wkQwP2djbH+6TAdsEbDG/LLB1Q6n6Y8crzgpwFNaJ/gFd/7rgjv8lRtrNsEj
         mOepj3Pf8SrlC0wZL19xQbwgm2aZB9hQaLuP65l/92W1aecBOT3EgIXsnR6Pkue6WUEk
         QEfqjOQGEEPispVnplryI/IMYhs32tG0TpH09VhnZhIPUD4NkYyOkIU4sY3ryylddYw6
         cbaA==
X-Received: by 10.180.88.193 with SMTP id bi1mr57183509wib.70.1423669888082;
 Wed, 11 Feb 2015 07:51:28 -0800 (PST)
Received: by 10.180.207.4 with HTTP; Wed, 11 Feb 2015 07:51:27 -0800 (PST)
In-Reply-To: <54D99BED.8010005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263680>

On Tue, Feb 10, 2015 at 6:49 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> add that to the repo, do the normalization  and push.

I did LF normalization over history. Looks like everything worked
correctly, just wondering, what does the WARNING mean?

$ git filter-branch --tree-filter '~/fix-eol.sh' -d /dev/shm/repo-tmp -=
- --all
Rewrite 4eab51b65af61d2b0e56f9990cc14be1e1372194 (13349/13349)
Ref 'refs/heads/master' was rewritten
Ref 'refs/remotes/origin/master' was rewritten
WARNING: Ref 'refs/remotes/origin/master' is unchanged

$ cat ~/fix-eol.sh
find . -type f \! -path ./.git/\* -print0 | xargs -0 dos2unix
--keepdate 2>/dev/null


--=20
Piotr Krukowiecki
