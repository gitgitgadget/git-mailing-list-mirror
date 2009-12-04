From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Fri, 4 Dec 2009 09:00:47 +0100
Message-ID: <ee9cc730912040000u76337d40n4fd8e0eda7ca6bb4@mail.gmail.com>
References: <1259788097.3590.29.camel@nord26-amd64>
	 <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com>
	 <20091204001359.GA6709@gmail.com>
	 <32541b130912031745i60dc918dk3e510ef1a3b28526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 09:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGT64-0004Dl-S6
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 09:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbZLDIAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 03:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbZLDIAl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 03:00:41 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41843 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbZLDIAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 03:00:40 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1744598bwz.21
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=U64LLipa7Yw6whVLgKnQf24LwHeMxvTN7SYmWiOzrjs=;
        b=kaOz+4HIT9QYsdaQBBgmzntUF57L5ycqQc/McOTrVCXxZyWKDStdthtlleekGKydzv
         9C/lBc3joLMLaLPhM+5GDwnIRVOUgTaFxhRDa/ZKMfZbRJzkqhQupaPmKBQxP4YyZ6T4
         YJCn2Exo/HwKPmc/VyVyDq0+EjdPjYaGAInHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=lmqwHod3Y/cVS5Ozz0KhTExxPjNG9Cx1q/UBlcjqSYDGG7I4C2dJ4ZkZEVJHxbrVBs
         P0084imY1zC48mdNgzIokt+xH9Y4qF1pTZuZmm1MTEZ6bS11SL+xpxVOmfw30Sch8CEA
         5WwIikJ54wixk4YiXFxK54MC5DBPZHDCt5UcI=
Received: by 10.204.5.207 with SMTP id 15mr2834923bkw.89.1259913647067; Fri, 
	04 Dec 2009 00:00:47 -0800 (PST)
In-Reply-To: <32541b130912031745i60dc918dk3e510ef1a3b28526@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134501>

 On Thu, Dec 3, 2009 at 7:14 PM, David Aguilar <davvid@gmail.com> wrote:
 > JSON's not too bad for data structures and is known to
 > be friendly to XML expats.
 >
 > http://json.org/

I am currently working on two projects in this direction :

1. mediawiki on git, using mediawiki markup files. I apologise that I
have not made progress on that lately, because I have had inspiration
on my older project
2. the gcc rdf introspector, storage of the files in rdf. It is
working now with a mysql database, using the librdf mysql driver, and
running on a catalyst framework using jquery/jstree on the front end.

None of those formats are perfect, the sizing of the files is
important. I am returning individual nodes in json on the cataylst
server and that works to deliver the AST nodes from the compiler to
the jstree front end. But these fetches to the front end should be
longer and contain direct components of the fetched node. I think that
a cluster of nodes should be pulled together to make a more  optimal
system.


here is just my two cents:

if you are using a distributed git data repository as your central
repository, then think about a database page. Imagine that you would have
pages of data being retrieved and compared.

Would it not make sense to split your pages something that would be swapped
into memory directly, or with very little parsing, and then used?

So, in effect, you would design the sizing of the pages and the page
contents around the usage model, since git is a low level storage system.

I dont know what would be available if some database manager system like
mysql or postgres could be taught to store table pages in git.

just some ideas,

mike
