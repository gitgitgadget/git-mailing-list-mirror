From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: how to compare fetch to see changes?
Date: Tue, 9 Mar 2010 11:35:06 +0300
Message-ID: <20100309083506.GH31105@dpotapov.dyndns.org>
References: <27828348.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: saltzmanjoelh <talk@joelsaltzman.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyWd-0001Do-20
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab0CIIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 03:35:12 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:41351 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0CIIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 03:35:09 -0500
Received: by mail-bw0-f222.google.com with SMTP id 22so342185bwz.28
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tqq0yPvb2nI3LuYeaLHfcWr5ipVwv7NNbNPzjwczTwM=;
        b=qFzvCTBpyQSxyTa2++/UTsTxCHWPAx/LHxq7/vDxYOZDgU66kxEL//N1aFXFq6vORV
         vw13q76x48b8zZ2mTu7/1Rv2/9L60eG8+Pj/60w7jaoz02ZeZUZqUcNs3G79DxioIzbr
         RYEfbOxWsLAn02RgzWBY5nsrF8zVdyxnbbuHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KrQOEdCtgPOw9PBje9rEQotzktdyna7fKpARUaNRBkZVuObRdlst3t6x/SV9/vWbJI
         E0PXQu23tgsDFQ5yr6+CYlO7D3CdzgiUFQ6r4uiiGNQyP/tqFMGbKPhbnTOMQKgFLeUv
         2b/t576L/jrTxyRjNN47dV0ZwJZgTNIzsZkTY=
Received: by 10.204.16.76 with SMTP id n12mr1806088bka.136.1268123709056;
        Tue, 09 Mar 2010 00:35:09 -0800 (PST)
Received: from localhost ([91.78.51.61])
        by mx.google.com with ESMTPS id 16sm3075766bwz.1.2010.03.09.00.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 00:35:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <27828348.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141801>

On Mon, Mar 08, 2010 at 02:01:42PM -0800, saltzmanjoelh wrote:
> 
> How do I compare what was fetched to compare changes?

"git fetch" prints something like that:

>From git://git.kernel.org/pub/scm/git/git
   7ff0f55..636c8b2  html       -> origin/html
   b599672..97222d9  maint      -> origin/maint
   59e5778..7e15109  man        -> origin/man
   7e5eb8f..b7e7f6f  master     -> origin/master

So, if you want to see what new was fetched for master, you can run:
  $ gitk 7e5eb8f..b7e7f6f

> 
> Then, how do I choose to pick some changes over others, like the mergetool
> does?

You can cherry-pick some patches and even modify them if necessary, but
it is not a good workflow. Normally, you should merge branches, then it
will be clear what is merged and what is not, and Git will automatically
merge only changes that were not merged before.


Dmitry
