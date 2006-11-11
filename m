X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 12:56:19 +0100
Message-ID: <200611111256.20157.jnareb@gmail.com>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com> <ej4ba6$oqt$1@sea.gmane.org> <fcaeb9bf0611110331q53522c50sda399d4a7916636d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 11:56:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ig6P8fDfYsnuZxS8oz8dDkvycR7aEgsPRacH1R4nRVqXeLVJvS5tZZYPEyfh5WSbOEnkSoPhFw0jEgSeRe0Nw5D5cF+ytWR4bmuZ5zUwR6tqhEknAokZQtxUXjgPZz4o8SkO+UV0b1EaoprQ5i934n34pUQGnxleh0+KUQQJ72c=
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0611110331q53522c50sda399d4a7916636d@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31215>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GirTL-0006YN-IS for gcvg-git@gmane.org; Sat, 11 Nov
 2006 12:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424559AbWKKL4Z convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 06:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424560AbWKKL4Z
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 06:56:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6880 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1424559AbWKKL4Y
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 06:56:24 -0500
Received: by ug-out-1314.google.com with SMTP id m3so730490ugc for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 03:56:23 -0800 (PST)
Received: by 10.66.242.19 with SMTP id p19mr4973525ugh.1163246183263; Sat, 11
 Nov 2006 03:56:23 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 50sm3300821ugb.2006.11.11.03.56.22; Sat, 11 Nov
 2006 03:56:22 -0800 (PST)
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Dnia sobota 11. listopada 2006 12:31, Nguyen Thai Ngoc Duy napisa=C5=82=
:
> On 11/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> You can only amend topmost commit in any branch. Anything else would
>> be rewriting history, starting from amended commit upwards in lineag=
e
>> (parentage).
>=20
> Yes. That's what I want. I am tempted to edit older commits just
> because I forgot to add some entries to .gitignore that I should have
> added sooner :-)

In pure git you would have to create new branch at the commit you want
to amend, amend the commit (in this branch), and rebase (or cherry-pick
if you need to edit other commits too) the rest, then rename branch.
Or if you don't want ot loose reflog, tag/branch current branch, then r=
eset
(rewind) current branch to the commit you want to amend, then cherry-pi=
ck.

Or you can use cg-admin-rewritehist tool from Cogito.

See: http://git.or.cz/gitwiki/GitTips
--=20
Jakub Narebski
