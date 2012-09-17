From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched branch
Date: Mon, 17 Sep 2012 19:11:11 +0700
Message-ID: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org> <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:11:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDaB5-00022j-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab2IQMLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:11:43 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46975 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab2IQMLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:11:42 -0400
Received: by qaas11 with SMTP id s11so1468577qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZUq1mzWWTi5KuOWeUNgMug+19LzePDs6+SrKvxYUs9A=;
        b=cI9+gn6xzbTn8Vd24RdGneY6I2mTIOtWL8rXJp+hnGxy35H5uai8K/APy4pECriJSf
         BMvlOcQVn/r7Fq6t3ZOpVjgDsoZzyL2lN+O0/zphhqZRjEQWVpu592CgW74ttcMLsW47
         9dYbDUHOL3GEHY+eY1+rvSElAp2gY+FJOGIz5/vyEntV4QpQ27EQzakQlQrDFb3VCefB
         PKI9GB+aZKy88lPFgzQO3G2ZWb3e71ephiLcJ8E3ujuFPA3AMWNJRAc4+SavsYLmMJew
         ZN6geRe/tsIFil0BXmCoJge/9iyXg5uZvfURu4sITa9ZNP6y1BNy66tSzj8KZahuOS1r
         dVzA==
Received: by 10.224.117.82 with SMTP id p18mr26889123qaq.21.1347883901865;
 Mon, 17 Sep 2012 05:11:41 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Mon, 17 Sep 2012 05:11:11 -0700 (PDT)
In-Reply-To: <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205678>

On Mon, Sep 17, 2012 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> --mirror --single-branch combination does not look right. The "heads/"
> part is missing..

It also does not look right for cloning a tag:

$ LANG=C ./git clone --single-branch --branch=v1.7.0 .git abc
Cloning into 'abc'...
done.
Note: checking out 'e923eaeb901ff056421b9007adcbbce271caa7b6'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

$ grep fetch abc/.git/config
        fetch = +refs/heads/v1.7.0:refs/remotes/origin/v1.7.0
-- 
Duy
