From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 10:06:39 -0500
Message-ID: <AANLkTim93jDnbTPYVk2zjxf+usPT==gMxK4ezUc9AcHx@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com> <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:08:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrtqT-0000nC-WB
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab1BVPH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:07:57 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47479 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1BVPH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:07:56 -0500
Received: by iwn34 with SMTP id 34so637617iwn.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zsDxmnXmz+G0Q9qy1i5uJxnV5DbPTr1ETd/ZYMm0x5Q=;
        b=ee3BJNWFgh59TthRRUj/Bas2dJMMfa/betAsLUM3ogGG0YBvDzOT+nk/8V238H66fs
         Q22WlQ9h4VwR/FnZDJNIio7DAtU0g665+rzwMlpulJUm25txK7zrJY6DCIerYMktCiWe
         nNJPFS+dA9HWD3KZMfgGlkPHbIKl0Uwy95fPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DbnbcRVHDL8FHZQqhU+0ZQmoLZEJjz+XWfLIm4f5HLCefM+LdHZr8BGuQn233weWsv
         oNIR6mSqEies5CtVbk0DUbAZn68GLDPQsKOxDF+eZgTVVuprS2F2/J+lq7rpVxknDqk8
         18C9iWTNOpP5ctShnS8GPEboDz598/ozFPpHI=
Received: by 10.42.225.4 with SMTP id iq4mr3677497icb.110.1298387276331; Tue,
 22 Feb 2011 07:07:56 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 22 Feb 2011 07:06:39 -0800 (PST)
In-Reply-To: <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167549>

On Tue, Feb 22, 2011 at 1:17 AM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> Is there any better way to achieve that certain commits are not
> garbage collected than to create such tags. I love my foot and don't
> want to "shoot if off" but I want to make sure the the
> "release-process-machinery" in our company can be sure that certain
> source states are never gc'ed. I can also live with creating normal
> tags 'refs/tags/release/1.20' but would prefer a solution where 'git
> tags' shows only developer created tags.

Yes, I'm sorry I wasn't more careful/clearer in my earlier reply.

> Will any ref underneath "refs/' prevent gc to garbage collect a
> commit? Or only those in the well-known locations (e.g. refs/tags/*)

Anything under refs/ is safe, but you should create a subdirectory so
that you've got your own name-space under there. For example, the
gerrit code review system uses refs/changes/ for its refs.

Because these refs would be outside git's normal name-spaces
(refs/heads and refs/tags), they won't be fetched by the default
(non-mirror) refspec.

j.
