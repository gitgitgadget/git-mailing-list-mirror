From: Danny Yates <mail4danny@gmail.com>
Subject: Re: Where should git-prompt.sh be installed?
Date: Thu, 25 Oct 2012 07:02:27 +0100
Message-ID: <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com> <20121025005106.GA9112@elie.Belkin>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	=?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGWi-0004No-4C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 08:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882Ab2JYGCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 02:02:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35532 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab2JYGCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 02:02:30 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so5606103wib.1
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 23:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=hNRpioVHrtuqEyB0p5EvsYzbYcxHDeMvC4Ud5t38HGI=;
        b=sp+TBddfbncDsiLUMcL8SPT3MLlIVo6igaCA8rodmLwrnmIi30caQ9mghA8Zophu/w
         lBSsqgAclxmgOnWDroE8yrcRnXe7iidsbq6vHE72eF0MqTG8ZtEQO16u+oq7CtiNeN0c
         I+ZKU1uAfLs+YdWRhEucNWTkP7fdo4ynX3rxpWS/y7BYTttBU4eDY5bc1f/WBuPbC+bv
         QNT82Omsa45oNNKYmrdiBs3rsE+gjigu36oRxTxQKglmwLSB5kHmMMyc/d6JEt+tzDZf
         AbW2ywTP/6C4C25Vu9Ou2wI6B5duH2upoVooO8SEhC+FC0xBjdmVEf0+mWNHqOWyBgRw
         PoOg==
Received: by 10.216.202.206 with SMTP id d56mr11950132weo.73.1351144948917;
        Wed, 24 Oct 2012 23:02:28 -0700 (PDT)
Received: from [188.29.9.42] (188.29.9.42.threembb.co.uk. [188.29.9.42])
        by mx.google.com with ESMTPS id fp6sm8274706wib.0.2012.10.24.23.02.26
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 23:02:28 -0700 (PDT)
In-Reply-To: <20121025005106.GA9112@elie.Belkin>
X-Mailer: iPad Mail (10A403)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208349>

Would that not give the impression of "git sh-prompt" being a core command? If so, that would be poor, IMHO. 

When I was investigating this last night, I expected to find it (git-prompt.sh) in contrib, although that doesn't make an enormous amount of sense. Ideally, the full path to wherever it's installed should be mentioned in the bash completion file (which is where I went to look when __git_ps1 stopped working), but that would mean modifying a file from upstream and I'm not sure if that's easy/"the done thing".

Danny. 


On 25 Oct 2012, at 01:51, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
> 
> In olden days the admin would copy contrib/completion/git-completion.sh
> to
> 
>        /etc/bash_completion.d/git
> 
> and mortals could source /etc/bash_completion or
> /etc/bash_completion.d/git in their ~/.bashrc (possibly shared among
> multiple machines) so that the bash completion and __git_ps1 helpers
> could work.
> 
> With Git 1.7.12 __git_ps1 has been split into a separate file, to help
> users who only want __git_ps1 to avoid the overhead of loading the
> entire completion script (and allow the completion script to be loaded
> by bash-completion magic on the fly!).  Now the sysadmin should copy
> contrib/completion/git-completion.sh to
> 
>    /usr/share/bash-completion/completions/git
> 
> and contrib/completion/git-prompt.sh to
> 
>    /usr/share/git-core/contrib/?? (somewhere?)
> 
> Mortals source /etc/bash_completion in their ~/.bashrc (possibly
> shared among multiple machines) and expect bash completion to work.
> For __git_ps1, users should source that ?? path.
> 
> Questions:
> 
> 1) what path is appropriate for ?? above?
> 2) is this documented anywhere?
> 
> Possible answers:
> 
> 1) Fedora uses /etc/profile.d/git-prompt.sh.  Gentoo uses
>    /usr/share/bash-completion/git-prompt.  Maybe others use
>    some other path.
> 
> 2) The scripts themselves suggest copying to ~/.git-completion.sh
>    and ~/.git-prompt.sh.
> 
> Proposal:
> 
>  1) /usr/lib/git-core/git-sh-prompt
>  2) git-sh-prompt(1)
> 
> Sensible?
> 
> Thanks,
> Jonathan
