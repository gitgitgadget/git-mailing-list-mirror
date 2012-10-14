From: Christopher Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v2 2/2] git-cvsimport: allow local timezone for commits
Date: Sun, 14 Oct 2012 15:58:48 -0500
Message-ID: <CAEUsAPYbywPJUje8LGsOMYn_oQ-RFxznjZ1KeAsZL=skiDtG3g@mail.gmail.com>
References: <cover.1350100320.git.chris@rorvick.com>
	<db5c9b72e08ed9d5522f38098d68126e5d3c7e5a.1350100320.git.chris@rorvick.com>
	<7vfw5hzj16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Oct 14 22:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNVH3-0006be-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 22:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab2JNU6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 16:58:50 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:43065 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab2JNU6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 16:58:50 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2974492lag.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:cc:content-type;
        bh=bBEWU6LN0UBi+Z60p01pOXWZQiNanYXeYZFkJrGP+uA=;
        b=OXFHnlyM2R4fZHEgZAJWjjHjCOJw6oCrE5KzZEZYOgZWKmdfsH8W1Vje6NV3doYjvh
         T51LlwLJTDJkGRpQOHf56yN2UVkPvp8rq10sujDUQ2+t20MRqewHhcVy1s6IfI23jyk6
         daPoIjRi7ePJ8R0qXPxFZ9V+xb2spjyOQpIK5OL7JOPizsiuC6NI8pAWomVOdY0A0puW
         SkBgWqr3KD5ngdtUysBj9WizR2Q3hEi3qRNG7uCymIoEV8S/D4CVAJpNOc405aGN0znv
         578S6jO4PC6Yj40Ceu9AA1OKFh85Dauy1ZdCzPIogqRQ4Ofd7Jtulpruq0cCuRTJ/Pin
         hHTQ==
Received: by 10.112.8.2 with SMTP id n2mr3489475lba.5.1350248328643; Sun, 14
 Oct 2012 13:58:48 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Sun, 14 Oct 2012 13:58:48 -0700 (PDT)
In-Reply-To: <7vfw5hzj16.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: lP5knqPTRqO9P1BSx2QAtMzuboE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207684>

On Sun, Oct 14, 2012 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> CVS patches are imported with the timezone offset of +0000 (UTC).
>> Allow timezone offsets to be calculated from the the local timezone by
>> adding -l to the command line or specifying cvsimport.l in the config.
>
> A single "I do not like everybody's timestamp is in GMT, so instead
> use the local timezone I the importer happen to be in" sounds more
> like an uninteresting hack with limited application than a useful
> new feature.  Even back in CVS days, many projects and repositories
> worth converting to Git were multi-people projects that span across
> timezones.
>
> I am wondering if it is sufficient to enhance existing cvs-authors
> file to tie a person to a timezone to add a feature like this in a
> more sensible manner.  I'd assume that in many multi-person project,
> one person, even when travelling, tend to record commits in a single
> timezone (i.e. his or her home timezone).  Even for a single-person
> project, adding a single entry ot the file is not too much to ask to
> the user.  Being able to view his human-readable name and timezone
> would be good value for the amount of trouble.

This sounds pretty straight forward.  It had crossed my mind that
using the cvs-authors file like this would be a more general solution,
but I thought that what I proposed was at least a step in the right
direction.  But since anyone that cares about this is almost certainly
putting together a cvs-authors file anyway, I agree that being able to
set an alternate default timezone probably isn't a very useful
addition.

I'll resubmit when I have something working.
