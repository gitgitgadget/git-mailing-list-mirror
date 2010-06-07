From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Create Gitweb::Git module
Date: Mon, 7 Jun 2010 21:01:35 +0530
Message-ID: <AANLkTilYX3EKifncmM0U2PTWhww6LFYqOiK3P5fi0Zk_@mail.gmail.com>
References: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
	<201006071042.42908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 17:31:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLeIk-0005zp-E2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab0FGPbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 11:31:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60726 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0FGPbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 11:31:40 -0400
Received: by gye5 with SMTP id 5so2290088gye.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UwSPm+vJRLrQ/1G7yv3W6xYD5DbwXka2FipZ/5sl+aw=;
        b=YN17LefF7hJIfYxl2xfHDA5wm89qL2FKyugK3kT2hIfRfIZm/MWQCm9lLaXC9TSXQQ
         fHMg9b8SOs9f1ya9E1gM+eCzXo+d3+gLh+TnKhlRcO7SLh92lGS1kMGZ2QysoXeiH68w
         ulOnc3dkA14ogZ+IN35SFY1QySsqL5GHcMT6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wgp2+fCBnzfXv9ig4pGjuQgt86M+Xu6n02YFXIbTfyXZiUZR6gQVjfn47ODXWlFm/I
         J8dECqNVVLRi39EBfBGsZlEtGle0bAnBa+65YBysYgIudYa/rcCH36R9qHNcyus5nXxI
         ifG9fIv0rfS2VDRs1qfI7SMJpvWdfb0KYS2iI=
Received: by 10.101.132.26 with SMTP id j26mr15315923ann.144.1275924697951; 
	Mon, 07 Jun 2010 08:31:37 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Mon, 7 Jun 2010 08:31:35 -0700 (PDT)
In-Reply-To: <201006071042.42908.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148608>

2010/6/7 Jakub Narebski <jnareb@gmail.com>:
> Summary: minor complaints, mainly about _descriptions_.
>
> On Sun, 6 June 2010, Pavan Kumar Sunkara wrote:
>
>> Subject: [PATCH/RFC] gitweb: Create Gitweb::Git module
>>
>> Create a Gitweb::Git module in 'gitweb/lib/Gitweb/Git.pm'
>> to store essential git variables and subs regarding the
>> gitweb.perl script
>
> The pararaph above and the commit description (subject of this mail) =
do
> not tell us what does this new module Gitweb::Git is for, what does i=
t
> contain. =A0The description of module in header comment is also a bit
> lacking (see my comments below).
>
> I know I suggested, among other forms, the above short form of commit
> description, but I think that in this case it is too short.
>
> Perhaps (this is only a proposal):
>
> =A0gitweb: Create Gitweb::Git module, to run git commands
>
> =A0Create a Gitweb::Git module in =A0'gitweb/lib/Gitweb/Git.pm'
> =A0to deal with running git commands (and also processing output
> =A0of git commands with external programs) from gitweb.
>
> I think you should also write why $GIT variable is moved to Gitweb::G=
it,
> even though it is variable which is configured during build, and one
> might think that it belongs to Gitweb::Config.
>
> Perhaps something like this (it is only a proposal):
>
> =A0This module is intended as standalone module, which does not requi=
re
> =A0(include) other gitweb' modules to avoid circular dependencies. =A0=
That
> =A0is why it includes $GIT variable, even though this variable is
> =A0configured during building gitweb. =A0On the other hand $GIT is mo=
re
> =A0about git configuration, than gitweb configuration.
>
> Or something like that.

Ok.

