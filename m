From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 17:27:53 +0200
Message-ID: <1a6be5fa0809150827y6d52e240m24fd463549bd4971@mail.gmail.com>
References: <263224.61965.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"David Brown" <git@davidb.org>, "GIT SCM" <git@vger.kernel.org>,
	"Simon Hausmann" <simon@lst.de>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 17:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfG0f-00062Q-K8
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 17:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbYIOP14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbYIOP14
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 11:27:56 -0400
Received: from rn-out-0910.google.com ([64.233.170.190]:1278 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbYIOP1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 11:27:55 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1300542rnd.17
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lYr/c7uz68DAkz3EHEIE39MAeHCtLojwqG8ipwEi4Ns=;
        b=e86pxSaE9SSgXnfNUW8ZK1r7d7Bfq93ZbP+0q/bS7+giEma7Wv3Toi89BYALmx+Y2o
         QvaHtZhBRBqCXJuRZlOhoiassa1d09zR59UTL/oNWl6OaSrcdnaDEBeZr2nNRC+Dzp+1
         1cHsi9HrvS/afq5notL5porKZrY8DOGRkIPzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QBkI3OMzVUdkJKNne8rjYE0vDj9GGcK2g4aOC0x4u1bijdJ19eA8MkzcZwVuyJnAWO
         9jl3Khmkw5cX7prxjyfol2JV7wYgaD/5QawwHlo4LecI/xPPpuzJ0+R0SNAxr/Y66b8O
         nYza3jE3kOURTeMEkAqZpXprsWIgLnFP/ypKA=
Received: by 10.86.98.14 with SMTP id v14mr6047923fgb.74.1221492473751;
        Mon, 15 Sep 2008 08:27:53 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Mon, 15 Sep 2008 08:27:53 -0700 (PDT)
In-Reply-To: <263224.61965.qm@web95002.mail.in2.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95914>

On Mon, Sep 15, 2008 at 1:46 PM, dhruva <dhruva@ymail.com> wrote:
> ----- Original Message ----
>> From: Tor Arvid Lund <torarvid@gmail.com>
------ >8 ------
>> Hmm.. I thought this was not a p4 problem. I think however, that
>> "git-p4 submit" tries to do git format-patch and then git apply that
>> patch to the p4 directory. In other words, I believe that git apply
>> fails since the file in the p4 dir has the keywords expanded, while
>> the patch does not. I haven't done any careful investigation, but If
>> my assumption is true, it sounds like dhruvas patch should work...
>
> Your assumption is true (from my understanding of the code). My doubt is, even the files in p4 folder will be from git with no RCS keyword expanded. The patch application must ideally be clean! I am confused here.

Hmm, regarding the p4 folder - I'm pretty sure git-p4 calls "p4 sync
<depotpath>/..." in that folder before applying the patch. So those
files are whatever p4 says they are - which is with keywords
expanded...

-TAL-
