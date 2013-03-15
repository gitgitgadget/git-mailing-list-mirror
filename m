From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 19:30:34 +0700
Message-ID: <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tboegi@web.de, git@vger.kernel.org, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 13:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGTnL-0007XY-7X
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab3COMbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 08:31:07 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:42169 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab3COMbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 08:31:06 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so3314510oag.16
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=r7S4s98m88ssHgLEcICSosy0y2QAeJdDSAuFqCnID8Y=;
        b=ADW/hW+gYM7gbHewt5f7z5rNCWnYuQZXg94JqzNrsUfXF1M5SKrq5DnCDOuljgi4mP
         M7QNHRro7tHtrjUnGGxCrXk4e2kGBlSn8W43ffvotwUtoTCiU7UpktBHqRyekBRqrb+D
         2WfaPJi2bnWNEZfOdu91xBVh5ou/dVAnNlTXNiaz0X9PPEPYE7T2yxB9KuSHb54a3kG+
         1BoqX+ByCjIVK2cx7oIkb4RmVyluagt+KTpJStlrPTxpsJhShAoavf/0xib4as46MxfD
         5xRdiohaBA/v6f1LZxTT/Dz6unAtm8sFYVowildqe9AdNT5gbWb/xH2vrHzvnPzG7UOK
         svKQ==
X-Received: by 10.60.171.230 with SMTP id ax6mr2810608oec.25.1363350664607;
 Fri, 15 Mar 2013 05:31:04 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Fri, 15 Mar 2013 05:30:34 -0700 (PDT)
In-Reply-To: <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218239>

On Thu, Mar 14, 2013 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "to speed up by stopping displaying untracked files" does not look
>>> like giving a balanced suggestion.  It is increasing the risk of
>>> forgetting about newly created files the user may want to add, but
>>> the risk is not properly warned.
>>
>> How about "It took X ms to collect untracked files.\nCheck out the
>> option -u for a potential speedup"? I deliberately hide "no" so that
>> the user cannot blindly type and run it without reading document
>> first. We can give full explanation and warning there in the document.
>
> But it makes the advise much less useful to introduce more levels of
> indirections, no?

To me the message's value is the pointer to -uno that not many people
know about. And I don't want it to be too verbose as there'll be false
positives (cold cache, busy disks, low memory..), 2-3 lines should be
max. So indirections are not a concern. You want to speed up, you need
to pay some time. Anyway how do you put it to suggest -uno in
git-status with all the implications?
-- 
Duy
