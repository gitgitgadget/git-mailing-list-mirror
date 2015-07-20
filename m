From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 16:26:20 -0400
Message-ID: <CAPig+cTJ3uKhSbvPKen7UQxoqVx3ZOET9k-8w73igTbrQB5iig@mail.gmail.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
	<CAPig+cQ2nTt60iw0Td_MTP7xftt2+OQAx63pOZ4XzH0qeOhDsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHHdr-0005yC-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 22:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbbGTU0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 16:26:22 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36121 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbGTU0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 16:26:21 -0400
Received: by ykay190 with SMTP id y190so148255641yka.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4Uv7mGyWglSQKgWr3Mthk37nx6UTo9JPD2x5XBE7Nxs=;
        b=lFLLnW8cSNsBT7mKhXx5Kh9aAKvf/ZIR2zH7/HYa3db8qRbrGBcW4IsF57BuTWwdo/
         YWO/7MpH78rPH/1ZgGZ3yu942HUZpqKfFZpGJZCCemuyytmxtT+7RbRrmSknwLOc2wN7
         8t2COZy0+FKqnSz/bamGx9E2xvAaHnXbwpo4RV2aTcdh8uiICBN5WhG/tA1qmuistRvH
         dEpHD7VHI2dVESjrQEI8dyH+rni2XfhHzgs/n5vFP5lC2CGaXps5ezT4S7oPT2W61JLL
         BdADqGbqbrYa/htjj1TS8qOo6ldyOatTQ47etrbsqq/OMqyn4IsxUFbvLTmNZ71QVK46
         hZNQ==
X-Received: by 10.13.207.1 with SMTP id r1mr30258296ywd.166.1437423980484;
 Mon, 20 Jul 2015 13:26:20 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 13:26:20 -0700 (PDT)
In-Reply-To: <CAPig+cQ2nTt60iw0Td_MTP7xftt2+OQAx63pOZ4XzH0qeOhDsA@mail.gmail.com>
X-Google-Sender-Auth: MlJNL4168pDDoKE6n57zBnc4eZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274352>

On Mon, Jul 20, 2015 at 3:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> If you really want to give an example of how to use --cc-cmd
> (--to-cmd) with a plain text file holding email addresses, maybe
> something like this instead:
>
> Create an EXAMPLES section.
>
> Make the bare-bones, static address list script the first example:
>
>     #!/bin/sh
>     echo <<\EOF
>     person1@example.com
>     person2@example.com
>     EOF
>
> Then add an example showing how to take the fixed address list from a
> plain text file. Have the user create the following script (let's call
> it "anticat") which cat's all of its input arguments except the final
> one, which is the patch itself:
>
>     #!/bin/sh
>     while test $# -gt 1
>     do
>         cat $1
>         shift
>     done
>
> And, to use: --to-cccmd='anticat myaddresses.txt'

I forgot to add that even this is iffy as an example because it
depends upon the current implementation passing the cmd string to a
shell, which might not always be the case, and might not be reliably
implemented that way on some platforms (such as Windows).
