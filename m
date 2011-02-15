From: Emeric Fermas <emeric.fermas@gmail.com>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Tue, 15 Feb 2011 04:49:31 +0100
Message-ID: <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com> <F624322D-359A-48ED-A241-622042F77CDA@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
	libgit2@librelist.com
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 04:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpBvJ-0000uj-3S
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 04:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab1BODtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 22:49:53 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:35041 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1BODtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 22:49:51 -0500
Received: by pxi15 with SMTP id 15so935814pxi.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 19:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NJhWkD0r1Vvpz+SiHP65uk+vmm6TiV61ShYgp+HQ0RU=;
        b=HMoyFhD8ylmTRduc/bfr3xsWwNReAxu1SyfOnqGmwH8Mwv5l7+ViG+lzK7AZYuNsZl
         ibNfmeCodEQzQJ6J/hZqjERbx95E9HYiQS5skNxXpMR4DQ9IFg0Bd0V3zWe2kWJKgMXC
         elHMJaKVUkqJYr1FKbDNQQmM+O05mRNcZoWUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bTsvKopwpSEAxBgn2TCZ6xmZlHpRnkx9c6eN3WI5mis1kQpX2iL7DM24msK/Age4jm
         14Wtpxeu3xqB8rbbTMaPEncsrE2J2SvPoski8BNg7Qk3dDOfbM3055Ccp7CzQaSCwDNY
         xpuOe9qeRFbvn8UGQ5Z0axXa1QO3Um+MGmmgc=
Received: by 10.142.234.21 with SMTP id g21mr3761993wfh.301.1297741791487;
 Mon, 14 Feb 2011 19:49:51 -0800 (PST)
Received: by 10.142.195.18 with HTTP; Mon, 14 Feb 2011 19:49:31 -0800 (PST)
In-Reply-To: <F624322D-359A-48ED-A241-622042F77CDA@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166810>

Thanks a lot for this answer.

I've also read the man page of check-ref-format. However, there may be
some not up-to-date documentation or some "non guarded against"
command usage in git.

This explains the second part of my question ("Or maybe this command
(ie. check-ref-format) is not intended to deal with symbolic links
?").

Another possibility would be that only git internal symbolic
references are allowed to live under the ".git" dir (HEAD, FETCH_HEAD,
...) and that user defined symrefs should live under refs/. In this
case, maybe "git symbolic-ref" should also prevent the user from
creating a reference which doesn't contains a forward slash.

Once again, by reading at the code I can understand how those commands
currently work. What I'm trying to achieve is to understand what
should be their recommended usage.

Of course, I'll be glad to contribute any code/doc patch once the
"voice of the git community" has spoken :-)


Em.



On Tue, Feb 15, 2011 at 4:19 AM, Kevin Ballard <kevin@sb.org> wrote:
> On Feb 14, 2011, at 12:58 PM, Emeric Fermas wrote:
>
>> - As check-ref-format fails when being passed "first", does this mean
>> that it's not recommended to create a symbolic reference at the same
>> level than "HEAD"? Or maybe this command is not intended to deal with
>> symbolic links ?
>
> I don't know about the rest of your question, but check-ref-format
> explicitly states in the manpage that the refname must have at least
> one /, to enforce the presence of a category (such as heads/) in the
> refname.
>
> -Kevin Ballard
>
