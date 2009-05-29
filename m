From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Sat, 30 May 2009 01:58:03 +0300
Message-ID: <94a0d4530905291558u564b4648ted79900b405f91b4@mail.gmail.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Sat May 30 00:58:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAB1j-0008HH-8R
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 00:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbZE2W6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZE2W6E
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 18:58:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:39522 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbZE2W6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 18:58:03 -0400
Received: by fg-out-1718.google.com with SMTP id d23so130823fga.17
        for <git@vger.kernel.org>; Fri, 29 May 2009 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ci98hosDAkdqhDBGD1TKWioh6FE2bSTvX/AxY3rBpns=;
        b=gmRNQlAZbreQCScN/MehNq1LxH6XSaVPlz00jJnNdNUGJjq/XpuPww2kTHkvnvRl9X
         ILM9Oit6rta1crVKSGa2DwQhcrH4wlGGFWN19AjTUTy9cr357b2L6YM08tOhfiVuzIMq
         dLd79juGxMNtOLTXVOnL7Y7pBBScdM4Oy4Euo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=irnpQhiApbWsJEBs3VzUcaXzupNp+JSJ38IbNUehj9P3s8kBXRSWADeYi57J6EJpoy
         TuMIm0e2F/wKF4nxfG5UZCZY0nI/xEBmzfGh2BPSTge1EJUnjJZuDeOrZNz5WcuAzWQd
         RpcR9SwgYRXJYhXftiGBV4QAxMyfHORB7Cvdw=
Received: by 10.86.86.10 with SMTP id j10mr3479595fgb.37.1243637883697; Fri, 
	29 May 2009 15:58:03 -0700 (PDT)
In-Reply-To: <20090529184125.GE11222@starfruit.corp.slide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120323>

On Fri, May 29, 2009 at 9:41 PM, R. Tyler Ballance <tyler@slide.com> wrote:
> As some of you may recall from my last swath of emails to the list
> regarding memory usage and repository size, we have quite a large
> repository. About a month ago, I added a submodule to the primary repo
> in an effort to start to segment where possible, particularly around
> third party modules.
>
> I've noticed that keeping submodules updated is an absolute pain,
> particularly with a large multiuser setup with *lots* of branches.
>
>
> What will tend to happen is that the submodule reference will be updated
> in the master branch (we use a centralized model) and then committed
> (imagine the commit reference was incremented from A-B).
>
> Other developers with other branches will then periodically merge master
> into their project/topic branches but will either neglect to run
> `git submodule update` or our bootstrap script (which also executes the
> submodule update command). At this point they'll have outstanding
> changes of their own, and the submodule will be marked as "modified" as
> well. Usually what will then happen is they'll `git commit -a` without
> thinking and the submodule's reference will be changed (typically from
> B->A, undoing the previous change).
>
>
> Are there any saner ways of managing this? I've been trying to get the
> `git submodule update` command to run with as many hooks as possible
> (pre-commit, post-update) to make sure that developers aren't
> inadvertantly breaking things, but nothing seems to ensure that
> *everybody* is up to date and that *everybody* doesn't inadvertantly
> commit changes to the submodule?

Have you tried repo?
http://source.android.com/download/using-repo

-- 
Felipe Contreras
