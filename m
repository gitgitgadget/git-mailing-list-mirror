From: Stefan Beller <sbeller@google.com>
Subject: Re: git pull not ignoring the file which has been sent to the
 temporary ignore list
Date: Fri, 23 Jan 2015 14:32:33 -0800
Message-ID: <CAGZ79kaNHjAna3PBxMEfZV1dfZnoohst1Ky5aSkCi+v4NBcN=w@mail.gmail.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
	<xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
	<4004424.cytMaov38D@linux-wzza.site>
	<CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
	<xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaJkDjr7uPScKgO=P5nVZ4sQgn1aQNf9MwVuHMcA4a2NQ@mail.gmail.com>
	<xmqq4mrhqgl4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arup Rakshit <aruprakshit@rocketmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:32:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmmM-0007Dx-S3
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbbAWWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:32:36 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40625 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbAWWce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:32:34 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so66401ier.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 14:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6wKXFJ4WbVGiCkpEGRNmmvO7IFGrchqLN5eihoD2PDU=;
        b=V72Sh6LHAMAYHWBdm3WZoxwtTxrZ4/riqjadQHOznAmFzyrf0ZlF3bYiGeibnX7UtZ
         +Dv6tqPLUOCXMtntiiPxqq4M5wOmwMrA2/amuMld71WQevtcZG4VsSadwRYa8HJtsWda
         gqXtXdsAZRHszu3N7FFikZXbB2b2tZTlVNyoF1iJ7+I9Bfu4EFbFEv8sNvyrbTYd5mn7
         MWcmTvT5V60bCrEkrAdvmzyQrSFzV+h+Bu0Vy+zDHRdAXcLnFElrfT2nk9LotsI9fkao
         4gDtsdXKVstjh8kiK+cnDZeIhTlrw+QiWOJ/m4GE7cNWLCjRSigQtEBGByWlXKs7nX6l
         9T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6wKXFJ4WbVGiCkpEGRNmmvO7IFGrchqLN5eihoD2PDU=;
        b=Kuaznqvys43fzQkrxGFiWpGy4oJk4MXlv1y9LGLgr/oBNcl2JcbLLw1WtLra/IDhU7
         TQaL+Qe4JM+YYzMlnBLfanKfNgQqaWXFb8i2ExhShCo7+TGEHJsVnYVcK3Zp5Dkv/xRv
         G/fv7at1N7KMxoasjJCqPyIBeN3Cd6PpPGnfgrQn1j6heLTbfpJ1T4ye2kfS8NBNU8Jv
         h1UHPQKnrlYl8El+w80i4Z+eHdqgHd/Y76prNiKYxUN62VurtFQVbXHvLrnOQrBORvNU
         tReB/IkYXpfsFVkjfA1Jci/cfzfwxe2G+b84DDV34JG/u8BWpsRAxKP4du0kD/sa5aXY
         x0AA==
X-Gm-Message-State: ALoCoQkx1tglkGHEQuT2L26IJhaKsMdjVxCRSJ5P+uC3nBSrgr7e+xonpIZgMS6CdOYEIgIx5SWf
X-Received: by 10.107.16.138 with SMTP id 10mr6249771ioq.33.1422052353815;
 Fri, 23 Jan 2015 14:32:33 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 14:32:33 -0800 (PST)
In-Reply-To: <xmqq4mrhqgl4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262970>

On Fri, Jan 23, 2015 at 2:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Assuming you want to ignore less than the upstream project (delete some
>> lines from .gitignore) it get's tricky in my opinion.
>
> Why?  Doesn't info/exclude allow negative ignore patterns?

I used negative patterns only once, so they did not come to my mind today.
Apologies for not looking it up before replying. :(
