From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global  server root and projects list
Date: Wed, 19 May 2010 01:05:57 +0200
Message-ID: <201005190105.59606.jnareb@gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com> <m3ljbhcp46.fsf@localhost.localdomain> <AANLkTilhdkw7v-jV9JNBx8qvGBCenieExRh_zVm3hAKq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 01:06:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEVrd-0005qj-5E
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 01:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab0ERXGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 19:06:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45197 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0ERXGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 19:06:09 -0400
Received: by fxm10 with SMTP id 10so1716735fxm.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xUaPQ+6BEPckDFW5BBGrXq8IjHodpfP4uThwWDesjzc=;
        b=waJ7C8yUE8Q7iTAi6zahgksheANrJ8Appinb5/kq3yYFdXAPmnlZwXIw7SffcCChlx
         jewAmeo2EKqzu8/lVwio8txvwCg3kVZGftq49E8r7HxQFMR7ZFwkqbswySwIYUj8hq2f
         5oADMU1ATIYCgG5Uw8zEUA6GauOHm2ugiOaow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vr0mXYhzLfBGbPBR5pkeb8LiBua70Fo/KtSelzieJBk0AIlzSDBslS4HSaYXXszLjv
         VgpONJAfDN28EPoCRDRU/MFIw0rzlQtoBoel0pOTPLUIBDfPdcfJrwEUlzhGwbCj8Fac
         71wGvSebpJEUdcKCV7VeXcSNZfeEMcmCVceYM=
Received: by 10.103.7.28 with SMTP id k28mr5152519mui.25.1274223967202;
        Tue, 18 May 2010 16:06:07 -0700 (PDT)
Received: from [192.168.1.13] (abvv101.neoplus.adsl.tpnet.pl [83.8.219.101])
        by mx.google.com with ESMTPS id d13sm21133376bkd.17.2010.05.18.16.06.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 16:06:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilhdkw7v-jV9JNBx8qvGBCenieExRh_zVm3hAKq@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147313>

On Tue, 18 May 2010, Pavan Kumar Sunkara wrote:
> Jakub Narebski wrote:
>> Pavan Kumar Sunkara wrote:

>>> and the httpd.conf along with server logs and pid go into
>>> '$(HOME)/.gitweb' directory.
>>>
>>> As there is no need to call git-instaweb in every git repository,
>>> configure gitweb to get $projects_list from file '$(HOME)/.gitweb/l=
ist'
>>> and $projectroot is ''
>>>
>>> Example of ~/.gitweb/list:
>>> home%2Fpavan%2Fgit%2F.git Linus+Torvalds
>>> home%2Fpavan%2Fgsoc%2F.git Pavan+Kumar+Sunkara
>>
>> This is quite a large change on how git-instaweb works.
>>
>> First, I think such change should be better left for a separate
>> commit, splitting this one in two: one making git-instaweb use
>> installed gitweb files, and installing gitweb files somewhere when
>> installing git, and second changing how git-instaweb behave.
>> "Do one thing, and do it well." =A0It would make easier to check
>> if there are errors in the commit.
>=20
> Ok.
>=20
>> Second, in my opinion it is not a good change at all. =A0Currently y=
ou
>> can run "git instaweb" when inside git repository, and get a web
>> browser (or a new tab in existing session of a running web browser)
>> with current repository in it, to browse its history. =A0It is simil=
ar
>> to running gitk (or other graphical history browser, like qgit, tig,
>> etc.), or running "git log", but with web interface.
>=20
> Yes. But this change is vital for the success of my GSoC project. I
> will explain why.
> If you remember, my GSoC project contains some functionalities like
> creating/cloning repositories which need a server which need to start
> outside git directory.
>=20
> Until now, I thought to use git-instaweb to do this. But I realised
> now that it would be better if we have another script.
> So we need to have a different "git-client" script which starts this =
client.
>=20
> What do you say ?

Well, I can understand that.

There are two options how to resolve this issue without adding yet
another script (although on the other hand git-web-gui / git-client
could share code with git-instaweb just like git-difftool and=20
git-mergetool do).

=46irst is to leave git-instaweb similar to how it is now, with pid fil=
e,
server config file, gitweb config file, etc. in $GIT_DIR/gitweb, but
if it is invoked outside any git repository, start it in "repository
administration" mode, i.e. on the page that allows one to create new
repository or clone repository.

The alternate solution would be to follow the idea implemented in this
patch, namely per-user pid file, gitweb config file, server config file
etc. and the *list of projects* file in $HOME/.gitweb (or whenever
XDG / FHS / LSB says it should be named), _but_ add an easy way to add
a new project (a new repositoey) to list.  Perhaps even make=20
'git instaweb', when run from inside git repository, add automatically
current repository to list (unless it is present there already), and
perhaps open 'summary' page for said repository.

But independently on which solution would be chosen, it should take pla=
ce
in a separate commit,
>=20
>> Now, current git-instaweb behavior has its quirks, but having
>> git-instaweb show _current_ repository is a very important feature,
>> and I'd rather we didn't lose it in transition.
>>
>> So in my opinion it would be better to just update git-instaweb and
>> generating git-instaweb to make use of installed gitweb and installe=
d
>> gitweb files, but do not change organization of generated files; jus=
t
>> instead of gitweb.cgi there should be gitweb_config.perl with
>> appropriate configuration to show current repository. =A0And of cour=
se
>> there would be no gitweb files in $GIT_DIR/gitweb (in .git/gitweb)
>> directory.
>=20
> Ok. Sure I will do it.

Thanks in advance.
--=20
Jakub Narebski
Poland
