From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn dcommit always uses my own name
Date: Tue, 15 Apr 2008 18:35:32 -0400
Message-ID: <32541b130804151535g56a8133dk863da833be87fb08@mail.gmail.com>
References: <32541b130804151425o6cf7646co541fb7cc85115606@mail.gmail.com>
	 <cac9e4380804151508p688bd7b7o1eb413b4133dad57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Richard Quirk" <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:36:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JltlE-0006Y8-7Z
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 00:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbYDOWff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 18:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbYDOWff
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 18:35:35 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:13104 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYDOWfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 18:35:34 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2438241fkr.5
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sPg2a0PhaOeM8oA6+6yIAd4EI+IZuN4VAS+sdPBQ/Rc=;
        b=GgFpRxbSq1MNPg+Qlesr14P6uDzpUNS3jt4jWuy8/CYRtzlSsnkf1Aio3bJK4h51wUPNj2rXeMLxBtte0J5yV7dCVa9o1knzQd185P1eUVTTRSupyBjI+T8/GtrWTSZcUCG2zoMzyb8Xddl+cSgQly42k8+PNcrCYeap1fzunkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x/qUr2FM4vFSouRQRnENWdI0gtq7PbpsoMtVXF4G9pnIX3ZxYdeXzjvu5zDUJNMo+1vPwUbN/XNZjG3KQTkE8u/jpmPKn1PqPzFZeyVlQy28B48toEBjsqFKm94ShcDxwctVYxc60MxhCM2TvqRs8EqzblJ8OXYFuKQT4fVa8sI=
Received: by 10.82.135.13 with SMTP id i13mr5676152bud.59.1208298932439;
        Tue, 15 Apr 2008 15:35:32 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Tue, 15 Apr 2008 15:35:32 -0700 (PDT)
In-Reply-To: <cac9e4380804151508p688bd7b7o1eb413b4133dad57@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79637>

On 4/15/08, Richard Quirk <richard.quirk@gmail.com> wrote:
> Subversion only remembers the user that made the commit; there's no
>  way to tell it that someone else wrote the patch and that you just
>  committed it. However, examining git-svn, there seems to be an
>  undocumented option. You can do this:
>
>  git svn dcommit --use-log-author
>
>  That uses the Signed-off-by: field in the commit message to extract
>  the author information. Of course it won't rescue the author field on
>  old commits, and you have to have Signed-off-by on any new ones to
>  gain any benefit.

Hmm, it looks like --use-log-author really affects git-svn fetch, not
commit: in other words, it pulls the signed-off-by information from
the svn repo when importing the commits back into git.

This is actually the clue I needed, which I think is: use
signed-off-by lines in the first place, because that will solve my
problem of tracking who wrote each patch :)

Have fun,

Avery
