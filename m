From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 09:50:48 -0700 (PDT)
Message-ID: <m3vdn12y6y.fsf@localhost.localdomain>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	<20090612084209.6117@nanako3.lavabit.com>
	<alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
	<85647ef50906120838s37c186a9mec301e880b1a8a4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 18:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF9z1-00032B-U3
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 18:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbZFLQut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbZFLQut
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 12:50:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZFLQus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 12:50:48 -0400
Received: by fg-out-1718.google.com with SMTP id d23so184930fga.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lRIpY6Z5C2G5Gqf8BsLBQr8wOTQzKRKtftevC1yXkIA=;
        b=q3xZPdeDaBQxl4VQS/B43Y8A8ZUa1nH6sR0Jn5jpDQ4ylg+M5WehIsIMFkGiy9mPUh
         UF/S72NjdCbSd9ZGHtZmjSD5X3yui9BB4rQ3B+9GNyIona3dHg1gMshsz4kNdBbQKJGM
         In+UmJhqZPzQz551LamFZxHH5Q8gkiM3Xn2RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=d6DloC7Vqbk1vXeg/JbuJRAJyhFGcyauZtgGelUPuPanP0Vtt8sdpdv5yIgCoEmJP0
         KsI6UQ0j2K3e3xGv/qwXbimebQ3fdYsZjDo+YMee+2uQRA2/b9AovUl09nSIygvA4pcE
         93h3rTNHEwvCyzrcRZKFwwDJK2j7aVlupfM/Q=
Received: by 10.86.49.16 with SMTP id w16mr3985401fgw.67.1244825450134;
        Fri, 12 Jun 2009 09:50:50 -0700 (PDT)
Received: from localhost.localdomain (abwj246.neoplus.adsl.tpnet.pl [83.8.233.246])
        by mx.google.com with ESMTPS id 12sm4347868fgg.5.2009.06.12.09.50.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 09:50:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5CGolt5028953;
	Fri, 12 Jun 2009 18:50:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5CGojeN028950;
	Fri, 12 Jun 2009 18:50:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <85647ef50906120838s37c186a9mec301e880b1a8a4e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121435>

Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:
> On Fri, Jun 12, 2009 at 11:56 AM, Daniel Stenberg<daniel@haxx.se> wrote:
>> On Fri, 12 Jun 2009, Nanako Shiraishi wrote:
>>
>>> It would be ideal if you can inspect the certificate and decide if you
>>> need to ask for decrypting password before using it (and otherwise you don't
>>> ask). If you can't do that, probably you can introduce a config var that
>>> says "this certificate is encrypted", and bypass your new code if that
>>> config var isn't set.
>>
>> Is this really a common setup? Using an unencrypted private key sounds like
>> a really bad security situation to me. The certificate is never encrupted,
>> the passphrase is for the key.
>>
> For SSH using unencrypted private key is very common for scripting and
> cron jobs. For HTTPS situation looks like being worse since there is
> no analog of ssh-agent that covers at least some of scripting
> scenarios. Do we want to disable scripting for HTTPS?

Actually you can use _encrypted_ private keys together with ssh-agent
and for example keychain helper for scripting.  You have to provide
password to all listed private keys only once at login.  I wonder if
something like this would be possible for HTTP certificates...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
