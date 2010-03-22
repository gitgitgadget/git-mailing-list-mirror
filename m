From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 08:48:52 -0700 (PDT)
Message-ID: <m3hbo8jr2e.fsf@localhost.localdomain>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	<81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	<4BA544FC.7050007@gmail.com>
	<41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	<4BA61CF9.7040104@gmail.com>
	<41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 16:49:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtjsD-0002W7-QF
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 16:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0CVPs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 11:48:57 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:64508 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab0CVPs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 11:48:56 -0400
Received: by bwz1 with SMTP id 1so2035163bwz.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=sE+5MJ7RtGVJFqHRjrpRijWYkRx9+dKGpywb3ujfLXM=;
        b=C8auzSGPdQ75tScRMWaFGKdDevb05r8o/t8JwqlfDdu4HimNraztvnUQFT6NnI09+n
         zpwXKmE1vI1G9XbjSOl1i2ajiWadd3CbA7cYZvrGs7C30WOxsYVqv4/qFWxomKrrLbYu
         LsNMtmpySnAhDajcc3e9YfTJfQ7mYlgVozsnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Wxw18jlwAwbGRfwoDrCVtTrJBzhPntwG3SYSNRRl45vnoG7COhGAkMUIMBmuwSQ67T
         lNlxwwPZfMXXHWgE6+YLpoFUFE60lIMWIUjWpCaAvsUvFnrG8x+7bxVERDwKlS6XtGYZ
         C05JFR2goIhZMvMZVaLayiKrZxM/xVx1Wct3s=
Received: by 10.204.84.220 with SMTP id k28mr1305448bkl.70.1269272934225;
        Mon, 22 Mar 2010 08:48:54 -0700 (PDT)
Received: from localhost.localdomain (abvg192.neoplus.adsl.tpnet.pl [83.8.204.192])
        by mx.google.com with ESMTPS id 24sm20059483bkr.18.2010.03.22.08.48.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 08:48:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2MFmPPQ008865;
	Mon, 22 Mar 2010 16:48:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2MFm9Xt008861;
	Mon, 22 Mar 2010 16:48:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142940>

Bo Yang <struggleyb.nku@gmail.com> writes:

> This project will add a new feature for 'git log' to display line
> level history. It can trace the history of any line range of certain
> file at any revision. For simplity, users can run the command like: '
> git log -L builtin/diff.c:6,8 ', he will get the change history of
> code between line 6 and line 8 of the diff.c file. 

I think that, at least at first, line-level log should follow the
git-blame, i.e.

  git log -L <begin>,<end>  <revs>  -- <file>

If we want (in the future) to follow history of some lines from one
file, and other lines from other file together, we do not need to use

  -L <file>:<begin>,<end>

syntax.  If parseopt allows, we can use posotion of parameters, i.e.

  <file1> -L <m>,<n>   <file2> -L <k>,<j>

> And for each history entry, it will provide the commits, the diff
> block which contains changes of users' interested lines.

The most important *new* algorithm you need to implement is, after
finding (blame-like) the commit that created given version of given
line, what was previous version of given line and which line that was.

You can probably find some heuristic in existing merge tools, like
emerge from GNU Emacs, or graphical diff tools.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
