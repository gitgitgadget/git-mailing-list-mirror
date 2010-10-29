From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Add a section on writing documentation
Date: Thu, 28 Oct 2010 22:56:14 -0400
Message-ID: <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 04:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBf9C-0003iW-UW
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 04:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935Ab0J2C4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 22:56:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43267 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab0J2C4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 22:56:34 -0400
Received: by iwn10 with SMTP id 10so3080747iwn.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=qy1MHcS+lEwAcsX49FmMi0z35Ocy3Y4t2LH1UklRDFQ=;
        b=CL3or1YDZ19iAUwjmiQi+GakAqQBhNJ8trIlyKeP5gssck8gLqvs4m1aB99jLvs48J
         fyQeMNTyr4DVf+OHyJQd3byvbZCY65+uH5Qr6J/a0PV9WVwrJKWwURQumzn3vRSOA5bc
         7HxHu4I9+QlXhs6VXglCicsNgxmCK71FEDeMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=F0MRI3FBsvaIZv3zAzHw2U44XwpfEH5D849omi8Zi3nl+f8PfYEkvnngDGy21ZU3Sf
         l6DnoPKLRsng+y2MPzAvwebF9ks0cts88H4jtdqUEe/rSKGqcWimVmkajI2l35rR3+E5
         Bmg0I1x/h1M+UqSRS/y2akban5wbdAdN7+Q9g=
Received: by 10.42.197.72 with SMTP id ej8mr7993605icb.196.1288320994184; Thu,
 28 Oct 2010 19:56:34 -0700 (PDT)
Received: by 10.42.174.9 with HTTP; Thu, 28 Oct 2010 19:56:14 -0700 (PDT)
In-Reply-To: <20101024155121.GA9503@headley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160263>

On Sun, Oct 24, 2010 at 11:51 AM, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <ste=
pnem@gmail.com> wrote:
> Provide a few examples on argument and option notation in usage strin=
gs
> and command synopses.

I think this is a great idea.

> + Specific number of occurences is indicated as follows:
> +   <commit>{0,2}
> +   (Up to two <commit>s.)

I suggest removing this notation - it is confusing and is only used by
git-diff.txt and git-difftool.txt.  We already have notation to serve
this purpose:

    [<commit> [<commit>]]

> + Parentheses are used for grouping, often combined with vertical bar
> + to indicate alternatives:
> +   [(<rev>|<range>)...]
> +   (Any number of either <rev> or <range>.  Parens are needed to mak=
e
> +   it clear that "..." pertains to both <rev> and <range>.)

You could also mention that parentheses are not needed if square
brackets will do:
    [-q | --quiet]

Also, should there be a standard for spacing and for whether the short
or the long option comes first?

git-add.txt:
    [--patch | -p]
git-commit.txt:
    [-a | --interactive]
git-stash.txt:
    [-q|--quiet]

Otherwise, I think this patch looks good.
