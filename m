From: Joshua Juran <jjuran@gmail.com>
Subject: Re: getting git to ignore modifications to specific files
Date: Wed, 1 Sep 2010 12:24:31 -0700
Message-ID: <0C30F6D9-8CAF-4677-AA40-7D41A7303C61@gmail.com>
References: <4C7EA1FF.8030307@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 21:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqsvI-0001an-M7
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 21:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab0IATYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 15:24:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40255 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0IATYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 15:24:35 -0400
Received: by iwn5 with SMTP id 5so7019917iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=NyNaZmAuci1o2p+L0nr7rmXJzU/bUVi+UEf3cy7xdXI=;
        b=Tre6aVoaGbOeAPolGjE+Qi9kYpbf2bIlyIUNEFJ6EqfJ01dgNWEo5ByyopJmdrkzab
         mMwj92Bi6O2M6hi2WiCeKzA8siB2f6jV0U2nXe3OBNG+Dl4ZePLFDCXrSYMcydpQ0m+x
         O8wDJ4ecXSzahXj1azUFkaP7zSddLIrqNsF/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=QQfpNh8Suaaj2EtcDuUQr35StRmU20SeMEZDVIHGc6M6prT7vijom97bya5syT9sHu
         zCzveCrjN50DkgQDEj21ajAYdjW6Z1EkzN48MugKvdzaFZVUlXOVOSxrIx+xwiJQ7loE
         9CuK/8ZKXEUPTVzBBF6DevSudqhDMLMLAaH2c=
Received: by 10.231.12.77 with SMTP id w13mr56301ibw.80.1283369074861;
        Wed, 01 Sep 2010 12:24:34 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id z6sm8631170ibc.6.2010.09.01.12.24.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 12:24:33 -0700 (PDT)
In-Reply-To: <4C7EA1FF.8030307@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155072>

On Sep 1, 2010, at 11:57 AM, Chris Packham wrote:

> We have a git repository that as some GNU build system (a.k.a.
> autotools) files, my current problem is with the INSTALL file but I
> suspect there may be some others. These can get modified if you are
> running a different version of autotools from when the files were  
> created.
>
> I've had various arguments about which autotools files should or
> shouldn't be included in our repositories. My general rule of thumb is
> that if it is automatically generated then it shouldn't go into the
> repository.
>
> There are a couple of repositories that are local clones of 3rd party
> repositories which have included the pesky auto-generated files so  
> whle
> I can remove the offending files from repositories we control I need
> another solution for the 3rd part ones.

I ran into this at a previous job, except using Perforce, so the files  
were readonly and make failed.  My workaround was to comment out the  
Makefile rules for rebuilding the autotools files.

The basic issues here are self-modifying code and mixing code and  
data.  The first is why I don't use autotools; the second is why I  
don't use make.

Josh
