From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Reading commit objects
Date: Wed, 22 May 2013 13:02:06 -0700
Message-ID: <CAJo=hJuO23YGMJV69WvdKweW7EYCYVE-f93w5a=+N2_xh_e1+A@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
 <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com> <CABx5MBS9YgNmZD_tumMJ-MJVjHbRFCKbCjs9AZ347-OCwqO7qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 22:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfFF1-0001FS-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 22:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3EVUC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 16:02:27 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45170 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3EVUC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 16:02:26 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6252475iea.32
        for <git@vger.kernel.org>; Wed, 22 May 2013 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AnfG7PF1tipm4Y0/EX100977RS2srABjw6D97eCiy6A=;
        b=F0KJqZbwasZGa2tN6apgbkTmndneiSFnhzfnEG8fmnSNTgkfY8QtouNJVjHo+B03E0
         r+GtZhSdX6BTai+5vx6xhR38Nyq6+HgUmX2/SzeuCk5LE4zl5oz4P+bncaI82vjnaEM6
         vSVQjyhFdrGW1bxLtzL06nNEN+xHRjmqS36FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=AnfG7PF1tipm4Y0/EX100977RS2srABjw6D97eCiy6A=;
        b=dIxw/BCqFsZfq5YaE9WPt6syMjN4hiKIIGYwaN639G1upAeO6GKL5RQ1Reyyf7Zddt
         Z1UG00hbu657+sZ8mhQWJBLUN7NsAKGdsdTY19s7unH7UrWDrEVHpqx2rt6W+EyVGOms
         f7bGVynCpfIlK5lqnr1iqogb0n/d9vMkycn9vStNKztE6GV0n/10R6lbxMvTwWZocVMs
         fxoSOAgvrP5PIiIKrAN8+667tWXBo7ysSpNKjTKFWmqhoDIzwbuBElB78Ed8R1FCx7h8
         knEzouF+msZ928qwJ3pW+aEezh8yz467ulK6GviqGPqHrVjyzMmtJmlBDeWN134A6itm
         VU5A==
X-Received: by 10.42.144.2 with SMTP id z2mr8157183icu.50.1369252946341; Wed,
 22 May 2013 13:02:26 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Wed, 22 May 2013 13:02:06 -0700 (PDT)
In-Reply-To: <CABx5MBS9YgNmZD_tumMJ-MJVjHbRFCKbCjs9AZ347-OCwqO7qQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnj23lobS3kzcvxy8Dw6GRwy0D3i+6dbw7ifBoMJN2ewwJusEtQDGXvT7hYfAQgDWjKDG8P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225188>

On Wed, May 22, 2013 at 7:20 AM, Chico Sokol <chico.sokol@gmail.com> wrote:
> I'm not criticizing JGit, guys. It simply doesn't fit into our needs.
> We're not interested in mapping git commands in java and don't have
> the same RAM limitations.

I guess you aren't trying to process the WebKit or Linux kernel
repositories. Or you can afford more RAM than I can[1]. :-)

[1] $DAY_JOB has lots of RAM.  Lots.

> Are you guys contributors of JGit?

Not really. I had nothing to do with JGit.  :-)

> Can you guys point me out to the
> code that unpacks git objects? The closest I could get was that class:
> https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/UnpackedObject.java

This class handles the loose object format in $GIT_DIR/objects, but
does not handle objects contained in pack files. That is elsewhere,
and well, more complex. Look at PackFile.java.

> It seems to be a standard and a non standard format of the packed
> object, as I read the comments of this method:
> https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/UnpackedObject.java#L272

There are two formats, the official format that is used, and an
experimental format that was discarded but is still supported for
legacy reasons.

> I suspect that the default inflater class of java api expect the
> object to be in the standard format.
>
> What the following comment mean? What's the "Experimental pack-based"
> format? Is there any docs on the specs of that?

Read the code. This is the dead format that is no longer written, but
is still supported.
