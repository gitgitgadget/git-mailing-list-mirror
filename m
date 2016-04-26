From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Tue, 26 Apr 2016 14:53:31 -0700
Message-ID: <CAGZ79ka-HbB=oCidTtKSa32R9kqd2_c-cG8h+ttAVy=a8UfgFQ@mail.gmail.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:53:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avAvd-00061D-2u
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 23:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcDZVxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 17:53:34 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34969 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbcDZVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 17:53:32 -0400
Received: by mail-io0-f178.google.com with SMTP id d62so29613771iof.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7fzNA4P4VJrRBBu2NquA0L7tZN3SLDs1IjN8pG8h5nI=;
        b=J/8ARVBBuVpYu2/Vi0aXaIXdLLKuS5nOhw93WxeSUS1LFp0+Z0c4Z9lDM11aUMxsz8
         BqTlpXC2EW1DqI34KxaiNL2S+Q0fk2eZMzwumjZd5zF1mUC8znVvuNKXAXnXpyHg02VR
         tB6NPVF4/p7hqRQ9mEQFoNp8zr1Hu8pLXo5itQh/J49mI99hZ0A6MCApyNTeN8bw6NtH
         wyQQ31txlDUjCHfkjICYNord9BQb7aPNgMvN3T/W/rLXw7oA3ZiU//GOYiOx4I0JPW+b
         ciOCPGEg/t45jzGJHulkY+I8rsPdewvS9ajiSzWPFESch8jDF27glGsTHH4G00JCkKJh
         yqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7fzNA4P4VJrRBBu2NquA0L7tZN3SLDs1IjN8pG8h5nI=;
        b=IsAgLl723AGqWlQbbgmmbH94C/0qmK3u/6CTjUtnSKb4uVQ8Gm7/jnyEjqwG4d2/W3
         ZyBpnDyLF5Yp/xL4pe8Ksad2SJDhxtPEWlcFwKJZFgfyTmnB8buzt6agVoa45f64BQgR
         MLfRmFsN6uDn2b4mKiXLlBPnQPN0xtmuH6DQD+OZ3kdDoVKuG83wIJXwwXipV750iJG+
         a6kp20mfsyhzd5dwcdEJxd+jDzBQxw0LRxinBlND2CF711DPoelRE2K9JEcWbdvdy122
         IoJoNTzDrSzAV5/Z1mTzzjjgORDbgRFWoM54E8kLU+YvGE+9MmrcuzHLaXtsVCUXXYww
         t3Xw==
X-Gm-Message-State: AOPr4FXgtuYSXVgSwZXfl8MkqTyjBgwJ2U8UUMwQbmtFZ1l5UiGeNrwSEnuA90mWw5HEbxLM1SKZkQeMGOyGvbnK
X-Received: by 10.107.53.200 with SMTP id k69mr6181168ioo.174.1461707611882;
 Tue, 26 Apr 2016 14:53:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 14:53:31 -0700 (PDT)
In-Reply-To: <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292686>

On Tue, Apr 26, 2016 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +static void no_commit_impossible(const char *message)
> +{
> +       if (!option_commit) {
> +               warning("%s\n%s", _(message),
> +                       _("--no-commit is impossible"));
> +               warning(_("In future versions of Git, this will become an error."));
> +       }
> +}

During discussion of the parallel process framework
(sb/submodule-parallel-fetch~3),
you seemed very inclined on not having major decisions made deep
inside the helper
function, but rather at the main function to easier see the program flow IIRC.

This looks very similar to me as we'll have the no_commit_impossible function
which is a helper of cmd_merge. Following your advice there, I would
have expected to
have

    static void no_commit_impossible(const char *message)
    {
        warning("%s\n%s", _(message), _("--no-commit is impossible"));
        warning(_("In future versions of Git, this will become an error."));
    }

and later

    if (!option_commit)
        no_commit_impossible(_("Already up-to-date"));


> +
>  int cmd_merge(int argc, const char **argv, const char *prefix)
>  {
>         unsigned char result_tree[20];
> @@ -1403,6 +1412,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>                  * If head can reach all the merge then we are up to date.
>                  * but first the most common case of merging one remote.
>                  */
> +               no_commit_impossible(_("Already up-to-date"));
>                 finish_up_to_date("Already up-to-date.");

Coming back to this patch, in case of -v given, we'll
see ("Already up-to-date") twice?

If --quiet is given, do we want to suppress output
in no_commit_impossible?
