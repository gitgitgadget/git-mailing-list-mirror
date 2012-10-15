From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Mon, 15 Oct 2012 19:47:09 +0200
Message-ID: <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:47:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNolR-0000Pn-Ud
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 19:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab2JORrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 13:47:31 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64645 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2JORra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 13:47:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5251452oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zNNm59LK3FmwmmlCqQ9usNhBh7PDMED1fKKQYZQpJuk=;
        b=LENaAwCzg2RbC9x2Ba1Y6AFSAx5B228Ikk/pgTz4LjT1cnVRFsqiJ8TfPlvkeDW+Wn
         CWTBHy0qE2kaFX/dQMG+5m7feN+6HrkOpQ443ytdw4+E+D5Y12LOjbj/5lkLRUojLSx4
         bv7eUWoH3wHszPEG8OfXGL4yw7Suf6v2g+qNhnz0l/0Ft0VCzhOry5hygqlvoG2zqF50
         GcHRakh9xXqrw70PU3L7qVF4m2eyGPMAONW68HQ4jshkkKRLCMWHN93p5b3nJlEklHs6
         vvM7p7Xjv3yM6CPdBBhcEu9Q/zTHHOim5iuRID1vqLzISfM/COpCEvNl2NleWT5C0voV
         Ua/A==
Received: by 10.182.113.5 with SMTP id iu5mr10258228obb.36.1350323250050; Mon,
 15 Oct 2012 10:47:30 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Mon, 15 Oct 2012 10:47:09 -0700 (PDT)
In-Reply-To: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207766>

On Mon, Oct 15, 2012 at 6:42 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Very clear analysis. Well written. Perhaps is it the time to update
> http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?
>
> Hope useful
>
> http://www.schneier.com/crypto-gram-1210.html

This would be concerning if the Git security model would break down if
someone found a SHA1 collision, but it really wouldn't.

It's one thing to find *a* collision, it's quite another to:

 1. Find a collision for the sha1 of harmless.c which I know you use,
    and replace it with evil.c.

 2. Somehow make evil.c compile so that it actually does something
    useful and nefarious, and doesn't just make the C compiler puke.

    If finding one arbitrary collision costs $43K in 2021 dollars
    getting past this point is going to take quite a large multiple of
    $43K.

 3. Somehow inject the new evil object into your repository, or
    convince you to re-clone it / clone it from somewhere you usually
    wouldn't.

At some point in the early days of Git Linus went on a rant to this
effect either on this list or on the LKML.

Maybe it would be useful to include some of that instead?

It would be very interesting to see an analysis that deals with some
actual Git-related security scenarios, instead of something that just
assumes that if someone finds *any* SHA1 collision the sky is going to
fall.
