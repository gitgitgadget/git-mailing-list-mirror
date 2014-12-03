From: Petr Bena <benapetr@gmail.com>
Subject: Re: git stash broken on MS Windows (automatically modify the files again)
Date: Wed, 3 Dec 2014 15:48:20 +0100
Message-ID: <CA+4EQ5fbDPFuzuz_OAX1Y=zCdL76j3ah0u0BVUW2pPqjaf4kBQ@mail.gmail.com>
References: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
	<CA+4EQ5cfC2N+e6g7wnxDZnnPj3BKTyuMj=TxX90fB7o+_EiOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 15:48:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwBE9-0002gD-5u
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 15:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbaLCOsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 09:48:21 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42666 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbaLCOsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 09:48:20 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so11542300obc.2
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=/RHKhHDAqp14tJl6CGN7K1WJH6yRT1QUhKJ3oF9OXVY=;
        b=04oSP4OSAVHDiWWSTqtT/lB+711fY2XVaYalAZwSUflmWTP2/LHg1KKN+pMlkwzCEB
         L0WuJea584YIoH83dPlhSiUrisfgceD75acnCwQT5aL0VECAxDpA+EiQjW37TiO7YKTD
         sIhepIsfXJK8TBM92/AO55SfPYzdNOdJi7mFog+aS4/j4YeJyoNZosnsUtgCMb5xclqA
         B4aN/7MIFSQ9LQa7gKuxHV3+hzRnQqe29FytfpO8xTaJplGY6MniFX1/qBB8wfppHgsn
         IHYagqVr+qHYcRYEuL7ceOVbJx5zIqSxGZN2OQcla9cDM1FLKDKh//H4pYaQE/nmDz3C
         6EkA==
X-Received: by 10.182.125.165 with SMTP id mr5mr3305251obb.71.1417618100146;
 Wed, 03 Dec 2014 06:48:20 -0800 (PST)
Received: by 10.202.3.3 with HTTP; Wed, 3 Dec 2014 06:48:20 -0800 (PST)
In-Reply-To: <CA+4EQ5cfC2N+e6g7wnxDZnnPj3BKTyuMj=TxX90fB7o+_EiOBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260652>

Only solution so far was to clone on linux, remove the folder which
contains these files and push them, then I had to delete the whole
repository on windows and clone it again.

If I checkout any revision which contains these files repository get
broken in a way that only solution is deleting it from disk and
cloning again. Is this a bug?

On Wed, Dec 3, 2014 at 3:46 PM, Petr Bena <benapetr@gmail.com> wrote:
> I actually can't even commit these changes:
>
> petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
> $ git stash
> Saved working directory and index state WIP on export: ee21f45 Updated inserts
> HEAD is now at ee21f45 Updated inserts
>
> petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
> $ git checkout master
> error: Your local changes to the following files would be overwritten by checkou
> t:
>         BSS/export_home_oracle/scripts_IDAEU001/RENEWAL_BED_NEW/script_sql/creat
> e_new_bed.sql
>         BSS/export_home_oracle/scripts_IDAEU001/appo/RENEWAL_BED/script_sql/crea
> te_new_bed.sql
>         BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql
>         BSS/export_home_oracle/scripts_IDAEU001/audit/audit_on.sql
>         BSS/export_home_oracle/scripts_IDAEU001/create_ts_transito.sql
>         BSS/export_home_oracle/scripts_IDAEU006/RENEWAL_BED/script_sql/create_ne
> w_bed.sql
>         BSS/export_home_oracle/scripts_IDAEU006/bed/script_sql/create_new_bed.sq
> l
> Please, commit your changes or stash them before you can switch branches.
> Aborting
>
> petr.bena@MW7H3TP5JJBR0I ~/Documents/repo (export)
> $ git commit -a
> fatal: Will not add file alias 'BSS/export_home_oracle/scripts_IDAEU001/Audit/au
> dit_off.sql' ('BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql' alre
> ady exists in index)
>
> On Wed, Dec 3, 2014 at 3:33 PM, Petr Bena <benapetr@gmail.com> wrote:
>> I have a mysterious problem with one of my git repositories that work
>> fine when I check it out on linux, but not when I do that on windows.
>>
>> On windows, pile of files immediately change themselves - eg when I do
>> git diff I see a lot of changes. What is even more interesting, is
>> that when I do git stash, nothing happens (it tell me it stashed back,
>> but changes are still there, so i can keep stashing and stashing but
>> it doesn't help), I still have lot of dirty changes to tracked files
>> and I can't get rid of them in any way. It's pretty much like if files
>> were containing something what can't be stored on NTFS and windows
>> version of git would replace the content with something else.
>>
>> Because it's private repository I unfortunately can't provide it's
>> content, but these files are mostly SQL text files, the screenshot (so
>> that colors are preserved), is here: http://snag.gy/93A8S.jpg
>>
>> Is there any way to "fix" windows git so that it works? Did anyone
>> experience this? It may be something related to windows line endings,
>> but I am not really sure.
>>
>> During installation of GIT I checked "keep line endings as they are in
>> repository"
>>
>> Thanks
