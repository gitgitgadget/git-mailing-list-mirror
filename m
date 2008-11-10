From: "Piotr Findeisen" <piotr.findeisen@gmail.com>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Mon, 10 Nov 2008 08:38:24 +0100
Message-ID: <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com>
	 <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com>
	 <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
	 <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRN9-0003T0-FI
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 08:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbYKJHi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 02:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYKJHi1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 02:38:27 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:22939 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbYKJHi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 02:38:26 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2449832wfd.4
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 23:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kYwpzH8Rr1LlUujyZ9Ywv1z0PO0T/xx2DGZM46ejWLA=;
        b=mfl+0+g8xjfuyfCO4inHw/H2d46ritysDEzNUKUuremdxpjl1QLAdd5qj6VnFCClh0
         5D6t34OPkVSZiAVes7j7S9NaeM0Q2Svq7vvRVwJFHeAK8mc8+mlEu6ZYtwPjTpsZzBj1
         KZJmeak9TLxZrwaId+MPS3KxuBKHZ0K2MuQ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FqX4Gpgk+XgQ8v373L6IqzH6BTRpIlDqzWRMmidbntFMVnL9c9D5QowqregpIZIYZe
         frTB5yIiqUITawGABMSR9bTbOWr00Ryc0pWnfXuJ9jrY4C41Ln2bnkb/lnJoZQmtGtxi
         bPWP/cBhAqPlH7ROqgKGa/3VRX1MQfIqFYLOU=
Received: by 10.142.77.11 with SMTP id z11mr2250815wfa.114.1226302704850;
        Sun, 09 Nov 2008 23:38:24 -0800 (PST)
Received: by 10.142.157.6 with HTTP; Sun, 9 Nov 2008 23:38:24 -0800 (PST)
In-Reply-To: <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100495>

Hi!

>>> The attached file is a result of running `git diff HEAD~1`.
>
> Please read Documentation/SubmittingPatches for the preferred way to
> contribute patches.

Ok, I'll look there, when you tell me this patch is worth anything.


>>> Asciidoc replaces "--" with "=97" when not in verbatim mode. This i=
s
>>> sometimes unwanted -- especially when citing command line options l=
ike
>>> "git diff --cached". This commit includes proper quotes in user-man=
ual.txt.
>
> Newer asciidoc versions have the following "workaround". Maybe adding
> something like this to Documentation/asciidoc.conf would be more
> future proof.
>
> # -- Spaced and unspaced em dashes (entity reference &mdash;)
> # But disallow unspaced in man pages because double-dash option name =
prefixes
> # are pervasive.
> ifndef::doctype-manpage[]
> (^|[^-\\])--($|[^-])=3D\1&#8212;\2
> endif::doctype-manpage[]
> ifdef::doctype-manpage[]
> (^|\s*[^\S\\])--($|\s+)=3D\1&#8212;\2
> endif::doctype-manpage[]
> \\--(?!-)=3D--

Well, this doesn't solve the problem -- I'm not talking about
manpages, the "--" where replaced with single "=97" on the
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html page.
Yes, we can disable such a replacement in the config file, but take a
look at the sentence "...how to fetch and study a project using
git=97read these chapters...". In this case "--" in the source file was
replaced with "=97" and this is what we want.

I noticed that all substitutions "--" -> "=97", where "=97" is a part o=
f
sentence punctuation, match \w--\w pattern (e.g. no spaces on both
sides) and probably this is how it should be written in English. But
basing on this doesn't seem to me to be fool proof.

Best regards,
Piotr
