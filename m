From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: drawbacks to svn server + git-svn vs git server?
Date: Wed, 21 Oct 2009 20:05:58 +0400
Message-ID: <20091021160558.GA19389@dpotapov.dyndns.org>
References: <25994334.post@talk.nabble.com> <4ADF2666.1070908@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dexter Riley <edbeaty@charter.net>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0dhQ-0002BB-0i
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 18:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbZJUQF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 12:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbZJUQF6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 12:05:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59431 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbZJUQF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 12:05:57 -0400
Received: by fxm18 with SMTP id 18so7926683fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9yaOHJUb9H5hgOaQRzUhjOQAKcI2FpfLSxqDRs32yos=;
        b=XfwUxOxHZBX42hVXUbAviFLIA2+Ei5Yu0fJVZq2mOo00244EAnpMq+A1EmPdr3RXvZ
         ch/CFw8ckT5C37mvPlDtgoMvqeOBL/74UwCk1lF9L0ERK1pmaCFhLx0Zwmjhh3+fW0tp
         TcPSXDqCIrsVO95gyRNYuT8HOAG6tozXP7Wts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EqDLUHCIvcz8LmFCl7HoHnvevB6qCzJYccaL/P0EKhoyZYOpb0nVnPe45/nrjElgiQ
         PocDKInCiJy/zWWY147U/LO1l8qDbLme7Vnim9b7cAJ9lD5x9RhxOLlW0Dla/3iyY65d
         w3cPuukdS6nSCbL2k8EPGyOKIFHYTRN8OwP44=
Received: by 10.204.20.142 with SMTP id f14mr8255199bkb.64.1256141161288;
        Wed, 21 Oct 2009 09:06:01 -0700 (PDT)
Received: from localhost (ppp91-77-225-238.pppoe.mtu-net.ru [91.77.225.238])
        by mx.google.com with ESMTPS id d8sm3026113fga.28.2009.10.21.09.05.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 09:05:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ADF2666.1070908@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130929>

On Wed, Oct 21, 2009 at 05:19:02PM +0200, Pascal Obry wrote:
> Le 21/10/2009 17:05, Dexter Riley a =E9crit :
>> Hello.  My group is currently using subversion on our version contro=
l server,
>> but would like to move to git as a client.  We are considering using
>> git-svn, to avoid revalidating the server software.  My question is,=
 are
>> there any major disadvantages to using git-svn versus git?  I know t=
hat the
>> git repository would be smaller.  I'm more concerned about possible =
svn
>> repository corruption, performance when pushing large merges back to=
 svn,
>> and any gotchas you might have encountered.
>
> Something that come to mind immediately is that you'll loose merge =20
> information as Subversion has linear history. I understand that recen=
t =20
> Subversion versions have added some information about merges but I do=
n't =20
> think git-svn handles this (I don't even know if it makes sense or no=
t:).

AFAIK, SVN remembers what changesets have been merged and what are not
(on per file basis). So, it is more like cherry-pick with some automati=
c
tracking than git merge, and stored separately for each file in the rep=
o.
So, I do not think it is easy to map svn merge concept to git one...

Inability to do merges mean that you have to track what changes what
branch by hands, which is very inconvenient if you have a few long
living branches.

Another long standing issue with git-svn was automatic end-of-line
conversion. It did not work with git-svn and the last time I heard abou=
t
it, it was disabled for repository created by git-svn. Probably, it may
not difficult to correct, but no one has looked at that closely....

> If you have a single integrator you'll also loose the author name.

Right... And if everyone has the right to commit then git-svn will
automatically rebase your changes during 'dcommit' on top of changes
made by other people, which means that you put into the repository a
different state than one you have actually tested.


Dmitry
