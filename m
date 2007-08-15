From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Wed, 15 Aug 2007 01:03:25 -0700
Message-ID: <a1bbc6950708150103v35330b47o781fb5d74e3d9aef@mail.gmail.com>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
	 <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: msclrhd@googlemail.com
X-From: git-owner@vger.kernel.org Wed Aug 15 10:03:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILDqp-00007z-9v
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 10:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXHOIDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 04:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbXHOIDa
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 04:03:30 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:36078 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbXHOID1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 04:03:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1663501rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 01:03:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=udCX2TcM9+aqVBe00ZsfDfnC48+XS4rGodUw7+zB6ATnfV1i4vYnWjpgoRcQF5jXgZ146OpmtW6mZf0dss+sajjLFjOZMz6qa2/lJK4mgKnJgokcw1rKRoyW8Nvrl7W96fmv5tcg/WSUjJlzlXX49zrXZoEOxBw0/nZc68dh2RU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8Va1dymZATLAI/AIQSp2DBMYwISOHl8F3oSP93YEw//q/GSbOcANKj4NW8rMcTXFVGvVu4J6nnkaQPB/h4JGNQgMCnYSUZka9xkOWWEkxB2wtJtTmIy04volVXXnrpl5YhGY5WPrZatArRsIKSIOfImuvhncW5inYMSmCEG/zY=
Received: by 10.141.99.4 with SMTP id b4mr86468rvm.1187165005956;
        Wed, 15 Aug 2007 01:03:25 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Wed, 15 Aug 2007 01:03:25 -0700 (PDT)
In-Reply-To: <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55887>

On 8/15/07, Reece Dunn <msclrhd@googlemail.com> wrote:
>
> On 15/08/07, Dmitry Kakurin wrote:
> > Here are the facts:
> >
> > 'git branch --color' produces garbage:
> > $ git branch --color
> >   devel←[m
> >   dima←[m
> >   dmitryk←[m
> > * ←[32mmaster←[m
> >   mob←[m
> >   next←[m
> >
> > 'git branch --color | cat' produces expected colored output.
> >
> > I've traced it down to printf statement in gdb and it sends the right
> > esc-sequence.
> > Where should I look next?
>
> Windows doesn't recognise the *nix printf colour codes.
>
> Piping through cat will be going through cygwin/mingw emulation,
> translating the colour codes to the correct API calls.

That's my question. If there is a way to build cat.exe to do this kind
of emulation under MinGW then I should be able to do the same for
git.exe.
I hope I just need to #define something while building Git.
But what is it?
-- 
- Dmitry
