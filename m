From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 11 Mar 2008 17:38:22 +0000
Message-ID: <320075ff0803111038x36bc40bbkf4b9eec6dd9284fd@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <478D1442.2090301@gmx.ch>
	 <c0f2d4110801151230g5843df66t62fb659375a1680e@mail.gmail.com>
	 <alpine.LNX.1.00.0801152109580.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 18:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8RM-0005W4-D7
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbYCKRiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYCKRiZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:38:25 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:50483 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYCKRiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:38:24 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1756515rnb.15
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=edOBb2oLKbtuBiz6AMFxYzL2bL5Lqpz09zh4lXY8CKw=;
        b=If4ZLANJm72qFLtV1crHLxLrVC7CiA05b5aAsENgH4R+O/OLAZ1PJIj8DMG4MTNLRBgwgkN9mZfHIf70XlIXIr7naSZexGDluwLdh3A9443EDaMWUiZXGLGR/xtbSLqypez0qdWsd+M3neGrmwztVGavgRs/6YkN1KdxpCZwO9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uwUUMEUuO4ufSMf6hAAmp8iNECSYB24OLd+L5deXJSlOtYFQ0DbptCD08YIduPWObAfF33K4mVrNFuT56w8kOFYoCnkDTFSA0QgCdNhwn1bDcMYFSSGQVsrOp1by53bjgKZLmQJF9lDQDtCrs5CfTQxHTy+lLTB5LjelgUCS7xA=
Received: by 10.142.237.20 with SMTP id k20mr2861382wfh.227.1205257102512;
        Tue, 11 Mar 2008 10:38:22 -0700 (PDT)
Received: by 10.66.243.3 with HTTP; Tue, 11 Mar 2008 10:38:22 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0801152109580.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76886>

Did there ever become a way of generating svn format diffs from git?

A project is having a hard time applying my format-patch --no-prefix
diffs, but I don't have a tortoiseSVN machine to figure out why..

On Wed, Jan 16, 2008 at 2:20 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 15 Jan 2008, Chris Ortman wrote:
>
>
> > You are correct about Tortoise in that it is too strict.
>  > I looked through their code and they have written their own patch
>  > program which keys off these Index: lines
>  > http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/src/TortoiseMerge/Patch.cpp
>  >
>  > I think it could go either way as to if git-svn creates a different
>  > format patch or tsvn accepts multiple formats, but I anticipated
>  > git-svn would be easier to extend so I started here.
>
>  I think it would be worthwhile for tsvn to be less picky in some ways. It
>  should at least be able to accept GNU diff, since sometimes people send
>  maintainers patches prepared by hand (diff -u file.c.orig file.c), and
>  there are comments in there that suggest that they're trying to support
>  non-svn-generated diffs, although they seem to think that such diffs look
>  like:
>
>  Index: filename
>  ============
>  @@ -xxx,xxx +xxx,xxx @@
>  ...
>
>  which isn't anything I've ever seen. You're much more likely to get:
>
>  ...junk...
>  --- junk
>  +++ filename    junk
>  @@ -xxx,xxx +xxx,xxx @@
>
>  And that should be easy enough to parse as an alternative format in tsvn.
>  (I'd send them a patch to do it, but they wouldn't be able to apply it...)
>
>
>         -Daniel
>  *This .sig left intentionally blank*
>  -
>
>
> To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
