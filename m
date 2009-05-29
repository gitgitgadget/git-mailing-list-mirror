From: Paul Tarjan <ptarjan@gmail.com>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 13:24:59 -0700
Message-ID: <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
	 <20090529125853.GB11785@sigill.intra.peff.net>
	 <m3d49sauru.fsf@localhost.localdomain>
	 <20090529135242.GA30926@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	yury239@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 29 22:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8eH-0006jO-Dc
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764421AbZE2UZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764693AbZE2UZA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:25:00 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:57882 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764605AbZE2UY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:24:58 -0400
Received: by gxk10 with SMTP id 10so10813239gxk.13
        for <git@vger.kernel.org>; Fri, 29 May 2009 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eq3bXbND6qbAVQ6m93VnRKjwNj3n2NElowG9MYSxdmo=;
        b=lmKeNXp39yqSsqI2id0MP/mZb7imEEkmdh4jiVxABxPiDenl8Qe4E3KkwxfqT6T1Y0
         7Q4XO3fQ+KpsRIHzMsxCyMqvrqu40xMaPSuxdFa1Cej54DfQWPxb5lJijPaEyesKMg8N
         OIj2LRYmTd+jnzAyk/AkDsKriS72qL3jVgwEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eA0ZGk5tVA9wd+t0NVE4tb1dRUjQ8w1QNYMZSfitvlKev348z10IW0BWv5SpzsBkjh
         EwEhcHcHygV5gBa/WiUDbJYq0+rNQVCID4VixBLm6oN6niqE5fHshzjr6Mc02FOeyHy6
         QBuZGC+YWokrJWF84adCSAlNUz1+2UBRzr9dg=
Received: by 10.151.50.13 with SMTP id c13mr5986545ybk.28.1243628699316; Fri, 
	29 May 2009 13:24:59 -0700 (PDT)
In-Reply-To: <20090529135242.GA30926@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120311>

Thank you very much. For skimmers the solution is :

git update-server-info

every time I do something to the remote repo.

The reason I need http is slightly convoluted. The remote machine is
shared hosting with 1 ssh login that I don't want to give to my
partner AND I don't have root on that box. And as you correctly
guessed, that box doesn't have the git demon. The local machine where
he is doing his development. The only solution I saw without giving
him my username + pass to SSH was to do http cloning. Any better
solutions?

Thanks guys, a great first intro to the git community.

Paul Tarjan

On Fri, May 29, 2009 at 6:52 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 29, 2009 at 06:44:26AM -0700, Jakub Narebski wrote:
>
>> > Usually such a repo is bare, and gets updates only by push. In that
>> > case, enabling the update hook to run update-server-info is sufficient.
>> > But in your case, you are actually working on the remote repo via commit
>> > and other means, so there is no convenient way to always
>> > update-server-info after a change.
>>
>> Well, he can always add git-update-server-info to post-commit hook.
>
> That covers committing, but what about reset, rebase, "branch -f", etc?
> I don't think there is a catch-all for all the ways that a repo can be
> updated locally.
>
>> > Is there a particular reason you cloned over http instead of over ssh?
>> Or git protocol?
>
> Yes, that would work fine, too. I mentioned ssh because he already
> indicated that he was able to ssh into the box (and may or may not have
> the git daemon set up).
>
> -Peff
>
