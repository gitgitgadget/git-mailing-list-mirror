From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Corner case bug caused by shell dependent behavior
Date: Thu, 13 Mar 2014 17:37:01 -0700
Message-ID: <20140314003701.GF15625@google.com>
References: <20140314000213.GA3739@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Uwe Storbeck <uwe@ibr.ch>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:37:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOG7y-00024M-IY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 01:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaCNAhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 20:37:05 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44447 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaCNAhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 20:37:04 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so1845301pbb.31
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vpotlLDqgZIM03BOjFGzsGz5hk7diC//M3tp7G3HT30=;
        b=BEvcvJ+SIWD7kFcxxrfHmlou6KHOkEdd6wobevZqI0+dvwneu+LJO9JbYHUktZwKYC
         jx0vBpaiY85gOdnUf51IDw04prFUdeN7o7S2X3AqK4OkxhL+9UX06X4ngg6m6dDzm+tj
         jfpW1xzlNUan/SEMrGmSjjOqnTm5Sge3ozNnTEB2bU5HboBNP5almIBxpDOD3k/0E1qM
         BSDWlYyjh3eZQmSya+sMnitr6DEeomFy2hMOcil98fcmF9Yvaex+tSdxVjQK7cL7fNth
         r8uf4QUCsmFZq3gftUaYSU0XYPqNm8i+cUstFtOm6lIaJ1LuFjorwRaSvuHZF4XWyADm
         oN9Q==
X-Received: by 10.66.9.41 with SMTP id w9mr5711072paa.39.1394757424297;
        Thu, 13 Mar 2014 17:37:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk1sm16807115pac.21.2014.03.13.17.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 17:37:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140314000213.GA3739@ibr.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244064>

Hi,

Uwe Storbeck wrote:

> To reproduce the behavior (with dash as /bin/sh):
>
>   mkdir test && cd test && git init
>   echo 1 >foo && git add foo
>   git commit -m"this commit message ends with '\n'"
>   echo 2 >foo && git commit -a --fixup HEAD
>   git rebase -i --autosquash --root
>
> Now the editor opens with garbage in line 3 which has to be
> removed or the rebase fails.

Would it make sense to add this as a test to e.g.
t/t3404-rebase-interactive.sh?

> The attached one-line patch fixes the bug.

May we have your sign-off?  (See Documentation/SubmittingPatches
section "Sign your work" for what this means.

Looks obviously correct, so for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
