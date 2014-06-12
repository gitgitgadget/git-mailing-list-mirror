From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 11:46:37 -0700
Message-ID: <20140612184637.GA16641@hudson.localdomain>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
 <20140612084152.GA6095@hudson.localdomain>
 <20140612135051.GA35824@sirius.local>
 <20140612180459.GA15556@hudson.localdomain>
 <20140612180830.GB15556@hudson.localdomain>
 <20140612182341.GA42013@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvA1N-0001ou-1o
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbaFLSql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:46:41 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52100 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaFLSqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:46:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so1235913pdb.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eTClG+RPUYAntmamqtfvbvu5JNuKv1yN3tt2bhnFgJ0=;
        b=wb2EPo/Dz1mRJS+6H/QKhbQTDL7LlQqcL1vJ06enfBqY6ezGGNc9JBRocWOvv6zhda
         d38p9Rn5Ivz/uafDbl4W/1FZIHbGoptGoh76y6AiXGyAVz2bXWk2mtUh0bmqPwW0krUB
         zaoc7AK6no2bFIoWwH0a0zMv91IRsaYqirrSsELIei7gCMoTCn2AonZX3Bvu3GmbJu43
         +kOU0jZ7GzT8dDae5K4+NYSvvIKzHOjMEVoUQKRRxlsHHp6RhwoXMpgMALlU7AVVd1Ym
         KazI1utnUksrW33NUdHn/sRW4oMN4hj/4jfJPoSCs31LpfP33EBT4wWbRJGJGpZOngmw
         vdSw==
X-Received: by 10.66.153.80 with SMTP id ve16mr23213333pab.143.1402598800283;
        Thu, 12 Jun 2014 11:46:40 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xk3sm81670466pbb.65.2014.06.12.11.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 11:46:38 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140612182341.GA42013@sirius.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251476>

Caleb,

On Thu, Jun 12, 2014 at 01:23:41PM -0500, Caleb Thompson wrote:
> Jeremiah,
> 
> On Thu, Jun 12, 2014 at 11:04:59AM -0700, Jeremiah Mahler wrote:
> >
...
> >
> > How are you preparing your patches.  'git format-patch' with a 'git
> > send-email'?
> 
> I'm so glad you asked, because I've just been muddling through this.
> 
> I've been generating the cover page variously with request-pull or diff
> --stat, then running a command like this, with --cc arguments added from
> a list I've been keeping of people who respond to the threads:
> 
>     git send-email --compose --to=git@vger.kernel.org --thread \
>         [--cc ...] --no-chain-reply origin/master...
> 
> Then I manually edit the subjects to add the version to the [PATCH N/M]
> portions. I haven't been using format-patch.
> 
> It's interesting that only the first patch isn't applying. I'd love to
> hear a better way.
> 
> Caleb

It sounds like you are doing too much work.

After I make a series of commits I run format-patch.  This example has 2
patches (-2).  I like --thread, although it seems to work fine without
it.  And --reroll-count will automatically do your N/M numbering for
you.  It also generates a cover letter which you can then edit by hand.
All the patches will be named v3-* in this case.

  git format-patch --reroll-count=3 --cover --thread -2

Then I can send the whole patch series using send-email.

  git send-email --to=caleb --cc=git --cc=junio v3-*

Felipe Contreras has a good writeup [1] on how to setup aliases with Mutt so
you don't have to type the full email every time.

[1]: http://felipec.wordpress.com/2009/10/25/git-send-email-tricks/

I recently setup Mutt with Offlineimap [2] and Msmtp.  This is an
awesome setup too.  Not patch related, but it makes the email part
easier.

[2]: https://wiki.archlinux.org/index.php/OfflineIMAP

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
