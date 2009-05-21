From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Fri, 22 May 2009 08:57:49 +1000
Message-ID: <fcaeb9bf0905211557i4b586ecay83d3f160e6b19f3a@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<m363fukb3j.fsf@localhost.localdomain> <fcaeb9bf0905210344h7ac8e10bx311bf9d714573eeb@mail.gmail.com> 
	<200905211429.13831.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 00:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7HDO-0003aV-BK
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 00:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZEUW6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 18:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbZEUW6J
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 18:58:09 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:21576 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZEUW6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 18:58:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so2959356and.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7a28iofQEKWphNaE8FcpLqHgX30sFHj3SZg4p3B+dno=;
        b=HFEhMA4rqVz+AbAsyUqNtzz64l+evn9gVxjwZMV1Ro7mW9jnbXmnhLY26tk30m8++z
         d7xvWWwn/SsFTGCRLLWhVKTDc2BEUmCGLMBQR2+gLkPVf0gmYAfLXsJ0UinXIpnMEw4Q
         p6kmuimfZl6f76df/uqhwmWnfQ1QBBORqwuU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Vp9eUEOjD8kfVn1YEF7tey+FHQx7GRs1Zbt2X3awc+8uOFDg13OrIB74xR/sWjkYqk
         IoYgG2Ow4U8VZkSl5C8ZsC7Kuj2n3u2JnlJ71aZcvaqycMNbKoQlNCOeHXi7bQyqg7Z4
         RJgjy9CaM+rTJda+gMwloVclxnn03O/2hkSn0=
Received: by 10.100.107.3 with SMTP id f3mr5926099anc.119.1242946689263; Thu, 
	21 May 2009 15:58:09 -0700 (PDT)
In-Reply-To: <200905211429.13831.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119708>

On Thu, May 21, 2009 at 10:29 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> [...]
>>>
>>> Couldn't you use parseopt also in subcommands?
>>
>> I don't understand. You mean parseopt for --continue, --skip and
>> --abort?
>
> Yes. I don't know if it possible, and if it would make sense, but it
> seems strange to me having both parseopts in main, and strcmp
> comparisons for other parts...

Ah you meant --interactive. It's because git-rebase--interactive.sh is
a separate command and it needs full arguments. parseopts eats
arguments. I'm too lazy to rebuild argv after being eaten by
parseopts. So just search for "interactive" sign, then pass them all
to git-rebase--interactive.sh (until git-rebase--interactive.sh is
built in)
-- 
Duy
