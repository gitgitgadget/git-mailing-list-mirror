From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to configure Git to treat certain type of ascii files as binary files
Date: Wed, 22 Oct 2008 15:40:55 -0700 (PDT)
Message-ID: <m3hc74i73a.fsf@localhost.localdomain>
References: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Weiwei Shu" <shuww1980@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:42:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsmPB-0006Vg-19
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbYJVWlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbYJVWlB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:41:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:10755 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310AbYJVWlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:41:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so18327nfc.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=gI5hRiylVxSFF7ifZzO97sntbAEFmVkk7NHF95eV6M8=;
        b=Z2ZZSK0/OiVLK+9HFy1qp6FTZ0dLDVOrlVwlVnmsuEsy2xHGyv6QBjSndOdujmNdfG
         gBFELahBgEhM9Zy4QByzpQRPwTm03QyaZ3lagpu+xbpNq7tsndItT9b18Afz8iYXvyD8
         ZM+9HN9o49dCsngxvkKUQWd4f8zecaR84PmEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jhI7cqvUntrkoa3vyhKQpxQ2ePRBjn58gVrFrsslXuLeOiXOI4nDDngchrBr850lhX
         TvJMXJ17UyQvez3MRsiyAFT7QMkR4hfKmHS8hm3jjnp63yZMf1xp4tD0qh9byFS+5Vjq
         lvaOcLf/rE9+oUoEna9DiDqbAScNyjlVEOyCY=
Received: by 10.210.43.10 with SMTP id q10mr12635120ebq.1.1224715256746;
        Wed, 22 Oct 2008 15:40:56 -0700 (PDT)
Received: from localhost.localdomain (abxd135.neoplus.adsl.tpnet.pl [83.8.253.135])
        by mx.google.com with ESMTPS id 7sm14923451eyb.1.2008.10.22.15.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 15:40:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9MMhmiT012524;
	Thu, 23 Oct 2008 00:43:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9MMhcoZ012520;
	Thu, 23 Oct 2008 00:43:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98923>

"Weiwei Shu" <shuww1980@gmail.com> writes:

> My first post in this mailing list. Could some one direct me to some
> document/manual pages to setup Git to treat ascii files as binary
> files? I'm using Git to do circuit schematics (SPICE files)
> versioning. I will not do any merging or editing stuff with external
> editors. The only way to change it is to use schematic capture GUIs
> (Cadence, ADS, etc). So I'd like to treat them as binary files to
> reduce the possibilities of messing them up.
> 
> I know it seems a little bit stupid to use Git to do such an easy job.
> But hey, it's the most eye-catching SCM software, isn't it?

First, git does not modify files unless you have core.crlf set,
and even then it warns about irreversible transformations
(core.safecrlf)

Second, using gitattributes you can set diff driver and merge driver;
one of possibilities is to treat file as binary (binary diff and no
using 3-way file merge).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
