From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Support tags in uncommit - use git_id instead of rev_parse
Date: Wed, 3 Oct 2007 21:35:26 +0100
Message-ID: <b0943d9e0710031335o1c7f3a10i6f2055b76376bfd4@mail.gmail.com>
References: <20070930172647.18972.49369.stgit@tt.roinet.com>
	 <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
	 <1191362591.26879.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 22:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAwc-0004kF-AR
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbXJCUfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758657AbXJCUfa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:35:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:7418 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbXJCUf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:35:29 -0400
Received: by wr-out-0506.google.com with SMTP id 36so2554068wra
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AGWt2Cr+lxq/8XKF1Err0ga9WH9XI88ssFpiTSRTsTs=;
        b=WQmJe4VBT/W3mkrXQYUFSM8dpgRjJqYh3Z64zhRPatuOoDVQIzflZ/KHISiFFe+HG5xNHm7Rd1WoVOs0l8lP0+CZTdLkjsfmnA+1gp2J3x9xk8iZdPyioDKaec2x4j6EFHbV/eilav8xxitKo3VnWfv47mEjuuj5h4D4fDEjXv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KjPtMGPOvsUcfK7zrh8eAk2uILTHnpoVPMLwDyRyqX+JFKPj7677mDveTgQ+lO56ranY2Cf4iCzjL39+pIe09xDls9M+myyDxykuMT8PpPl7ys/gl2tWiOLOJxh1J++RMo0irBYU84VrB5pg+yw0Epw0BQUMx9TqAQBj+x4wgHM=
Received: by 10.142.88.20 with SMTP id l20mr55395wfb.1191443726506;
        Wed, 03 Oct 2007 13:35:26 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Wed, 3 Oct 2007 13:35:26 -0700 (PDT)
In-Reply-To: <1191362591.26879.3.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59882>

On 02/10/2007, Pavel Roskin <proski@gnu.org> wrote:
> On Mon, 2007-10-01 at 23:00 +0100, Catalin Marinas wrote:
> > To allow tags, maybe just pass something like
> > "git.rev_parse(options.to + '^{commit}')" or just modify git.rev_parse
> > to do it (and git_id to avoid it).
>
> I prefer to work with software that understands what I mean and tells me
> that I cannot do it.  It makes it easier to understand what is possible
> and how the command is working.
>
> Recognizing patch names in some commands but not others would be
> annoying and inconsistent.  Dumbing downs interactive software on
> purpose is probably not worth the trouble.

Without this patch, the 'stg uncommit -t patch' fails with 'Unknown
revision: patch'. With the patch applied, it still fails but with
'Commit ... does not have exactly one parent'. I don't say that the
first one is good but I don't think the latter is clearer. The 'stg
uncommit --help' states that the '--to' option takes a commit argument
but if one passes a patch name the error message gets pretty
confusing.

-- 
Catalin
