From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Mon, 9 Apr 2007 12:43:52 -0700
Message-ID: <56b7f5510704091243w2ef54809m339663b3fbf72ad6@mail.gmail.com>
References: <46197814.5010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:25:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazmY-0008WP-69
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbXDITny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXDITny
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:43:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:51148 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbXDITny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:43:54 -0400
Received: by wr-out-0506.google.com with SMTP id 71so966900wri
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 12:43:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qXKtP00Xj0C0Za6sdwGuaVfiJEQTm6dp4lJOSE8qv1U1vnUonccrh4hQGZe2sWAoPZ6gHIJKuXMfZTYUYKGF2E4F/gRMzB44nMBOTM3Ao/xAhtrw579aP2K0mYev+rzKQPcRyxXzhHStDcX6tNTlCIQL4UaHXeVfLC/UJt6Sb9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vh3tkUnlCg/4Ub8OrVsaiuY0wOydnRCycnCc+5dM2ehPzdRGMittbBEuUoVNdYK7/9fYnSufN3elfj1X3OrHI9FR9y7CuEWnHt1uCzoSdjfVSQPW9BDXsF5rQjySyAFp900qg8SsHtvd1+pyGi9pMjaxtm+3Fdb3wP2qyEpxxV4=
Received: by 10.114.111.1 with SMTP id j1mr2479493wac.1176147832892;
        Mon, 09 Apr 2007 12:43:52 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 12:43:52 -0700 (PDT)
In-Reply-To: <46197814.5010909@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44090>

On 4/8/07, Dana How <danahow@gmail.com> wrote:
> The three most common ways of making large packfiles
> are git-fast-import, the first git-repack, or git-repack -a.
> The first already supports a "--max-pack-size=N" option,
> which limits the resulting packfiles to N megabytes.
> This patchset adds the same option, with the same
> behavior, to git-repack to handle the other two cases.
>
> After reviewing others' comments,  this latest patchset
> touches 2/3 fewer files and 1/6 fewer lines,  and
> introduces no behavior not seen elsewhere in git.

At the moment,  I plan the following changes to this patchset:
* Redo after 64b index applied (Nicolas)
* Bad re-use of header around sha1write (Nicolas)
* Set object_entry.offset before write_object (Dana)
* Finish reducing struct object_entry (Junio)
* Remove spaces from inside () (Junio)

Concerning refactorings,
I'd prefer to keep those in a separate (follow-on?) patchset.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
