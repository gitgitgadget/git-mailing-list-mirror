From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 00/28] Support multiple checkouts
Date: Mon, 7 Jul 2014 17:25:16 +0700
Message-ID: <CACsJy8D=9vVkZ2PtZq=b6R6wEmr1pX-yxCCXVBrd-akfeqE1sQ@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com> <20140706204651.GB21237@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Jul 07 12:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X467O-0001uX-61
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 12:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaGGKZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 06:25:48 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:59470 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaGGKZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 06:25:47 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so3525873qgf.12
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W5Cc+e3UTMTH1tr9nJNnJMvMrQ0qMuJGhjPXDv0Wj48=;
        b=L34Rbf3t3L6wkR5dPqiAnYpeCRoU5UQUBVf1K2xHFgMvUMRvJV4U9fk+Id3GoauGEp
         +dyAsH2LCj0+5YyBu7KirrTu15xaR+ONGfKdz0mG1Y+M174C++MVG7UtbeVrHEo2tGdX
         VKsUM6BygPbhmhLciQ9JQNiZLi5M1NrHC75Az7xPsZzCM8sLbyLY25BrGeZrLtS585BK
         c73RwwTFzK9w/3XjtGkjl+dWV73S4XyOG9cOISqzSF4370xmDlZpCNIwvoUi7sTCGz8/
         cFMExW4XQovWQRR1szhCot1D1RQSXEkK0HuCqN7HTgcBkNoxks9V6mxA9hfWNk8qXe9R
         FZNQ==
X-Received: by 10.140.98.195 with SMTP id o61mr33728342qge.41.1404728746739;
 Mon, 07 Jul 2014 03:25:46 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 7 Jul 2014 03:25:16 -0700 (PDT)
In-Reply-To: <20140706204651.GB21237@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252964>

On Mon, Jul 7, 2014 at 3:46 AM, Max Kirillov <max@max630.net> wrote:
> Hi.
>
> What future does this have? Currently it is marked as
> "Stalled", but still mergeable with some trivial conflicts
> and seem to be working (except some bugs in interaction with
> submodules, see below). It would be very nice if this
> feature is officially supported.

It's to be re-rolled soon. I have a patch about sparse-checkout and
Dennis may contribute another one to enable "checkout --to" from a
bare repository. By the way Dennis has been testing this feature and
he reported (off-list) it worked fine, which is good news. I have done
nothing so far because my git time (or energy to be precise) is
limited these days, and I wanted to see if Dennis reported any new
bugs.

> I also have a comment about how it interacts with submodules.
> Would it be more appropriate to mark "modules" as a
> per-checkout directory? Because each of the working tree's
> submodule is obviously a separated directory in filesystem,
> and in most cases (at least in my practice) they are
> checked-out to different revisions.

Submodule interaction is something I have avoided so far because I'm
not a big user and admittedly does not follow its development closely.
I think we could get this in first, then let submodule people aware
about this feature and let them decide how to use it.

> So, currently (before proper linking of submodules checkouts
> implemented), if make submodules per-checkout (actually it
> appears to somehow work even with current code, maybe
> because some submodule code ignores the common_dir), one
> could run "git submodule update" if necessary, and get fully
> separated clones, which would work normally.
>
> It still may break if submodules are removed, added or
> renamed, but this seems to be inevitable until config is
> separated to per-checkout and common parts, which I suppose
> is a much bigger task.
-- 
Duy
