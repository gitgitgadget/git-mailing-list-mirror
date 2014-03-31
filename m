From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 01 Apr 2014 00:50:10 +0200
Message-ID: <5339F122.60801@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUl26-0002wy-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaCaWuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:50:15 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:57385 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaCaWuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:50:14 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so5509126wes.11
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cvo4rgwhNmpFBB1plBaPy0cLJze0WwMYQ5F6UR4IXlY=;
        b=E0rk3Xgmk91ljGPeU0hsp1mkfCvyCCRju8rj60Phru74UcT2GomZAND0gh9z7GwRF8
         mmCu8UcygkIO2QYHp1CGlO4hEQruwfg+yeY1xfpI1yoMLJrzwlnQZEkMf1LHm3gwd2Ol
         5iGWRutNFZgtjJMJ77UKcRgXC0uiIxXHMIU7oe/mv/bDmENMdYNAd/stkKqG0n2W6fbj
         lxamrgNlmRjUSF6c7W0vn2gJYAmk5JC0CGICoXgby5SfKFLUTFdlNzKRV7bs9oJWJ4ke
         jQ/byJHE6Wo17e/uZ9QsyQYeaK9OPOOFvXNToYbmMaYGypX+tHyT9nX/5OuNWcGGrHCX
         WyNA==
X-Received: by 10.180.101.40 with SMTP id fd8mr15421735wib.1.1396306212994;
        Mon, 31 Mar 2014 15:50:12 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id 45sm36188720eeh.9.2014.03.31.15.50.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 31 Mar 2014 15:50:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245565>

On 31. 3. 2014 23:47, Ronald Weiss wrote:
> On Mon, Mar 31, 2014 at 8:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> As Junio mentioned it would be great if you could teach the add
>> command also honor the --ignore-submodule command line option in
>> a companion patch. In the course of doing so you'll easily see if
>> I was right or not, then please just order them in the most logical
>> way.
> 
> Well, if You (or Junio) really don't want my patch without another one
> for git add, I may try to do it. However, git add does not even honor
> the submodules' ignore setting from .gitmodules (just tested with git
> 1.9.1: "git add -u" doesn't honor it, while "git commit -a" does). So
> teaching git add the --ignore-submodules switch in current state
> doesn't seem right to me. You might propose to add also support for
> the ignore setting, to make "add -u" and "commit -a" more consistent.
> That seems like a good idea, but the effort needed is getting bigger,

Well, now I actually looked at it, and it was pretty easy after all.
The changes below seem to enable support for both ignore setting in
.gitmodules, and also --ignore-submodules switch, for git add, on top
of my patch for commit.

So I'm going to do some more testing, write tests for git add with
ignoring submodules the various ways, and then post two patches
rearranged, one for git add, and second for git commit on top of that,
as you guys suggested. Including the change suggested by Jens, to not
mess with index_differs_from() in diff-lib.c, that works fine too.


diff --git a/builtin/add.c b/builtin/add.c
index 1086294..9f70327 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -350,6 +350,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */

+static char *ignore_submodule_arg;
+
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
        /* if we are told to ignore, we are not adding removals */
@@ -375,6 +377,9 @@ static struct option builtin_add_options[] = {
        OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
        OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
        OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+       { OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+         N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+         PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
        OPT_END(),
 };

@@ -422,6 +427,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
        int implicit_dot = 0;
        struct update_callback_data update_data;

+       gitmodules_config();
        git_config(add_config, NULL);

        argc = parse_options(argc, argv, prefix, builtin_add_options,
@@ -584,7 +590,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
                memset(&pathspec, 0, sizeof(pathspec));
        }
        update_data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
-       update_files_in_cache(prefix, &pathspec, &update_data, NULL);
+       update_files_in_cache(prefix, &pathspec, &update_data, ignore_submodule_arg);

        exit_status |= !!update_data.add_errors;
        if (add_new_files)
