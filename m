From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] Use ALLOC_GROW() instead of inline code
Date: Mon, 3 Mar 2014 03:23:31 -0500
Message-ID: <CAPig+cQ-6h3JJr5uUu0J1_m+ENfFq2X4CusetPssQuJNB61zCA@mail.gmail.com>
References: <530FA3E7.8020200@yandex.ru>
	<53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:23:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKO9w-0005V5-Er
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbaCCIXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 03:23:32 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:53316 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaCCIXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 03:23:31 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so9740404ykr.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 00:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CUmzzVc95WpgtLPVE3gKdxSFpG7DHzqZ6N7pK4vnRY8=;
        b=dGM2odXyz1EhPMhjRkUXCXiLp9wvD2nuXx3TRJ4pc+892WKQWyWW/FMQ7/YQc36Gwk
         kEuboIQ1n1ZHjHvqte+D0xqB+3PtUkXGa7pWXMBPkNcns1CD4wQ31qoTpcwfKGrtrExb
         uPmO0tZP3Auxma4H3SHuR4Y4kj3pMc7zPed9sUxatlmaQhaLnxih+EGDQnPuMPw1gLmV
         oxtnxm+UIjs6BF6iTbW9soolWJmfDnl2cA3NEd9A/4SCE2VvMMSO2wKcOYGRB31snJoG
         DnAjsNgwK4fDQ8zfD6/QAD4pctY2XD1F3J8W6tXgMh3DU+6YeWj7DRn/yNcwlWQNn7IE
         dvgQ==
X-Received: by 10.236.122.99 with SMTP id s63mr20681406yhh.19.1393835011225;
 Mon, 03 Mar 2014 00:23:31 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 00:23:31 -0800 (PST)
In-Reply-To: <53142CB9.80100@yandex.ru>
X-Google-Sender-Auth: UosTsjl999bwXKoRjY0stTq657Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243197>

On Mon, Mar 3, 2014 at 2:18 AM, Dmitry S. Dolzhenko
<dmitrys.dolzhenko@yandex.ru> wrote:
> Dmitry S. Dolzhenko (11):
>   builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
>   bundle.c: use ALLOC_GROW() in add_to_ref_list()
>   cache-tree.c: use ALLOC_GROW() in find_subtree()
>   commit.c: use ALLOC_GROW() in register_commit_graft()
>   diff.c: use ALLOC_GROW()
>   diffcore-rename.c: use ALLOC_GROW()
>   patch-ids.c: use ALLOC_GROW() in add_commit()
>   replace_object.c: use ALLOC_GROW() in register_replace_object()
>   reflog-walk.c: use ALLOC_GROW()
>   dir.c: use ALLOC_GROW() in create_simplify()
>   attr.c: use ALLOC_GROW() in handle_attr_line()
>
>  attr.c                 |  7 +------
>  builtin/pack-objects.c |  9 +++------
>  bundle.c               |  6 +-----
>  cache-tree.c           |  6 +-----
>  commit.c               |  8 ++------
>  diff.c                 | 12 ++----------
>  diffcore-rename.c      | 12 ++----------
>  dir.c                  |  5 +----
>  patch-ids.c            |  5 +----
>  reflog-walk.c          | 12 ++----------
>  replace_object.c       |  8 ++------
>  11 files changed, 18 insertions(+), 72 deletions(-)
>
> --
> 1.8.5.3
>
> This version differs from previous only minor changes:
>   - update commit messages
>   - keep code lines within 80 columns

Place this commentary at the top of the cover letter since that's
where people look for it.

You want to ease the reviewer's job as much as possible, so it helps
to link to the previous submission, like this [1].

Likewise, you can help the reviewer by being more specific about how
you updated the commit messages (and perhaps by linking to the
relevant discussion points, like this [2][3]).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/242857
[2]: http://article.gmane.org/gmane.comp.version-control.git/243004
[3]: http://article.gmane.org/gmane.comp.version-control.git/243049
