From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 13:11:37 +0200
Message-ID: <20131019111137.GT13967@paksenarrion.iveqy.com>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ain Valtin <ain.valtin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 13:12:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXUSK-0002PQ-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 13:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3JSLMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Oct 2013 07:12:17 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35182 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab3JSLMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 07:12:17 -0400
Received: by mail-lb0-f178.google.com with SMTP id o14so29801lbi.23
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YkrsB+Ijt7JYiZZZevz2TuTWPcvtcuqqhcY3nY5gP7I=;
        b=VaQAdRh+8aVxvsraHyiUKP+Cvj6/EvEWv65JsYCePyP2xub7VMlpIZtZOLBa59srEl
         yF4h0nPfQGW8quVOpwqc4+DDYEPj6YGZXwBbtz1K+4Qs/YBTQnKJfKR56+pemgHKeYjS
         1yJOxgx/6mHgrZNiY8Ep4qQCKhGSBoQ1TmJhNO42BTDdXLX2V/x9sr6TZkEvyRk1ZEmI
         3nsHF0j2HHJdv5iTtVWchI/EzFMX3MRNx5+BLdr9E98KJjlhwQOVwcO/jdCSxCxw/89t
         aFirSOcZ/iGtPMLG17J1JMsx+KanOb+4l7bex9z+Qi+gf9mU4DmYtKJIxl1NdiNnqIkL
         dd1Q==
X-Received: by 10.152.37.130 with SMTP id y2mr3430933laj.24.1382181135562;
        Sat, 19 Oct 2013 04:12:15 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id u18sm5010786lbp.4.2013.10.19.04.12.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 04:12:15 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VXURV-0005DU-3N; Sat, 19 Oct 2013 13:11:37 +0200
Content-Disposition: inline
In-Reply-To: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236396>

On Sat, Oct 19, 2013 at 11:49:27AM +0300, Ain Valtin wrote:
> Hi
>=20
> I want to use git in a VirtualBox guest so that the repository is on
> the host drive. So in the VB settings for the guest I set up a shared
> folder "gitRepos" to /home/ain with full access rights. Then in the
> guest OS (Windows XP) I map this shared folder as G drive. Now in the
> project dir I execute
>=20
> C:\...\TPP>git init --separate-git-dir g:/TPP
> Initialized empty Git repository in g:/TPP/
>=20
> Checked, the repo structure is in the "g:/TPP/" (thus the guest OS ca=
n
> write to the mapped dir) and in the .git file created to the project
> dir there is line
>=20
> gitdir: g:/TPP
>=20
> However when tring to use the repo it fails to recognise the g:/TPP p=
ath, ie
>=20
> C:\...\TPP>git add .
> fatal: unable to access '../../../../../../g:/TPP/config': Invalid ar=
gument
>=20
> Also tryed "gitdir: //VBOXSVR/gitRepos/TPP" but this fails too:
>=20
> C:\...\TPP>git add .
> fatal: Unable to create 'C:/Documents and
> Settings/Ain/prog/AVT/TPP/../../../../../..///VBOXSVR/gitRepos/TPP/in=
dex.lock':
> No such file or directory
>=20
> Am I doing something wrong or is it a bug? Any idea how to get it to =
work?
>=20
> BTW the VB is 3.0.14 ie rather old version but it seems that this
> isn't the problem as the git init recognises the mapped drive but
> other commands fail.
> git version is 1.8.4.msysgit.0
>=20
>=20
> TIA
> ain
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Git has a bad history with mapped drives in windows. It's also usually =
a
bad idea to use git over the network (and most mapped drives are over
the network and not local between virt. machines).

I would advise not to use this setup since for the past two years that
git has sometime worked and sometimes not with this setup. (It's not
just seperate git dir, a git dir at all over a smb share have been
problematic).

(This is probably something we should have in a test-suite somewhere.)

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
