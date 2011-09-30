From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri, 30 Sep 2011 01:44:13 -0700 (PDT)
Message-ID: <m3pqiio1xc.fsf@localhost.localdomain>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
	<1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
	<119711285.RuumktFLOq@hyperion>
	<loom.20110930T041939-332@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 10:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Yhk-0002JW-5k
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 10:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452Ab1I3IoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 04:44:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36537 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1I3IoP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 04:44:15 -0400
Received: by fxe4 with SMTP id 4so2673941fxe.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=qQzJJNqEY1JxWuDsGnJlZegYNpObOgkXFHuM2F1VcHM=;
        b=VsVIu8JlBh2Ihm8L5922oJg5HQl1zWjyDTgG3f5T9Li6hbC7xQBOKHlyP4NoskpE8T
         FJdK/jo6HV7a2L7S6jgtB5T20f2BUOpF2TKWcG+0Wqgl8b2s8cXdeSr8njqSjPm/Xz2X
         edARJtZWvtvS5PHEtsXLnaTCRc2FKpj2MH5hU=
Received: by 10.223.29.69 with SMTP id p5mr1443585fac.35.1317372254301;
        Fri, 30 Sep 2011 01:44:14 -0700 (PDT)
Received: from localhost.localdomain (abwd251.neoplus.adsl.tpnet.pl. [83.8.227.251])
        by mx.google.com with ESMTPS id a1sm5791498fab.4.2011.09.30.01.44.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 01:44:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8U8hstJ000360;
	Fri, 30 Sep 2011 10:44:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8U8hiS0000356;
	Fri, 30 Sep 2011 10:43:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20110930T041939-332@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182471>

Peter Shenkin <shenkin@gmail.com> writes:

[...]
> Now I have a related question. I always want to retrieve all
> tags from tracking branches when I do a "git pull". Right now,
> if I want to do this, it seem (unless I am missing something)
> that I have to do "git fetch --tags; git fetch;  git merge". Is
> there a way I can put something into my .git/config file so
> that I get this effect simply by doing a "git pull"? That's
> what I was trying to do when I added "tagopt =3D --tags".

Actually fetching of branches on remote into remote-tracking branches
would also fetch all tags that point to commits on fetched branches
(so called "autofollow" feature).

If you want to fetch _all_ tags, you need to configure fetched
branches (e.g. via glob refspec). I think that then "tagopt =3D --tags"
works as expected then, as it is in addition to refspec not as the
only refspec; "fetch =3D +refs/tags/*:refs/tags/*" should work as well.

HTH
--=20
Jakub Nar=EAbski
