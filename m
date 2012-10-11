From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Thu, 11 Oct 2012 08:49:27 +0700
Message-ID: <CACsJy8CoedQBm4xyfhZX1mNTXpLMHxugygZUqOoZS8V5WVztGg@mail.gmail.com>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 03:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM7ud-0006RU-4T
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 03:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803Ab2JKBt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 21:49:59 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47053 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265Ab2JKBt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 21:49:58 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so863835iag.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rqNJdX3OJpW3KdBHG8lJnjrYHjiWZupkwZKUrraw4fs=;
        b=a1eMCNchwy/Q9318E21YfPd63TYKwtHGOPp2yWwpLwidiEhdq5d2BQTSV/JvSMvicv
         ptTeETPIngRHD/Vl72Hv4vAzmNJ+XzASs84u5H0z6kIZfe/MOfxGfqqZCxAAyyxza1Ox
         ZLQVcLYpX5FIGNNmt82PIun3uFD6WOxpDgP6haKJSOZaZOR814SM5VAtAINJPLeof32w
         xluPS2R2oBOBjLJc57ut6MiafPXEdT5K2JNvu47CvMDCrlZuGLbFFq2o69SuMY5dobX0
         nPT28tMPV34HvapLd5SRKzWFj5eFfPyPg2ktVpz3jE4OaUmDStLU6QPUex37rl97hrsJ
         PybA==
Received: by 10.50.185.231 with SMTP id ff7mr7325453igc.40.1349920197890; Wed,
 10 Oct 2012 18:49:57 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 18:49:27 -0700 (PDT)
In-Reply-To: <50758477.3030304@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207456>

On Wed, Oct 10, 2012 at 9:21 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> +     git commit -m new &&
>> +     echo "Binary file HEAD:t matches" >expect &&
>> +     git grep text HEAD -- t >actual &&
>> +     test_cmp expect actual &&
>> +     git reset HEAD^
>> +'
>
> And in yet another test, should
>
>         git grep text HEAD:t
>
> /not/ respect the binary attribute?

Gray area. Is it ok to do that without documenting it (i.e. common
sense)? I have something in mind that could do that, but it also makes
"git grep text HEAD^{tree}" not respect attributes.
-- 
Duy
