From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 20:35:50 +0200
Message-ID: <CAB9Jk9AR7vFBH6E7-hFabyD9XgRrF5PVZU-HtABS85wkwVTt+Q@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<20121026174255.GE10560@camk.edu.pl>
	<CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
	<20121026182020.GF10560@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <n1xim.email@gmail.com>, git <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRolH-0000Fz-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 20:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966009Ab2JZSfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 14:35:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37585 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965944Ab2JZSfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 14:35:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2951198pbb.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0PyFhTon3PbGjw9Mb8FuAmyapTNagpZn1n/5ERUu3QA=;
        b=RF22WSIeWVcmo7DTt0iTslBoYUpHUVgqsUs+n1vrH90ctUJzbbsaMfqZ9vJBfoLqS9
         7zDLLMSM0vW8oItv8XSBZKNu8giuKNwrZiEH5+82mzDLyYluxXEPZVC49MdzCTMuoRd9
         5z9HMGmMlYV01ic3Jjw78oC9y16jC9o/kC7HtqLdLHWUYTT/jRaClRUObqHcQVN064iK
         BFDITLkcMpz09KE8YMZuLS1m+DTpmXUED5CY+aU/O5S6b0QO+ujpGuq0V/fsJV0FbAX3
         +ESMt+Dy0lotT0OSPzm5ozS0wHHKIPfvb3LTnjOmyRShtgus+PMoWgUpuStnHJ0nsEJ5
         9Iug==
Received: by 10.68.129.72 with SMTP id nu8mr71816250pbb.29.1351276550093; Fri,
 26 Oct 2012 11:35:50 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Fri, 26 Oct 2012 11:35:50 -0700 (PDT)
In-Reply-To: <20121026182020.GF10560@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208475>

Hello

Drew,

I made some further tests on git-push to see if it handled branches
and tags in the same way, and have discovered the following
differences:

    - git push origin --delete master
      remote: error: By default, deleting the current branch is denied

    - git push origin --delete vx            (where vx is a tag)
      ... accepted

This is consistent with what is done on the local repo: deleting the
current branch is disallowed, but deleting a tag is allowed (even when
HEAD points to it).
That means that git-push does not handle branches and tags exactly the same.

Kacper

thank you for the patch. To keep downward compatibility, the denial to
update tags should perhaps be enabled with some option.

-Angelo
