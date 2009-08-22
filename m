From: skillzero@gmail.com
Subject: Re: git svn pointing at svn branch instead of trunk?
Date: Sat, 22 Aug 2009 15:12:01 -0700
Message-ID: <2729632a0908221512v7d7af188h28d11a4bc8f092fc@mail.gmail.com>
References: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
	 <20090822204627.GA22484@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 23 00:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meyom-0007vz-96
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 00:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317AbZHVWMC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 18:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbZHVWMB
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 18:12:01 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51534 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbZHVWMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 18:12:00 -0400
Received: by ewy3 with SMTP id 3so1482303ewy.18
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f/R0yWKQop/cS1LwlWoXYllq1eQenhi29LdI9LJw4jE=;
        b=Q1ZoiBIenGaBePCSmU1h7sC2oRvVq8n5egPs2baGGnqW9loPei+U7wx8cWsBlIzEFk
         XikRcdeJRnvMxo47wHnffiyRlCe6oQdOcxCxv9iqQc+Du1YqhF+C8MwDsbPTMp4PNoxI
         9UNDdtkLLPAmdG5fq9aG8QCYfBK5/vcQ1ZgDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XOsPQBTOvUJ3k0CYwuwbDoplM6RkEfSBmAzacc7OM+b2IDK5oXpRLm/qIaCBrlolFp
         ZMS6GOJCwPVbDZuoM6g7gans/4HXG9XXddj06t1668lc7HQemUAzWWTAniqWwuqUG5/2
         NikEgYxMqzo559YiacLAi5ywa4JlWna6ULRXM=
Received: by 10.210.68.8 with SMTP id q8mr3176921eba.39.1250979121405; Sat, 22 
	Aug 2009 15:12:01 -0700 (PDT)
In-Reply-To: <20090822204627.GA22484@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126824>

On Sat, Aug 22, 2009 at 1:46 PM, Eric Wong<normalperson@yhbt.net> wrote=
:

> So you have something like this?
>
> ----------trunk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \-> tag
>
> It looks like it's mixed but that's because trunk is an ancestor of y=
our
> tag, so the majority of commits (see git-svn-id:) look like they're f=
rom
> trunk except the latest git-svn-id: which should have the URL of the =
tag
> in it. =C2=A0So in short, everything here is OK.

Yes, that's what I see: most of the commits have a /trunk URL except
the last one has a /tags/TagX URL.

When the next commit happens on master (I don't have svn commit access
on the svn repo to try it myself), will git svn automatically track
master->trunk again? Or is there something I need to change to tell it
"master tracks svn's /trunk"? I normally do git svn fetch and git svn
rebase (while on master, I do all my own commits on a separate
branch).

> I changed this recently in b186a261b1f7ec1fbda8c5f6d84595f3a7716d92
> git svn used to always pick the newest change in the entire SVN repo
> to point master to, now it'll attempt to find "trunk" to be master.

Thanks, I'll build that and try it out. That sounds like what was confu=
sing me.
