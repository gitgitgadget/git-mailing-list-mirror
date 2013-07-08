From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Mon, 8 Jul 2013 11:51:42 +0100
Message-ID: <CAHCaCkL6p2ha-8yj4x0G5NodwSdupftCDO4Rst0WTLBRdK2PcA@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
	<CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
	<CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
	<CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
	<CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
	<CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 12:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw92q-0001Cg-1g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 12:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3GHKvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 06:51:44 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:59940 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3GHKvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 06:51:43 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so6153539oag.15
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bzo8l2V2D2wePsHQ70tLMznuh9QUt4TJO94XYy3ljN8=;
        b=tSBcWf5olKMDiegu6hIXL/TG1G3l6DcbCVQM36t01ZykzWvguiyIyjHE/tIUCpMVpY
         yum4C0vGATgx2PzgS0Ya2isM8yNQA4O3421JlTICcVumaBD+nFzYwpzTVI2drQsBXsm4
         zrQ63IOqW8obpKUOl+yM0ttr1WDFoJCYGLafG7iVnTnnHOs7+m9hSuGGKdvp905tBYXR
         KIepp0gC/EONoY/ZVqe289a8H56BGyjWmC7I55y6XJhqKaEv+CMaHOLTtZNe+2i1nzJt
         FyXcO7l+rZCtzh9gcc527geYqwYFz4a3U3mwwVJQMZm3CjFh/Iu1aPnREslxexpy58j5
         55tg==
X-Received: by 10.60.123.10 with SMTP id lw10mr19857607oeb.102.1373280702896;
 Mon, 08 Jul 2013 03:51:42 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Mon, 8 Jul 2013 03:51:42 -0700 (PDT)
In-Reply-To: <CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229836>

Unfortunately, git branch -a returns nothing :/
I tried with the simple detect-branches as well as with the config values.
Perhaps the spec-client? Although it is strange as it seems that the
repository is completely empty.

Thanks,

Matthieu

2013/7/8 Vitor Antunes <vitor.hda@gmail.com>:
> On Mon, Jul 8, 2013 at 11:09 AM, Matthieu Brucher
> <matthieu.brucher@gmail.com> wrote:
>> Hi again,
>>
>> I tried with @all, but it didn'y work as expected. It imported a bunch
>> of revisions (but no files?) and ended with:
>>   Reading pipe: ['git', 'config', '--bool', 'git-p4.importLabels']
>>   Not checking out any branch, use "git checkout -q -b master <branch>"
>>   executing git config --bool git-p4.useclientspec true
>>
>> And when I tried to checkout Branch/Main, it failed with
>>   fatal: Cannot update paths and switch to branch 'master' at the same time.
>>   Did you intend to checkout 'Branch/Main' which can not be resolved as commit?
>
> Hi Matthieu,
>
> Please run "git branch -a" in that repository and you should be able
> to see the various branches under /remotes/p4/
> Then you just need to choose a branch and run "git checkout -b
> git_branch_name p4/p4_branch_name".
>
> Cheers,
> Vitor



-- 
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
