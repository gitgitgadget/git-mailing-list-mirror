From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 10/10] mergetool: use run_mergetool from
	git-mergetool-lib
Date: Thu, 2 Apr 2009 18:54:03 -0700
Message-ID: <20090403015402.GA52576@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <200904020054.23147.markus.heidelberg@web.de> <20090402200235.GB13817@hashpling.org> <200904022213.15173.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 03:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpYdE-0005Oa-OP
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 03:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZDCByM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 21:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbZDCByM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 21:54:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:27746 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZDCByL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 21:54:11 -0400
Received: by rv-out-0506.google.com with SMTP id f9so921657rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CXHdXHLLkQ7IHY9+Xy6qL7Sf190limU5wnOS6bHyR1w=;
        b=MwZ/2rR2OStYMao40Jxiz9jfaX4E/vmlZyXeIoUDbBDgQiZbQTsnQVF2ATe24aPmB0
         0iano6OfyryM7oP7390bejOVNmL42q8ITEH7ozZs6+gO05tfhbLZiqn54oDqpKfJncvv
         Wv7WtYrS3ilDLirGULWMBDa8mAJJKoJ5FsXoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K6McYtYvbCttw+KPVN1AZuBfl3OWziPXzjAUJxojndXYiiyiTVpFMAu3IC+jkDcMHx
         yZC18L0iLhlsxiC+qCkrjhaaTJtn+uKZ5GuZZbyVBgfKFdJAPlkyqDP3YhLGdUdh9+TA
         C2VjuIzYO1T1HoAX4P3UBfVa1e4CyeX59kDiU=
Received: by 10.141.33.8 with SMTP id l8mr247627rvj.294.1238723649223;
        Thu, 02 Apr 2009 18:54:09 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id b8sm5138825rvf.32.2009.04.02.18.54.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 18:54:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904022213.15173.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115507>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> Charles Bailey, 02.04.2009:
> > 
> > I think that it would be better if $status stayed as local as
> > possible. If run_mergetool returned the value of $status as its exit
> > code then the function will properly return whether the merge
> > succeeded or not.
> > 
> > This way run_mergetool's clients can just use its exit code, without
> > having to know about a magic $status global variable.
> 
> And shouldn't also check_unchanged() move from git-mergetool.sh to
> git-mergetool--lib.sh, since it is only used there?
> Huh, it seems as if some editors for difftool cannot work correctly
> currently, because this function is used, but defined in
> git-mergetool.sh.

Sounds good.
A patch is on the way:

- moves check_unchanged into mergetool--lib
- returns $status in run_mergetool
- updates mergetool to not rely on the global $status

-- 
		David
