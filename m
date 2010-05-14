From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Fri, 14 May 2010 22:10:50 +0530
Message-ID: <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com>
	 <201005141707.26416.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 18:41:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxwf-00012K-Du
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab0ENQkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 12:40:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35085 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab0ENQkv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 12:40:51 -0400
Received: by gwj19 with SMTP id 19so1387880gwj.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r2qMANvxPyy5cAz7QgO6vzAjZxzaDH/bHvIrs49usFU=;
        b=cSm2YxuLf7VyEgmWNg0eXdmvQLzK8zstIpOcQ/H7PfAN3D4sYfdjgMTax4nJ2FArn5
         f9TXX2EcwlmCxM8lNCR1vBCecIomW7sLICu4C+cRD7HFe5LGoVICkQnIfqowwOUU+wC0
         DltBiYx/9TTLSxx5+sv536jN4ccUgKG/04Jzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rVruILzZQ7B3rhAHo/LyEs4l+rkcOkypeJNag8Fifg5BvA+XjOgN6jYDo03C7Hk46P
         R1pQD49/ZNpNWg9HL5NgKgUWIkuItAEObdHKJWNx1XydM6U4vW+Cz/sG4ZxOZ7FCElBn
         EEVfoVv1rj6gFVtJRJyXyu98gGT5JtmrowlcI=
Received: by 10.90.225.16 with SMTP id x16mr1009979agg.71.1273855250422; Fri, 
	14 May 2010 09:40:50 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Fri, 14 May 2010 09:40:50 -0700 (PDT)
In-Reply-To: <201005141707.26416.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147102>

On Fri, May 14, 2010 at 8:37 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Cc-ed Eric Wong, the main author and maintainer of git-instaweb
>
> In short: I think that this patch should be split into two patches, o=
ne
> which sets default value of 'gitwebdir' (in Makefile or gitweb/Makefi=
le;
> please explain why you chosen one or the other), and second that "fix=
es"
> git-instaweb (and might include installing gitweb, in $(gitwebdir) or=
 in
> $(sharedir)/gitweb).

Yes, I agree. This is the first patch.
The second patch which fixes git-instaweb is in discussion with my
mentors. after that I will be sending it to the git mailing list.

I choose Makefile rather than chossing gitweb/Makefile becuase
git-instaweb is a package of git not a package of gitweb. So, I choose
Makefile rather than choosing gitweb/Makefile

> On Thu, 13 May 2010, Pavan Kumar Sunkara wrote:
>
>> Subject: gitweb: Add global installation target for gitweb
>
> The name "target" is here a bit misleading in the context of Makefile=
=2E
> You meant that you set default installation destination (default
> installation directory) for install-gitweb target in Makefile, by add=
ing
> default value of 'gitwebdir' variable. =A0To clarify this issue I thi=
nk it
> would be better to write:
>
> =A0gitweb: Set default destination directory for installing gitweb
>
> or something like that.

Ok.

>> The current installation of gitweb requires us to give it a
>> target directory. But splitting of gitweb makes it difficult
>> for git instaweb to continue with the current method.
>
> This paragraph has not a best grammar, and is also slightly inaccurat=
e.
> Also having default value for build variables (for a destination
> directories for install targets) is a good thing in itself, independe=
nt
> of the issue of git-instaweb and splitting gitweb.
>
> What about this?
>
> =A0Currently installing gitweb requires to give a target directory
> =A0(via 'gitwebdir' build variable). =A0Giving it a default value
> =A0protects against user errors.
>
> =A0Also git-instaweb in its current form (re)creates gitweb.cgi and
> =A0(some of) required static files in $GIT_DIR/gitweb/ directory for
> =A0each repository it is ran. =A0Splitting gitweb would make it diffi=
cult
> =A0for git-instaweb to continue with this method.
>
> See also comment about git-instaweb below.
>
>>
>> This commit allow installation of gitweb files into the target
>> '$(sharedir)/gitweb' by default when user type 'make install'.
>
> I would phrase it a bit differently myself, emphasizing that
> "make install" would now also install gitweb (!):
>
> =A0This commit sets default installation directory for gitweb files
> =A0to "$(sharedir)/gitweb". =A0The 'install' target ("make install")
> =A0now also installs gitweb.
>
>> This target act as root directory for instaweb servers.
>
> It does not, as you have not provided required changes to
> git-instaweb.sh and 'git-instaweb' target in main Makefile.
>
>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Ok.

> Two things.
>
> First, I think providing default value for 'gitwebdir' could be I goo=
d
> idea. =A0I think that all other build variables containing installati=
on
> directories have default values. =A0But I do wonder whether the
> "$(sharedir)/gitweb" is a good default value for 'gitwebdir' (see als=
o
> comment about git-instaweb below).

I chose it because the lib files of gitk and git-gui are being
installed in sharedir.
I am happy to accept if you have any other better idea. :-)

> Second, the issue with git-instaweb in its current form, and splittin=
g
> gitweb is very important. =A0I am not sure though if this is correct
> solution for this problem. =A0It is NOT A FULL SOLUTION, that is sure=
=2E
>

Yes, It is not a full solution. There is another patch that is
currently in discussion with my mentors.
Petr and Christian told me to make sure that I send patches as small
as possibl so that they will be merged into the mainstream. That is my
GSoC aim too.

So, I sent this small patch which justs installs gitweb with git's
"make install" without breaking the git-instaweb.sh script.
The patch for modifying git-instaweb will be sent soon to his mailing l=
ist.

