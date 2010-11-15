From: "Dennis" <dennisfm@friendlymatch.com>
Subject: Re: Setting up Git Server over SSH
Date: Mon, 15 Nov 2010 14:14:46 -0500
Message-ID: <E698106BE2EB405A93D2C3304AF79529@denny>
References: <B99C7057496B47E48E5ABED7DE6BA51A@denny> <AANLkTimF2N-rYFYjOMm5kRRqRueLnmzJGpUoaCK3jsAC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:15:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4WD-0006Th-P7
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933523Ab0KOTPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:15:00 -0500
Received: from fmailhost05.isp.att.net ([204.127.217.105]:63532 "EHLO
	fmailhost05.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933505Ab0KOTPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:15:00 -0500
DKIM-Signature: v=1; q=dns/txt; d=ameritech.net; s=dkim01;
      i=dennismv@ameritech.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1289848499; h=Content-Transfer-Encoding:Content-Type:
     MIME-Version:Date:Subject:References:Cc:To:From:Message-ID; bh=
     HYptp9fnMKqHfrE3WlxA3SXCZTkmavA1ZQ9E+CQyDGw=; b=ES6HfPy+9s5qHHuhhdL
     CA2pFi50Vivujps8rht6SO8tqwQCJo4QvuPpsjHIJor6hGQaJGkQN5tdmnWxKcVIymg
     ==
Received: from denny (d118-75-134-244.clv.wideopenwest.com[75.118.244.134])
          by isp.att.net (frfwmhc05) with SMTP
          id <20101115191451H0500hclske>; Mon, 15 Nov 2010 19:14:51 +0000
X-Originating-IP: [75.118.244.134]
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161505>

Thanks, that worked

I used OpenSSH instead of Putty
and that fixed things up.

Dennis


----- Original Message ----- 
From: "Shawn Pearce" <spearce@spearce.org>
To: "Dennis" <dennisfm@friendlymatch.com>
Cc: <git@vger.kernel.org>
Sent: Monday, November 15, 2010 1:38 PM
Subject: Re: Setting up Git Server over SSH


> On Mon, Nov 15, 2010 at 10:20 AM, Dennis <dennisfm@friendlymatch.com> 
> wrote:
>> I am doing this, but it fails:
>>
>>> git clone ssh://hostname.com:/home/user/.git
>>
>> Cloning into user...
>> fatal: protocol error: bad line length character: logi
>
> This looks to me like your server is echoing back text upon login.
> That text is being confused for Git protocol data by the Git client,
> but its not as expected, so it aborts with an error message.
>
> Try getting the simple case to work first:
>
>  ssh hostname.com echo hello
>
> This should *only* print "hello".  If it prints anything else (and
> right now I suspect it prints "login ..."), that will confuse Git.
> You need to adjust your server's shell login scripts to stop echoing
> information during a non-interactive shell.  Or you may need to adjust
> your SSH client to ensure the authentication proceeds smoothly.  Those
> "Access denied" errors look like you aren't actually authenticating to
> the server.
>
> -- 
> Shawn. 
