From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [l10n] date: Note for translators not included in .po files
Date: Thu, 17 Apr 2014 09:41:42 +0800
Message-ID: <CANYiYbGC0MsYFMv2kUjDxE64tO_gXb6gtFoRMNv4zpyTcHdT+w@mail.gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 03:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WabKm-0004nU-OZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 03:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbaDQBlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 21:41:44 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:50037 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaDQBlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 21:41:44 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so11676542wes.31
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 18:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9mjvNp+dbbdddMHHnYE3A0IHe3xwj21EQzfQa+BoiI4=;
        b=1BAjXE9+Ir9wZsQBO/4sXKbYIShWzW5oxsBpV6w+br8FWFGRQenPDrunUhEf0z72SW
         8cfUiSBIBNC59bIc8iu/YpSdhlGbIVZbCn1yvmgUQUXoGSs5LuBUDu0EkAq7Ro75jB6n
         1a2LMOfukj6DVeAXXyfqJrsIuzYl56UW3xUdC64zg/TNH6G8TNxRR7o3J+JeFJ08/JJ4
         jfmxhXurvEGiAB7gt9f4la0ebtZBhIB8o+Ulnx46OrNYP7KLl2VNzxeltkOw2JIUjEpr
         tpNQ5ZcXkFWP4t4ELPpeOIznGKdFwOfOBLb4QFdWVZyyu4Q7637y+REoba3luLrgo+36
         4F6w==
X-Received: by 10.194.204.199 with SMTP id la7mr9600117wjc.4.1397698902819;
 Wed, 16 Apr 2014 18:41:42 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Wed, 16 Apr 2014 18:41:42 -0700 (PDT)
In-Reply-To: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246399>

2014-04-17 6:51 GMT+08:00 Brian Gesiak <modocache@gmail.com>:
> A note for translators in date.c is not included in git.pot.
> Namely, the following note from date.c:147 is not included
> (https://github.com/git/git/blob/v1.9.2/date.c#L147):
>
> /* TRANSLATORS: "%s" is "<n> years" */
>

Comments for translators will be extracted to pot file automatically,
when run xgettext with "--add-comments" option.

       -c, --add-comments
              place all comment blocks preceding keyword lines in output file

For example, the comments in the following code blocks will
be extracted.

       /* TRANSLATORS: "will be extracted." */
       strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);

        strbuf_addf(&sb,
               /* TRANSLATORS: "will be extracted." */
               Q_("%lu year", "%lu years", years), years);

But if the comment is not right before the l10n markers, such
comments will not be extracted. E.g.

        /* TRANSLATORS: "WARNING: will NOT be extracted." */
        strbuf_addf(&sb,
                Q_("%lu year", "%lu years", years), years);

        /* TRANSLATORS: "WARNING: will NOT be extracted." */
        strbuf_addf(&sb, Q_(
                "%lu year", "%lu years", years), years);


I will scan all the codes and make a fix.

> This is a very useful note for translators (in fact, I think
> the zh_CN translation for date.c:149 might be a little off
> because this note was not included. My Mandarin is rusty,
> but I believe "<n> years, <m> months ago" should be expressed
> without a comma).
>
> According to po/README, the l10n coordinator is responsible
> for updating the git.pot file. Would it be possible to update it based
> on v1.9.2 and include the above comment?
>

I could generate a new git.pot for "maint" branch, but fixes for codes
may only contribute to "master" branch.


-- 
Jiang Xin
