From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 21:41:50 +0200
Message-ID: <CAA01Csp6tjKJ9LqX+9qcJL4t3kfFJCagjZQ=QwddvscPori9Ow@mail.gmail.com>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	<vpqvc1z6eoo.fsf@anie.imag.fr>
	<CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
	<CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
	<xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
	<1496b663-6b6c-45a2-95d1-cbe634b0d160@email.android.com>
	<xmqqpps7xoax.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM19q-0002YT-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab3IQTlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 15:41:55 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:47553 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3IQTlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:41:51 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so2944238eae.23
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2SA4n67T7DGnk1adcqSSY29p467zgm1NJ1Jl7BmWgu0=;
        b=Ne3Qtqnc9s/ptoc9yT0bkgRW+jUOw7w9uqTEdu/MRLHrR3k1ZRHnlLcwJLwI/EP8B3
         j4XpMiiuv7IXwob9izDV2fELUXKWigFgJ8uZ9iM3xBEjKVVd+oD7bl8LIEOCsz/xAg4M
         AK3FU+t6kNks8LQDSGhVG+qSBTvdpKmXn6FEBWuANOU3x10qdgR3DbUkcllizeeoY8vV
         SYbSn66NU8FE87WPEb9ogeXTbtk/UyRpvcYT2F+llkYWXKIf/Xf6jQmEPg6BttP/U2Lo
         KH+2IxYs3s6umximVWbodUAiDpTcll9JQ9lfi/KwhYDBYxTJrNR28MQSy/0BAmOl6rSr
         ATjA==
X-Received: by 10.15.99.72 with SMTP id bk48mr54031094eeb.22.1379446910166;
 Tue, 17 Sep 2013 12:41:50 -0700 (PDT)
Received: by 10.223.193.4 with HTTP; Tue, 17 Sep 2013 12:41:50 -0700 (PDT)
In-Reply-To: <xmqqpps7xoax.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234908>

On Tue, Sep 17, 2013 at 9:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>>  What about simply iterating over options in order in which they
>>  are specified and the last option that matches specifies the
>>  result?
>
> But isn't it very inconsistent from the way normal pathspec works?
> "git log -- A B" and "git log -- B A" would give the same result.

Both are include-type filters. "--include A --include B" will give the
same result as "--include B --include A" too.

Are there existing include/exclude filters where order does not
matter? For example gitattributes(5) says "When more than one pattern
matches the path, a later line overrides an earlier line."

Ignoring (possible) inconsistency thing, I think they are easy to
understand and use.


-- 
Piotr Krukowiecki
