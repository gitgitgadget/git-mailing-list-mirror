From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 14:54:07 -0400
Message-ID: <CAPig+cQG-yjmw6uMN0bL-3jYhgffi5Mc6rOsRePTLBvXpfdiKQ@mail.gmail.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<1431022630-7005-1-git-send-email-lars@redhat.com>
	<CAPig+cSPGguo1mEqfCTpLbHuCMaKkH8YQhoDCOPM82Fjt0C+eg@mail.gmail.com>
	<20150507184804.GF16334@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQw3-00024C-9o
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbEGSyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:54:09 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32812 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbbEGSyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:54:07 -0400
Received: by igbpi8 with SMTP id pi8so17081568igb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Sv6Bx9++f5N1W+1gnLT4lgOrqgsbdAvWv7vtn93PTiQ=;
        b=J+5MtLpzyHnTlkNOyHlqKwerEXhORDvS1RxpUE5YTuFkUR/DP/LeiqPV5rBWAi52hD
         wa/s7fV6SjWtyZ7r0JO2ogHz4UkqRJTfFS80OmMSsS2tjTGf1ZbtXlUZHTz39CReW0S3
         PVOA9eyZSpdxIMeBwUJKHwC51YTFqrikTB7J6TXpL0Nh2uzwzk5K0U2E//Gtk40CWZdR
         z77HYhsBkxtKNlBe5fQqIb59e8Qbnb7C58GlTbNxeSFSjHnS2BdBoD+v2Qq3d3vMfe+s
         CORvdyIU9Cat2O/620qq6wDg2rhQLvGUvgmj+DZzUDUbse95Mx2ktIoSDUkAQep3NGqh
         gRbQ==
X-Received: by 10.50.61.200 with SMTP id s8mr55382igr.7.1431024847281; Thu, 07
 May 2015 11:54:07 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 11:54:07 -0700 (PDT)
In-Reply-To: <20150507184804.GF16334@redhat.com>
X-Google-Sender-Auth: J8fbKU3ssLGU0n7NOt2WXX9UZCM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268579>

On Thu, May 7, 2015 at 2:48 PM, Lars Kellogg-Stedman <lars@redhat.com> wrote:
> On Thu, May 07, 2015 at 02:41:07PM -0400, Eric Sunshine wrote:
>> > +       if (ssl_cipherlist != NULL && ssl_cipherlist[0] != '\0')
>>
>> In git code, this is usually spelled:
>>
>>     if (ssl_cipherlist && *ssl_cipherlist)
>
> Huh.  At least in http.c, explicit checks against NULL seem more
> common:
>
>     if (ssl_cert != NULL)
>     if (ssl_key != NULL)
>     if (ssl_capath != NULL)
>
> Etc.  I was just trying to make the new code look like the existing
> code.  If nobody else has an opinion on this, I'm inclined to leave
> the first clause as-is so that it matches and change the check for an
> empty string.

Sounds good. Matching existing style makes sense.
