Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51052C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiHPX6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHPX6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478C22B24
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so204213wme.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=k96gWVU4mZ2RgauOJq94ePrCAhI408cx6mij+BkdKX0=;
        b=iitkHMhW9UelUhnmo8o7SZ50GkC2qlaPV1S1f9Qxxr8RWogeV1tGI6X5G/8T1Sp+gw
         co3ERY2S39Qo1KFJGVcHeT5zDnbaAd3BD42k7zbNWF/SG1LBD/IArXVSgsi/08+HwyM8
         jMt3Bl8engEBEKs/y19R5WFKKIYvsl1o6PX5+a9rfZMOmKbyE8w2+5gv8KHWRqb4+Esb
         l/qI+6/5nXhi3D7A9l9oaYt0NPLGDNTDhJqMF+KkOnG6FgdJGmps7M5jrQDrFXRIJPXY
         ByGx+2/M8K8zJ+eRumP0s/cLCofUdEFLsZYp31M+R8KtOWC189DUsR4A6CnglAdNOBn2
         nw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=k96gWVU4mZ2RgauOJq94ePrCAhI408cx6mij+BkdKX0=;
        b=7Ld3GIyJAoSnDY+3FW3FzaY8VI7kFu3v72699vJmFeRLcsfNvpiPOnv9xcWrA4hq2Y
         sfv06XW1o76bzJ7/PY8QCjPRRYzfVPcZpsMVAZ6RueP1iGU0izOj0MoZtRSDRj51rmlo
         p2iBQU1hNZqs6yY2FjbNPU8OVJsP/o6Fqv9LvtHtuhQEuOFLNX553GDE6FILAKwLeFEi
         uzY/SYBDAlSFpVDAp385ogHDqs1kWSR2/wmAh5lDEPd5PAbqUYwgLlqx/ct3Eb7mm/Py
         4FomEaKXrrZmmc6P2nEpQTHySF3hQYcAd1uMdVOmP4wc4DoBMt5hwtYh5BRpi8DwV4VW
         he6A==
X-Gm-Message-State: ACgBeo3mcxhqh5JcHdAc7LvzzY1Ltvf9p3dmxeUwge/6qmMrfGJaa0GN
        +emYgWTHKS3wXz4txiSRafo1/DCJBho=
X-Google-Smtp-Source: AA6agR5xdvwsY2byTjRDr0N8IFCaVDVic+QM5e8hQYsb2rwCtKIAzQc6EoTGDCVftsK9kbwzRnMnCA==
X-Received: by 2002:a05:600c:1e04:b0:3a5:c83f:76bd with SMTP id ay4-20020a05600c1e0400b003a5c83f76bdmr434077wmb.191.1660694291189;
        Tue, 16 Aug 2022 16:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq27-20020a5d5a1b000000b002205f0890eesm11917850wrb.77.2022.08.16.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:10 -0700 (PDT)
Message-Id: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:04 +0000
Subject: [PATCH v2 0/5] scalar: enable built-in FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables the built-in FSMonitor [1] on 'scalar'-registered
repository enlistments. To avoid errors when unregistering an enlistment,
the FSMonitor daemon is explicitly stopped during 'scalar unregister'.

Maintainer's note: this series has a minor conflict with
'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
I can provide (in addition to [2]) that would make resolution easier.


Changes since V1
================

 * Added a patch to fix 'unregister_dir()'s handling of return values > 0
   from 'toggle_maintenance()' and 'add_or_remove_enlistment()'.
 * Added a patch to print error messages in 'register_dir()' and
   'unregister_dir()' indicating which of their internal steps fail.
 * Moved check of 'fsmonitor_ipc__is_supported()' to '[un]register_dir()' to
   avoid calling '(start|stop)_fsmonitor_daemon()' when the feature is not
   supported. Added assertion of 'fsmonitor_ipc__is_supported()' to
   '(start|stop)_fsmonitor_daemon()' to enforce that they are not called
   when the feature is unavailable.
 * Simplified '(start|stop)_fsmonitor_daemon()' implementation. Now, if
   FSMonitor is already running/stopped (respectively), the function simply
   returns 0; otherwise, it runs 'git fsmonitor--daemon (start|stop)' and
   returns the exit code.
   * Note that the "could not (start|stop) the FSMonitor daemon: <err_msg>"
     error messages are no longer printed by
     '(start|stop)_fsmonitor_daemon()'. Instead, "<err_msg>" is printed to
     stderr by swapping 'pipe_command()' out for 'run_git()', and
     '[un]register_dir()' prints the "could not (start|stop) the FSMonitor
     daemon" message.

