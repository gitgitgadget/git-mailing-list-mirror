From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 02 May 2011 10:11:59 -0700 (PDT)
Message-ID: <m31v0hvxi3.fsf@localhost.localdomain>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGwfM-0007wx-5g
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab1EBRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 13:12:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55648 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1EBRME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 13:12:04 -0400
Received: by fxm17 with SMTP id 17so3766331fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=upguqbA9J1MPhzcUXPVt+kNx4QwzUb7cRpaiAKlxJmA=;
        b=yEmRX8kk+iQY0PQtCNRUNfvOOpWmSKAmYvlLyK8vHy6XpcyGYC9HURI+KflzA2cILr
         Tc0vDUJAxDKp/E9oRuqCpRLLCc6Ye+j5aUnbk7wEm19BteiWDs0NljkNz86HwvIwp1a0
         d2UvcRRNQENL88yN+g29lUxZ1bWw81v6x9Vd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KYI8eiCkU4O0cdj1kK5VwTyJo14gDIkt7sy3ya23tEhJMvGUm48o5fZdwuSguGjiD9
         3EdiOfkZwM+U67ygptsRqBT70DIKJDY8d3TfmKY/7PK2lHuxV0ZNKt3ldE47Q0Iwyifk
         bEhk2vqjuCDO92G/klRqWqH4JhzyMTnUiw5qs=
Received: by 10.223.144.144 with SMTP id z16mr225868fau.24.1304356322711;
        Mon, 02 May 2011 10:12:02 -0700 (PDT)
Received: from localhost.localdomain (abwp119.neoplus.adsl.tpnet.pl [83.8.239.119])
        by mx.google.com with ESMTPS id c24sm1805403fak.7.2011.05.02.10.11.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 10:11:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p42HBLSM018406;
	Mon, 2 May 2011 19:11:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p42HB0Ma018402;
	Mon, 2 May 2011 19:11:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172602>

Junio C Hamano <gitster@pobox.com> writes:

> I am personally not thrilled by what this series attempts to do, but first
> a few questions:
> 
>  - Are there existing non-git "grep" implementations that do this?
> 
>  - If yes:
>    - what command option letter do they use to specify line number?
>    - do they not support a range notation (e.g. -@ 25-30,32-40)?
>    - what do they do when given more than one file?

I'm not sure if it is exactly the same as '-@' in Bert proposal, but
"ack", grep-like text finder in Perl (http://betterthangrep.com or
http://p3rl.org/ack), includes the following command line option:

  --line=NUM

    Only print line NUM of each file. Multiple lines can be given with
    multiple --line options or as a comma separated list
    (--line=3,5,7). --line=4-7 also works. The lines are always output in
    ascending order, no matter the order given on the command line.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