> The gitweb.cgi file that git-instaweb puts into $GIT_DIR/gitweb/gitwe=
b.cgi
> is *modified* to browse given git repository; the gitweb_cgi() functi=
on
> in git-instaweb that creates gitweb.cgi also changes $projectroot in =
it:
>
> =A0script=3D'
> =A0s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D "'$(dirname "=
$fqgitdir")'";#;
> =A0s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
> =A0s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectr=
oot;#;
> =A0s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/t=
mp'";#;'
>
> =A0gitweb_cgi () {
> =A0 =A0 =A0 =A0cat > "$1.tmp" <<\EOFGITWEB
> =A0@@GITWEB_CGI@@
> =A0EOFGITWEB
> =A0 =A0 =A0 =A0# Use the configured full path to perl to match the ge=
nerated
> =A0 =A0 =A0 =A0# scripts' 'hashpling' line
> =A0 =A0 =A0 =A0"$PERL" -p -e "$script" "$1.tmp" =A0> "$1" # <------ '=
-e "$script"'
> =A0 =A0 =A0 =A0chmod +x "$1"
> =A0 =A0 =A0 =A0rm -f "$1.tmp"
> =A0}
>
> So in its current for git-instaweb wouldn't be able to use generic
> gitweb.cgi that is installed in "$(sharedir)/gitweb".
>
> Also git-instaweb when run (when starting server) puts appropriate
> configuration into $GIT_DIR/gitweb/httpd.conf (the same file for any =
web
> server chosen). =A0This configuration includes paths to static files =
that
> gitweb requires, and that currently git-instaweb puts (installs) in
> $GIT_DIR/gitweb (in $fqgitdir). =A0So you would need to change that f=
or a
> full solution of git-instaweb problem.
>
> The solution to modifying gitweb.cgi in git-instaweb could be for
> git-instaweb to put (install) appropriately configured
> gitweb_config.perl file into $GIT_DIR/gitweb, and set GITWEB_CONFIG (=
and
> export) environmental variable to it inside git-instaweb.
>

As we discussed earlier, I will be making use of git-instaweb script
and gitweb to create a local server for user which takes a file list
of repositories and provide client UI for them. According to this, the
user needs to execute 'git instaweb' only once, not in every
repository.

The next patch will take care of modifying git-instaweb.sh and
configuring gitweb.perl

> By the way, perhaps in the future split gitweb should install its
> subpackages (the *.pm files) in the same place that Git.pm is install=
ed,
> and for gitweb.perl to have
>
> =A0use lib (split(/:/, $ENV{GITPERLLIB}));
>
> Or not. =A0Food for though.
>
>> ---
>>
>> This is necessary step to achieve the goals of my GSoC project.
>> Currently instaweb script creates gitweb.* files in every repository
>> which is unnecessary. So if we have global folder for gitweb files w=
e
>> can configure the instaweb server root to point to that direction.
>
> *Can* configure, but you actually doesn't do this.
>
>>
>> =A0Makefile | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index de7f680..0b262a9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -269,6 +269,7 @@ mandir =3D share/man
>> =A0infodir =3D share/info
>> =A0gitexecdir =3D libexec/git-core
>> =A0sharedir =3D $(prefix)/share
>> +gitwebdir =3D $(sharedir)/gitweb
>
> Why in Makefile, and not in gitweb/Makefile?
>
>> =A0template_dir =3D share/git-core/templates
>> =A0htmldir =3D share/doc/git-doc
>> =A0ifeq ($(prefix),/usr)
>> @@ -1971,6 +1972,7 @@ install: all
>> =A0 =A0 =A0 $(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
>> =A0ifndef NO_PERL
>> =A0 =A0 =A0 $(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DES=
TDIR_SQ)' install
>> + =A0 =A0 $(MAKE) -C gitweb gitwebdir=3D$(gitwebdir) install
>
> First, I think that gitwebdir=3D$(gitwebdir) is not necessary here. M=
ake
> automatically passes variables to invoked submakes. And then it would=
 be
> as easy as adding 'install-gitweb' (or new 'install-git-instaweb') as
> additional dependency for 'install' target.

So, you want to me to do something like this ?
+ =A0 =A0 $(MAKE) -c gitweb gitwebdir=3D$(sharedir)/gitweb install

> Second, why don't you set default value of 'gitwebdir' in gitweb/Make=
file
> instead?

It's explained above.
I don't want the user to install gitweb specifically, from now onwards
gitweb will installed along with main program so that git-instaweb
script will be working properly and the users will be happy to get a
web client along with git.

> The above are questions that needs to be answered, but not necessaril=
y
> require changes to patch.
>
>
> Please also note that if user wants to install gitweb in for example
> '/var/www/cgi-bin', and to do that sets "gitwebdir=3D/var/www/cgi-bin=
" in
> config.mak file, so that it would be present for "make install" (and =
not
> only "make install-gitweb"), gitweb files would be not present in
> "$(sharedir)/gitweb" for git-instaweb to find (well, unless git-insta=
web
> search for them in "$(gitwebdir)" instead...).

User need to specify instaweb.root in config file to point to the
gitweb files which defaults to /usr/share/gitweb
This is covered in my next patch.

> Most important of all, without changes to git-instaweb.sh and
> git-instaweb target in main Makefile, installing gitweb by default, b=
e
> it
>
> =A0install: all install-gitweb
>
> or
>
> =A0 =A0 =A0 =A0$(MAKE) -C gitweb gitwebdir=3D"$(sharedir)/gitweb" ins=
tall
>
> doesn't make absoultely no sense.

Yes, it doesn't make sense. But petr and christian asked me to send my
patches as small as possible without breaking any of the current
functionalities. That is the reason I sent this.

I need to complete my GSoC, so you can be sure that every patch of
mine has a reason.

> NAK to this part of patch.
>

Just rethink about this or you can wait until my next patch :-)

Thanks
- Pavan
