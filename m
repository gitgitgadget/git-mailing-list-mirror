From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v4 11/12] format-patch: update append_signoff prototype
Date: Tue, 12 Feb 2013 14:51:48 -0800
Message-ID: <CA+sFfMcJf2Jdjs8T3Sxx6gZGNrrtNYQog5p33NV0QOf4dAP-Ww@mail.gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
	<1360664260-11803-12-git-send-email-drafnel@gmail.com>
	<7v1uclgwk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ohx-0000Yx-BM
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3BLWvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:51:50 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46945 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab3BLWvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:51:49 -0500
Received: by mail-wi0-f176.google.com with SMTP id hm14so5033085wib.15
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YDmFOqdgeWYkuNwWTIleOIW+h2vaw5Qx3/QL1txTtp0=;
        b=wRmFD93k/+ZsH0wjClZLr/H0P+uox/bVIkWwtVzRSkhdoxyS33lzbPopxc6x3XCVWy
         TTcklvVJ+h4tg9NgGUIQmgGdbXcXHotHTQ3xJfvzMv0pK3vzZUUGsYX39fzfOc3TODvA
         mGIk8Y/DDz3pPkC4RMtxVRjtLfyYtIZ2sVN4dG2xlfTySKQIteR31rJqkpjVUwDN7YdH
         dY5TOpIAffOLNbwfgyFrS/4FS9clepKK/r9qcZXFXw4u4Wj4PpSxK/hr48OY65NrQU3I
         s2gjKDEaGH1UqDKakJ8lnnwxu+U/Pk9UNYSysYoeP0IRsDPPWdynelAB6tnP0AWH6m2B
         wqpA==
X-Received: by 10.194.92.65 with SMTP id ck1mr34284488wjb.54.1360709508293;
 Tue, 12 Feb 2013 14:51:48 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Tue, 12 Feb 2013 14:51:48 -0800 (PST)
In-Reply-To: <7v1uclgwk7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216214>

On Tue, Feb 12, 2013 at 11:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:

>> diff --git a/builtin/log.c b/builtin/log.c
>> index 8f0b2e8..59de484 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c

>> @@ -253,9 +255,12 @@ static int detect_any_signoff(char *letter, int size)
>>       return seen_head && seen_name;
>>  }
>>
>> -static void append_signoff(struct strbuf *sb, const char *signoff)
>> +static void append_signoff(struct strbuf *sb, int ignore_footer, unsigned flag)
>>  {
>> +     unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
>
> Unused variable at this step?

Yeah, looks like that line can be dropped.

-Brandon
