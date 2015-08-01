From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 0/2] notes: add notes.merge strategy option
Date: Sat, 1 Aug 2015 15:30:11 +0200
Message-ID: <CALKQrgeoUOLeiJi6EVF8-hz9D74iNA4pxzC8WYiX2_mN=CH8XA@mail.gmail.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 15:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLWru-0005rF-3d
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 15:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbbHANaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 09:30:22 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:56358 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbHANaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 09:30:22 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZLWrh-00004P-Nv
	for git@vger.kernel.org; Sat, 01 Aug 2015 15:30:17 +0200
Received: by ykek23 with SMTP id k23so6542657yke.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 06:30:11 -0700 (PDT)
X-Received: by 10.170.53.79 with SMTP id 76mr9695398ykv.68.1438435811854; Sat,
 01 Aug 2015 06:30:11 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Sat, 1 Aug 2015 06:30:11 -0700 (PDT)
In-Reply-To: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275120>

On Sat, Aug 1, 2015 at 1:12 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> This series adds a default merge strategy option for git-notes, so that
> the user does not have to type "-s" every time. It is overridden by the
> -s option.

I like this addition. A natural extension (i.e. future work, you
needn't worry about it for now) would be to allow this configuration
to be per notes ref. Different notes refs are used to hold different
kinds of data, and where cat_sort_uniq may be a good strategy for one
particular notes ref, it may be a poor default for other notes refs.
So we should consider adding notes.<notesref>.merge options to allow
more fine-grained control of which notes merge strategies apply to
which notes refs.

> I also added some tests to ensure that the "--abort" "--commit" and "-s"
> options must be independent.

Good. These could easily be split out into a separate commit, though,
as they are independent of the notes.merge addition.

> In addition, I found a small documentation
> bug which is corrected in the first patch of the series.
>
> I Cc'd a couple more people in this version of the patch in order to
> hopefully get some more review.

Thanks, appreciated (although AFAICS the cover letter was not CCed to me).

> This is based on pu incase there were
> any other conflicts, but I can easily rebase if necessary.

Junio has the final word here, but I believe the preferred workflow is
to base your patch series on master or next, as those do not jump
around quite as much as pu does.

>
> Jacob Keller (2):
>   notes: document cat_sort_uniq rewriteMode
>   notes: add notes.merge option to select default strategy

Both patches Acked-by: Johan Herland <johan@herland.net>


...Johan

>
>  Documentation/config.txt              | 11 +++++--
>  Documentation/git-notes.txt           | 33 +++++++++++++--------
>  builtin/notes.c                       | 55 +++++++++++++++++++++++++----------
>  notes-merge.h                         | 16 +++++-----
>  t/t3309-notes-merge-auto-resolve.sh   | 29 ++++++++++++++++++
>  t/t3310-notes-merge-manual-resolve.sh | 12 ++++++++
>  6 files changed, 119 insertions(+), 37 deletions(-)
>
> --
> 2.5.0.482.gfcd5645
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
