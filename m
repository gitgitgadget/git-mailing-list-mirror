From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Query on git commit amend
Date: Tue, 06 Dec 2011 21:16:18 +0530
Message-ID: <87fwgxwvn9.fsf@gmail.com>
References: <4EDDD0E4.6040003@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 16:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXxDv-0007f1-18
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 16:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab1LFPqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 10:46:21 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42923 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab1LFPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 10:46:21 -0500
Received: by eaak14 with SMTP id k14so5245034eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rnssCaAu3oZVmxClHHZzkP3zZzW6nHNS1Q19w6Ru33U=;
        b=D6t2r/lUmRJlt30NYadiAXU63Kz2RiTqnJY9Nq6yrff8uUgdYC/XsjnandmwBk4gOE
         Syjbu25WYF8RIvyOWEklB+RK7fAzbLLdAPyum7ncPr7YD+FHheSwBC6sCbemkBs0d6D5
         /ijZl5BoeOGMo9sJTKoSFMnDvzuDW6EoQoTFY=
Received: by 10.50.216.137 with SMTP id oq9mr15575992igc.40.1323186379524;
        Tue, 06 Dec 2011 07:46:19 -0800 (PST)
Received: from BALROG ([59.92.45.19])
        by mx.google.com with ESMTPS id e2sm90946680ibe.0.2011.12.06.07.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 07:46:18 -0800 (PST)
In-Reply-To: <4EDDD0E4.6040003@st.com> (Viresh Kumar's message of "Tue, 6 Dec
	2011 13:53:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186354>

Viresh Kumar <viresh.kumar@st.com> writes:

> Hello,
>
> Suppose i want to add few new changes to my last commit (HEAD).
> The way i do it is
> $ git add all_changed_files
> $ git commit --amend
>
> OR
> $ git commit --amend -a
>
> With both these ways, i get a screen to edit the message too.
>
> I want to know if there is a way to skip this screen.
>
> i.e.
> $ git commit --amend -a -some_other_option
>
> which simply adds new changes to existing commit, without asking to change
> message.
>
> If there is no such way, then can we add a patch for this, if it looks a valid
> case.

I've found 

$ GIT_EDITOR=cat git commit --amend

useful.

The benefit of this technique is that it even works for git-rebase -i.

In my typical git usage, I do a lot of git-commit --fixup's.  After
reaching a level of stability, I change the history with:

GIT_EDITOR=cat git rebase -i --autosquash

and my history is adjusted without requiring manual intervention.

-- 
Cheers
~vijay

Gnus should be more complicated.
