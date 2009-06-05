From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can I set up a GIT server w/o administration privileges on a Solaris machine?
Date: Fri, 05 Jun 2009 01:42:30 -0700 (PDT)
Message-ID: <m3eitz6php.fsf@localhost.localdomain>
References: <4A27F7E6.8060405@xnet.com>
	<32C5F26D-7498-440C-8BF4-97AF137EF78F@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stuart <stuart@xnet.com>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCV0n-0002Ek-0K
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbZFEImc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 04:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZFEImb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:42:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:40798 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971AbZFEIma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 04:42:30 -0400
Received: by fg-out-1718.google.com with SMTP id d23so170005fga.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=A4oT0AbAKjPnPLlVUFCZKkmmQoCeotD/3rKHZWqjJu4=;
        b=g9I6nzZ0FfU5hJ9kGUqfvjDk9FMwcPCc9xUy097Yo+22ZtRtvu7TBiJFAah9fcM88u
         U873mixdoAzoDPE/i+l1YijL23Ek4oX0FRNtQ8gytgo0cT5PZzjBgBcFNA3UWLFux6dz
         Lxygron0N64Mnj+yYclmTFeADmUCbSHGaNvZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=u8S3igoakq64I0Di0RHoxDGTTuwz2ZVKfUH/29QM/cfT3OL2IFHV3uQ9ZsaBdZ4Lze
         cQkAl+LGMQ5rrEEK7uRJSE0z2Hq9GyqCP3HZIhNPb/6VCRT9byo1STiVSWm6GJrSUI46
         CS6KgOy7FIHvlmMJo9ZiOUVg4qtNcl/CPrDyw=
Received: by 10.86.91.3 with SMTP id o3mr3648582fgb.29.1244191351483;
        Fri, 05 Jun 2009 01:42:31 -0700 (PDT)
Received: from localhost.localdomain (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id 4sm19657fge.13.2009.06.05.01.42.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 01:42:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n558gRQR013835;
	Fri, 5 Jun 2009 10:42:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n558gQ5J013832;
	Fri, 5 Jun 2009 10:42:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32C5F26D-7498-440C-8BF4-97AF137EF78F@dbservice.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120763>

Tomas Carnecky <tom@dbservice.com> writes:

> The default port of the git daemon is 9418. Unix systems usually don't
> require admin privileges to bind to port >1024. Maybe there's a
> firewall between you and the solaris box preventing you from
> connecting to such non-standard port? If you are sure there is no such
> thing, then simply fire up git-daemon and try to connect to it:
> 
> (assuming /path/to/repo.git is the git repository on the server)
>
> server$ git-daemon --export-all --verbose \
>   --base-path=/path/to/ /path/to/
> client$ git ls-remote git://<server>/repo.git

Use dashless form "git daemon" and not "git-daemon", otherwise
it cannot be found with modern git installation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
