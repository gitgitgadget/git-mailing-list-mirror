From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCHv6] clone --single: limit the fetch refspec to fetched branch
Date: Wed, 19 Sep 2012 10:24:10 +0200
Message-ID: <CAN0XMOKxOsXZ_gHy-MAwzwS5j-6npd8YeiTmbGeKU73zwAD7ag@mail.gmail.com>
References: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
	<1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
	<CACsJy8AjCC2C2dGt+G0V1FZWVJg1f=QGetTJdB4-JVEs8f4DBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEFa7-0005xM-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 10:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2ISIYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 04:24:13 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:44582 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab2ISIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 04:24:12 -0400
Received: by wibhr14 with SMTP id hr14so832574wib.1
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VQyzc4i9tLdLG9mySYAxoxBDeIZsAE+RpdZgxbKSTMk=;
        b=T9JW3ODpXKhd4c6rsoxTuNw9huiFFYDAnVN0//hOFgwHDg72yLbVA+sHIWYn4rv3Ur
         KeEhHjjbDYSDS3ifYAaVJ7cGAbTllW/sFd9wxLgW0wnvrzK3IqFSvRkjB3cUz9ZRsfTO
         c9v6vq8r6A/5HrZaM03qhVEJeRahHLz6L5oqpB8Ao4JaPtMl9BDjW2+LAZG4MYiZWQkh
         LjIj0i4+21KaLpHToI6b/r4I8ZSypyY8PyytUz6Um5QSYjGAkue5ZCrI/bF7UiPFWB3y
         ndNjfMlgvWfyfm5tKpIzjshTpw/3iJ9hljpe1K1Uavg6Xj111jPXHoSyFxE1p7s2lJ5H
         2Phw==
Received: by 10.216.141.14 with SMTP id f14mr778530wej.208.1348043050423; Wed,
 19 Sep 2012 01:24:10 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Wed, 19 Sep 2012 01:24:10 -0700 (PDT)
In-Reply-To: <CACsJy8AjCC2C2dGt+G0V1FZWVJg1f=QGetTJdB4-JVEs8f4DBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205917>

On Wed, Sep 19, 2012 at 9:36 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Sep 19, 2012 at 2:14 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> +test_expect_success '--single-branch with explicit --branch tag' '
>> +       (
>> +               cd dir_tag && git fetch &&
>> +               git for-each-ref refs/tags >../actual
>> +       ) &&
>> +       git for-each-ref refs/tags >expect &&
>> +       test_cmp expect actual
>> +'
>
> We should have added the tag right after cloning, not until the first
> git-fetch. Not that I object how you do it in this patch. Just a note
> to myself that if I'm going to do that, I'll need to update this test
> to update the change tag before fetching and verify the tag is updated
> after git-fetch.
> --
> Duy

Right. I'll create two tests to replace this one. The first test
verifys that the tag
has been added after cloning. And in the second test, the tag gets updated in
the cloned repository and we verify that the next fetch updates the tag, which
catches my "delivery" tag example.
