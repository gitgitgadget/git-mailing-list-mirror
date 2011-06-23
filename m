From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Having some problem with instaweb
Date: Thu, 23 Jun 2011 21:29:21 +0200
Message-ID: <201106232129.22137.jnareb@gmail.com>
References: <BANLkTim6gLg_-UdG36TXWS0Mfj3MOAQ_3w@mail.gmail.com> <m3iprx554t.fsf@localhost.localdomain> <BANLkTinvSt9xGNSRKLGucsRKoChMfs_b9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Gurjeet Singh <singh.gurjeet@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 21:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZpaw-00026J-Oo
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 21:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946Ab1FWT3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 15:29:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35973 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab1FWT3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 15:29:31 -0400
Received: by fxm17 with SMTP id 17so1463156fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TksPlgvrAIMf0rfiYtNHPp1Cc2dzZgM9DDWzGgi1TgQ=;
        b=luBm5lsP2HMN3/upvCakq4zlDVvA0VbscQGSj1HDOV3Td5rtCVQTS+xgQXVs5/7qw6
         Cx4N2J4rlrWxJMN1Zjbl9hqKFWaAU0OlhHuTbm/L8HlTxEpkwD79C12miISKLcZHKJFF
         O1Kmxx2c2Me+bxMFpRiaozI5zGalyvpfmDcJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PitImkaJgFu90o2OVuR7E9jELOlOLMBxilwg2Y+XZHdXKjmOxL7yZkzNJVFQjcTQY7
         f20VhkDoxKTu21L8m8OpyQSOmdfTld6boWGlIQOV+u88sZ7XBH0XOdLTZyaZsqG9Bd4j
         LgkvFFLKEMecZLOm8/8LDLCI3f9DGNvyooUpU=
Received: by 10.223.57.5 with SMTP id a5mr3170838fah.90.1308857369759;
        Thu, 23 Jun 2011 12:29:29 -0700 (PDT)
Received: from [192.168.1.15] (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id h1sm1180760fag.35.2011.06.23.12.29.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 12:29:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTinvSt9xGNSRKLGucsRKoChMfs_b9w@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176287>

On Thu, 23 Jun 2011, Gurjeet Singh wrote:
> On Thu, Jun 23, 2011 at 4:23 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> Gurjeet Singh <singh.gurjeet@gmail.com> writes:
>>
>>> I am on Linux Mint 10 and I tried the following command:
>>>
>>> $ git instaweb -d apache2 -p 1234 --start
>>> Syntax error on line 1 of /mnt/storage/gurjeet/.git/gitweb/httpd.co=
nf:
>>> Invalid command 'server.document-root', perhaps misspelled or defin=
ed
>>> by a module not included in the server configuration
>>> Could not execute http daemon apache2 -f.
>>
>> Hmmm... it looks like starts apache2, but generates config file
>> (httpd.conf) for lighttpd instead.
>>
>> Ahh... actually you started apache2, but didn't generate configurati=
on
>> file for it, so git-instaweb re-uses previous config file... which b=
y
>> default is lighttpd:
>>
>> =A0start, --start
>> =A0 =A0 =A0Start the httpd instance and exit. This does not generate=
 any of the
>> =A0 =A0 =A0configuration files for spawning a new instance.
>=20
> Now that's very unintuitive.... I am the impatient kind, and didn't
> read the whole paragraph. I assumed --start would just start the
> webserver (maybe run in daemon mode).

I'm working on it... actually the patch series is ready to send; it wil=
l
be sent as a reply to this email.

I just hope that it wouldn't be lost being deeper in thread...
=20
>>> /mnt/storage/gurjeet/ is my $HOME.
>>
>> Nb. it doesn't mater where $HOME is, but where is git repository you
>> were in when calling git-instaweb.
>=20
> Got it. I have some files of my home directory in a Git repository, s=
o
> $HOME is where the repository is.
>=20
> I have quite a few development related Git repositories under
> $HOME/dev/ and instaweb shows all of them on the first page (with
> description etc). IOW, is it supposed to recurse down all directories
> to look for .git/ directories?
>=20
> .git
> dev/EDB-ADVISORS/.git
> dev/EDBAS/.git
> dev/PCS/.git
> dev/PEM/.git
> dev/PGAGENT/.git
> dev/POSTGRES/.git
> dev/SERVICESTOOLS/.git
> dev/SLONY/.git
>=20
> Is this expected?

It is expected behavior.


It is consequence of the fact that the default gitweb mode is to search
for repositories recursively starting from given root; git-instaweb set
this $projectsroot to the one directory up from $GIT_DIR.  Alternate
solution would be for git-instaweb to generate projects list file for
gitweb with only single repository listed...

Nevertheless usually you don't have repositories inside of working
directory of other repositories. There was even idea floated to depreca=
te
such support, but it didn't gained traction.

One expected exception is when you use _submodules_; in this case you
would probably want to see both supermodule and submodules (subreposito=
ries).

That is why I think that current git-instaweb behavior has sense.

--=20
Jakub Narebski
Poland
