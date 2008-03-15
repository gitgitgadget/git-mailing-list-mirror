From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Sat, 15 Mar 2008 12:22:13 +0100
Message-ID: <200803151222.16731.jnareb@gmail.com>
References: <200803091459.21354.jnareb@gmail.com> <200803101938.09300.jnareb@gmail.com> <e03c8a420803130450y77fd4038h734d80b636fa30a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mercurial@selenic.com
To: "=?iso-8859-2?q?Zden=ECk?= =?iso-8859-2?q?_Vr=E1bl=EDk?=" 
	<zdenek@vrablik.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 12:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaUTz-0002EA-Pu
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 12:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbYCOLWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2008 07:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYCOLWS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 07:22:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:48403 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYCOLWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 07:22:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so656535fgb.17
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=DvcnLXTbCnWqL30XndYeHqV4WFGlasxSqm6zcTNJmSM=;
        b=fc3xrU/hEwt0OFxmm4eURXuZPAVFZIYVdinw9js/h6nYnkisF4IanaUZAxpcR8ksGJ8KGAPr9m7gHfXbiq16ZL8D/MixV6hwzDo7Ti4TwdgByH+duQGpNvjSUhRpHw5p9rmcWA2YUY3ZVK3+mmgSwjtuOLyUD/nLGwUhrKp8R9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=yGGTdrV2lVor+r11/Gw7WGCKjobmUnRUeuw/qvqLkduQF22kEo5Re9KSdkiJ+VD7ZtB0GDFQ337Ccj3LtBi5p0IEOURMLo4XaI6B9A5qD+MoSsjM15CQ5QSO32lYjRLcjRacrW1DxpKvEdomdtsuYZHd5Z5p/gtKcoz6o2+PGAQ=
Received: by 10.82.138.6 with SMTP id l6mr29578428bud.35.1205580136072;
        Sat, 15 Mar 2008 04:22:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.193.189])
        by mx.google.com with ESMTPS id b33sm8266766ika.5.2008.03.15.04.22.13
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Mar 2008 04:22:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <e03c8a420803130450y77fd4038h734d80b636fa30a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77321>

[Cc: git mailing list, mercurial mailing list]

On Thu, 13 March 2008, Zden=ECk Vr=E1bl=EDk wrote:
> On Mon, Mar 10, 2008, Jakub Nar=EAbski <jnareb@gmail.com> wrote:
>>
> ...
>>  cvscommit           | see git-cvsexportcommit, git-cvsserver

=46irst, a word of warning. I use Git (and sometimes even contribute
to it), and watch its mailing list; I know Mercurial only from=20
documentation and a few discussions on #revctrl IRC channel. So now you=
=20
should know which way I tend to be biased ;-)
=20
> I have looked at git-cvsserver
> http://www.kernel.org/pub/software/scm/git/docs/git-cvsserver.html
> It doesn't put back changes from git to cvs server.
> It uses cvs client to work with GIT repository.

On http://www.selenic.com/mercurial/wiki/index.cgi/UsingExtensions

   cvscommit            | Push changesets to CVS

But on the link on its wiki page we have

  From: Simon 'corecode' Schubert
  Imbeault, Jean-Christian wrote:
  >
  > Are there any tools available that can push an hg repository
  > into CVS?=20
  I've written the cvscommit extension, but it might be outdated and
  maybe could use some structural changes, but I've used it for some
  commits.

There is no documentation for this extension, unfortunately, so I don't=
=20
know what exactly it does.


=46rom listed git "equivalents"

  git-cvsexportcommit  (1)  - Export a single commit to a CVS checkout
  git-cvsserver        (1)  - A CVS server emulator for git

it looks like git-cvsexportcommit is more equivalent to hg.ext.cvscommi=
t
Mercurial extension.

> Does Mercurial has something like this? I use Mercurial personally an=
d
> I like it. But to migrate from cvs I need persuade all team. It will
> be easier to do it with such cvs emulator.

I don't know of such extension / tool

> Thanks for the comparison.

You are welcome.
--=20
Jakub Narebski
Poland
