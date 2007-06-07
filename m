From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 0/2] Fix issues with series deletion
Date: Thu, 7 Jun 2007 22:50:00 +0100
Message-ID: <b0943d9e0706071450u1587d109x1e592bfa453c0c0@mail.gmail.com>
References: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 23:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwPry-0005Ij-7g
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 23:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXFGVuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765239AbXFGVuD
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 17:50:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:48347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbXFGVuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 17:50:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so786375ugf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 14:50:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=njDgHezGkdVpfNer5WYiOOMh7Wf/7f3s9+TGJPdBkYbSGCGfrZ2ColIxxSynbPXR9O+w7Lpp4euQOPo0S4MbLvAtE7wDQh1tmRtVDosYzDtm5IdWdcE+Xk2l7nIOb0JM5OhO3SMVcX6yLkYz4Hj16n9+gwPcszLLzmdsDB5xn/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CQiQW69/uTitm6DRcj0L9xX2luXIAXamiRnpS9DCNiHLPZN7svZc9V8RhKYN5q8ZY7vjxbOoeiLlr3U5zS5JGDgZhEwXZZ/L96n11pWZD2vb0B4mBf5yJ9Y3j8AP+BXncg1Ua7D9GBquudM3MvL32Kk0jr9kXW+9rCea3TsoLEo=
Received: by 10.66.242.5 with SMTP id p5mr2305915ugh.1181253000160;
        Thu, 07 Jun 2007 14:50:00 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Thu, 7 Jun 2007 14:50:00 -0700 (PDT)
In-Reply-To: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49391>

On 06/06/07, Yann Dirson <ydirson@altern.org> wrote:
> I am however not happy at all with the way we delete patches and
> series, starting with an existence check and then deleting.  If any
> error occurs midway, then we are left with an inconsistent state that
> the user has to cleanup by hand.  IMHO, we should have those methods
> be as robust as possible, maybe starting by removing the formatversion
> item, and printing a "cleaning up zombie stack" if does not find it.
> So at least after fixing a "delete" bug, we could rerun the same
> command and get to a sane state again.

This sounds OK for a quick fix. Longer term, I think we should support
some kind of transactions. One idea is to put the StGIT metadata in a
single file (or maybe two if we include the config) that gets checked
in after every operation.

-- 
Catalin