Thanks

 * Victoria

[1]
https://lore.kernel.org/git/pull.1143.git.1644940773.gitgitgadget@gmail.com/

[2] The conflict is a result of both series updating the Scalar roadmap doc.
For reference, my merge resolution (from git diff <merge commit> <merge
commit>^1 <merge commit>^2, where <merge commit>^1 is
'vd/scalar-generalize-diagnose' and <merge commit>^2 is this series) looks
like:

------------->8------------->8------------->8------------->8------------->8-------------
diff --cc Documentation/technical/scalar.txt
index f6353375f0,047390e46e..0600150b3a
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@@ -84,20 -84,26 +84,23 @@@ series have been accepted
  
  - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
  
 +- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
 +  into `git diagnose` and `git bugreport --diagnose`.
 +
+ - 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
+   enlistments. At the end of this series, Scalar should be feature-complete
+   from the perspective of a user.
+ 
  Roughly speaking (and subject to change), the following series are needed to
  "finish" this initial version of Scalar:
  
- - Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
-   and implement `scalar help`. At the end of this series, Scalar should be
-   feature-complete from the perspective of a user.
 -- Generalize features not specific to Scalar: In the spirit of making Scalar
 -  configure only what is needed for large repo performance, move common
 -  utilities into other parts of Git. Some of this will be internal-only, but one
 -  major change will be generalizing `scalar diagnose` for use with any Git
 -  repository.
--
  - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-   `git`, including updates to build and install it with the rest of Git. This
-   change will incorporate Scalar into the Git CI and test framework, as well as
-   expand regression and performance testing to ensure the tool is stable.
+   `git`. This includes a variety of related updates, including:
+     - building & installing Scalar in the Git root-level 'make [install]'.
+     - builing & testing Scalar as part of CI.
+     - moving and expanding test coverage of Scalar (including perf tests).
+     - implementing 'scalar help'/'git help scalar' to display scalar
+       documentation.
  
  Finally, there are two additional patch series that exist in Microsoft's fork of
  Git, but there is no current plan to upstream them. There are some interesting
-------------8<-------------8<-------------8<-------------8<-------------8<---------


Johannes Schindelin (1):
  scalar unregister: stop FSMonitor daemon

Matthew John Cheetham (1):
  scalar: enable built-in FSMonitor on `register`

Victoria Dye (3):
  scalar-unregister: handle error codes greater than 0
  scalar-[un]register: clearly indicate source of error
  scalar: update technical doc roadmap with FSMonitor support

 Documentation/technical/scalar.txt | 17 +++++----
 contrib/scalar/scalar.c            | 55 ++++++++++++++++++++++++------
 contrib/scalar/t/t9099-scalar.sh   | 11 ++++++
 3 files changed, 66 insertions(+), 17 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1324%2Fvdye%2Fscalar%2Fadd-fsmonitor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1324/vdye/scalar/add-fsmonitor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1324

