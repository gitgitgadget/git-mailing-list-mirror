From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 12:29:09 +1030
Message-ID: <93c3eada0901071759u2496835dy134d92613bf4244b@mail.gmail.com>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
	 <alpine.DEB.1.00.0901080144270.30769@pacific.mpi-cbg.de>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKkCG-0000sr-4r
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZAHB7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 20:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbZAHB7L
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 20:59:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:33070 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZAHB7K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 20:59:10 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8159622rvb.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hzthWH6yAr0VW5+oB/K56Gi8Dq5CUb0ZgAPraaBuzd0=;
        b=f8Y90BPSIotKzXA4NRJ2VgNejZyfNYa2mnMBiwtZvlN39kvQe1qUrSMTK6bCxeOKZ+
         LmJXmG0esuYo8wvwh7YRKMczFOwZMKufOylL/CwpO1F7hCNzYtkLS0Zm3Tzal7Z9c1PZ
         CCAZ0f533uMrVN9TLa4rZe+Au04N4mrC3k0WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=IFOxTqFYQ9HdE+uMSDRVe7jtIFUb576qspuMaloMQCCoFvV4mqt6WLVoDYdaA3Tlyo
         4yi2mSo6XeJSTvMa14IL3xtehT0oLHeheOjUc8MovVOPmO+18j30xwJy0TiLxk6OWNdT
         OsKaDJNa7p9a/Chk6gL5+t+dAGENewzyFdsnI=
Received: by 10.140.202.12 with SMTP id z12mr11807194rvf.183.1231379949731;
        Wed, 07 Jan 2009 17:59:09 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Wed, 7 Jan 2009 17:59:09 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901080144270.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104871>

On Thu, Jan 8, 2009 at 11:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 8 Jan 2009, Geoff Russell wrote:
>
>> Dear gits,
>>
>> I have a series of commits:
>>
>>     A---B---C---D---E---F
>>
>> I want to collapse B---C---D into one single commit. git rebase -i B
>> will allow me to do this, but I'm looking for a non-interactive
>> incantation.
>
> You set GIT_EDITOR to a script ;-)

This is plan B.

>
> Alternatively, something like this should work for you:
>
>        $ git checkout A
>        $ git read-tree -u -m D
>        $ git commit -m "My message"
>        $ git cherry-pick E
>        $ git cherry-pick F

Plan B is looking good, because I'd generally like the commit message to be the
concatenation of the messages for B,C and D.

Many thanks.

Geoff.
