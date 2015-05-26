From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to
 'ref-filter'
Date: Tue, 26 May 2015 12:28:59 +0530
Message-ID: <556419B3.5030902@gmail.com>
References: <556317F8.2070609@gmail.com> <1432557943-25337-1-git-send-email-karthik.188@gmail.com> <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com> <55636301.7060803@gmail.com> <xmqq617gbg58.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 08:59:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx8pZ-0000bj-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 08:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbbEZG7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 02:59:07 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35922 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbEZG7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 02:59:05 -0400
Received: by paza2 with SMTP id a2so76712178paz.3
        for <git@vger.kernel.org>; Mon, 25 May 2015 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BpyINOsyt4gNDyfbWTTiUQg1ceKXcEYD91H5Mp13UsU=;
        b=TzrdkjdwqrLK1J5NHC49UzbdH6na4AB5JRpJER+GRt8FIg8+96ixMzXlp+DjEbdG8S
         6fbnVOrgE+ZAmd5fDKq7c1FzZyCAhoOHKgWS9A5KF+9h1uxE762FDX1FKkKuAONO6ecU
         PlR2G8FUR1dnXl3qHJNQDL0WfRGkXcjo1jDbzQAyx+9kKR7HHrEfjxZljWsg2ZgBCLU3
         Y1go0zVeJdQLZXmdq0vjAD5g0QYfjbvUpV2wUJtqZzf4ncYANJjXDb4PO7PT/5NAYW6k
         D9rjMJ/eTDfQfe648Bw2dJ+V9DkMUz2AHKGSeIB4t3eaA0N1MpIOFEi8TQrnXpZZC1YD
         lS2A==
X-Received: by 10.66.141.12 with SMTP id rk12mr45371476pab.97.1432623544538;
        Mon, 25 May 2015 23:59:04 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id bx8sm12026837pab.38.2015.05.25.23.59.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 23:59:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqq617gbg58.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269933>

>
> Also I think Matthieu already commented that "filter" was out of
> place for that struct.  I still think your ref_list is better called
> ref_array, but that is a minor point.  Use of "foo_list" in our
> codebase is predominantly (because we use "commit_list" very often
> in the core part of the system) for a linear linked list where you
> do not have a random access to the items.  string-list is misnomer,
> I would think.
>

ref_array also sounds good, yes! there might be confusion and might be
considered a linked list rather than an array. Will change.

>
> I think you now know after seeing that 56-patch series ;-)
>

Haha, That definitely helped.

>
> If that is the case, I would suggest making that "turn it flex array"
> a separate step.
>

Sure.

-- 
Regards,
Karthik
