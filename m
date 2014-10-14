From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] remote.c - Make remote definition require a url
Date: Mon, 13 Oct 2014 21:05:47 -0400
Message-ID: <543C76EB.1000103@gmail.com>
References: <1413040849-20056-1-git-send-email-mlevedahl@gmail.com> <xmqqppdv51lv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 03:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdqYl-00062O-K4
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 03:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbaJNBFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 21:05:52 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:63999 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbaJNBFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 21:05:51 -0400
Received: by mail-qg0-f45.google.com with SMTP id q107so7552399qgd.4
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D43IixDR/bFPCKvlRPzvLMPy+q1w7o/tLWPOfY80NJE=;
        b=FaAoyIC2piFm2F5dQlBB4tF6I2lMY0rTgMFng7eenGseAmq7eZwJfLNak5Tzr7Kjib
         Dy12rjUpn9wa5Jtuakc0gXjGZSN/I69kdXIhqRaW6xZ3R/O3HEEBSSfqmgufhayqri/s
         Nt2TreOukFRotJ68BPe9N+/F8tIM7fk/LBjl0qqAENQ1/ea+E6kDsWgBF1yEcsk0egBv
         YUkFKDFiRGhj+4SgSFfqlewL1hC3bdJ9GuHfLwusOxjqVBgXe7tODMEr0dUSYWmuQaBQ
         WYArFsJfRfalwP27WqVbSBA06wX8pXfIo3AQa+SL15alCYXYEBudbnjrbSCQ3sVc+Dq1
         Lm9w==
X-Received: by 10.224.90.3 with SMTP id g3mr3756762qam.90.1413248750551;
        Mon, 13 Oct 2014 18:05:50 -0700 (PDT)
Received: from marklaptop.lan (pool-173-73-114-83.washdc.fios.verizon.net. [173.73.114.83])
        by mx.google.com with ESMTPSA id q6sm14273685qas.16.2014.10.13.18.05.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2014 18:05:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqppdv51lv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2014 01:19 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> Some options may be configured globally for a remote (e.g, tagopt).
> Or some remotes may have only pushurl and not url.  "git remote"
> output for me has a few such remotes but wouldn't this patch break
> it?
>
> If a caller that walks the list of remotes misbehaves only because
> it assumes that r->url always is always valid, isn't that assumption
> what needs to be fixed?  for_each_remote() should be kept as a way
> to enumerate all the [remote "foo"], I would think.
>
>
>
>
As long as the rule is that for_each_remote will enumerate every remote 
that has anything defined at all, even if only in the global config 
outside of a user's control, I'm not really sure how to tell whether the 
missing url / pushurl / whatever is intentional, or a misconfiguration, 
so having the code complain that it didn't find what it wanted (the 
current condition) is probably no worse than the alternatives. Patch 
withdrawn.

Mark
