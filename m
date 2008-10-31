From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification time
Date: Fri, 31 Oct 2008 14:45:36 +0100
Message-ID: <81b0412b0810310645o1ad4f6e4i9b0527f5789e5665@mail.gmail.com>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
	 <1225344554.10803.17.camel@maia.lan>
	 <20081031070003.GA4458@blimp.localdomain>
	 <eaa105840810310559l29addd80i7a22c21e37231bb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Peter Harris" <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 14:46:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvuL1-0000QA-4A
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 14:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYJaNpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 09:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYJaNpj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 09:45:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:8534 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYJaNpi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 09:45:38 -0400
Received: by yx-out-2324.google.com with SMTP id 8so521429yxm.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hHTtS0JN+fEn/2/OF/OfOeEZ6vMJplDTpv9PBfMxLys=;
        b=cCZtW4z2DjEyjs6rQtt6rwLP+96CsG71VGuwSlrffakPZJjH0MKnrh50WAZbRaiGwc
         nPcj4oNxbYrjbQmWp8rWafQLbsJ2U6m9l+cC1LdeSNxM6fTtPBQv3AAZuZtAAtG5dVus
         hZUOIMKyWZlAo5yw1KfpgrVICUlzZl81xMtEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qD6rO/Ty8UgubsLlvW9GWP0j8CRf2d1bwNwKmIzJmycF5lXiiL+5PEKEKyGlhiGEOM
         kecuRKDMjLd8cxBV6BbldVFLt4WKYY40NjlDFAvJzDpvKLAmqzvw+ZyAaeQWGHQd3L9H
         hFDtHkHWw0bpk2jjNIYFAXSfkhq4+1v2CPRew=
Received: by 10.100.122.12 with SMTP id u12mr1845011anc.78.1225460736774;
        Fri, 31 Oct 2008 06:45:36 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Fri, 31 Oct 2008 06:45:36 -0700 (PDT)
In-Reply-To: <eaa105840810310559l29addd80i7a22c21e37231bb1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99587>

2008/10/31 Peter Harris <git@peter.is-a-geek.org>:
> On Fri, Oct 31, 2008 at 3:00 AM, Alex Riesen wrote:
>> Sam Vilain, Thu, Oct 30, 2008 06:29:14 +0100:
>>> On Wed, 2008-10-29 at 11:38 +0100, Alex Riesen wrote:
>>> > I could not find what exactly does the ActiveState's Perl use for its stat
>>> > implementation (and honestly, have no motivation to look harder).
>>> > It seems to honor TZ, but the produced time does not seem to be either
>>> > local or GMT.
>>>
>>> See, the difference is that the perl is portable and your patch isn't.
>>
>> ActiveState Perl on Windows is portable? To another windows, maybe.
>
> Quite aside from missing the point (which is that Vanilla Perl runs
> everywhere, including Windows[1]), this is also factually incorrect.

Ok, it is (almost: "Vanilla Perl is experimental and is not intended for
production purposes". Well, I need it exactly for production purposes!)

> A quick check of the ActiveState website would reveal ActivePerl
> downloads for AIX, Linux (x86 and x86-64), Solaris (x86, SPARC, and
> SPARC64), MacOSX (x86 and PPC), and source code, in addition to
> Windows.

what's the point of that, I wonder... Just to admit they broke the original
source beyond all repair on one platform (windows) so now they
have provide their poor customers with the same broken version
on all the other platforms, because they complained about incompatibilities.

So Perl is portable. ActiveState Perl may look portable. They just don't
seem to be compatible enough. Even then, the Git's test suite and some
scripts (I have no use for git-svn on Windows) do very good job to be usable
even if the portable dependency replaced with something else. I'm trying to
keep it at that because I personally have no choice.
