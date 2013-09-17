From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Locking files / git
Date: Tue, 17 Sep 2013 23:36:19 +0200
Message-ID: <20130917213619.GM28675@paksenarrion.iveqy.com>
References: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:29:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM2pq-0005o0-WE
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab3IQV3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 17:29:23 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35947 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab3IQV3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:29:22 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so5744391lbi.25
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5gxoQeLoO9NhWJD5MeszbRFqI5a0QSJVGz4G3FaUlKA=;
        b=DXI80qT4wvh2Sp7ZO1lLn7Tg4613MAlmRfMT6vWdhVz5Aq09qkiWAJMWUjsX8AlJiO
         2u86kuuh+u51ROOeKNYIORTyKfnWazdts35OJckQDEaW8dKN6PYxG3PoTnRLJa+dkz0k
         wH5Js/MixtNkCT2SZeRaqBxZC+Dj8lUHSBQ8XYLT9DE5EV16Sls581eG1XCrdj3CBIm/
         DTp5n1my2S6GGKQ8YWn5hRKfff6BFc+tvUO5iJm778jJskB5/bzyx2WaqyrwLPeu96Df
         IdjtwihHxnzlcg+gTNfvvaGQj/KVSjkei5naJsoRY4nDw8Hu8DmxMDtd1PTviZAFPxZ/
         FmVQ==
X-Received: by 10.112.60.104 with SMTP id g8mr3368303lbr.32.1379453361316;
        Tue, 17 Sep 2013 14:29:21 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id k6sm15429578lae.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 14:29:20 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VM2wV-0004HQ-8f; Tue, 17 Sep 2013 23:36:19 +0200
Content-Disposition: inline
In-Reply-To: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234932>

On Tue, Sep 17, 2013 at 09:45:26PM +0200, Nicolas Adenis-Lamarre wrote:
> Ooops. It seems that each time somebody says these two words together=
,
> people hate him, and he is scorned by friends and family.
>=20
> For the moment, i want a first feedback, an intermediate between
> "locking is bad" and "ok", but i would prefer in the negativ answer
> something with arguments ("Take CVS as an example of what not to do;
> if in doubt, make the exact opposite decision." is one), and in the
> positiv answer, good remarks about problems with my implementation
> that could make it better.

So working with locks and text-files is generally stupid to do with git
since you don't use git merging capabilities. Working with binary files
in git is stupid because git doesn't handle them very well because they
the deltas can't be calculated very good.

It seems to me that if you need to do locking one of the above scenario=
s
is true for you and you should not use git at all.

However, there's always the case when you've a mixed project with both
binary and text-files. In that case I believe Jeff gave an excellent an=
swer.

But think twice, are you using git in a sane way? Even a small binary
file will result in a huge git repo if it's updated often and the
project has a long history.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
