From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: HOWTO set up a repository which can be pushed into over HTTP
Date: Wed, 9 Aug 2006 21:31:18 +0200
Organization: M38c
Message-ID: <20060809193118.GC7841@nospam.com>
References: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de> <7vac6kjoxh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5bd6ku8.fsf@assigned-by-dhcp.cox.net> <20060808190220.GA6001@nospam.com> <Pine.LNX.4.63.0608090049480.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@wingding.demon.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 21:31:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAtmB-0008V6-1x
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWHITbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Aug 2006 15:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHITbX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:31:23 -0400
Received: from post-24.mail.nl.demon.net ([194.159.73.194]:5590 "EHLO
	post-24.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751295AbWHITbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:31:22 -0400
Received: from wingding.demon.nl ([82.161.27.36]:36765)
	by post-24.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GAtlw-0007w1-D7; Wed, 09 Aug 2006 19:31:20 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GAtlu-00025s-F7; Wed, 09 Aug 2006 21:31:18 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608090049480.1800@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25137>

> > Today I did try to follow it, and it made an otherwise impossible j=
ob
> > for me doable, although still taking too much hours and a patch. Th=
e
> > 'impossible job' for me had to do with my zero-apache experience an=
d
> > (probably) a bug in WebDAV.
>=20
> Thank you for doing that valuable work! I think the patch is fine (ta=
ke=20
> that as an Acked-by:); next time you might want to send it as a prope=
r=20
> patch mail ;-)

Ok, I send it out. Don't know if I did it proper...


> > -This text assumes that you
> > -
> > -- have an Apache webserver,
> > -- can edit the configuration of it,
> > -- can restart it, and
> > +
> > +What's needed:
> > +
> > +- Have an Apache webserver
> > +
> > +  On Debian:
> > +    $ apt-get install apache2
> > +    To get apache2 by default started,
> > +    edit /etc/default/apache2 and set NO_START=3D0
> > +
> > +- can edit the configuration of it
> > +
> > +  On Debian: this means being able to edit files under /etc/apache=
2
>=20
> On some other setups, it is /etc/httpd/. Since it is not specific to=20
> Debian, we might want to give some common options, but refer the user=
 to=20
> the Apache manual if she cannot find it.

Ok, but I find it always very convenient when someone describes the
situation for _me_. So if other distro's would join in, I would be
delighted. And indeed a general fallback to the Apache documentation
would be good for all distro's (+ homegrown) not covered.

However, Debian already differs quite some from the defaults. I wrote
this addendum to the documentation _because_ it costed me quite some
time since Debian tries to be different.

Debian seperates as much as possible into different files and
directories to be able to easily install and deinstall modules with
the package manager. And it has scripts to manage those directories.

> > +
> > +- can restart it.
> > +  'apachectl --graceful' might do.
>=20
> It is =C3'apachectl graceful' here (without'--').
>=20
> > +  On Debian:
> > +    $ /etc/init.d/apache2 restart
>=20
> This should work everywhere, except it might be called apache or http=
d=20
> instead. However, please warn users that this interrupts (however bri=
efly)=20
> a running webserver, and if you do that on a production machine, user=
s=20
> just downloading an iso file might be rightfully upset.

If you're on a production machine with a webserver already in
production, you're probably not using this tutorial (I hope).

If you're downloading a large iso, recent browsers have 'resume'
buttons. The internet has never been very reliable.

If you're on Debian, '/etc/init.d/apache2 restart' is the same as
'/etc/init.d/apache2 force-reload', so no interruptions.

=2E..but warning is always good :)


> > +  On Debian:
> > +
> > +    $ cd /var/www
> > +    $ mkdir my-new-repo.git
>=20
> Again, it might be cooler to be a bit more portable: if the user foun=
d=20
> httpd.config, he could just "grep DocumentRoot /where/ever/httpd.conf=
".

Nope. On Debian, httpd.conf is a placeholder which does not contain
anything expect for:

# This is here for backwards compatability reasons and to support
#  installing 3rd party modules directly via apxs2, rather than
#  through the /etc/apache2/mods-{available,enabled} mechanism.
#
#LoadModule mod_placeholder /usr/lib/apache2/modules/mod_placeholder.so

And the grep gives nothing. Doing a recursive grep gives:

/etc/apache2$ grep -r DocumentRoot *=20
sites-available/default:        DocumentRoot /var/www
sites-enabled/000-default:      DocumentRoot /var/www

=2E..where sites-enabled is a link to sites-available.


> >  Change the ownership to your webserver's credentials
> > +=20
> > +    $ chown -R www.www .
> > +
> > +  On Debian:
> > +
> > +    $ chown -R www-data.www-data .
>=20
> Again, a better way would be to direct the user to "grep ^User httpd.=
conf"=20
> and "grep ^Group httpd.conf".

Both come up empty on Debian. The uid + gid appear to be in apache2.con=
f :

