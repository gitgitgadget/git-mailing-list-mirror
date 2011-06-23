From: Gurjeet Singh <singh.gurjeet@gmail.com>
Subject: Re: Having some problem with instaweb
Date: Thu, 23 Jun 2011 07:48:11 -0400
Message-ID: <BANLkTinvSt9xGNSRKLGucsRKoChMfs_b9w@mail.gmail.com>
References: <BANLkTim6gLg_-UdG36TXWS0Mfj3MOAQ_3w@mail.gmail.com> <m3iprx554t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 13:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZiOk-0002zO-NP
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 13:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215Ab1FWLse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 07:48:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43683 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759132Ab1FWLsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2011 07:48:33 -0400
Received: by vws1 with SMTP id 1so1240787vws.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WrsX+qQT8P8x0B8y9nNrOCxAdw9lUlMNbnGE57BKQDs=;
        b=bsXp+Wo0md2glqWycDVFjMSYNKQWOo/jTUMc6TBMvz0yfq9uJvKICWxojmbVE9eitx
         ML/6htXItsnfCZ0mCO6I3DNNH3/5HxMBeXONWB/dA5NbS3pTiFGAQh75CLEP9jZuVdQf
         p1uuQAb/UT8M2Wq1vOGpqPYi33KrZ3Z3MZynk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fxV2uHkot70z3YWIovc585kS+sUxdoYKaa7gKQ/6ISUrWUXx1I3s28FSJAH/UBPgRU
         /YJoxolvaUeK29CiefIFGY8a3zkiDIcvLuZfSB7kJfPo2aEF3WAORTYggkfcKu5BU4N0
         +ckeJY9XbL68TPlS8POsukr9Vkwc526otJO7k=
Received: by 10.220.147.201 with SMTP id m9mr642162vcv.264.1308829711141; Thu,
 23 Jun 2011 04:48:31 -0700 (PDT)
Received: by 10.220.183.73 with HTTP; Thu, 23 Jun 2011 04:48:11 -0700 (PDT)
In-Reply-To: <m3iprx554t.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176269>

On Thu, Jun 23, 2011 at 4:23 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> CC-ing Eric Wong, author of git-instaweb.
>
> Gurjeet Singh <singh.gurjeet@gmail.com> writes:
>
>> I am on Linux Mint 10 and I tried the following command:
>>
>> $ git instaweb -d apache2 -p 1234 --start
>> Syntax error on line 1 of /mnt/storage/gurjeet/.git/gitweb/httpd.con=
f:
>> Invalid command 'server.document-root', perhaps misspelled or define=
d
>> by a module not included in the server configuration
>> Could not execute http daemon apache2 -f.
>
> Hmmm... it looks like starts apache2, but generates config file
> (httpd.conf) for lighttpd instead.
>
> Ahh... actually you started apache2, but didn't generate configuratio=
n
> file for it, so git-instaweb re-uses previous config file... which by
> default is lighttpd:
>
> =A0start, --start
> =A0 =A0 =A0Start the httpd instance and exit. This does not generate =
any of the
> =A0 =A0 =A0configuration files for spawning a new instance.

Now that's very unintuitive.... I am the impatient kind, and didn't
read the whole paragraph. I assumed --start would just start the
webserver (maybe run in daemon mode).

>
> Try using
>
> =A0$ git instaweb -d apache2 -p 1234 -b lynx

That worked.. I do not have lynx, but it did start apache2 and I was
able to browse the repo.

>
> then exiting web browser.
>
>
> BTW. I think that git-instaweb should be more helpful here... will
> investigate.
>
>> /mnt/storage/gurjeet/ is my $HOME.
>
> Nb. it doesn't mater where $HOME is, but where is git repository you
> were in when calling git-instaweb.

Got it. I have some files of my home directory in a Git repository, so
$HOME is where the repository is.

I have quite a few development related Git repositories under
$HOME/dev/ and instaweb shows all of them on the first page (with
description etc). IOW, is it supposed to recurse down all directories
to look for .git/ directories?

=2Egit
dev/EDB-ADVISORS/.git
dev/EDBAS/.git
dev/PCS/.git
dev/PEM/.git
dev/PGAGENT/.git
dev/POSTGRES/.git
dev/SERVICESTOOLS/.git
dev/SLONY/.git

Is this expected?

>
>
> BTW. in the future it would be good idea to tell what git version are
> you using.

I am at 1.7.1


Thanks for the help, and thanks to everyone around Git for a great
piece of software.
--=20
Gurjeet Singh
EnterpriseDB Corporation
The Enterprise PostgreSQL Company
