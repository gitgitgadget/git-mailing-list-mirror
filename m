From: Bill Okara <billokara@gmail.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Fri, 26 Feb 2016 08:48:56 -0700
Message-ID: <CADsr5c-WztuTM5Tmu9_h_9_uSnGLwqSR1c5ZPa_DDi9yAJBNnw@mail.gmail.com>
References: <CADsr5c9j1ne5K4TKZGMvoFeaNWbQxDs253Y29bfb9BsA+7A0aA@mail.gmail.com>
	<1456487400-31174-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>, Kevin Daudt <me@ikke.info>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZKdb-00034n-3N
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 16:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbcBZPs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 10:48:58 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33710 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbcBZPs5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 10:48:57 -0500
Received: by mail-ob0-f180.google.com with SMTP id jq7so80766533obb.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=dRD3DYOohmL3NccpiEMHBPn/4Kmb4OMLmfYsb3ab1vU=;
        b=OCepnUEF5hwdYDidgrdG4sDHs8hWh3jMl9UYSbLQvLKC6TM6vZB7G0Npp4mgEBZC0X
         AyANENa0Wh+pG69iMeqiVEaCKMZ1F4CEI7tvSuGn0FbKRIrLI1/x1kokljh9S764jIgA
         8s0i7hjgiSmCYH8h5VufVpsZJMcIHuRa3fYcxgUspSeHzw7mASG1ZItefD8pvsTPDViA
         9IEuVqOoVBipAB/oqoKjQEOGUfzq5+UtDtHszev0B3oG1AdX0aGQOLGMVZvJzyjn1gJF
         o6IipiAvyk+HFruvApP1qih+LgveNu30WEE7Gfu9YSyOoft5FGew+dk0RyHCo9ZAcKRf
         eRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=dRD3DYOohmL3NccpiEMHBPn/4Kmb4OMLmfYsb3ab1vU=;
        b=Cp3O3JY5INaVZUVaZGWD8RJCn8kwLKBCX+uqiFSl5oqHsCcPjbqnAB1pWtsWp+VwyG
         Me75ztsvyaguwWDvPaRMifiyzAMT19lHTDoROd0jZ4dSOnvi3YV/xcpaX/hlUJjiOpAc
         q/sjDltzD+kEuwH1Y2XYvkftY2mPXeBo4vXvT+hBaFjcScpAIel9o074bEaP6tT8n2/L
         UxmMoRJQh9QGIHQzqN7dkDjo0M/QS5FdLOhN6jSs2w6VZ4mMlxNtS2gs7Aqh1SjPJq0k
         K3W/zLD2H38kGy+rmqi1jH/eIMI8u51Z1OlW+ppUOu4/yCY34+WI9u/6GzlpgnAo21zT
         75Og==
X-Gm-Message-State: AD7BkJKVQ6dBTvhhb0YMn0rNMTsLzNc2S9SDFddSN+pl8eWixKTSmE6gkufQtHgem9XLSVycf4pDJ7E30ifttQ==
X-Received: by 10.60.128.163 with SMTP id np3mr1760196oeb.16.1456501736151;
 Fri, 26 Feb 2016 07:48:56 -0800 (PST)
Received: by 10.182.17.103 with HTTP; Fri, 26 Feb 2016 07:48:56 -0800 (PST)
In-Reply-To: <1456487400-31174-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287580>

Hi,

On Fri, Feb 26, 2016 at 4:50 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
> Please don't top-post on this list.
>
Sorry about that. Just learned what that means and why it is bad...

> Subject: [PATCH] diffcore: fix iteration order of identical files dur=
ing rename detection
>
> If the two paths 'dir/A/file' and 'dir/B/file' have identical content
> and the parent directory is renamed, e.g. 'git mv dir other-dir', the=
n
> diffcore reports the following exact renames:
>
>     renamed:    dir/B/file -> other-dir/A/file
>     renamed:    dir/A/file -> other-dir/B/file
>
> While technically not wrong, this is confusing not only for the user,
> but also for git commands that make decisions based on rename
> information, e.g. 'git log --follow'.
>
> This behavior is a side effect of commit v2.0.0-rc4~8^2~14
> (diffcore-rename.c: simplify finding exact renames, 2013-11-14): the
> hashmap storing sources returns entries from the same bucket, i.e.
> sources matching the current destination, in LIFO order.  Thus the
> iteration first examines 'other-dir/A/file' and 'dir/B/file' and, upo=
n
> finding identical content and basename, reports an exact rename.
>
> Restore the original behavior by reversing the order of filling the
> hashmap with source entries.
>
> Reported-by: Bill Okara <billokara@gmail.com>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  diffcore-rename.c      |  6 ++++--
>  t/t4001-diff-rename.sh | 11 +++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)

> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 2f327b749588..ed90c6c6f984 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -77,6 +77,17 @@ test_expect_success 'favour same basenames even wi=
th minor differences' '
>         git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
>         git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"=
'
>
> +test_expect_success 'two files with same basename and same content' =
'
> +       git reset --hard &&
> +       mkdir -p dir/A dir/B &&
> +       cp path1 dir/A/file &&
> +       cp path1 dir/B/file &&
> +       git add dir &&
> +       git commit -m 2 &&
> +       git mv dir other-dir &&
> +       git status | test_i18ngrep "renamed: .*dir/A/file -> other-di=
r/A/file"
> +'
> +
>  test_expect_success 'setup for many rename source candidates' '
>         git reset --hard &&
>         for i in 0 1 2 3 4 5 6 7 8 9;
> --
> 2.7.2.410.g92cb358
>

Thank you very much for the fix and the detailed explanation!

-Bill
