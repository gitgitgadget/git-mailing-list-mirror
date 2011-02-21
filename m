From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Mon, 21 Feb 2011 12:48:51 -0500
Message-ID: <AANLkTi=CseZLobCoq+Li0AexHR+eaZpe84DG5hGzWHzR@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 18:49:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrZt1-000069-DE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 18:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab1BURtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 12:49:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41500 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1BURtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 12:49:21 -0500
Received: by iyb26 with SMTP id 26so965339iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oKwRKgdXjN8BPn1bYqfbGz8jrGv1EFkWMkkVC3Putiw=;
        b=WG31Oaveu7NHpJSSq7MCWYdYU7WkcdFTGSEZGTcB2cNALuUEcB/eMEgCK1OKU5I9ES
         tQNBr2N7qH3JZX6rW9O3XPjY2Zxuspkg6qmCl1J84Pv4Qz+4tsSiqb72P7r9tn8ggBeL
         YpcTpaoLWNV1LnPXc4dVd9vA46j+Nyd3Dw/94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ob70ABE7LosPIWfW9VYbIt+sp1J6Ltz3ssAq+SyHv9Z1l3QcGH4FCOOd/urDVe+8MJ
         LMPSITrLjHEUVE6RIK0cjbsCC1+qmHObufbv/XsHMtmBtbe6zf+zU0hpG/FryQxZvomN
         r7UWEYK3TVxG6ZvmEo44svliHfuuTvmebh+jI=
Received: by 10.231.14.8 with SMTP id e8mr1347733iba.117.1298310561219; Mon,
 21 Feb 2011 09:49:21 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 21 Feb 2011 09:48:51 -0800 (PST)
In-Reply-To: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167498>

On Mon, Feb 21, 2011 at 12:21 PM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> I would like to create a tag which full name is not starting with
> refs/tags. Is that possible with 'git tag'?

Nope.

> If not, is there any other command to create such tags?

If it's just a light-weight tag, you can use the low-level (plumbing)
command update-ref to create an arbitrary ref:

$ git update-ref refs/blargh HEAD

If it's an annotated/signed tag you want, you'll have to first create
the tag object with 'git mktag', then use update-ref to create a ref
to that tag.

See git-tag.sh in the contrib directory of git.git.

HTH,

j.
