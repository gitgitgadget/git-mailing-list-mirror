From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 13:48:47 +0200
Message-ID: <201004241348.49397.jnareb@gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <m3633hdw9u.fsf_-_@localhost.localdomain> <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 13:49:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5drB-0002ol-Oz
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 13:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab0DXLtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 07:49:01 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37529 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab0DXLtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 07:49:00 -0400
Received: by bwz19 with SMTP id 19so218904bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yz2JN5S+ovSrIivYKLMD/moQncobztC9Y0NEyhs5cWU=;
        b=M2wEQMZLfAJ9RtDtKNIqD5F2DzSaXocpYhhXtDlmYrqVFfKr39DL81v4/1rKFdyLgY
         jGPCiXY+VqwcbuYoCOuNajdIczNufd4Rpt1LjufPXttqN1Z3NF33Z2tegm3ejJ6rnGGz
         18ms55IvGruyjXvKIujDLnw0F+hDjmcXMcfYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=q11YErsi8NGbfD6v89tly3gwcwL+fxE5SoFxoEz0ewENJW/NcJ2r1czhAX8b56usee
         InVYbN5qhat6Hyu9jsflHYLPdIJmW6oIuFmA9S3n6QcaNsvNLtejhC0VxR5eg8BBSYbD
         c0KwdCqB2o7b4+j1atm5AVYzlinC4XQ9F7lUs=
Received: by 10.204.19.141 with SMTP id a13mr830392bkb.107.1272109738300;
        Sat, 24 Apr 2010 04:48:58 -0700 (PDT)
Received: from [192.168.1.13] (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id 15sm813436bwz.4.2010.04.24.04.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 04:48:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145667>

Dnia sobota 24. kwietnia 2010 13:10, Wincent Colaiuta napisa=B3:
> El 24/04/2010, a las 11:40, Jakub Narebski escribi=F3:
>=20
> > It's a pity that people didn't concentrate on this part: improving
> > error message...
> >=20
> >=20
> > On a bit unrelated note what I'd like to have is 'git commit -a'
> > (optional) safety against accidentally getting rid of staged
> > changes.=20
> >=20
> > I'd like for 'git commit -a' to *fail* if there are staged changes =
for
> > tracked files, excluding added, removed and renamed files.  If you
> > have some staged changes you would get an error message:
> >=20
> >  $ git add tracked-file
> >  $ git commit -a
> >  fatal: There are staged changes to tracked files
> >  hint: To commit staged changes, use 'git commit'
> >  hint: To commit all changes, use 'git commit -f -a'=20
> >=20
> > Perhaps this behavior would be turned on only if some config option=
,
> > like commit.preserveIndex or something like that is set to true...
>=20
> For me this is going to far. While we don't want to make it _easy_ fo=
r
> users to shoot themselves in the foot, neither do we want to make it
> difficult or impossible for them to get the tool to do things that
> _might_ be a mistake. And what's the risk here? Accidentally
> committing too much is not a destructive change, and can be easily
> undone.

What you cant recover by undoing commit is the state of index before
accidental 'git commit -a' instead of 'git commit'.

>=20
> Where do we stop here with the hand-holding? Would you also want
> a fatal error here?:=20
>=20
>   $ git add foo
    $ edit foo    # without this safety would not trigger for "git comm=
it -a"
>   $ git commit bar
>   fatal: There are staged changes to tracked files

No, I wouldn't.  First, there is much less chance of mistake here, IMHO=
,
and second you don't loose staged changes to 'foo' here.

>=20
> IMO, the fact that the commit message editor is populated with a list
> of changed files that will be included in the commit is enough for
> people to see what's actually going to happen. =20

Note that in original post there was patch restructuring a bit this inf=
o,
for relevant information to be more visible.

--=20
Jakub Narebski
Poland
