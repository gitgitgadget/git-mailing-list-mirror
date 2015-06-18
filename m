From: Luke Diamand <luke@diamand.org>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 23:47:03 +0100
Message-ID: <CAE5ih79KhNXqvSNW-w8pMmiys2Dv24Rt4KFdRdoA9EuPDS3ELw@mail.gmail.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
	<xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5iag-00064n-EH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbFRWrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:47:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33564 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbFRWrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:47:05 -0400
Received: by obbkn5 with SMTP id kn5so35264332obb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2d+xVbeBkD2NsVF0SXZTmQWGe1xBuzgpYy2VYQf+PWY=;
        b=PGuD7imADq/wSWxfVXIgARoYTv/gbDwRbBNxFnMPgunGH8F9lokwtJSexNV9extoI7
         iIX+I/0Vk/faG5RyoyUFaA27qKKCt+thpT3Oe2Hnb1NSC/0haC3e/f8J048jAaaHQ6Xp
         MYnTNnxQRMW5bziqcvTY94NUO3vldubTL6dEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2d+xVbeBkD2NsVF0SXZTmQWGe1xBuzgpYy2VYQf+PWY=;
        b=GaDwC8Yyq83pI8wyzcNpExMHOLxfm9yUQmM9NLkeJpWu4jGW0xOQ/3VC+smC5vK4f5
         a+2OWhoFNA3m9tcUn7hXzj+zmbrm10XcyEjVEI/4r1FvBAv1G/llGebdMGT43hT1GMZk
         rthUKIkuFIoPXdTXJSbO20jUzJguyhNKTa0NWqjf5Jg/D9JpTQypzQ5VEIQ/S2NP01s8
         Lq38E2exP7Hwq0ciQ2RQuwjNASXrd09EzrjzPmz9fq0zBIxNmhT5iz8Q1lbiknqvn5A0
         ttUVbt60utQnliyFPl3AM5LOo8kmEqebjlRpyM7vBj2pN/c4Nf8qkjYa1PPrQThrr98k
         PXnQ==
X-Gm-Message-State: ALoCoQlZGhAk61VMvMxJyIcbp/qF3eYygrZykeMt5QhIwqC20QxnwK4RWo/otDlcJ3kue00MBX4x
X-Received: by 10.202.198.151 with SMTP id w145mr470899oif.72.1434667624080;
 Thu, 18 Jun 2015 15:47:04 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Thu, 18 Jun 2015 15:47:03 -0700 (PDT)
In-Reply-To: <xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272091>

On 18 June 2015 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> This is probably user error, but I'm not sure what I'm doing wrong.
>> I'm posting here in case anyone else gets the same thing
>>
>> I'm using 2.4.4.598.gd7bed1d, i.e. 'next' as of today.
>>
>> I've somehow ended up with history skipping back in time, but git not
>> prepared to let let me fix it, or something.
>>
>> $ git diff upstream/master -- subtree
>>  - lots of deltas, which look like I've reverted this back several
>> revisions (which I haven't AFAIK)
>
> Are you on the right branch that you think you are working on?

Yes.

>
>> $ git checkout upstream/master -- subtree
>> $ git diff upstream/master -- subtree
>> -- still lots of deltas
>
> Does this show _ONLY_ additions?  Or does it include modifications
> and removals?

There are indeed _ONLY_ additions.
