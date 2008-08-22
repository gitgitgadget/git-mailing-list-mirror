From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 15:42:12 +0200
Message-ID: <200808221542.13227.jnareb@gmail.com>
References: <200808221256.21805.jnareb@gmail.com> <200808221501.54908.jnareb@gmail.com> <cb7bb73a0808220620m10245693pabe49993e91cff3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWvD-00076R-9V
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYHVNmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYHVNmT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:42:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25276 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYHVNmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:42:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so215600nfc.21
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=G0wYDN6UIQgzTSyvtHwF+3ZD2VfQytOTN9xlZN2J4is=;
        b=j8KpVJwkY7Uqq9egqOdZeQU5tKprEHI0PVyvxBqV6z10bwFYKAgBv7EXaPehCdHkVZ
         8dwfe3dawBT0NvKg6iI6tVbI2++iPPM7xBI04+PzuE0oUVZMfN48CgdHt9Veb+bLhHBs
         pMjtI7MJuCrTc4faIsPTeiPUimbAbVH/hhjUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cZuiicIKb6BkYyAtFcDk94H4MmI1mn+z8CfmrxdeMdsSponfcn6WQUi78QrHQPH5Sk
         Up0CiX3WzegyndgTsTtwHYIn9IjQcz3E+NzAEZwag5sQS5Nt5HckIKX6CmDk0+ewKEkE
         k/PrF8mMbxcCiYaeh8foC72M6mkLlQnzzUlm8=
Received: by 10.210.120.17 with SMTP id s17mr1477515ebc.181.1219412536695;
        Fri, 22 Aug 2008 06:42:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.249.91])
        by mx.google.com with ESMTPS id 20sm1435516eyk.4.2008.08.22.06.42.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 06:42:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0808220620m10245693pabe49993e91cff3d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93296>

Giuseppe Bilotta wrote:
> On Fri, Aug 22, 2008 at 3:01 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Seems overly complicated.  How about something like this, instead?
> > It simply moves stripping ^{} from refs to format_ref_marker(),
> > and uses "tags/v1.5.0^{}" instead of [ "tags/v1.5.0", 1 ].
> 
> My thought was that if the refs stuff was being used for something
> else than format_ref_marker, it would fail more spectacularly due to
> the different kind of values, rather than introducing potentially
> subtle bugs due to the additiona ^{} popping in unexpectedly, but it
> wouldn't be a problem to do it the simple way. Let me clean the patch
> up and resubmit it.

This might be good idea, but for the two following reasons: a) it makes
code more complicated, b) it is inconsistent, because ref type would
be saved in refname then stripped in format_ref_marker, while indirection
would be saved in git_get_references; consistent would be 
["tags", "v1.5.0", 1].

Thanks for your work on improving gitweb.

-- 
Jakub Narebski
Poland
