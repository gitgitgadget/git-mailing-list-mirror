From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: * [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 09:28:16 -0600
Message-ID: <20071205152816.GA21347@mediacenter.austin.rr.com>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com> <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwAu-0003Wb-61
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXLEP2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXLEP2L
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:28:11 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:44829 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbXLEP2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:28:09 -0500
Received: by nz-out-0506.google.com with SMTP id s18so2643033nze
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=oQ+WdZcQOY3Zl8l3yzDpwV2mCLjVWJiQA8uA7TAu1I4=;
        b=XrwFP/jgBHseZSVwlkIqGS0H0c9y6C7KAu/79YH4l5AGcRNKcIcn4lz+pE7slS3CTA5Gm2231aCRqMVu87oQsK/X/X+LhXrjsTArd9ysMWLAG7BZQKlmmWA7+0cHQrLpppD/5X0ELZ2OFAVUgp38CbGYBnFJFMGnWiBRVgBPAYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=AflZR4E2+LjobkWT7xdrPGzr+Kusm8GMWG7j/8mbOX1hRoVIEv5cdB2ZKtv0RYmvUyR44hrysQ/pjbItv80AM1+qiysR3yW6jWmrLTUAjXb20h0k1yZkVhfTyVjrgVp6XzlT0tPjX1hyRl31OHKkSiOo7Xrufcce+4y0rkQdPpE=
Received: by 10.142.251.9 with SMTP id y9mr987190wfh.1196868487692;
        Wed, 05 Dec 2007 07:28:07 -0800 (PST)
Received: from mediacenter.austin.rr.com ( [70.112.149.232])
        by mx.google.com with ESMTPS id 9sm10199415wrl.2007.12.05.07.28.06
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 07:28:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67158>

On Tue, Dec 04, 2007 at 11:55:41PM -0800, Junio C Hamano wrote:
> Does this patch help?  I am not sure why the directory side of the code
> is written that way, but I have a suspicion that "was a directory
> explicitly given as one of the pathspec" check is also bogus, although I
> did not touch that part.

Before the rewrite in C git clean would refuse to remove a directory if
you said:

   git clean dir

without using the -d parameter.  Per your suggestion this check causes
git clean to remove the directory anyway since you explicitly asked it
to.
