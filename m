From: Petr Bena <benapetr@gmail.com>
Subject: Re: git stash broken on MS Windows (automatically modify the files again)
Date: Wed, 3 Dec 2014 15:46:56 +0100
Message-ID: <CA+4EQ5cfC2N+e6g7wnxDZnnPj3BKTyuMj=TxX90fB7o+_EiOBQ@mail.gmail.com>
References: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 15:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwBCn-0001sc-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 15:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbaLCOq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 09:46:58 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54569 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaLCOq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 09:46:57 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so1132787obc.10
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=5xuyko7pIGLYw5FD8Q96IcfEvVb8iQ3Jr9LPlMtlMfU=;
        b=OmP7rXh5bWtAgYLEbO1FXnrN9XfZQv2LvEeDByFs5S2MoeaNUS9WT7P3wbm1IfUK1W
         pi6mG8OVpQok2egGtXKvExCYn0iPSZ+ypyrCSa42FXPr/AshcHn39+7Vw3tI05txDcKd
         kGtpnusaUu8gjihbKEFhqWM6mDjpXripnQ3JgWpHOTQGgzQFmQOCDQawT55SDBS6WY5z
         BeVWCCPbam/3FJs6Tf5T+Dfr+CHieB2W3B/+tTPSus8VNsjch8cL52M4zMvPkKCXr9Xu
         kpP/uwQ2jmfCNv5zCKKjhJ4ghIeFUOM/RkARpKURM2Yiddcg538LX3ToH4WDdCfB12Jy
         HA2g==
X-Received: by 10.202.134.78 with SMTP id i75mr3045943oid.33.1417618016405;
 Wed, 03 Dec 2014 06:46:56 -0800 (PST)
Received: by 10.202.3.3 with HTTP; Wed, 3 Dec 2014 06:46:56 -0800 (PST)
In-Reply-To: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260651>

I actually can't even commit these changes:

petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
$ git stash
Saved working directory and index state WIP on export: ee21f45 Updated inserts
HEAD is now at ee21f45 Updated inserts

petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
$ git checkout master
error: Your local changes to the following files would be overwritten by checkou
t:
        BSS/export_home_oracle/scripts_IDAEU001/RENEWAL_BED_NEW/script_sql/creat
e_new_bed.sql
        BSS/export_home_oracle/scripts_IDAEU001/appo/RENEWAL_BED/script_sql/crea
te_new_bed.sql
        BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql
        BSS/export_home_oracle/scripts_IDAEU001/audit/audit_on.sql
        BSS/export_home_oracle/scripts_IDAEU001/create_ts_transito.sql
        BSS/export_home_oracle/scripts_IDAEU006/RENEWAL_BED/script_sql/create_ne
w_bed.sql
        BSS/export_home_oracle/scripts_IDAEU006/bed/script_sql/create_new_bed.sq
l
Please, commit your changes or stash them before you can switch branches.
Aborting

petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
$ git commit -a
fatal: Will not add file alias 'BSS/export_home_oracle/scripts_IDAEU001/Audit/au
dit_off.sql' ('BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql' alre
ady exists in index)

On Wed, Dec 3, 2014 at 3:33 PM, Petr Bena <benapetr@gmail.com> wrote:
> I have a mysterious problem with one of my git repositories that work
> fine when I check it out on linux, but not when I do that on windows.
>
> On windows, pile of files immediately change themselves - eg when I do
> git diff I see a lot of changes. What is even more interesting, is
> that when I do git stash, nothing happens (it tell me it stashed back,
> but changes are still there, so i can keep stashing and stashing but
> it doesn't help), I still have lot of dirty changes to tracked files
> and I can't get rid of them in any way. It's pretty much like if files
> were containing something what can't be stored on NTFS and windows
> version of git would replace the content with something else.
>
> Because it's private repository I unfortunately can't provide it's
> content, but these files are mostly SQL text files, the screenshot (so
> that colors are preserved), is here: http://snag.gy/93A8S.jpg
>
> Is there any way to "fix" windows git so that it works? Did anyone
> experience this? It may be something related to windows line endings,
> but I am not really sure.
>
> During installation of GIT I checked "keep line endings as they are in
> repository"
>
> Thanks
