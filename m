From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Truncating history (Re: Sparse clones)
Date: Fri, 13 Aug 2010 14:19:54 -0500
Message-ID: <20100813191954.GA2003@burratino>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
 <20100813173147.GB27540@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 21:21:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojzp0-0003PA-DN
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 21:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab0HMTVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 15:21:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39774 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523Ab0HMTVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 15:21:36 -0400
Received: by gwj17 with SMTP id 17so116820gwj.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/Vqml1wSEhL4zOZ0KnUeG6BYvNXI9qjINvEegQA2pas=;
        b=N4fmZUhaRMHrBU9tokRGtg4isQQ9ztET8/qfN1L1qW61OrXgcAS8zgSWaeYlcUiIWY
         p2Z060GczdXWSOgGwpIU5P3HrBi5aGKPZUmqz4szR9wq4bFJ6ZdH+xo6+GRLh2jyuGab
         isxFNOIusM3ggYX6uB+3+vaHuWjciDh2GT5Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ehJD8GD4a/VSxK2U4Z3rJDxaQNiipCpizzX4RzvCBPigb1Hwm5SD31Dtwzghleph3C
         U2iTyMls6FNwuwuSVhgy98tmAxHd/eTgyHw/5kho6mp6OHqraDwgIsydWE48OexjBLrg
         88eADpYRdcpVV+4mLLb7cHJbzlqjD2hr/pkK4=
Received: by 10.101.127.5 with SMTP id e5mr2388648ann.138.1281727295938;
        Fri, 13 Aug 2010 12:21:35 -0700 (PDT)
Received: from burratino ([66.99.3.225])
        by mx.google.com with ESMTPS id e8sm1570512ibb.20.2010.08.13.12.21.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 12:21:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813173147.GB27540@nibiru.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153487>

Hi,

Enrico Weigelt wrote:

> Fake-roots are special refs that declare certain commit objects
> as root-commits). Each time git walks down the history, it checks
> whether the current commit is an fake-root and so treats it as
> having no ancestor. That should be generic enough let everything
> else (commit, push, gc, etc) work as usual.
> 
> The only tricky point is when to update remote fake-roots: the
> remote should not cut off my local repo (unless explicitly asked).
> So remote fake-roots should only be imported if the local/receiving
> side has not the dropped commits anymore.

You may be interested in grafts and replacement refs; see
git-filter-branch(1) and git-replace(1) for some hints.

Good luck,
Jonathan
