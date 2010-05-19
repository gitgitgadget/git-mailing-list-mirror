From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global 
	server root and projects list
Date: Wed, 19 May 2010 14:28:54 +0530
Message-ID: <AANLkTimFrX6yE69ZNlZM11XJVNLS5rpbsdeNN984iNs7@mail.gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
	 <m3ljbhcp46.fsf@localhost.localdomain>
	 <AANLkTilhdkw7v-jV9JNBx8qvGBCenieExRh_zVm3hAKq@mail.gmail.com>
	 <201005190105.59606.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 11:07:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEfFA-0006mX-CM
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab0ESJGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 05:06:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62464 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab0ESJGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 05:06:07 -0400
Received: by mail-gw0-f46.google.com with SMTP id a20so1634839gwa.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WtYRuSzTGnsZoUB6SA+VYtl7GfAkoyU7goXxB4SeZiM=;
        b=FAFN72nYIjoP8dZG+pA+7UH7deYwnKkJ+B6YrfKWi1I8x2RvNPLDmNdUNDbW/ueiDv
         4zLZIOdyo042LcKEDxvGFtzzowUlaKvJWrMigDEyT/a7yctXmi8qzhpAPWU5ttcUWOmK
         HmeN58d8eFnA14PylaGREzqvss6eRJG+uXkls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lK5XGOXp7kJIy3Kih/iVxm75cfBfJvGHu0FlmmGKGPGgLzbPpZjKeTvQnpZq6iVd6y
         An7Kh1qXesX4se3Cb7ba5f+qHzapZeylW9TNMt6I7w5mxCbMdvf48Aq2ms68qNcfkZYr
         mUJWFUf9fRzASgcXBcUhIU9GnJgN9CB9e1IqE=
Received: by 10.91.204.30 with SMTP id g30mr102060agq.78.1274259534796; Wed, 
	19 May 2010 01:58:54 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Wed, 19 May 2010 01:58:54 -0700 (PDT)
In-Reply-To: <201005190105.59606.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147320>

>
> Well, I can understand that.
>
> There are two options how to resolve this issue without adding yet
> another script (although on the other hand git-web-gui / git-client
> could share code with git-instaweb just like git-difftool and
> git-mergetool do).
>
> First is to leave git-instaweb similar to how it is now, with pid fil=
e,
> server config file, gitweb config file, etc. in $GIT_DIR/gitweb, but
> if it is invoked outside any git repository, start it in "repository
> administration" mode, i.e. on the page that allows one to create new
> repository or clone repository.

But this solution requires starting of many apache servers on many
ports which is quite complicated and even messier.

> The alternate solution would be to follow the idea implemented in thi=
s
> patch, namely per-user pid file, gitweb config file, server config fi=
le
> etc. and the *list of projects* file in $HOME/.gitweb (or whenever
> XDG / FHS / LSB says it should be named), _but_ add an easy way to ad=
d
> a new project (a new repositoey) to list.

The feature *Adding repository to client* in my project proposal will
take care of this.

> =A0Perhaps even make
> 'git instaweb', when run from inside git repository, add automaticall=
y
> current repository to list (unless it is present there already), and
> perhaps open 'summary' page for said repository.

Yeah, we can do that but I think I will do it in another commit.

> But independently on which solution would be chosen, it should take p=
lace
> in a separate commit,

So, I will implement the second solution but in seperate commit. First
I will take care of this patch :)

Thanks
- Pavan
