From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in
 t0090-cache-tree
Date: Mon, 22 Dec 2014 15:38:07 -0800
Message-ID: <20141222233807.GU29365@google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
 <xmqqd27b6zd3.fsf@gitster.dls.corp.google.com>
 <xmqq8uhz6za0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bdwalton@gmail.com>, dturner@twopensource.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CYO-0007JF-QL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbaLVXiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:38:16 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:62503 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaLVXiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:38:15 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so3331400iec.26
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=da/GcWA+JQaCjcjnsjuUiINHtSCKhljzFriti9WwvGA=;
        b=qx9gDhEm8oOZHMWtC1D913k02OJdmrw9/62htfLYF/5YQKT47H3QIsT3uUG39bjm0P
         cDM29M7A846Una1tVGwxiPCDlexKDLPg//lV0H/MSTqQNgpjO6ArmRfkSW/6AD29bh3R
         vDABwm1VtL2IQJn1h/EBb7GdIploFZGcOW0xyUhO8R6Mjmd3sXcgr/zwgvobFR7OBcu+
         MWF4D3334igoToVkdG2MIteaJnSugBAw7ieaW95PCJX20qGBvMZx8OjLKnpDoEWvV6S3
         xKSNm8FcFvZYJPy3jekP1aui4+YtL+KwnnIrMHVmtJ6GX1BKBeFEk96uSobMjV9FIdTR
         YEUA==
X-Received: by 10.42.155.71 with SMTP id t7mr19524214icw.96.1419291490045;
        Mon, 22 Dec 2014 15:38:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id i19sm5563988igh.6.2014.12.22.15.38.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 15:38:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq8uhz6za0.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261702>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> From: Ben Walton <bdwalton@gmail.com>
>>
>> The awk statements previously used in this test weren't compatible
>> with the native versions of awk on Solaris:
>>
>>     echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
>>     awk: syntax error near line 1
>>     awk: bailing out near line 1

If I were doing it, I'd leave the above four lines out --- they are
describing an unrelated problem.  I wonder if we should make the test
harness respect SANE_TOOL_PATH to avoid that kind of problem in the
future.

[...]
> heh, not like that without updating the subject, perhaps like this:
>
> Subject: t0090: tweak awk statement for Solaris /usr/xpg4/bin/awk

With the updated subject,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
