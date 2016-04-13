From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/3] clone: add t5614 to test cloning submodules with
 shallowness involved
Date: Tue, 12 Apr 2016 23:52:32 -0700
Message-ID: <CA+P7+xppaK9d77h74j-4K=oWftdkeJE7048+PMzLS6gBS3E_uQ@mail.gmail.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com> <1460504929-19208-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 08:52:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqEfa-0007sO-9O
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 08:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166AbcDMGwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 02:52:53 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34645 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759054AbcDMGww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 02:52:52 -0400
Received: by mail-io0-f169.google.com with SMTP id 2so58781475ioy.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oktH0OBm/1+D0TPG+QuCqzoP2UNAVTxQd/Y8UuA5TDU=;
        b=A3Vy16QCONLRYQI7GfgH+7qyPX2b0iyfS6rYn1xuZhNeReERtaF3MCJAPaz/YXuFUn
         6XJcRbDhqNNKDmOJTj5A+0mLpuDb3S5i2GcW3fM8tHDt8+4exjBBtj/Zlk2iEAC2axIZ
         dL/0uzenk6y8aCbJ0TfOmFwvRnQdXh6bhn9K0NzAOV3ac6ViUo8qmZYd+2zO98rT/+WV
         F4q2E6RwPpDDd36GspZQOeJpbkZ2mJ5z/pIu1z/QqvPebUwhBLLru7gjBHAtfMYeCjRi
         Mw06lA/Wg7MDCBS7yxod75WoSMt5Pp9zu/hnYsED5IDZeBxrjEMxtlCZkku/cNOe2Izo
         jjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oktH0OBm/1+D0TPG+QuCqzoP2UNAVTxQd/Y8UuA5TDU=;
        b=jo5M65Dxk78wzTI/8IYu+59AFLyt8Zf4scDoqNlZRMc4IHpzVvIiMPf0Ew3TxsOfjE
         PIvwgW7XJWs9Z6rilsnDOi+BNNkSJTHUzNvD6EWTkvLGDQUBMSz1bISyKSu2LyXKwVGU
         pUNskkk029YDtmEaYo7Zs+vUGMnkI45Pu3RV6M2x1P/qiGGH7s1oWkAyfe0TX3gMbm75
         +0/aHeTsskbl5t/fJPtnok4iNY6eyoIzLxWrsH/0YqicVGOg3v0jjsGVIep1K8sZA5Ln
         jPkyX+5sWZE75SK8/ZCMpc3xQj6pSwJbdh2QHdYUNM6i7Dwzz4soY/YCmQNZBHqLkKJ2
         8u/Q==
X-Gm-Message-State: AOPr4FWCCPLxmayQ2polULVPct3K0CnwDp7aIRy826YeR2Lkv7lz0YpwjP/cr1PUB1SDKsPYtba0zk6+jGxErQ==
X-Received: by 10.107.136.69 with SMTP id k66mr9433074iod.0.1460530371642;
 Tue, 12 Apr 2016 23:52:51 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Tue, 12 Apr 2016 23:52:32 -0700 (PDT)
In-Reply-To: <1460504929-19208-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291376>

On Tue, Apr 12, 2016 at 4:48 PM, Stefan Beller <sbeller@google.com> wrote:
> There are some inherent issues with shallow clones and submodules, such
> as having not having a commit available the superproject may point to
> in the submodule due to being shallow. Use the new file t5614 to document
> and test expectations in this area.
>

The description seems to imply that there will be
"test_expect_failure" tests to indicate what needs to be improved...
Maybe I am just mis-reading it?

Thanks,
Jake

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t5614-clone-submodules.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 t/t5614-clone-submodules.sh
>
> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> new file mode 100755
> index 0000000..a66c2db
> --- /dev/null
> +++ b/t/t5614-clone-submodules.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description='Test shallow cloning of repos with submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       git checkout -b master &&
> +       test_commit commit1 &&
> +       test_commit commit2 &&
> +       mkdir sub &&
> +       (
> +               cd sub &&
> +               git init &&
> +               test_commit subcommit1 &&
> +               test_commit subcommit2
> +       ) &&
> +       git submodule add ./sub &&
> +       git commit -m "add submodule"
> +'
> +
> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
> +       test_when_finished "rm -rf super_clone" &&
> +       git clone --recurse-submodules . super_clone &&
> +       (
> +               cd super_clone &&
> +               git log --oneline >lines &&
> +               test_line_count = 3 lines
> +       ) &&
> +       (
> +               cd super_clone/sub &&
> +               git log --oneline >lines &&
> +               test_line_count = 2 lines
> +       )
> +'
> +
> +test_expect_success 'shallow clone implies shallow submodule' '
> +       test_when_finished "rm -rf super_clone" &&
> +       git clone --recurse-submodules --no-local --depth 1 . super_clone &&
> +       (
> +               cd super_clone &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       ) &&
> +       (
> +               cd super_clone/sub &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       )
> +'
> +
> +test_expect_success 'shallow clone with non shallow submodule' '
> +       test_when_finished "rm -rf super_clone" &&
> +       git clone --recurse-submodules --no-local --depth 1 --no-shallow-submodules . super_clone &&
> +       (
> +               cd super_clone &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       ) &&
> +       (
> +               cd super_clone/sub &&
> +               git log --oneline >lines &&
> +               test_line_count = 2 lines
> +       )
> +'
> +
> +test_expect_success 'non shallow clone with shallow submodule' '
> +       test_when_finished "rm -rf super_clone" &&
> +       git clone --recurse-submodules --no-local --shallow-submodules . super_clone &&
> +       (
> +               cd super_clone &&
> +               git log --oneline >lines &&
> +               test_line_count = 3 lines
> +       ) &&
> +       (
> +               cd super_clone/sub &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       )
> +'
> +
> +test_done
> --
> 2.5.0.264.gc776916.dirty
>
