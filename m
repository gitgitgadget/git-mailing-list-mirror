From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH 0/5] Fast forward strategies allow, never, and only
Date: Wed, 23 Apr 2008 22:39:48 -0700
Message-ID: <402c10cd0804232239p3e49a6d0vdc1ff9acb3636a17@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
	 <7vskym310l.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0803192347q7b4a3fb0s35737f361d53a86a@mail.gmail.com>
	 <7vbq56ilnj.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0803252050u582111cag18674e0257ac2884@mail.gmail.com>
	 <402c10cd0803302119r251b3a43te69ce2a52e121ba5@mail.gmail.com>
	 <402c10cd0804191806h5460eb82y2442517343734b8e@mail.gmail.com>
	 <7vhcdu2uu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 07:40:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JouCF-0002gQ-Jn
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 07:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYDXFjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 01:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYDXFjv
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 01:39:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:39463 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYDXFju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 01:39:50 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4197093fkr.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rr54VTD+I7z1Rz5xUKbiBTy5o11Jhz5oyQd6DryIdxc=;
        b=brgEDQOHCJxDLYec+R9Pw/b63g+Y+klDG/YcckD9nJ8F8dlhNWPdQcMIU676SNEJPtt4mnn8Bk7le/aoWjwToktWKA1kcb7Tzsm4gMiKA3QHx3gXrhlBUW7dBxS5hCHlYLU8ImBYHCZd9wdNbkwMAztIfLwd6FG7xLe1i1V8k4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ra4Te8czEDz9bC/x3QDn19vOVtYcEcuozjGMEol0PCVn0VkvcUo6AH5UOZYcjvTSQ+bQBeyarLX0Kw0orET83Ekp5K4ub9uRApsk7WHMdg40c7s+MBNpwcVf/LdzJKbaujS8WNSuFE53vNpR5V2ELnH/RmETSOW2rnwOVIwvIjk=
Received: by 10.82.140.20 with SMTP id n20mr2148507bud.86.1209015588799;
        Wed, 23 Apr 2008 22:39:48 -0700 (PDT)
Received: by 10.82.156.16 with HTTP; Wed, 23 Apr 2008 22:39:48 -0700 (PDT)
In-Reply-To: <7vhcdu2uu5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80284>

On Tue, Apr 22, 2008 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  Sorry, but I am with a rather big backlog and am reluctant to go back the
>  archive a looong way to pick up and comment on a series when not many
>  people are wondering what happened to the wonderful series ;-)  Care to
>  resend and ask for comments from people?

 I resending these patches for you to coment.  The patch series
consists of the following five patches:

  0001-New-merge-tests.patch
  0002-Introduce-ff-fast-forward-option.patch
  0003-Restructure-git-merge.sh.patch
  0004-Head-reduction-before-selecting-merge-strategy.patch
  0005-Introduce-fast-forward-option-only.patch

The first patch add some tests.  The second, fourth, and fifth adds
new features and they are all trivial.  I was able to make the fourth
patch trivial as well by actually doing the real work of finding the
reduced parents in the third patch.  The third patch computes the
reduced parents but uses it only to determine whether we are
up-to-date or do a fast forward.

There are probably some minor adjustments to the documentation we
should do. The patch series uses the term actual-parents and
reduced-parents in the code and the documentation.  Maybe we should
use the term actual-heads and reduced-heads instead?  I am not sure
that all the documentation for 0004 should be included.  Please give
me some advise regarding this.

-- 
Sverre Hvammen Johansen
