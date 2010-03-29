From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 14:18:32 -0500
Message-ID: <20100329191832.GA26842@progeny.tock>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 21:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwKTw-0006R3-UA
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 21:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0C2TSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 15:18:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50568 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0C2TSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 15:18:34 -0400
Received: by gyg13 with SMTP id 13so1650209gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f6pdkCvPUnPlnSX5OC6VhrsqYEbqQi+uLVW5wq0KGgM=;
        b=bW0H5U/udnKXiwjZVD/h4EqBTnVvADHOark+Et3labzmOxzzyoqgBr92bVlAQ0xVX9
         SygweDR7qJe4O+fOsLjKXnamt+X4MJhj7Ogl+41y4G53pg92Z5eg7kspmT7eIYdHx7MN
         C8dpiScP/NIKCoN3dpLJkludRDEq5BV6P5Cjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NglUAnabL6IgJLpusr1VfoXAvYysuP1xhdDtDEtO9+uThVsIUNA3JLGlGIOHmh0wo+
         Dxs85W1CFWc3fPL60Q8a25EvbRBb+W5VLpozRgGLQeGcLrbxwe+ru7I5FZ/yq+Z7KWFQ
         ukLHfRIRsK3x27Zcqk6uDhGW3PLsh2KFy1tyE=
Received: by 10.143.85.8 with SMTP id n8mr76721wfl.276.1269890312906;
        Mon, 29 Mar 2010 12:18:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x35sm648436wfh.6.2010.03.29.12.18.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 12:18:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143508>

Ramkumar Ramachandra wrote:

>  I'm not entirely happy with it because the remote vcs setting doesn'=
t
>  quite fit here. Plus, it seems like a dirty hack to me. The name doe=
sn't do
>  justice: giturl exists to host Ilari's remote helper notes.

I suppose you are right.  I was imagining something like this:

 NAME
 ----
 giturl - Specifying remote repositories to Git

 SYNOPSIS
 --------
 <transport>://<rest-of-URL>, <host>:<path>, <transport>::<address>, <n=
ickname>

 DESCRIPTION
 -----------
 To specify a remote repository using Git=E2=80=99s native protocol, on=
e can
 use a traditional-looking URL.

 . git://host.xz[:port]/path/to/repo.git/
 . git://host.xz[:port]/~user/path/to/repo.git/

 For the SSH protocol, often used with 'git push', use the traditional =
syntax
 supported by 'scp'.  You can optionally specify which user to log in a=
s.

 . [user@]host.xz:/path/to/repo.git/
 . [user@]host.xz:path/to/repo.git/

 That syntax does not allow specifying a port number. For this, a more
 verbose URL-style syntax is supported.

 . ssh://[user@]host.xz[:port]/path/to/repo.git/
 . ssh://[user@]host.xz[:port]/~[otheruser]/path/to/repo.git/

 Frequently-accessed repositories can be given a short alphanumeric
 nickname.  For example, the 'parent repository' for a new clone is
 automatically given the nickname 'origin'.  See linkgit:git-remote[1] =
for
 details.

 . nickname

 A path on the current machine can be used directly.  If a repository i=
s
 specified in this way to the linkgit:git-clone[1] command, the clone w=
ill
 automatically use the --local option (which see).  The file:// syntax
 can be used to avoid this behavior.

 . /path/to/repo.git/
 . path/to/repo.git/

 Other protocols (most notably HTTP) can be specified with the
 schema://path syntax.  Support for the 'rsync', 'file', 'git', 'ssh',
 'git+ssh', and 'ssh+git' transports is built in.

 If Git was installed with HTTP support, then the 'http', 'https',
 'ftp', and 'ftps' schemata will be supported through helper programs.
 Third-party helpers may support other protocols, for example for
 interaction with other version control systems.  The syntax
 `transport::schema://path` can be used, or `transport://path` if
 the helper is already named after a URL schema.  The
 'git remote-<transport>' helper will be used to service the request,
 with `schema://path` passed as the associated URL.
 See also linkgit:git-remote-helpers[7].

 . http[s]://[user@]host.xz[:port]/[~user/]path/to/repo.git/
 . ftp[s]://[user@]host.xz[:port]/[~user/]path/to/repo.git/
 . file:///path/to/repo.git/
 . rsync://[user@]host.xz[:port]/path/to/repo.git/
 . http::http://[user@]host.xz[:port]/[~user/]path/to/repo.git/
 . etc

git-remote(1) would include the information currently in remote-urls.tx=
t
about remote nicknames, plus:

 - how to specify a relevant vcs helper
 - the pushurl setting

Pages such as git-clone(1) that currently include urls.txt or
remote-urls.txt could have the remote section replaced with something
shorter:

 See giturls(7) for an explanation of the supported values for <reposit=
ory>
 (git://host.xz/path, http://host.xz/path, and so on).

But this is more major surgery than the purpose of your patch calls
for.  If you find a simpler way to convey the relevant information in
the meantime, I can prepare a patch this weekend.

Thanks,
Jonathan
