From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Mon, 8 Jul 2013 11:09:03 +0100
Message-ID: <CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
	<CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
	<CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
	<CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 12:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw8Na-00045x-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 12:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab3GHKJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 06:09:05 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44155 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3GHKJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 06:09:04 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so5265610obb.8
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w0X3x1c5WYCvzUC9XLynE+XkRDJiiFbcoMiZTieG5aI=;
        b=D9JL/LiLTioaMKsODnYdCOGQ3Qc9tTfkyfgv5LGIT3i9HESPyYGTqVmocNrdeBzx4U
         8yX/HkteuQ8PhAeL5LM3D6JLsB8YS9ZQDLq9HRYM3HXtMO41os7++ZCwmNlY6kla8uqj
         fzk0lan5p5Ev+F15PSZF17TAe15CNobNGtTeqxx2nJC7/dq+BQgdNNaEd85KmwwYELZ6
         gS8reRcgzBEcdhyfUwk9IMAo+ZFhIcaL+pUa/TCgdm3TrKlrEwpL6+HQqxadWmJ4CZu7
         8MvwF6XjKNJ76TzmJxzTuYKBCyBS7IfxBDBwidNcVuXhWvyBCE94RT0s90PqXEqtGiKA
         W6CQ==
X-Received: by 10.60.131.171 with SMTP id on11mr19717175oeb.71.1373278143607;
 Mon, 08 Jul 2013 03:09:03 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Mon, 8 Jul 2013 03:09:03 -0700 (PDT)
In-Reply-To: <CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229833>

Hi again,

I tried with @all, but it didn'y work as expected. It imported a bunch
of revisions (but no files?) and ended with:
  Reading pipe: ['git', 'config', '--bool', 'git-p4.importLabels']
  Not checking out any branch, use "git checkout -q -b master <branch>"
  executing git config --bool git-p4.useclientspec true

And when I tried to checkout Branch/Main, it failed with
  fatal: Cannot update paths and switch to branch 'master' at the same time.
  Did you intend to checkout 'Branch/Main' which can not be resolved as commit?

Thanks,

Matthieu


2013/7/5 Matthieu Brucher <matthieu.brucher@gmail.com>:
>>> I can try. Indeed, at this revision, the two other branches do not yet
>>> exist. But @all will get everything? Last time, I only got head
>>> (IIRC).
>>
>> Our P4 server has a limitation on the number of lines returned by "p4
>> changes" command, so sometimes I have to use @change_start,@change_stop
>> instead of @all. You might want to use this range limitation to test
>> git-p4 by limiting to a small number of changelists that allows you to
>> check if at least one branch is correctly detected.
>
> I didn't know about this. I wanted to start the cloning at some point
> in the past, that's why I used the @123456789 notation.
>
>>>> Also, by using that command it means that the following depot paths must
>>>> exist:
>>>> //Depot/Project/Branch/Main
>>>> //Depot/Project/Releases/2013
>>>> //Depot/Project/Branch/Feature1
>>>
>>> Yes, they indeed do.
>>
>> In this case the problem should not be in branchList configuration.
>>
>>>> I've never used the --use-client-spec, so I'm not sure if that will not
>>>> break the branch detection code.
>>>
>>> I need to do that because if I don't, the depot is clobbed with
>>> binaries. Or perhaps if I put some .gitignore stuff, I might not do
>>> this?
>>
>> Keep using it, at least for now. If everything else fails we can look at
>> this again.
>
> OK, I'll send a mail on Monday (forgot it was the week end tomorrow...)
>
> Cheers,
>
> Matthieu
> --
> Information System Engineer, Ph.D.
> Blog: http://matt.eifelle.com
> LinkedIn: http://www.linkedin.com/in/matthieubrucher
> Music band: http://liliejay.com/



-- 
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
