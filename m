From: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
Subject: Re: [PATCH] Git.pm: Make _temp_cache use the repository
 directory
Date: Thu, 13 Nov 2008 07:27:27 +0800
Message-ID: <491B665F.3090103@svanfeldt.com>
References: <491AE80A.5060807@svanfeldt.com> <1f748ec60811121406j7ac72c7eqcfbe68132b2ebfc0@mail.gmail.com>
Reply-To: developer@svanfeldt.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,  Eric Wong <normalperson@yhbt.net>
To: piyo@users.sourceforge.net
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Nov 13 00:29:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0P98-00005A-G1
	for gcvm-msysgit@m.gmane.org; Thu, 13 Nov 2008 00:29:14 +0100
Received: by wa-out-1516.google.com with SMTP id k6so610939wah.53
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Nov 2008 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :x-spam-checker-version:x-spam-level:x-spam-status:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=A56g5p71pdjKXJHudQI5WoL9SeON4K5bhvoWLdmzOig=;
        b=bMmrKPfP2GeBVxCHbMvEZZUOU1tCiuVbUaO6kfFlIUB1s4gghcHpXLlQWvB6BK2fK/
         ihswIzu8HcmgotGlvAbteREQe59KYFAgUkczUD/KYs7GIba7levkgtQO1abEfglk0SyW
         JsAtYdEJiFNJcNxoadDcTzNMDVz8Rei5KfvHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-spam-checker-version:x-spam-level:x-spam-status:message-id:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=cXGrAkuCi7iW2oGAAGmkshE2OSE/eIKjEjjQHNE/y29Wpmf0DXcqt7J+evbMqR4sba
         EyllNCiYF0ZCj4gaWKemmANiEg5dpsp32FBrOo3z4RmHtI0kpwJmCgS3zgJ+q1F1mkO+
         /0j0QzCWrQbyr+VB4FUysfWAMZlQgwkhzHowI=
Received: by 10.114.154.12 with SMTP id b12mr811889wae.10.1226532478187;
        Wed, 12 Nov 2008 15:27:58 -0800 (PST)
Received: by 10.106.151.34 with SMTP id y34gr3156prd.0;
	Wed, 12 Nov 2008 15:27:58 -0800 (PST)
X-Sender: developer@svanfeldt.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.10.7 with SMTP id n7mr6677281ybi.14.1226532473361; Wed, 12 Nov 2008 15:27:53 -0800 (PST)
Received: from smtp.anarazel.de (mail.anarazel.de [217.115.131.40]) by mx.google.com with ESMTP id 7si16217773yxg.0.2008.11.12.15.27.52; Wed, 12 Nov 2008 15:27:53 -0800 (PST)
Received-SPF: neutral (google.com: 217.115.131.40 is neither permitted nor denied by best guess record for domain of developer@svanfeldt.com) client-ip=217.115.131.40;
Authentication-Results: mx.google.com; spf=neutral (google.com: 217.115.131.40 is neither permitted nor denied by best guess record for domain of developer@svanfeldt.com) smtp.mail=developer@svanfeldt.com
Received: by smtp.anarazel.de (Postfix, from userid 108) id ADFA9448005; Thu, 13 Nov 2008 00:27:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=ham version=3.2.5
Received: from [140.114.202.94] (x970003.HUNG.ab.nthu.edu.tw [140.114.202.94]) by smtp.anarazel.de (Postfix) with ESMTPSA id 67F78448004; Thu, 13 Nov 2008 00:27:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <1f748ec60811121406j7ac72c7eqcfbe68132b2ebfc0@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100833>


Hi,

Clifford Caoile wrote:
> Hi Marten Svanfeldt:
> 
> On Wed, Nov 12, 2008 at 11:28 PM, Marten Svanfeldt (dev)
> <developer@svanfeldt.com> wrote:
..
> I suppose if I wanted to used ${workingdir}/.git instead of
> ${workingdir}, I should replace the $tmpdir line above with $tmpdir =
> $self->repo_path() . "/.git" ?

No. repo_path() is the path to the repository, so the .git directory. If
you instead want within the working directory it is wc_path().

> 
> Best regards,
> Clifford Caoile

-Marten Svanfeldt