/etc/apache2$ grep ^User *        =20
apache2.conf:User www-data


> > +  DAVLockDB "/usr/local/apache2/temp/DAV.lock"
> > +
> > +  On Debian:
> > =20
> > -	DAVLockDB "/usr/local/apache2/temp/DAV.lock"
> > +    Enable the dav and dav_fs modules of apache:
> > +    $ a2enmod dav_fs
> > +    $ a2enmod dav
> > +    The DAV lock is located in /etc/apache2/mods-available/dav_fs.=
conf:
> > +      DAVLockDB /var/lock/apache2/DAVLock
>=20
> I did not find a2enmod on my only Debian setup, so a more portable wa=
y=20
> would be to tell the user to insert the following lines in httpd.conf=
:
>=20
> 	LoadModule dav_module libexec/httpd/libdav.so
> 	AddModule mod_dav.c

No, a2enmod is the recommended way to enable modules. It adds symlinks
from the /etc/apache2/mods-enabled to /etc/apache2/mods-available.

I got those from http://www.debian-administration.org/articles/285

> (I do not know if there are setups where you have to load dav_fs=20
> explicitely...)

According to http://www.debian-administration.org/articles/285, I had
to. Didn't check it myself, though.

> > +  On Debian:
> > +    Create (or add to) /etc/apache2/conf.d/git.conf :
>=20
> Is this picked up automatically?

Yup. From /etc/apache2/README:

=2E..
conf.d/

        Files in this directory are included by this line in
        apache2.conf:

        # Include generic snippets of statements
        Include /etc/apache2/conf.d

        This is a good place to add additional configuration
        directives.

httpd.conf

        Empty file.
=2E..



> > +    <Location /my-new-repo.git>
> > +       DAV on
> > +       AuthType Basic
> > +       AuthName "Git"
> > +       AuthUserFile /etc/apache2/passwd.git
> > +       Require valid-user
> > +    </Location>
>=20
> We should not violate the DRY principle ("Don=C2=B4'Repeat Yourself")=
=2E

Ok, a merge could be done, but AuthUserFile is different.
Something like
    +       AuthUserFile <passwd-file>
then.

> > +On Debian:
> > +
> > +   To test the WebDAV part, do:
> > +
> > +   $ apt-get install litmus
> > +   $ litmus http://<servername>/my-new-repo.git <username> <passwo=
rd>
>=20
> There has to be a more portable way to test WebDAV, like an URL to ty=
pe=20
> into a webbrowser. DAV wizards, anyone?

The renaming bug I found by using Windows Internet Explorer -> Open Loc=
ation ->
http://<servername>/my-new-repo.git [x] Open as webfolder -> login,
and copy a file to it, rename it, ...

Another interactive tool is cadaver (see
http://www.debian-administration.org/articles/285 again).

With FUSE + fusedav you can mount a WebDAV like a normal filesystem
(which is cool ;)

> > -Then, add the following to your .netrc (you can do without, but wi=
ll be
> > +Then, add the following to your ~/.netrc (you can do without, but =
will be
>=20
> Okay, I thought it was common knowledge where this resides. Although =
I=20
> would say $HOME/.netrc instead.

Ok.

> > +    On Windows, use %HOMEDRIVE%%HOMEPATH%.netrc instead.
>=20
> Huh? You want to access it with something else than cygwin?

You're right, Cygwin should have $HOME set.

> > +To check whether all is OK, do:
> > +
> > +   curl --netrc --location -v http://<username>@<servername>/my-ne=
w-repo.git/
> > +
> > +...this should give a directory listing in HTML of /var/www/my-new=
-repo.git .
>=20
> Does everybody who has libcurl installed, have curl installed also?

Don't know, but I think most people who have apache2 installed have
better things to worry about :) Might want to add the dependancy
explicitly in the document, yes.

> > -	$ git-http-push upload master
> > +   $ git push upload master
> > +
> > +This pushes branch 'master' (which is assumed to be the branch you
> > +want to export) to repository called 'upload', which we previously
> > +defined with git-repo-config.
> > =20
> > -(This assumes that the branch you want to export is called 'master=
' in your
> > -client setup...)
>=20
> Your wording is much clearer.

It took me a while to figure out, I (incorrectly) assumed 'upload' was
the name of the remote branch. And git-http-push didn't work at once,
so I got it working with some extra options before I realised it
should be 'git push' instead.


> >  request; This can happen when you start Apache, but then disable t=
he
> >  network interface. A simple restart of Apache helps.
> > =20
> > -In other cases, reading /usr/local/apache2/logs/error_log is often=
 helpful.
> > -
> > +Errors like (22/502) are of format (curl error code/http error
> > +code). So (22/404) means something like 'not found' at the server.
>=20
> I think the error log is more useful than the http error codes.

You deleted those two lines (look at the version I sent), so jut put
them back :)


Do you want to finish it, or should I do a reedit?

Regards,
Rutger.

--=20
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
