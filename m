From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Thu, 25 Mar 2010 16:16:55 +0100
Message-ID: <fcaeb9bf1003250816r16b06b1es6030b4fb8ae0a6de@mail.gmail.com>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 16:17:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuooL-0003bF-TR
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 16:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0CYPRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 11:17:24 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:59396 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0CYPRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 11:17:23 -0400
Received: by qyk26 with SMTP id 26so5602178qyk.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Uas//+ZziGby6b/4MdsRlL0CcwWZmYm7FbO54jU05Zo=;
        b=SZW6QxjjYtOA2R1J5xo1qHCrGeeYdX4O7AO1NPJl9obiSgO04hnfOujNYq099ku8TL
         cceDSTsiD0nJ9Rrh0s6V/BzGVPnvIlSO/EzSi1rElTPZ3YmXSP+tJ8rcbhvQyer8e0ra
         hw6u9ILB4wF9AV0W2JDIEEOa5/A41PkMfPGxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uze931huE1Lwh5lJ0UmeaQbfzXhWE+SPSPS7zoe9adtSI019MPl3UdJjaaeuItPqSB
         +q3Aa5sqt3+a/azwy6NgwGADovTXjYLGUt37D/LKKeTB4X/LNRHQxmPy6U8WaRCSXWuh
         7UapapzosRPAB7gj48hHlidWjhgD+FHldjB+k=
Received: by 10.229.26.135 with SMTP id e7mr950040qcc.58.1269530235314; Thu, 
	25 Mar 2010 08:17:15 -0700 (PDT)
In-Reply-To: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143183>

2010/3/25 Junio C Hamano <gitster@pobox.com>:
> * nd/setup (2010-03-21) 40 commits
>  - Guard unallowed access to repository when it's not set up
>  - alias: keep repository found while collecting aliases as long as p=
ossible
>  - Allow to undo setup_git_directory_gently() gracefully (and fix ali=
as code)
>  - builtins: check for startup_info->help, print and exit early
>  - builtins: utilize startup_info->help where possible
>  - run_builtin(): save "-h" detection result for later use
>  - config: do not read .git/config if there is no repository
>  - apply: do not check sha1 when repository has not been found
>  - Do not read .git/info/attributes if there is no repository
>  - Do not read .git/info/exclude if there is no repository
>  - git_config(): do not read .git/config if there is no repository
>  - init/clone: turn on startup->have_repository properly
>  - worktree setup: restore original state when things go wrong
>  - Use git_config_early() instead of git_config() during repo setup
>  - Add git_config_early()
>  - worktree setup: call set_git_dir explicitly
>  - rev-parse --git-dir: print relative gitdir correctly
>  - enter_repo(): initialize other variables as setup_git_directory_ge=
ntly() does
>  - Move enter_repo() to setup.c
>  - index-pack: use RUN_SETUP_GENTLY
>  - index-pack: trust the prefix returned by setup_git_directory_gentl=
y()
>  - worktree setup: calculate prefix even if no worktree is found
>  - merge-file: use RUN_SETUP_GENTLY
>  - var: use RUN_SETUP_GENTLY
>  - ls-remote: use RUN_SETUP_GENTLY
>  - help: use RUN_SETUP_GENTLY
>  - diff: use RUN_SETUP_GENTLY
>  - bundle: use RUN_SETUP_GENTLY
>  - apply: use RUN_SETUP_GENTLY
>  - verify-pack: use RUN_SETUP_GENTLY
>  - check-ref-format: use RUN_SETUP_GENTLY
>  - mailinfo: use RUN_SETUP_GENTLY
>  - archive: use RUN_SETUP_GENTLY
>  - builtin: USE_PAGER should not be used without RUN_SETUP*
>  - grep: use RUN_SETUP_GENTLY
>  - shortlog: use RUN_SETUP_GENTLY
>  - hash-object: use RUN_SETUP_GENTLY
>  - config: use RUN_SETUP_GENTLY
>  - builtin: Support RUN_SETUP_GENTLY to set up repository early if fo=
und
>  - builtin: introduce startup_info struct
>
> This seems to break t7006 when merged to 'pu'.

Unfortunately that test does not break on my machine (b745e293f).
t9100 breaks though. I=C2=B4m looking into it.

Can you send me =C2=A8./t7006-* -v=C2=A8 output? If you have free time
(unlikely), and the output says =C2=A8internal error: access to .git/co=
nfig
without repo setup=C2=A8 or =C2=A8internal error: setup_git_env can=C2=B4=
t be called
twice=C2=A8, can you run gdb and give me the stack trace when it die()?=
 I
could have missed some code path.
--=20
Duy
