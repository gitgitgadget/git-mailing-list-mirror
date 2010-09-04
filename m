From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-fast-import doc problem and git-fast-export does not quote
 filenames correctly
Date: Sat, 4 Sep 2010 11:48:50 -0500
Message-ID: <AANLkTimsVQ=mg2EUhUEO5ZWQMZoA72B=p2+1ZA=1qBtn@mail.gmail.com>
References: <4C81E461.7010704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 18:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvvZ-000397-5l
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab0IDQtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:49:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64621 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0IDQtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:49:11 -0400
Received: by yxp4 with SMTP id 4so1111214yxp.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2b6GpXe/+8eJJjGAMMpbT5nxm7TiMESRzbsS4PvVsHA=;
        b=Nd2I5hs9uilKRmi1RqXLCkNA3+n0Cs4RwflPToSe29jnt+7BemRflTgpw2FbV2CKoh
         YrNVOHxk/uMi2Xa+DWK6bWVwGIJRRE9arTYPLAT40rcM+AO6dtWq9ENsLQs1JN9L2a4N
         pPXzYLqaf7pDFme0Hbz+FMxVRUGi+B7NFYHFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=E9RLKzrQHhKAtjt/qsjyat7oVABKnIVcV77e3nmYgEiOkOli5HruhUz6oMHYY9eJeC
         eblc+IESBAVawWyGpBxgEvYOyPaOGAZQMfMi91tm2BaX2RLWLbxAJnedfhAe/SDoHUcN
         tORvYXS0YsMgRUmYgSyhGwcGTGqGb2a48P29M=
Received: by 10.150.192.9 with SMTP id p9mr41601ybf.145.1283618950211; Sat, 04
 Sep 2010 09:49:10 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 09:48:50 -0700 (PDT)
In-Reply-To: <4C81E461.7010704@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155342>

On Sat, Sep 4, 2010 at 01:17, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The first problem is that the doc seems to allow NUL bytes (which I
> suspect are not really allowed)

Fast import keeps reading until it finds a '\n' and stores data in a
strbuf, so I don't see why 'NUL' would not be allowed.

> or the backslash '\' character (which,
> if allowed, would logically have to be escaped, too).

Backslashes are allowed, and it seems they need to be escaped as
usual. Perhaps Shawn can confirm that this should just be updated in
the docs.

> The second problem is that "git fast-export" does not do even the
> specified quoting:

That's a bug with fast-export then :)

-- 
Cheers,

Sverre Rabbelier
