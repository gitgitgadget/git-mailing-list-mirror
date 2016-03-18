From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 18 Mar 2016 20:47:42 +0530
Message-ID: <CA+DCAeTnvEZjcGaS=Ed95bGYHRqV-svtTY-hX8gEbXstbkYe5A@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
	<CAPig+cQg2gYbr26X6PPQ6bobkxbufSSNtA1T94kdyEKQwHZXBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:17:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agw9r-0003VY-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 16:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbcCRPRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 11:17:45 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36722 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbcCRPRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 11:17:43 -0400
Received: by mail-qg0-f66.google.com with SMTP id 14so7575408qgg.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fAG6UxEcdMB3YhWshxJCgS299dUfNV2EEwalQKFdh38=;
        b=M3grwIrKrxEwRv/UJIfLo0NzG70iTjmMhxLuAwSy364nnxVRtG9JbhRLZr4NZci0KI
         WET7Cq2bB+SrdGbUZwx9gnIDLpxMeQwvHniVG4gqWDUVEd2Ag3ziL2eeFMTMOxMf3/AX
         GIu3pB9zvNaf5FMnDX9k1bkhGnFp33WnC8ZuTK13iAEJyEBlIQ3wl1IzzbcUfTXN0Llx
         yEJxOXs7RPLBklgKEJCqj138T/a/MAydtlv6P3MEUgRvg/Ewta9OozWg3FY/fWuTAqvh
         5m3eUxp64dv0FnOZcwNF+g3RzRniqYOxc4PRcDg2n+w00nGyPKkj58LdjeYU9UPwSyHr
         vaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fAG6UxEcdMB3YhWshxJCgS299dUfNV2EEwalQKFdh38=;
        b=ejKnEdpl2UvgGDEgkqdOtrDJKV9pqcjZG8StTIMjqokQ9B3m2/m8ojinKlBxH6kFiH
         jbVpel1IGEu1zpwzO5spg1UOekusl5jdowXlZCD6K1D5J7CYfyKi3gR7qbDuJqudO+21
         /YUMQYKZR9OFIGN1sfB7In3E+gG0YmoHDHPY4YfMOK0/ZNFaRaniQVuiAUZP4D6W0pPn
         D6z2b3LhjV60qCZYszXNMvkXrVXyCyKksReUyoCfH55l7SgrcwXHQg1qqstN5RWcI5bl
         g/hwUzgKdJfBkgXkG7Zlxq7kPEqbCJfkzruSPhPzpSu/xhG8E6CtdIQDtMWDm7F3s5lp
         /CXQ==
X-Gm-Message-State: AD7BkJLpuYR9tBqz9zc554jod5qtVlOAh5uLdUwwBlYzkPKvBtBEJ6/aKjDYGRTuyb0XIgvCZml/5eP3gkfHsw==
X-Received: by 10.140.41.164 with SMTP id z33mr23041543qgz.78.1458314262234;
 Fri, 18 Mar 2016 08:17:42 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 18 Mar 2016 08:17:42 -0700 (PDT)
In-Reply-To: <CAPig+cQg2gYbr26X6PPQ6bobkxbufSSNtA1T94kdyEKQwHZXBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289223>

On Fri, Mar 18, 2016 at 10:09 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 18, 2016 at 12:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Mar 17, 2016 at 12:49 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>>> @@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
>>>         argv_array_pushv(&args, opt_strategy_opts.argv);
>>>         if (opt_gpg_sign)
>>>                 argv_array_push(&args, opt_gpg_sign);
>>> +       argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");
>>
>> At this point, we know that opt_autostash can't be -1 (thus
>> incorrectly triggering use of --autostash) because the conditional in
>> cmd_pull() set it to the value of config_autostash (either 0 or 1) if
>> the user did not specify it on the command-line. Okay. Makes sense.
>
> Actually, this is going to pass --autostash or --no-autostash to
> git-rebase unconditionally won't it? This seems kind of undesirable
> due to the unnecessarily tight coupling it creates between the two
> commands. I wasn't paying close attention to the earlier discussion,
> but wasn't the idea that you should pass one of these two options
> along to git-rebase only if the user explicitly asked to do by saying
> so on the command line?

This is interesting. I checked out git-rebase.sh and found that it reads
rebase.autoStash if nothing is specified by user. So if user is not
specifying anything about stashing then it is the job of git-rebase
to decide whether or not to do stashing by reading rebase.autoStash.

Similarly if user doesn't specify the --[no-]autostash option to git-pull
then neither of --autostash and --no-autstash should be passed to the
git-rebase as it will decide on his own about what needs to be done.
Agreed. I made a unnecessary tight coupling between git-pull and
git-rebase. Instead of that the following changes can be done to
remove it.

...
        if (opt_gpg_sign)
                argv_array_push(&args, opt_gpg_sign);
-       argv_array_push(&args, opt_autostash ? "--autostash" :
"--no-autostash");
+       if (opt_autostash == 0)
+               argv_array_push(&args, "--no-autostash");
+       else if (opt_autostash == 1)
+               argv_array_push(&args, "--autostash");

...

...
        if (opt_rebase) {
+               int autostash = config_autostash;
                if (is_null_sha1(orig_head) && !is_cache_unborn())
                        die(_("... with changes added to the index."));

-               if (opt_autostash == -1)
-                       opt_autostash = config_autostash;
+               if (opt_autostash != -1)
+                       autostash = opt_autostash;

-               if (!opt_autostash)
+               if (!autostash)
                        die_on_unclean_work_tree(prefix);

                if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
                        hashclr(rebase_fork_point);
        }
...

Note that the above changes are suggest with respect to my patch, not
the current
code base.

This way there's no need to remove "autostash" from the current code
base and instead use it to write a much cleaner patch.  Something like
this (this is w.r.t. current code base)

...
        if (opt_gpg_sign)
                argv_array_push(&args, opt_gpg_sign);
+        if (opt_autostash == 0)
+               argv_array_push(&args, "--no-autostash");
+       else if (opt_autostash == 1)
+               argv_array_push(&args, "--autostash");

...

...

if (opt_rebase) {
                 int autostash = config_autostash;
+               if (opt_autostash != -1)
+                       autostash = opt_autostash;

                if (is_null_sha1(orig_head) && !is_cache_unborn())
                        die(_("... with changes added to the index."));

                if (!autostash)
                        die_on_unclean_work_tree(prefix);

                if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
                        hashclr(rebase_fork_point);
        }
...


What are your views on this? Also this way I will not touch changes
introduced in patch 1/2.

> In other words:
>
> * invoke "git-rebase --autostash" only if the user typed "git pull
> --rebase --autostash"
>
> * invoke "git-rebase --no-autostash" only if the user typed "git pull
> --rebase --no-autostash"
>
> * invoke "git rebase" if the user typed bare "git pull --rebase"


Thanks,
Mehul
