From: Andreas Ericsson <ae@op5.se>
Subject: Re: git branch case insensitivity (Possible bug)
Date: Wed, 09 Jan 2013 16:52:59 +0100
Message-ID: <50ED925B.2060402@op5.se>
References: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gallego <gallego.alexx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsxy4-0007CR-MN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab3AIPxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 10:53:06 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53356 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab3AIPxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 10:53:04 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so878641eek.19
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 07:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=r3MIEZgufdMQrjmMnhp3vafNauaF5vLDy087afZRUVI=;
        b=bOWFtSeCaHbOPpMOf9ZyUx+NySM8RL2ELSR6nq3Hlag3cbc71itw+6+iLPonxQAcCL
         b6k+qoSS34CrDEYbO4vsSiGMZptRtVhE1PA2iUW9gtBAvZ4YiHaKK3pziOgrEgYwZDGE
         iD8lfk3ianIhfQ0Cgv/4H+cBS2Z33sPt2SbzxEUHKDhqfEm2zsAcs1DkaDRbzXjOePP1
         rpLoqwDX9VxodjhbupUSFSixVI8YvgA0ueB2ouFrM6USdpVgbV/ydgmN6ntqveVBLwyq
         IuMMY8UEODp4RIucwY9HyatmWW4VcgkUY9VADhOUi3Wf9lVZSUzilvhdln7cswRA+VER
         MBjA==
X-Received: by 10.14.221.5 with SMTP id q5mr182902810eep.33.1357746782449;
        Wed, 09 Jan 2013 07:53:02 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id q44sm142121113eep.5.2013.01.09.07.53.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 07:53:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com>
X-Gm-Message-State: ALoCoQngrEQGsbrqstu5YdIPFbB4donL3MG1gg1QRKtnA6Lt5z6Q3ttmJmkv8WHxHzGwJL31db6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213063>

On 01/09/2013 04:46 PM, Alexander Gallego wrote:
> Hello,
> 
> Here is a pastebin where I've reproduced the steps on a clean git repo.
> 
> http://pastebin.com/0vQZEat0
> 
> 
> 
> Brief description of the problem:
> 
> 
> 
> 1.Basically one creates a local branch call it 'imp_fix' (branch off
> master --> this doesn't matter)
> 2.One does work, commit, etc
> 3.One rebases imp_fix with master via: (inside imp_fix) git rebase master
> 4.One checks out master via: git checkout master
> 5.One merges an incorrect name "imp_Fix" (notice the capital F)
> 6.The expected output is that git would say, silly you --> that branch
> does not exist.
> 7. Instead it merges (what I think is incorrectly) imp_fix.
> 
> 
> Kindly let me know if I can provide more details.
> 

Are you using Mac OSX?
Are you using the HFS+ filesystem shipped with it?
Did you use the filesystem's default settings rather than reinstall your
system with sensible settings?

If you said "yes" to all of the above, this is a filesystem "feature",
courtesy of (cr)Apple, and you're screwed.

You can work around it by running "git pack-refs" every time you create
a branch or a tag though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
