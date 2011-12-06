From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Mon, 05 Dec 2011 22:02:27 -0800
Message-ID: <1323151347.1745.73.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
	 <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
	 <CACsJy8CM8xqWxTx14QbY+-bT=306p3U=6gJfRaW=dDD-Swo7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Chris West (Faux)" <faux@goeswhere.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 07:02:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXo6w-0007rx-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab1LFGCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:02:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64790 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1LFGCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:02:33 -0500
Received: by iakc1 with SMTP id c1so3194605iak.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=17zJ7fOf1nuSUiqwwoHtwUK+9UkssykfFvkYARgJ91k=;
        b=lSbrAG/Z9n5QVunuEbLxCH+6w46Dregi3jWkfPDB3ESESyxe3U0F27AtxjO1i2KxiW
         3JctUosNZhqbeESn35U1Kdj9dpNpRVF+1VjuVWvOd8+FQsvrLYfsxhEAcwyNB3XbcFB4
         HsJRNzdOOPMtHYN9gJmS8Y/+iT8KGJsyrZrI0=
Received: by 10.42.96.132 with SMTP id j4mr13565709icn.50.1323151352546;
        Mon, 05 Dec 2011 22:02:32 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id j1sm47343144igq.2.2011.12.05.22.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 22:02:31 -0800 (PST)
In-Reply-To: <CACsJy8CM8xqWxTx14QbY+-bT=306p3U=6gJfRaW=dDD-Swo7-w@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186318>

On Tue, 2011-12-06 at 11:46 +0700, Nguyen Thai Ngoc Duy wrote:
> On Tue, Dec 6, 2011 at 8:56 AM, Chris West (Faux) <faux@goeswhere.com> wrote:
> >
> > Nguyen Thai Ngoc Duy wrote:
> >>
> >> SHA-1 charateristics (like 20 byte length) are hard coded everywhere
> >> in git, it'd be a big audit.
> >
> >
> > I was planning to look at this anyway.  My branch[1] allows
> >  init/add/commit with SHA-256, SHA-512 and all the SHA-3 candidates.
> 
> Great!

If you are replacing SHA-1 as an object ID with another hash function,
two things to watch are submodules and alternative object databases.
Because of those, it is necessary to worry about the order in which
repositories are converted.  In the worst case for submodules, you'd
have to do multiple repositories at the same time, switching between
them depending on what you need at each point.
