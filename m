From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Tue, 18 Sep 2007 11:07:32 -0400
Message-ID: <1190128052.23692.6.camel@hinata.boston.redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
	 <1190074014548-git-send-email-krh@redhat.com>
	 <11900740142347-git-send-email-krh@redhat.com>
	 <11900740153845-git-send-email-krh@redhat.com>
	 <11900740154136-git-send-email-krh@redhat.com>
	 <1190074016669-git-send-email-krh@redhat.com>
	 <11900740163661-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709181453220.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXeg3-0004J8-Kp
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759237AbXIRPHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbXIRPHm
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:07:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759239AbXIRPHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:07:41 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8IF7ccb001221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 11:07:38 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IF7bvd027108;
	Tue, 18 Sep 2007 11:07:37 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IF7bf6026238;
	Tue, 18 Sep 2007 11:07:37 -0400
In-Reply-To: <Pine.LNX.4.64.0709181453220.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58618>

On Tue, 2007-09-18 at 14:58 +0100, Johannes Schindelin wrote:
> Hi,
> 
> very nice!
> 
> Four nits, though, and a half:
> 
> - it would be nicer to put the option parsing it option.[ch] (you would 
>   also need to pass the usage line then, instead of hardwiring it to 
>   "git_commit_usage"),

Yes, good point.

> - it seems more logical to me to call it "parse_option()" than 
>   "scan_options()", since that is what it does,

Yup.

> - you might want to rename OPTION_NONE to OPTION_BOOLEAN, and maybe even 
>   allow "--no-<option>" in that case for free,

Agree.

> - wt_status_prepare() could take a parameter "index_file", which would 
>   default to git_path("index") when passed as NULL, and

Yeah, the way I did it, I preserved the API, but that's not really a
concern, I guess.

> - launch_editor() is defined in builtin-tag.c, which is not part of the 
>   library, and therefore it would be technically more correct to either 
>   move the function to editor.c (my preferred solution), or declare it in 
>   builtin.h instead of strbuf.h.

Yeah, and we should move the stripspace code there too.  Or maybe we
should rename that strbuf_stripspace and put it in strbuf.c.

> As you can see, my nits are really minor, which means that I am pretty 
> happy with your work!

Great, I hope we can get it in soon :)

Kristian
