From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: New User Question
Date: Mon, 17 Jun 2013 19:07:53 +0200
Message-ID: <20130617170753.GD25488@paksenarrion.iveqy.com>
References: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joel McGahen <vin4bacchus@me.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uocr2-0005XR-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab3FQRE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 13:04:28 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:61735 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3FQRE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:04:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so2761659lbi.11
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AlT/LUhKlxNw8NvQFwodasqjJeiH2/rsH1eF6VKst74=;
        b=WO0TvOe6FeR5dvcFd+IeZ/mMN/MwcXRzbZjFomwWNoFwX/ujmeZ4sDnFAwJejMz1C0
         gHPV8eIS/ys0LInF4tMVvsF2IwFcvE/UcG/bEkVpMmQQt2OqPpAgEWqsEXwHlsVE1LkK
         brtof2hW0jtBZC2Xwrb0fYXF597Vdr/4LqXnW2hbz16epaTy1kmxU+lCSbysWlUVKoNe
         JSMkGI+RYtVtBT0v9F4wfqdpj9L3qIVdYJvAsCY9Z0abjIXn5tz4aJIIDHg0RnRWjXPp
         SjG2LrqNXyQmLdlKj5RniVXsoHcxbL0pqH1Rd96rv2mg3X2p3gY8aONEyOHip6wIe8Ui
         +BLQ==
X-Received: by 10.112.89.226 with SMTP id br2mr6716864lbb.12.1371488666328;
        Mon, 17 Jun 2013 10:04:26 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p20sm5740599lbb.17.2013.06.17.10.04.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 10:04:25 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UocuH-0004TJ-Mu; Mon, 17 Jun 2013 19:07:53 +0200
Content-Disposition: inline
In-Reply-To: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228085>

On Mon, Jun 17, 2013 at 11:39:44AM -0400, Joel McGahen wrote:
> I have a question about GIT remote repos. Here is my scenario.
>=20
> 1. Work client has a repo (origin, branch of master).
> 2. Due to contractual issues I need to host a remote copy of this rep=
o that my developers can utilize while we get the contractual issues re=
solved as development must continue.=20
> 3. I have a virtual machine from the client which already has a remot=
e of origin setup.=20
> 4. I have created a bare repo on a server my developer's have access =
to.=20
> 5. I have added that remote to my copy of the client VM local repo an=
d pushed its contents to my newly created bare repo.
>=20
> What I need to understand is how to
> a) Connect my developer's VM local repos to the new remote repo I cre=
ated so they can continue to work.
> b) Once the contractual issues are resolved reconnect the developer's=
 local repos back to the original orgin/master repo and merge all their=
 changes.
>=20
> I'm fairly new to GIT but have worked with version control for a long=
 time (CVS, PVCS, Subversion etc).
>=20
> Any help would be greatly appreciated!

Hi!
The short answer is: git remote add (and git help remote for
details). It's also possible to manally edit .git/config if it's
basically just a adress change you're doing.

The long answer is harder. You've experience with centralized systems.
Remember that git is decentralized. Every developer you've is a fully
functional unit on his own. All you need is a way for the developers to
interact with eachothers. It can be done via e-mail, or with them
pulling from eachother directly or as you've done, with one central
repository that everyone sync to.

The questions you've is rather fundamental to git. I tells me that you
do not fully utilize the strengths of git. I suggest reading the
progit book.

Good luck!

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
