From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/7] repack_without_refs(): convert to string_list
Date: Tue, 25 Nov 2014 17:15:36 -0800
Message-ID: <CAGZ79kan-SetY=ZM=t69pE3JAL3PaZ9c5x0oDbq9QqU1JfPOug@mail.gmail.com>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRCp-0005zV-FB
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbaKZBPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 20:15:38 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:51668 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaKZBPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 20:15:37 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so7769531igb.0
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GV8v85WksaMo0CQJhRAl/SMJ89xcX4Ribg7pvMfiVgs=;
        b=Tnp8CrCEVf1jf4YUM2C91e8O/z74Kj+ED0jSNZzgNoCAFWqJtTqGQ40KgKx2KDl8jD
         Xsi5sbBWFP+M81MwLcWks98h/U/ciUUKqVy6AJlidKwkrOB0DoApwSXD5vCkC9VqMOft
         DV5pwPOSFgObCdSwv8/OazpuaaksFMNw8pp1PJmwerhiv4kx/bj5yJuvGQvh6sfJhZ2a
         wayO0dmhbO6oxJfh7nbu6wB3rLyscL2V3O9aFjjUzdjQS8ltFwwyIpYp/v67CDzoBzZ0
         KvtCtl+LTuAn7habbj93KIVe+S3xLsey9/ATKYtI0P9sPDsGwSYQJNlwGxGcrdml35dw
         jlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GV8v85WksaMo0CQJhRAl/SMJ89xcX4Ribg7pvMfiVgs=;
        b=jInAU6ys7YIF3gJ346beNqi99w8sT9zzKW9/tlctGin3l0pyYMXgsq7wSTzAP2bxVz
         Fv42u8vDWKOcETD/Bq6bQxez70JvpkzrokjrHKhw3eLXt2vSxQ/W3kEr3h7NCTRJNFeI
         N4C7TptOESnlQsy/3zuUDHq8+P1fMAIFPOT3FT0SpxHNh4KZTJMrba0SX9zKPgtG3qvE
         yHOSaWN4vM/RKUUzTMZHanmI5RztQrb37Gyb59ynZCXDvisLEubRKdJmIf+zZs4oJw+y
         nI6SEqSk3heUd2MTIblp7rj0aLPl6PGdPkR7gGWw+0plrHyCGGP5jU5J2gb3wrSQS9JT
         vbbQ==
X-Gm-Message-State: ALoCoQk7qootgM+VtYcWWZA+Q+hl2pv4R1ZEAFd/dMzO8iMhteuqt0YSeZXRpIhSgSviK3Hnje6Z
X-Received: by 10.50.82.102 with SMTP id h6mr20690632igy.25.1416964536825;
 Tue, 25 Nov 2014 17:15:36 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Tue, 25 Nov 2014 17:15:36 -0800 (PST)
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260259>

On Tue, Nov 25, 2014 at 12:02 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is a re-roll of v1 [1] with the following changes:
>
> * Fix some nits in the commit message and comment change in patch 4/7
>   that were pointed out by Jonathan.
>
> * Add a new patch 7/7 that renames sort_string_list() to
>   string_list_sort() as suggested by Junio.
>
> I would have submitted the name change as a separate patch, but since
> this patch series uses the function the two series would have
> conflicted. Since I didn't see any other patch series in-flight that
> use sort_string_list(), I just renamed the function everywhere rather
> than going to the trouble of deprecating the old function and adding
> the new function.
>
> Thanks to Junio, Jonathan, and Stefan for their reviews of v1.

This series is also
Reviewed-By: Stefan Beller <sbeller@google.com>

As this is in conflict with origin/sb/simplify-repack-without-refs
we'd need to decide, which we'd take. I'd gladly go with this series as it seems
cleaner and easier to read.

>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/259831/focus=260030
>
> Michael Haggerty (7):
>   prune_remote(): exit early if there are no stale references
>   prune_remote(): initialize both delete_refs lists in a single loop
>   prune_remote(): sort delete_refs_list references en masse
>   repack_without_refs(): make the refnames argument a string_list
>   prune_remote(): rename local variable
>   prune_remote(): iterate using for_each_string_list_item()
>   Rename sort_string_list() to string_list_sort()
>
>  Documentation/technical/api-string-list.txt |  4 +-
>  builtin/apply.c                             |  2 +-
>  builtin/receive-pack.c                      |  2 +-
>  builtin/remote.c                            | 69 +++++++++++++----------------
>  builtin/repack.c                            |  2 +-
>  connect.c                                   |  2 +-
>  notes.c                                     |  2 +-
>  refs.c                                      | 38 ++++++++--------
>  refs.h                                      | 10 ++++-
>  remote.c                                    |  6 +--
>  sha1_file.c                                 |  2 +-
>  string-list.c                               |  4 +-
>  string-list.h                               |  2 +-
>  13 files changed, 75 insertions(+), 70 deletions(-)
>
> --
> 2.1.3
>
