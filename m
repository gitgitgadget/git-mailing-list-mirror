From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 10:41:49 -0400
Message-ID: <32541b130904300741p325012b7g28dabbd33576ceae@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
	 <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXT6-0004TX-CH
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763765AbZD3Oly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 10:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763638AbZD3Oly
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:41:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:60704 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763765AbZD3Olu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 10:41:50 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1063621yxj.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nsnTtZrW6gmPNgSMdwtLDoT/h6TUKZdhI1S6rmEWX1I=;
        b=gHnatrC0LWBrJuux02jqRmP6zhMHLhxDNvDVE2ZM62A/WHjPXCzl16BpXX1c36JpaK
         V8Ids5A1V7h9ck0zYOrQ9lHQAzAd+72lAIJszGLQtykJeAdXQpxHawWzN36NFMlyov+i
         3gGkdJ03IA43ZPJhqFXlfNmjjipELUeUMnM+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XIsZNbWg/B/fMoz0gU36lPQUU7Lh78N0Lkuk+IT8T1CDRdPdPSye6twWbMkYOHI8Gx
         vsAvA6/L8El1/SFRinqeKqsiERA4VXEWk/YnThHJVq7g+Uxb3AicutKq2gxtZiixN3xC
         VG+l4nnfXPRqHumWF7+8i4XvDHpWvo/oCOXVA=
Received: by 10.151.6.2 with SMTP id j2mr3723301ybi.88.1241102509992; Thu, 30 
	Apr 2009 07:41:49 -0700 (PDT)
In-Reply-To: <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118020>

On Thu, Apr 30, 2009 at 4:53 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Actually, after removing the git-core package and all its dependencie=
s...
>
> # same git version that succeeds on Fedora 9, here says:
> $ git svn =A0clone =A0-T trunk =A0http://paintweb.googlecode.com/svn =
paintweb.git
> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
> error closing pipe: Broken pipe at
> /home/martin/libexec/git-core/git-svn line 3252
> cat-file --batch: command returned error: 129

Try this:

  strace -fF git svn  clone  -T trunk
http://paintweb.googlecode.com/svn paintweb.git 2>&1 | egrep -i
'git.pm|git-svn'

If you wade through the output, it should tell you which git.pm and
git-svn you're *really* getting.

Avery
