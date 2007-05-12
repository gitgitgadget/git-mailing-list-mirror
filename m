From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sat, 12 May 2007 03:06:03 +0200
Message-ID: <200705120306.03806.jnareb@gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <200705120106.53624.jnareb@gmail.com> <7vlkfu98nn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 03:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfzQ-0006f9-R2
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXELBBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762672AbXELBBa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:01:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:64347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762551AbXELBB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:01:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so923083uga
        for <git@vger.kernel.org>; Fri, 11 May 2007 18:01:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IsuKaob4IX6wKy3kRgxMdLtbQ0pOX5f+gfxdpJPYVuXMCxiZDxQtFpcWWXS112RdMRGppVdV9p/NvNjoTn245vvqCA8xW8Q3wo1gN58H2EI3RuCeAcqwNiBDnvi6lS8C9RwKxdwXtqSIehGEK/qtkBGez12uYMyRV0oTwT+kaIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZpDvuMlG+U4xKqZ+kLJ1Z7ce3oQzHy9y8bPGx2CovWckKlX9+cS/HeTzPBNUEZ1zkOhogXs7LMLmxc1JNfC0Y9t8d7Jrs1cizjJlf66WsGgBT25s1t/ejKaSMz7mFhCQbC+UxcR0NIrzKP6e6TXl2ju4kG1b2JgjTxHGMdFL4zo=
Received: by 10.67.90.1 with SMTP id s1mr3225861ugl.1178931687549;
        Fri, 11 May 2007 18:01:27 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j1sm8608378ugf.2007.05.11.18.01.25;
        Fri, 11 May 2007 18:01:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkfu98nn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47004>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> -'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
>> +'git-add' [-n] [-v] [-f] (-u [[--] <file>...] | [--] <file>...)
> 
> I do not think this is correct; does -u take optionally path and
> when path is ambiguous you can add -- to disambiguate?
[...]
With *current* implementation you should take previous patch, 
amended, with the following synopsis:

-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] (-u | [--] <file>...)
+'git-add' (--interactive | -i)

> Of course, I would prefer a patch to allow use of paths with -u
> even more, but that is what I already said ;-).

The following synopsis is for such case:

-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] (-u [[--] <file>...] | [--] <file>...)
+'git-add' (--interactive | -i)

This is for "-u take optionally path and when path is ambiguous you can 
add -- to disambiguate", for example if you have '--interactive' file.

-- 
Jakub Narebski
Poland
