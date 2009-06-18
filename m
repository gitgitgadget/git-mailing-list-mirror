From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 13:18:55 +0200
Message-ID: <20090618111855.GB12924@vidovic>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de> <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <7vk53aymuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHFeA-00062E-7U
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 13:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbZFRLS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 07:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757588AbZFRLS6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 07:18:58 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:51275 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbZFRLS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 07:18:57 -0400
Received: by ewy6 with SMTP id 6so1430074ewy.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3sATnq8EncqoBAdtbawqln4tIJMRSeTPXSI/L9dhp8I=;
        b=QIO60JDy+5FMLy7hO0ccFhrEmsMBUcpPMJ0REVdPaKQ0KPpl2Thwrckq5Rjiz/uhDO
         /GFrmf081OtjDF5gpcx8CE7LgQPofAnAw5+ck7UznWcdS8ob7hEDoabsFWFcqn63QGJ9
         NqDu3TeSditZAHHLrM1M09HLtqFtyGLWOVrQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hiv2wohWAvcTWlrGo9C46v7Vj5Jk42I/8Euk0y3jCFG4uy/OJ7tFT0B24/EHaO1ZfS
         VwqOPXFnSo63TO3P/Y6nu/O6/mk4Bkhov43G3a8qJKWqmCuiGg/RZn+ytvWMAJWA3iei
         2MmuF41DH8mf3u+ThKDrFpWt+d/TxuAepYkrU=
Received: by 10.210.19.7 with SMTP id 7mr4346828ebs.10.1245323938853;
        Thu, 18 Jun 2009 04:18:58 -0700 (PDT)
Received: from @ (91-164-154-189.rev.libertysurf.net [91.164.154.189])
        by mx.google.com with ESMTPS id 28sm142637eye.36.2009.06.18.04.18.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 04:18:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk53aymuz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121830>

The 18/06/09, Junio C Hamano wrote:

> I also often use "magic" commit log message in other occasions.  The most
> important is "[DONTMERGE]" prefix to somebody else's commit I queue to
> 'pu' (or leave unmerged even to 'pu'---just keeping on a topic branch).  I
> accept a patch with "am" and then "amend" after review when I find that it
> needs more work.  One day I am hoping to write a pre-merge hook that
> forbids commits marked with such magic to come into 'next' and down.
> 
> The point?
> 
> Earlier somebody objected to a command that changes behaviour based on
> what is in the commit log message, but for the private commits the patch
> under discussion deals with and the ones I mark with "[DONTMERGE]", the
> commit log message _is_ the right place to leave a mark for commands to
> take notice and act differently.
> 
> Of course we _could_ use notes for that, but that won't play well with
> rebasing I suppose ...

Not for now; you're right. But what I see here is all about
commit/branch metadata to make our like with workflows easier.

What about implementing a true metadata feature into Git? There are a
lot of nice possible functionalities around metadata.

Fast, stupid and superficial thoughts on that:
- have metadata to make git to act differently and/or for information
  purpose;
- let the user create its own metadata for his own purpose;
- let the user have hooks script where appropriate.


-- 
Nicolas Sebrecht
