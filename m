From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Is git mktag supposed to accept git cat-file input?
Date: Wed, 24 Oct 2012 17:18:11 -0700
Message-ID: <CA+sFfMdaaTwc82-J6a=wdjDzAFq6z8PS2rjSZ=tuyweOzuf4Kg@mail.gmail.com>
References: <CAM1C4GneOnyBQyJRbhtuYNDsc4NxXgFcfHrQpziLpp_AY0TjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Anand Kumria <akumria@acm.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 02:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRB9V-0004vT-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 02:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab2JYASN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 20:18:13 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36967 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164Ab2JYASM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 20:18:12 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1250099vcb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RVISMxUANPkDKesFRNh+kJjLdlit+g/j4FIYWPLaNOk=;
        b=yB8FnFQiQiy8/UzVgpSKy6NzlmjwA1gdBuFD5Zl2R7l7sbtfudDydx+L0aQfKDbadr
         njrgs7n3sMCzse5in1pbOvZm97UKy1STGkKPIHmy53HJcyPMty0vdkIdfu34rRQ7qpdY
         FghKiUMe24d/T/VxPHDKMQt4xB8ujJGK/+9hDumX8oYLIwzTEK3VIEqgfTyTNIrSFRWV
         RHcVsS/cIWf4PvJ8Ud6FFNWmxXDjZAH6mVXxZCZHuI0JoWDBZliAaVXvkjuRqap4hKqQ
         E7WqmR96r8Z/MFceYHYHQtHYEdpRRwYkcXugmJ9lA16c2P6YzTvr1fgc7TU8EmBkqzHW
         XN1A==
Received: by 10.58.221.228 with SMTP id qh4mr3161692vec.49.1351124291653; Wed,
 24 Oct 2012 17:18:11 -0700 (PDT)
Received: by 10.58.220.9 with HTTP; Wed, 24 Oct 2012 17:18:11 -0700 (PDT)
In-Reply-To: <CAM1C4GneOnyBQyJRbhtuYNDsc4NxXgFcfHrQpziLpp_AY0TjbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208328>

On Wed, Oct 24, 2012 at 4:39 PM, Anand Kumria <akumria@acm.org> wrote:
> Hi,
>
> I am doing some experimenting with git-mktag, and was looking into the
> format it expects on input.
>
> Should this sequence of commands work?

Yes, with a slight tweak...

> kalki:[/tmp/gittest]% git tag -m "tag-test" tag-test
> kalki:[/tmp/gittest]% git cat-file -p e619

'-p' means pretty-print, i.e. produce a human-readable format.  mktag
supports the raw format.  So you should invoke it like this:

      $ git cat-file tag e619

which should produce something like:

   object c0ae36fee730f7034b1f76c1490fe6f46f7ecad5
   type commit
   tag tag-test
   tagger Anand Kumria <akumria@acm.org> 1351121552 +0100

   tag-test

and is the format expected by mktag.

-Brandon
