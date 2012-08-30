From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote SMB repo
Date: Thu, 30 Aug 2012 16:12:04 +0300
Message-ID: <CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
	<CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:12:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T74Xe-00012c-1z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 15:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab2H3NMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 09:12:06 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42314 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2H3NMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 09:12:05 -0400
Received: by qaas11 with SMTP id s11so127819qaa.19
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l5lisPgw1W2WL5gbGVpUY5jGjrez6KTqwrUgTFGr+TQ=;
        b=eGJ1B6oaRQ3rCYMqD6ikrxGI/fDtbiWMlSetpdd7fCrL5U5ogjbhjdL8WKGtf53oDA
         l1fEYKpS2C651l/p/H0Rvtn280v30WRNhXaYeohPJPfSxfrSvyXuzhOg164y40vaLJrW
         ihG/e9Kr/Mp1MpsLpCDCdbBbFn3shLi0EmsOMU8+QH7uK1UayR7kvbE06e5iDibGHyrm
         39kg8JPvRLNfkqsVNJ8Pba345owXJv1QwrwuXPnlxe6H9PGnmtDDZjvc4VSKpeg8dCER
         JMIFFVMkhkn57xdf4c35p+VE0X+LI4XdFr4BiMo36zf/qqIxjML7nN25+DvlZMSkDhKf
         hvMQ==
Received: by 10.224.213.198 with SMTP id gx6mr11171634qab.9.1346332324352;
 Thu, 30 Aug 2012 06:12:04 -0700 (PDT)
Received: by 10.49.131.8 with HTTP; Thu, 30 Aug 2012 06:12:04 -0700 (PDT)
In-Reply-To: <CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204536>

On Thu, Aug 30, 2012 at 3:51 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
> On Wed, Aug 29, 2012 at 1:43 PM, Orgad and Raizel Shaneh
> <orgads@gmail.com> wrote:
> > Hi,
> >
> > I have a repo accessed through //server/share/foo/repo (Using msysgit).
> >
> > .git/objects/info/alternates contains '../../../bare/objects'
> >
> > Running 'git status' (or almost any other action) gives the following
> > output:
> > error: object directory /server/share/foo/bare/objects does not exist;
> > check .git/objects/info/alternates.
> >
> > Note that it tries to access /server instead of //server.
>
> Could be path normalization. What does "git rev-parse --git-dir" say?
> Try to run it at top working directory and a subdirectory as well.
>
> If you set GIT_OBJECT_DIRECTORY environment variable to
> //server/share/foo/repo/.git/objects, does it work?
> --
> Duy

git rev-parse --git-dir in a subdirectory has //server

setting GIT_OBJECT_DIRECTORY prints "fatal: bad object HEAD" on git status.

- Orgad
