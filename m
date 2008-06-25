From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Where does gitweb take the owner name from?
Date: Wed, 25 Jun 2008 13:12:31 -0700 (PDT)
Message-ID: <m3y74ti89i.fsf@localhost.localdomain>
References: <ce513bcc0806250741q3821e925uf8b6439b12062ba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Erez Zilber" <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbMx-0005Jp-RU
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbYFYUMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYFYUMf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:12:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7613 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYFYUMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:12:34 -0400
Received: by nf-out-0910.google.com with SMTP id d3so171218nfc.21
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ilUmlij8tEtKjS2dngMjWJ4p9Ja+zdVJXqh2X2Vt3bs=;
        b=WetIh5ka0BkK7EbYUklkAS8OB+g5UymOueKJcInbjrxMa06yahtF0/B26hfeOAXoJ8
         mrHTEQ7ji4B0/k+EH6ovZcPZHwXnL/n5mIB2BSkanqxvUp7AtEjIGc8lnuOzNOnJ3F+u
         QIS2+5jemNgJnY5lhePkkKVCIrOJWWAScORo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=cNUifH5naltuaYsdsFTwkwG8gI2VanqxTGJGS0WXtnN7N2WwWGNDAcu/w1dLAm9Uf7
         zCsS8RX0izMuAu4fQ28hd79GTwWdu7z1MMDAvtSrpeoTeYyYAAQPPCpA1WlbYMS94lyy
         fdSh/nnTvU5TnbNlKwHNFGmW1Pq5QMsABrRCw=
Received: by 10.210.16.10 with SMTP id 10mr2009702ebp.118.1214424753210;
        Wed, 25 Jun 2008 13:12:33 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.164])
        by mx.google.com with ESMTPS id f6sm11493928nfh.37.2008.06.25.13.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 13:12:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5PKCRZt017502;
	Wed, 25 Jun 2008 22:12:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5PKCQ2g017499;
	Wed, 25 Jun 2008 22:12:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ce513bcc0806250741q3821e925uf8b6439b12062ba2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86337>

"Erez Zilber" <erezzi.list@gmail.com> writes:

> On the main page of gitweb (the one that lists all projects), there's
> an "Owner" column. On my gitweb, it is empty for all projects. Where
> is this information taken from?
> 
> Here is how it looks on the server when I run 'ls -l':
> 
> drwxr-xr-x 7 erez.zilber linux 4096 Jun 25 17:36 my_test.git

Unfortunately it is not stated explicitely neither in gitweb/README,
not gitweb/INSTALL.

Nevertheless when you grep for 'owner' in gitweb/README you can find
the following fragments:

 * $projects_list
   Source of projects list, either directory to scan, or text file
   with list of repositories (in the "<URI-encoded repository path> SPC
   <URI-encoded repository owner>" line format, [...]).
   Set to $GITWEB_LIST during installation.  If empty, $projectroot is
   used to scan for repositories.

 [...]

 * gitweb.owner
   You can use the gitweb.owner repository configuration variable to set
   repository's owner. It is displayed in the project list and summary
   page. If it's not set, filesystem directory's owner is used
   (via GECOS field / real name field from getpwiud(3)).

(This might be present only in 'pu' branch, as it was part of my
patch adding support for optional 'description' field in $projects_list
file).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
