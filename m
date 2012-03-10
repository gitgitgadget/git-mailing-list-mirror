From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Sat, 10 Mar 2012 21:05:59 +0700
Message-ID: <CACsJy8AUo3+ECdxfnyfYGA-mAtHB8KBOUrie3_Qo3cyfshZmAA@mail.gmail.com>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
 <7v4ntx4bol.fsf@alter.siamese.dyndns.org> <4F5B55E8.4080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 15:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Mwq-0001ir-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 15:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab2CJOGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 09:06:33 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39181 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab2CJOGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Mar 2012 09:06:32 -0500
Received: by wibhq7 with SMTP id hq7so1660792wib.1
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 06:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=b+XRirnpbALO6UOMb287X5TxTvlKc1/RfEMerTTOW9M=;
        b=mv2QSWHMd7PfvQ4gtxKau0Duk230k5+4ehLnyPG96pwgQZH3C4VnAPCYg/pvuSEODE
         brvA9LuGorPS7QBsRh7RDuvcr2QKRNAbX3Pv+6V/M4pYQBCooHmWq+zsuD26co3VztUJ
         AzASppHewOO7dY0ukpiIIXLYazkoN1iFr/GxfoD/b0po6m0D25j7ED+oEu/EEk0U9fpw
         wqOwS2N+xsHlDaQ39XKchtaO7pYKEtFGwBMGllsAZ8QkLcrGkZcSNrw1Js0T6icmkaQZ
         0dTFU9WfOUBVIsiFACBxo/unO+PJZopljMHplObvXhlTXmPcFQkFjyUlSLAZ9JXfZCjC
         zHLQ==
Received: by 10.180.91.10 with SMTP id ca10mr12570175wib.17.1331388391240;
 Sat, 10 Mar 2012 06:06:31 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 10 Mar 2012 06:05:59 -0800 (PST)
In-Reply-To: <4F5B55E8.4080000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192783>

2012/3/10 Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>:
> However man git-config says :
>
> "If --git-dir or GIT_DIR is specified but none of --work-tree, GIT_WO=
RK_TREE
> and core.worktree is specified, the
> current working directory is regarded as the top level of your workin=
g
> tree."
>
> Some more context on my precise problem :
> I have a project, with source files managed with git.
> I also use some Makefiles that I would like to manage with git _in a
> separate repository_
>
> $ GIT_DIR=3D<project_path>/.git git add some_file.c ...
> $ GIT_DIR=3D<project_path>/.git_mk git add Makefile ...
>
> Setting worktree in each GIT_DIR/config will fix that but I can't fig=
ure out
> why current git implementation actually needs this.

Historical reason: before separate worktree feature was introduced,
git assumed worktree was at $GIT_DIR's parent directory. Old scripts
may rely on that behavior.
--=20
Duy
