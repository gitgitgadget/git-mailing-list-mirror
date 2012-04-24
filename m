From: =?ISO-8859-2?Q?Jos=E9_Mar=EDa_Escart=EDn_Esteban?= 
	<ripero84@gmail.com>
Subject: Re: Static gitweb content when using pathinfo
Date: Tue, 24 Apr 2012 09:01:46 +0200
Message-ID: <4F964FDA.6030807@gmail.com>
References: <4F7DA413.2020502@gmail.com> <201204141919.19285.jnareb@gmail.com> <4F8C384C.2040109@gmail.com> <201204171430.52650.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:02:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMZlA-0001ca-0n
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab2DXHBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 03:01:55 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41148 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab2DXHBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:01:53 -0400
Received: by wgbdr13 with SMTP id dr13so350707wgb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=fhZ7lzLLCWoP6jcAm+gahDEL/CT6YBiRLlM5IdSJgY0=;
        b=gd0364D9qM8xF3WsQvFkcm7kgfyltYzEHZpJksSZDeaSPWGb+0EVxeOB7hE+CY/ahw
         LQqdkoA2sMkvtcsR6MWjXHHh2EcWPN5CO6TGKiK490+akqfyHfcWeHCEh4vDtCDe/Qiy
         7PjluIh14gE1zrvmH1ZQoUnMvN3NkHK+/Xr/+/00CSlV4KCRp2eZWdsXArLI7Sbx0qsx
         0YrCtUmCAflkOmsmHnVCqrNrUr8PaCBS4IZG5mXQ2/1xVY/GigqdnNkrhO3jqJBbndB+
         /qYf93pMY74MRhhmZhS6gq6d3FUP8jQvpslOrvtKUjJFLvQpkoHI6RK4DI5cIWmgZI4t
         2cuA==
Received: by 10.216.145.27 with SMTP id o27mr5588428wej.5.1335250912132;
        Tue, 24 Apr 2012 00:01:52 -0700 (PDT)
Received: from [192.168.3.8] (AToulouse-552-1-150-58.w2-6.abo.wanadoo.fr. [2.6.77.58])
        by mx.google.com with ESMTPS id e6sm28081756wix.8.2012.04.24.00.01.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 00:01:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <201204171430.52650.jnareb@gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196191>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello again,

On 17/04/12 14:30, Jakub Narebski wrote:
> On Mon, 16 Apr 2012, Jos=E9 Mar=EDa Escart=EDn Esteban wrote:
>> On 14/04/12 19:19, Jakub Narebski wrote:
>>> On Thu, 5 Apr 2012, Jakub Narebski wrote:
>>>> On Thu, 5 Apr 2012, Jos=E9 Mar=EDa Escart=EDn Esteban wrote:
>=20
>>>> There might be problem if you configured your web server to serve
>>>> gitweb using it as a handler for subdirectory, so the script name
>>>> does not need to appear in URL, e.g.
>>>>=20
>>>> http://localhost/cgi-bin/gitweb
>>>>=20
>>>> which would require the following base element
>>>>=20
>>>> <base href=3D"http://localhost/cgi-bin/gitweb/" />
>>>=20
>>> [...]
>>>=20
>>=20
>> Yes, that was precisely the problem.
>=20
> Note that you won't have problem with `http://localhost` as base url=20
> (without any directory), or in more realistic case using virtual host=
=20
> rather than virtual directory.  The problem is that without '/' the p=
ath
> part of $base_url is stripped of last element.
>=20
> Just for completeness.
>=20

Right.

> [...]
>> This addition to the man page would of course have been useful, sinc=
e it
>> took me a while to detect that the problem was a missing slash in th=
e
>> base url. However, it would not have solved completely my problem, a=
nd
>> for me the best has been to add the line of code you proposed in the
>> previous email.
>=20
> So how about the proposed updated addition at the end of this email?
>=20

I think now it's more clear and explicit, and more useful for users not
familiar with Perl, so better.  Thank you!

