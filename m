From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git push over git protocol for corporate environment
Date: Wed, 30 Sep 2009 16:43:24 -0700 (PDT)
Message-ID: <m3pr989eyt.fsf@localhost.localdomain>
References: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 01:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt8pZ-0007Xw-Cn
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZI3XnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZI3XnX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 19:43:23 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:44510 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbZI3XnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 19:43:22 -0400
Received: by bwz6 with SMTP id 6so3234491bwz.37
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=pkutwNDaABlIsJb5clk5vQUCf2FFv99sHtWlGh8LqX4=;
        b=wLw/TWOAX41gbe+NMOq7I352t0vNCyCKP4ys6EsuY4nX83tZdFaiqQS8T86Fz8fq6D
         O4hg+C822Q0gT1JEeE5+n0lwYjRd5FLFnkRhMWRRdr8gOcvnawnAqejAx6Acpkjq2FHC
         txtoeihJU7eVOxKYRQ0ApPZvIV76ZRfrz7vw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=w3hhnl95dzn1rxn9pW00rXPeirLm2jBJoRhmQOTU4sdahhVW+ufC+DGP71d+1c7kQA
         dbUDE9YZa99boPuFqatm7pmIT2eECzL0gIuCAqG5a5OAiky9teIde6XsX2DY5UybYB5h
         BwRbiOOzqe7+YHA+05zAbZ3CppV9PDNE7Pk9g=
Received: by 10.86.238.30 with SMTP id l30mr505377fgh.75.1254354204712;
        Wed, 30 Sep 2009 16:43:24 -0700 (PDT)
Received: from localhost.localdomain (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id d4sm121812fga.7.2009.09.30.16.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 16:43:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8UNh2Ed025619;
	Thu, 1 Oct 2009 01:43:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8UNgpYi025615;
	Thu, 1 Oct 2009 01:42:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129368>

Eugene Sajine <euguess@gmail.com> writes:

> My problem is that I need the simplest, easiest and fastest solution
> from setup and maintenance point of view in a situation when we have =
a
> huge CVS repo with hundreds of modules (projects) in it. My current
> understanding is that we are going to pull out project by project fro=
m
> CVS and create corresponding git repos.
>
> So, this brings us to hundreds of git repos and over 200 hundred
> committers. In this circumstances we don=A2t want to manage each repo
> separately as well as we don=A2t want to manage each person write acc=
ess
> rights to each repo.
>
> As I understand the best solution here is git protocol (one port only
> on dedicated server and no security as we are in trusted network) wit=
h
> read and write access configured for all repos on a dedicated server.
> What do you think I should do? How to enable push over git protocol?

No, I don't think it is a good solution, as git protocol is by design
anonymous and unauthenticated.

To enable push via git protocol, you have to enable 'receive-pack'
service for git-daemon (the --enable=3D<service> option).

>=20
> I would appreciate any recommendation about such set up and any links
> to corresponding docs.

You would probably want to use some tool to manage git repositories,=20
like
 * Gitosis (in Python, requires setuptools),
 * Gitolite (in Perl),
 * SCuMD (in Java),
or even
 * ssh_acl

I think Gitosis is most commonly used tool, see links in
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools and=20
http://git.or.cz/gitwiki/BlogPosts pages on git wiki.

There are also full-fledged git hosting solutions, usually with web
interface to git repositories administration:
 * GitHub:FI (proprietary, non-free)
 * Gitorious (Ruby on Rails)
 * InDefero (PHP, clone of Google Code)
 * Girocco (Perl + bash, used by http://repo.or.cz)


There are also tools such as repo and Gerrit from Android project
(Gerrit is a review board).


Also, depending on workflow used, you might not need for anyone beside
project maintainer to have push access to public repository;
maintainer would process pull requests from co-developers, from their
per-developer forks.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
