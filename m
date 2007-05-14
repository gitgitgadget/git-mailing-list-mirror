From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Mon, 14 May 2007 23:24:01 +0100
Message-ID: <200705142324.02929.andyparkins@gmail.com>
References: <200705141429.58412.andyparkins@gmail.com> <46486FE6.16A82D9A@eudaptics.com> <7v646vo3pn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 00:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnixn-0002pJ-5y
	for gcvg-git@gmane.org; Tue, 15 May 2007 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbXENWYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbXENWYL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 18:24:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:3198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbXENWYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 18:24:10 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1448162uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 15:24:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HL7AxELnUctAjJ4R9d7dJ6kcgMr2fFGn0cmMh/9h3W96E85XhDrRRtIY3OW8TbNf/Q/YZ20FNsJj4uan4hgYqZNPHl2h4FMEBS/kvdsat9THwoBr3s3m3tO+SMhnagHfODq80F+VLsxM5ajOou7LfNNqNA+tYKDtZPnoTkujbn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TSDdjLp1Y46j2sGQ08gYrZ+Tqb04bvXXMe83AV5U0MlLoBSTmba7s+MbVxNT+XIOpf9nTDfgTA3/mgrp7T8jD/et7izFn4X5PXtYsBBycRW/19noe3huq5zFnDFNSzxXFpkN/Yfe5LSXa4tPepa7eFMMa0SQdRtV89q7UnZm3z4=
Received: by 10.82.184.2 with SMTP id h2mr2632998buf.1179181449373;
        Mon, 14 May 2007 15:24:09 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm14708993ugd.2007.05.14.15.24.06;
        Mon, 14 May 2007 15:24:07 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v646vo3pn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47296>

On Monday 2007, May 14, Junio C Hamano wrote:

> My take when I did the $ident$ stuff on this issue was quite the
> opposite.  CVS "$Id$" means quite a different thing (pathname,

You're right, but I think it's intended as a unique identifier rather 
than that specific information.  If that were wanted by a CVS/SVN user 
they would have used $Author$, $Rev$, $Date$, etc.  $Id$ to me was just 
some way of identifying the file its in uniquely - the fact that git 
has a much better way of doing that is a bonus, and is exactly right 
for $Id$ IMHO.

> per-file revision number, date, and status) and it would not be
> right to overwrite it with $ident$ which does not record any of
> those "context sensitive" information.

It would be perfectly correct to overwrite it, as in the repository 
version none of that information is present, and even if it wasn't, as 
we've discussed at length, it's all meaningless in a git context 
anyway - the best thing that you could do for it _is_ overwrite it.

> I did not think other systems making that mistake was not an
> excuse for us to do so, but on the other hand, if the users of
> those other systems are happy to lose the information from CVS
> then perhaps the users do want $Id$.

As I said, there is no information in that field when we import from 
CVS/SVN - the repository versions are stored with the fields 
collapsed - so you are not overwriting anything, and therefore not 
losing information.

> Obviously I do not care much about this feature and I have not
> look at Andy's patch too deeply yet, but in any case I think the
> inverse conversion needs to be modified to match it, if it
> hasn't been done so.

I believe I did the inverse conversion as well.  It's only rough, in the  
end I don't care much either way - I've already converted everything of 
mine to git so it affects me not at all.  I offer it only as a 
suggestion for imports from other repositories.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
