From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Fri, 23 Sep 2011 11:59:22 -0700 (PDT)
Message-ID: <m3ehz7qe5a.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
	<m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AyA-0004L2-8t
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab1IWS7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 14:59:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38929 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab1IWS7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 14:59:24 -0400
Received: by fxe4 with SMTP id 4so4095501fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=OrjMbQR89hQiBIWTiekCNPlreW1yn19WRZWf/kf8mwo=;
        b=ovEJULoRZOsO8bYIlb5Tki1vEVfrZa+XI13VX0s+yds0uubV7+DKe+WzAGalZB/cTH
         lQFeXR/UTno/Ll9PfcIgNmexOBG94By9fWAGPWLuD9fgsGnOOeVHI6WtOQDx3ZSDHfoi
         o+czvpI5JiwD2EauXDrolCZjj6thGLBjHzVjI=
Received: by 10.223.9.129 with SMTP id l1mr5486899fal.36.1316804363627;
        Fri, 23 Sep 2011 11:59:23 -0700 (PDT)
Received: from localhost.localdomain (abvk31.neoplus.adsl.tpnet.pl. [83.8.208.31])
        by mx.google.com with ESMTPS id l8sm11984525fai.16.2011.09.23.11.59.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 11:59:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8NIwqbQ027393;
	Fri, 23 Sep 2011 20:59:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8NIwfEl027389;
	Fri, 23 Sep 2011 20:58:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E7CCCA0.50909@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181989>

BTW it is customary on git mailing list to send reply not only to git
mailing list, but also to all responders (to previous author, cc to
list and to others).

Jon Forrest <nobozo@gmail.com> writes:
> On 9/23/2011 10:42 AM, Jakub Narebski wrote:
>> Jon Forrest <nobozo@gmail.com> writes:
=20
>>> Does this include both changes that Alice has checked in to
>>> her repository and uncommitted changes in her working tree?
>>
>> Generally Alice shouldn't have uncommitted changes when doing
>> "git pull".
>=20
> That's what the tutorial said but I'm trying to understand
> what happens if she does have uncommitted changes. I'm
> trying to understand the total picture.

If Alice have uncommitted changes, in working tree and/or in the
index, what git does is try to merge if possible; if conflict or new
versions from "theirs" touch changed file, git refuses to do a merge.
=20
The idea is to do merge if possible, but abort if there is any chance
that user's changes would be lost.

>> When there is a merge conflicts, the index gets populated by more th=
an
>> one version: "ours" (i.e. Alice version) in stage 2, "theirs"
>> (i.e. Bob version) in stage 3, and "base" (common ancestor version) =
in
>> stage 1.  The stage 0, where "git add" / "git stage" puts contents o=
f
>> file, is empty.
>=20
> I didn't know there were multiple staging areas.

Those are called "stages" inside one single staging area (the index).
=20
>> You can see it using "git ls-files --abbrev --stage".
>=20
> That's very helpful.

Also in the case of conflict, "git diff" would show combined diff of
changes.

Try both on some example.

--=20
Jakub Nar=EAbski