>>
>> Subroutines moved:
>> =A0 =A0 =A0 evaluate_git_version
>> =A0 =A0 =A0 git_cmd
>> =A0 =A0 =A0 quote_command
>>
>> Subroutines yet to move: (Contains not yet packaged subs & vars)
>> =A0 =A0 =A0 None
>>
>> Update gitweb/Makefile to install gitweb modules alongside gitweb
>
> It is not 'gitweb modules', but single gitweb module.
>
> =A0Update gitweb/Makefile to install Gitweb::Git alongside gitweb.
>
>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> ---
>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index e95aaf7..59a65a8 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>
>> -# core git executable to use
>> -# this can just be "git" if your webserver has a sensible PATH
>> -our $GIT =3D "++GIT_BINDIR++/git";
>> +#only this variable has it's root in Gitweb::Git
>> +$GIT =3D "++GIT_BINDIR++/git";
>
> Hmmm... is this comment really needed? =A0It does not matter, at leas=
t not
> much, where given subroutine comes from. =A0Only lack of 'our' indica=
tion
> that it is defined in other package.
>
> Perhaps
>
> =A0+# $GIT is from Gitweb::Git
>
> or something like that?

Ok.

>> @@ -77,7 +75,6 @@ sub gitweb_get_feature {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 $feature{$name}{'override'},
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 @{$feature{$name}{'default'}});
>> =A0 =A0 =A0 # project specific override is possible only if we have =
project
>> - =A0 =A0 our $git_dir; # global variable, declared later
>> =A0 =A0 =A0 if (!$override || !defined $git_dir) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return @defaults;
>> =A0 =A0 =A0 }
>
> Nice side-effect.
>
>> @@ -197,13 +194,6 @@ sub get_loadavg {
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -# version of the core git binary
>> -our $git_version;
>> -sub evaluate_git_version {
>> - =A0 =A0 our $git_version =3D qx("$GIT" --version) =3D~ m/git versi=
on (.*)$/ ? $1 : "unknown";
>> - =A0 =A0 $number_of_git_cmds++;
>> -}
>
> I guess that evaluate_git_version and $number_of_git_cmds are moved t=
o
> Gitweb::Git because of technical reasons (for module to be self
> contained, and to avoid circular dependencies), isn't it?

Yeah. Exactly.

>> @@ -492,10 +482,8 @@ sub evaluate_and_validate_params {
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -# path to the current git repository
>> -our $git_dir;
>> =A0sub evaluate_git_dir {
>> - =A0 =A0 our $git_dir =3D "$projectroot/$project" if $project;
>> + =A0 =A0 $git_dir =3D "$projectroot/$project" if $project;
>> =A0}
>
> O.K.
>
>> diff --git a/gitweb/lib/Gitweb/Git.pm b/gitweb/lib/Gitweb/Git.pm
>> new file mode 100644
>> index 0000000..9961e6d
>> --- /dev/null
>> +++ b/gitweb/lib/Gitweb/Git.pm
>> @@ -0,0 +1,48 @@
>> +#!/usr/bin/perl
>> +#
>> +# Gitweb::Git -- gitweb git package
>> +#
>> +# This program is licensed under the GPLv2
>
> This description doesn't tell us much. =A0What does "git package" mea=
n?
> I would like to have description here what this package is for, and
> whet it (should) include.
>
> Perhaps (this is only a proposal):
>
> =A0+# Gitweb::Git -- gitweb's package dealing with running git comman=
ds
>
> or something like that.

Ok.

>> +
>> +package Gitweb::Git;
>> +
>> +use strict;
>> +use warnings;
>> +use Exporter qw(import);
>> +
>> +our @EXPORT =3D qw($GIT $number_of_git_cmds $git_version $git_dir
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_cmd quote_command evaluate_git=
_version);
>> +
>> +# core git executable to use
>> +# this can just be "git" if your webserver has a sensible PATH
>> +our $GIT;
>
> One could think that this should belong to Gitweb::Config, but it is
> more about _git_ configuration than about _gitweb_ configuration.
> And there are technical reasons for having it there.
>
>> +
>> +our $number_of_git_cmds =3D 0;
>
> I guess that counting git commands belong there...
>
> By the way, can anyone check if it is correctly reset, and is countin=
g
> number of git commands it took to process _a request_, also when runn=
ing
> in FastCGI mode?
>
>> +
>> +# version of the core git binary
>> +our $git_version;
>
> Hmmm... wouldn't it be better to have this close to evaluate_git_vers=
ion?
>
> Also, does $git_version and evaluate_git_version belong in Gitweb::Gi=
t?

Yes because it is regarding git rather than gitweb.

Thanks,
Pavan.
