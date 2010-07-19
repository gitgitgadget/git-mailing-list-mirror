From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 14:02:12 -0700 (PDT)
Message-ID: <m3aapnmbid.fsf@localhost.localdomain>
References: <4C4484A4.5010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-dev <git@vger.kernel.org>
To: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:02:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxTk-0001ur-VO
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966791Ab0GSVCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 17:02:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33608 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966763Ab0GSVCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 17:02:14 -0400
Received: by fxm14 with SMTP id 14so2419712fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ygr0Q0rHQR2xdQEtWRVokkv/rI54hIlDeZdASO1oS8w=;
        b=sh0QXgwOQEE7htj4RNK15sx5ExFfJwGlC71m2zLAXnfPxuvL+JX15lwtVt42EFSbXo
         ZgNBOwtBzVs3CkaVpv3OTw5C7m+Oz3jS7g7k4LzkjQeGPliAdHNYGCKgNdaZ75tARBuZ
         T7EZklGfOj04NZUgiid0dcPE2BcUyorwR9eIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Jq3u9vUdXPReZezH0SmhGowFxgkT2P3aAaIwO0eXYba2Wkbxp8CgNbRARUnEWIagGS
         USuSAcFq0Wn1Cf4GXRkAveFrnAQ1BgQ0zkj0gKvhaQyMx/OIBDtSLaI5GcXic6ZQ7Ufn
         xWoHOWjCGwEQof32rYE7qIgUu9i5AUkYAf3vs=
Received: by 10.223.116.6 with SMTP id k6mr4358188faq.49.1279573333003;
        Mon, 19 Jul 2010 14:02:13 -0700 (PDT)
Received: from localhost.localdomain (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id h4sm2160115faj.15.2010.07.19.14.02.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 14:02:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6JL1wmr007431;
	Mon, 19 Jul 2010 23:02:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6JL1lUF007426;
	Mon, 19 Jul 2010 23:01:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4C4484A4.5010009@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151280>

Ketan Padegaonkar <ketanpadegaonkar@gmail.com> writes:

> We use http to serve our git repos, in order for git to not ask me a
> username/password everytime, 

Errr... WTF?  Can't you configure SSH (use ssh-add, perhaps together with
tool such as keychain) to use public key based authentication?

> I've put the following in my .git/config:
> 
> [remote "origin"]
>    url = https://user:pass@host/repo.git
> 
> What is discerning is that every time git encounters a problem
> connecting to the repo, I get the following error containing both my
> username and password.
> 
> error: Couldn't resolve host 'host' while accessing
> https://user:pass@host/repo.git/info/refs
> 
> I would like to suggest that the password be removed/masked from this
> error message.

Which git version do you use?  I recall vaguely that something was
done in this direction (masking passwords in URLs).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
