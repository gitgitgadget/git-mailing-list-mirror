From: John Tapsell <johnflux@gmail.com>
Subject: Re: git merge --abort
Date: Fri, 20 Feb 2009 08:13:46 +0000
Message-ID: <43d8ce650902200013q4aca6b2na27092e0825f969a@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
	 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
	 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
	 <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQXX-0000Vw-1k
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbZBTINu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZBTINt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:13:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:38953 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbZBTINs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:13:48 -0500
Received: by gxk22 with SMTP id 22so2190924gxk.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=MRs3wptlE+S024rUBiTV3pGdxD9SSUMWdC0TZu9d93s=;
        b=u5Ao2imwFdiAcCI7boNZsZ9GXlqLLCTj/FFgWOcJ+k5FkO99cLj4F6QInPZd6aM2RJ
         1WnaJR9Zzro7/nnNgIhr2n8V1FOHdBvsZEzPRODnl9rqxnMAPH/ljeX2vsOnBJVbBqD+
         6SliGVHg1ksW/An8BQH8GKbZPFgk8jH1YrobA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=jUKZlbFUVAb5Qi28Ig+Ir4v/Nhg47fTwHG9jHBHjO8S1mC/EZUS+KxEJfLGGkc2moN
         P4sSG59ygfYAyfiMIT6gZbXil7doT2w2ZVK/TeJa/0jhiLKmpWt14X9BTVGe7fm88AMe
         Tc3QlSDabU51QJpykgYJVT7UI9KCHGvGEp5MA=
Received: by 10.150.121.6 with SMTP id t6mr522902ybc.80.1235117626979; Fri, 20 
	Feb 2009 00:13:46 -0800 (PST)
In-Reply-To: <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110813>

2009/2/20 Junio C Hamano <gitster@pobox.com>:
<snip>
>    $ edit ;# unrelated local changes are still here
>    $ git pull ;# or merge or whatever
>    ... oops, large conflict ...
>    ... look and see if it can easily be resolved ...
>    ... otherwise
>    $ git merge --abort

Can I just confirm - at this stage, "git merge --abort" would be a
"git reset --hard HEAD" ?

So could "git pull/merge" detect if there were local changes, and if
there are tell the user something along the lines that they have to
either abort the merge, or be unable to abort later?

>    $ git stash
>    $ git pull ;# or whatever, try again
>    ... the same conflict but this time you only need to worry
>    ... about the merge itself
>    ... resolve, review, test to convince yourself that your
>    ... resolution is good and then...
>    $ git commit
>    $ git stash pop
