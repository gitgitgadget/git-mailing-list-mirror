From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 00:56:37 -0400
Message-ID: <76718490903182156y3b2b9d8aw708829a6ed151aa@mail.gmail.com>
References: <49C0DE23.8020809@viscovery.net>
	 <20090319041837.GA32642@coredump.intra.peff.net>
	 <20090319044313.GA341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkAKY-0000Bv-1b
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 05:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbZCSE4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 00:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZCSE4k
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 00:56:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:49377 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbZCSE4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 00:56:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so376790rvb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 21:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1H84uaok6Rl64eGuRu83J6j4hiwtDp5X+LKFHqnoU2E=;
        b=TU2VtG4+1Cvy98eZDeDp7MDYSJOMc4+D2ML2DOvSNpftatKw3WJxNl88fVRfiaIZNa
         45nsrZGSS4b3nvQwlmo8itywr3qzmXqn2CGq+w2XNjZF1UKx6BOKYNVOkMt4m1hMzm5I
         RUi7CbRqQnTmjRJE7VJYcXDKyv5Fl/Vt9GCBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tSYl9Kov+acOWmYk/1RS0kwoSCN8uKmVtTiqOO6hOdh7Uovma6HyMYh6jfF9R3Y4sI
         fP++LCWuVLp2Xg0o07g49io8F0XCZTvt6eXZXav+uEQqv3zy3flOnXORLalm2PoOlf4f
         1Xuh3vNSSf1yTwD6ApOeX1lhkUk50rBsafCF0=
Received: by 10.140.139.3 with SMTP id m3mr575202rvd.64.1237438597392; Wed, 18 
	Mar 2009 21:56:37 -0700 (PDT)
In-Reply-To: <20090319044313.GA341@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113715>

On Thu, Mar 19, 2009 at 12:43 AM, Jeff King <peff@peff.net> wrote:
> The patch below probably fixes it, but as I can't actually reproduce
> here, it is largely untested.

Thanks.

> As a side note, I find this solution a little bit ugly. String lists
> should sort on their strings, not on some other random magic in the util
> field. This usage really abuses string_list a bit as a data type because
> we have no generic "list" type.

I really don't think so. The string_list API accommodates this case
quite nicely. So why not?

(And anyway, what sane configuration pushes a single local branch to
multiple remote branches? But the refspecs allow it, so I accommodated
it in builtin-remote and tested for it. I never actually tested
whether git push works with it tho.) :-)

j.