Range-diff vs v1:

 -:  ----------- > 1:  36fc3cb604d scalar-unregister: handle error codes greater than 0
 -:  ----------- > 2:  4bacf8bce8a scalar-[un]register: clearly indicate source of error
 1:  62682ccf696 ! 3:  5fdf8337972 scalar: enable built-in FSMonitor on `register`
     @@ Commit message
          For simplicity, we only support the built-in FSMonitor (and no external
          file system monitor such as e.g. Watchman).
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
     @@ contrib/scalar/scalar.c: static int add_or_remove_enlistment(int add)
       
      +static int start_fsmonitor_daemon(void)
      +{
     -+	int res = 0;
     -+	if (fsmonitor_ipc__is_supported() &&
     -+	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
     -+		struct strbuf err = STRBUF_INIT;
     -+		struct child_process cp = CHILD_PROCESS_INIT;
     ++	assert(fsmonitor_ipc__is_supported());
      +
     -+		/* Try to start the FSMonitor daemon */
     -+		cp.git_cmd = 1;
     -+		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
     -+		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
     -+			/* Successfully started FSMonitor */
     -+			strbuf_release(&err);
     -+			return 0;
     -+		}
     ++	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
     ++		return run_git("fsmonitor--daemon", "start", NULL);
      +
     -+		/* If FSMonitor really hasn't started, emit error */
     -+		if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
     -+			res = error(_("could not start the FSMonitor daemon: %s"),
     -+				    err.buf);
     -+
     -+		strbuf_release(&err);
     -+	}
     -+
     -+	return res;
     ++	return 0;
      +}
      +
       static int register_dir(void)
       {
     - 	int res = add_or_remove_enlistment(1);
     + 	if (add_or_remove_enlistment(1))
      @@ contrib/scalar/scalar.c: static int register_dir(void)
     - 	if (!res)
     - 		res = toggle_maintenance(1);
     + 	if (toggle_maintenance(1))
     + 		return error(_("could not turn on maintenance"));
       
     -+	if (!res)
     -+		res = start_fsmonitor_daemon();
     ++	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
     ++		return error(_("could not start the FSMonitor daemon"));
      +
     - 	return res;
     + 	return 0;
       }
       
      
 2:  78a7f0b1be0 ! 4:  fc4aa1fde31 scalar unregister: stop FSMonitor daemon
     @@ Commit message
          that the directory needs to be removed (the daemon would otherwise hold
          a handle to that directory, preventing it from being deleted).
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## contrib/scalar/scalar.c ##
      @@ contrib/scalar/scalar.c: static int start_fsmonitor_daemon(void)
     - 	return res;
     + 	return 0;
       }
       
      +static int stop_fsmonitor_daemon(void)
      +{
     -+	int res = 0;
     -+	if (fsmonitor_ipc__is_supported()) {
     -+		struct strbuf err = STRBUF_INIT;
     -+		struct child_process cp = CHILD_PROCESS_INIT;
     -+
     -+		/* Try to stop the FSMonitor daemon */
     -+		cp.git_cmd = 1;
     -+		strvec_pushl(&cp.args, "fsmonitor--daemon", "stop", NULL);
     -+		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
     -+			/* Successfully stopped FSMonitor */
     -+			strbuf_release(&err);
     -+			return 0;
     -+		}
     -+
     -+		/* If FSMonitor really hasn't stopped, emit error */
     -+		if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+			res = error(_("could not stop the FSMonitor daemon: %s"),
     -+				    err.buf);
     ++	assert(fsmonitor_ipc__is_supported());
      +
     -+		strbuf_release(&err);
     -+	}
     ++	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     ++		return run_git("fsmonitor--daemon", "stop", NULL);
      +
     -+	return res;
     ++	return 0;
      +}
      +
       static int register_dir(void)
       {
     - 	int res = add_or_remove_enlistment(1);
     + 	if (add_or_remove_enlistment(1))
      @@ contrib/scalar/scalar.c: static int unregister_dir(void)
     - 	if (add_or_remove_enlistment(0) < 0)
     - 		res = -1;
     + 	if (add_or_remove_enlistment(0))
     + 		res = error(_("could not remove enlistment"));
       
     -+	if (stop_fsmonitor_daemon() < 0)
     -+		res = -1;
     ++	if (fsmonitor_ipc__is_supported() && stop_fsmonitor_daemon() < 0)
     ++		res = error(_("could not stop the FSMonitor daemon"));
      +
       	return res;
       }
 3:  5457a8ff1fa = 5:  dd59caa2e5a scalar: update technical doc roadmap with FSMonitor support

-- 
gitgitgadget
