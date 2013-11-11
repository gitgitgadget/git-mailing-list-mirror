From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Mon, 11 Nov 2013 17:09:17 +0100
Message-ID: <5281012D.4060708@op5.se>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 17:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfu3L-0003bG-UW
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 17:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab3KKQJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 11:09:23 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:58778 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab3KKQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 11:09:21 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so914796lab.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 08:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iWZz4qoGchncIK8g9qdmjA7RKbGWG1ZD3Ztr6UGrg6U=;
        b=KIBXvRNw5AUxhyJFoXKTful9iSnolNGIEmkpyzGn1Psl7wWnzjYZ5vMTRPPoUuEtFH
         TaasGetEmrJLmOrJMQyzUJ9xFBrC0nLsewS5M2w0sdiMRmjaz7i1UCNe9KeuyfYXNb6p
         i9EIKLCMwA79zmFkxMI/GVzXLrcFx7J96jE5UPJpzAfY4w8oUES4ZhiyxU7b1iTygcFy
         sE7WEtPeXG52HSdam+6GJ/b+RhrZDOulv7/pLq3wfkvknVazqFwnt9J5G7OPSXOpXlkA
         JUvM2infSNqYoAsa0ntMZe2wgKYo+quQU0kbIgoIfJqPSM86S8FxSH0v418EvAOCq5BH
         ZmJg==
X-Gm-Message-State: ALoCoQlU64DV5pO4OfIqj1N5uF+TOa4ApPLm1zdqxo+crBRK9HA51kuJ1X5KvLOY3zBlA+xUFdRm
X-Received: by 10.152.171.72 with SMTP id as8mr2255224lac.33.1384186160054;
        Mon, 11 Nov 2013 08:09:20 -0800 (PST)
Received: from lenix.dev.op5.com. (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPSA id jv8sm17289282lbc.2.2013.11.11.08.09.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 08:09:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237616>

On 2013-11-09 08:05, Christian Couder wrote:
> Here is a big patch series to replace prefixcmp() with a new
> has_prefix() function.
>

Seems like totally useless codechurn to me. Besides, prefixcmp()
ties in nicely with strcmp() and memcmp() (and returns 0 on a
match just like its namesakes), whereas your function must return
non-zero on match and thus can't be used as a qsort() callback.
Granted, prefixcmp() lends itself poorly to that as well, but at
least it's consistent with the other *cmp() functions.

So -1 on this whole series.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
