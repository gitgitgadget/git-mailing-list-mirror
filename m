From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 17:44:13 +1000
Message-ID: <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox>
 <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com> <87a8krpehl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christoph Paulik <cpaulik@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 09:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as3rp-0004jS-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 09:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcDRHoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 03:44:55 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35608 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbcDRHox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 03:44:53 -0400
Received: by mail-ig0-f171.google.com with SMTP id gy3so66017360igb.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IhTQmZjjE0GC4o5jsfn3RAqJStSc+hQO5ZjKTcrn7ck=;
        b=Kk2fQcNH6aQlsJMGjT0yzy0EaZOA0voYWiB8FjMwTfWareUPNJJEMQSkk3o2nXExLI
         Pz2NdP1EfbEZhZUOv3axt4qEV35q9NWnKof4DpR+UkzLHahIwDDs1xfgJvi6E/g+v2jw
         FaXRa6FevmasiPwwnzPjGX1cKH3AQQ/ftXu7GuUv9pJSXG6qQ3+1bfHTnTdawRNxD1HW
         VNpQi0mcMxhA3FBnZB3PznJqIPdjW5s7Q10mwJg9QxIHZf/jSpikYkQi0A6tKjLy90aW
         4LLJVvz2cQkQy6Na7qNWO20Fkdmtw9eLc7h5Zs0sSm0N8ioe/i93irmt+dJL86UtFTIw
         8h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IhTQmZjjE0GC4o5jsfn3RAqJStSc+hQO5ZjKTcrn7ck=;
        b=cncYOUqMpfPGAEO44CqyJfvOw17GHtl7qM8qz+8A8mghDfU/n67BBnEQc9HxId+G7W
         3wpx8MzGh9/iVKXedw0RlJY4PMYPtvuyhWgUe6fC3y5mqRsy5QNThRp4YM6iNLmQ3+rA
         +IqE9Uw/BEOwU3KKkMSNDrIRT6Bw7GMxSfbUQ6xjbv0lvp9JnmxO5k2AneSfD++8+sch
         rmvTgUo7jdn/pB3KbS1oDjI+1fXRvkvd8AVKkpRSuidT9c28GXzt420kEyXk7B39QvgF
         IqpxUVGyWvZ6mD9Cv5zsVMXOVpYic9dXdi9AIivZuYd6oOxW+/7L8iIVmOwGIeeEjQDl
         tKRw==
X-Gm-Message-State: AOPr4FVpKBLSEDKBQTrZDyj8YAnpmkQemDyi+GmYwt9k4W5MtolJhQ238dX3C63hGEPQxv0Sau8P0HwnaapmXA==
X-Received: by 10.50.103.232 with SMTP id fz8mr16555154igb.61.1460965492867;
 Mon, 18 Apr 2016 00:44:52 -0700 (PDT)
Received: by 10.36.45.69 with HTTP; Mon, 18 Apr 2016 00:44:13 -0700 (PDT)
In-Reply-To: <87a8krpehl.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291801>

On 18 April 2016 at 17:23, Christoph Paulik <cpaulik@gmail.com> wrote:
> My expectations from what should happen came mainly from the description of
> the --no-commit flag in the help:
>
> With --no-commit perform the merge but pretend the merge failed and do not
> autocommit, to give the user a chance to inspect and further tweak the merge
> result before committing.
> So in the case of a fast-forward the flag does not pretend that the merge
> failed.

Yes, I think the mis-alignment in expectations comes from a
technicality in the description you quote. The fast forward is in some
ways not really counted as a true merge, and no new commits are
created.

Thus, the merge progresses up to the point where a merge resolution
would have to take place, realises that there is no merge resolution
to do (it's just a fast forward!) and so exits out. Unfortunately, a
side effect of this is that the fast-forward has already happened and
so you are left with something different from what was expected.

I do think that the --no-commit option should imply --no-ff (as this
would make the behaviour consistent for end-users). I don't know if
this is something that would break scripts etc, but if so you could
make it implied only if we detect a terminal or something like is done
in other places.

Regards,

Andrew Ardill