>> I am running a Debian testing (wheezy) server, so the distro gitweb =
files
>> are:
>>=20
>> /etc/apache2/conf.d/gitweb /etc/gitweb.conf /usr/share/gitweb/gitweb=
=2Ecgi=20
>> /usr/share/gitweb/index.cgi -> /usr/share/gitweb/gitweb.cgi=20
>> /usr/share/gitweb/static/*
>>=20
>> I am using two sets of git repositories, and each of the sets works
>> through a particular gitolite user:
>>=20
>> user     home ---------------------- git      /srv/project mygit
>> /srv/mygit
>>=20
>> I wanted that different groups of people were able to browse the
>> 'project' repos (in fact it is a mirror from the main project server=
)
>> from http://server.example.com/project/ , and the 'mygit' repos from=
=20
>> http://server.example.com/mygit/ . And I wanted to keep urls as shor=
t and
>> easy as possible, and to avoid proliferation of configs as much as
>> possible.
>=20
> I think that is this "two sets" that created configuration with a pro=
blem.
>=20
>> The setup I came up with was to link
>>=20
>> /srv/www/project -> /usr/share/gitweb /srv/www/mygit ->
>> /usr/share/gitweb
>>=20
>> and to use the following configuration files:
>>=20
>> ######### /etc/apache2/conf.d/gitweb ################## <Directory
>> /srv/www/project> SetEnv  GITWEB_PROJECTROOT      /srv/git/ SetEnv
>> GITWEB_CONFIG           /etc/gitweb.conf
> [...]
>> #######################################################
>>=20
>> ######### /etc/gitweb.conf ############################ $projectroot=
 =3D
>> $ENV{'GITWEB_PROJECTROOT'}."repositories"; $git_temp =3D "/tmp";=20
>> $projects_list =3D $ENV{'GITWEB_PROJECTROOT'}."projects.list"; @diff=
_opts =3D
>> (); $feature{'pathinfo'}{'default'} =3D [1];=20
>> $feature{'highlight'}{'default'} =3D [1]; $projects_list_description=
_width
>> =3D 50; #######################################################
>=20
> A question: why not have
>=20
> SetEnv  GITWEB_PROJECTROOT      /srv/git
>=20
> and use
>=20
> $projectroot =3D "$ENV{'GITWEB_PROJECTROOT'}/repositories"; $projects=
_list =3D
> "$ENV{'GITWEB_PROJECTROOT'}/projects.list";
>=20

Aren't both configurations equivalent? (just moving a slash to one side=
 or the
other of the definitions)

>=20
> BTW. what is this $git_temp?  Is it modified gitweb, because core one=
=20
> doesn't need to use temporary directory for anything nowadays?
>=20

That option is enabled by default in all the Debian shipped /etc/gitweb=
=2Econf.
 It was like this the first time I installed the package from the Debia=
n
repos, and it is still like this in the last version of the package in =
the
repos, gitweb_1.7.10-1_all.deb.  I didn't know it was any sort of modif=
ied
gitweb, the script is in git_1.7.10-1_all.deb (yes, they make a separat=
e
package for gitweb but the script is in the git one), and the only diff=
erences
to the v1.7.10 upstream source seem to be installation variables/flags.

> A tip: you can use GITWEB_CONFIG_COMMON for the common part of=20
> configuration and separate GITWEB_CONFIG for per-instance configurati=
on.=20
> Though I am not sure if it would help in your case.  It requires mode=
rn
> gitweb. though.
>=20

I will check that, thanks again.

Greetings,

	E.

>> Probably there are better ways to implement this, but at least this =
seems
>> to work, once I have added
>>=20
>> $base_url .=3D '/' unless ($base_url =3D~ m!/$!);
>>=20
>> to /etc/gitweb.conf .
>=20
> -- >8 ---------- >8 -- Subject: [PATCH] gitweb.conf(5): When to set
> $base_url
>=20
> Add a paragraph to description of $base_url variable in gitweb.conf(5=
)=20
> manpage explaining when and why one might need to set it, and how.
>=20
> Based-on-report-by: Jos=E9 Mar=EDa Escart=EDn Esteban <ripero84@gmail=
=2Ecom>=20
> Signed-off-by: Jakub Nar=EAbski <jnareb@gmail.com> ---=20
> Documentation/gitweb.conf.txt |   24 ++++++++++++++++++++++++=20
> Documentation/gitweb.txt      |    4 ++++ 2 files changed, 28
> insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.con=
f.txt=20
> index 7aba497..4716a0f 100644 --- a/Documentation/gitweb.conf.txt +++
> b/Documentation/gitweb.conf.txt @@ -559,6 +559,30 @@ $base_url:: PATH=
_INFO.
> Usually gitweb sets its value correctly, and there is no need to set =
this
> variable, e.g. to $my_uri or "/". See `$per_request_config` if you ne=
ed to
> override it anyway. ++ +You would need to set this variable when usin=
g
> path_info-based URLs +while using gitweb as a directory handler (whic=
h
> means that full path +to browse repositories looks like
> `http://git.example.com/gitweb` +rather than looking like
> `http://git.example.com/gitweb/gitweb.cgi`). +You can find yourself i=
n this
> situation (gitweb as directory handler) +when configuring gitweb to u=
se
> FastCGI interface as shown in +"Webserver configuration" section on
> linkgit:gitweb[1] manpage. ++ +If static files are served from 'stati=
c'
> subdirectory of directory +the gitweb script is handler for, with def=
ault
> URLs of static files +(e.g. `$logo` is `static/git-logo.png`), then y=
ou
> would need to ensure +that `$base_url` ends with slash to denote that=
 it is
> directory, to +work correctly: ++=20
> +--------------------------------------------------------------------=
--=20
> +$base_url .=3D '/' unless ($base_url =3D~ m!/$!);=20
> +--------------------------------------------------------------------=
-- ++=20
> +For example if gitweb URL is `http://git.example.com/gitweb`, and +s=
tatic
> files are available in `http://git.example.com/gitweb/static/` +then
> `$base_url` must end up to be `http://git.example.com/gitweb/` +(with
> trailing slash) for e.g. `static/git-logo.png` relative link +to refe=
r to
> `http://git.example.com/gitweb/static/git-logo.png`.
>=20
>=20
> CONFIGURING GITWEB FEATURES diff --git a/Documentation/gitweb.txt
> b/Documentation/gitweb.txt index b394ecc..c3db66a 100644 ---
> a/Documentation/gitweb.txt +++ b/Documentation/gitweb.txt @@ -473,6 +=
473,10
> @@ With that configuration the full path to browse repositories would=
 be:
>=20
> http://server/gitweb
>=20
> +Note that for this configuration `$base_url` must be set as describe=
d +in
> linkgit:gitweb.conf[5] for gitweb to correctly serve static files +wi=
th
> path_info links. + As PSGI using plackup ~~~~~~~~~~~~~~~~~~~~~ Gitweb=
 can
> run as PSGI app (via emulation with *CGI::Emulate::PSGI*(3pm)).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+WT9YACgkQY+7weQMem3xchQCcCxsIOs7GOcluIb++KKweK76Y
TRcAnjauwtudLCc2qTwJd5D8FxwI34mC
=3DMbaI
-----END PGP SIGNATURE-----
