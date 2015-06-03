From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP 6/8] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 3 Jun 2015 15:57:34 +0800
Message-ID: <CACRoPnQVfUke3eGbTE-sQbV8drH7tDcE+YOpSP0xGtgk9z_FTA@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-7-git-send-email-pyokagan@gmail.com>
	<xmqqh9qxk6tb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 09:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z03Ya-0002tP-2a
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 09:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbbFCH5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 03:57:39 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36072 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbbFCH5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 03:57:35 -0400
Received: by laei3 with SMTP id i3so1710469lae.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VF9vXkqHu2TdA/9uTLO0IzYzawG24GE3f+tm4+WxC2U=;
        b=rxs+Gij6hhzNSVV4c6Bp6x3NEPH2w0Z4Oe9x+moz9Igt949jABH7sAaT3wpUluNkzI
         UkOrdqLFfT5VhU8pC8MNAujjC1STiztIrqxWM3Rx2mVWYtT8l+btSgcVuwISVU2c+vGM
         g8gPQiE0vye7XFTzaG/mxM3r2cx6aAMCFAzFB1niL8w9h3x2TOFrpX7vLrs+1vpKq0jr
         Qrq0bN/4om7QOG5epf4kbXyVMoPZ4p31VMtwIBveRoc23CokXkB8KW5lfBr+xXW+yFUg
         WzYUjNUBBZ1cU0jWdsJGobsa0uukESaAKdT6SBJRxOZhavxJFpFty9TW/LJp2RnFtx81
         lRwg==
X-Received: by 10.112.27.238 with SMTP id w14mr20938818lbg.80.1433318254383;
 Wed, 03 Jun 2015 00:57:34 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 3 Jun 2015 00:57:34 -0700 (PDT)
In-Reply-To: <xmqqh9qxk6tb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270662>

On Thu, May 28, 2015 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +static const char *msgnum(const struct am_state *state)
>> +{
>> +     static struct strbuf fmt = STRBUF_INIT;
>> +     static struct strbuf sb = STRBUF_INIT;
>> +
>> +     strbuf_reset(&fmt);
>> +     strbuf_addf(&fmt, "%%0%dd", state->prec);
>> +
>> +     strbuf_reset(&sb);
>> +     strbuf_addf(&sb, fmt.buf, state->cur);
>
> Hmph, wouldn't ("%*d", state->prec, state->cur) work or am I missing
> something?

Yeah, I think it would. I justs didn't know about the existence of '*'.

Thanks,
Paul
