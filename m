From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 13:17:16 -0500
Message-ID: <CAPig+cQzkQ2G2EbrkDXHq4eytywFbJKPO2kxFTOxrcACQJCZ6g@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com>
	<CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com>
	<CAOLa=ZQ4-Qwp84XgTS9joGW4rJRiw8VMTf+Y1Dzo5M-ZNPZXuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6fG-0007BM-GK
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbcBQSRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:17:22 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34159 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965178AbcBQSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:17:17 -0500
Received: by mail-vk0-f49.google.com with SMTP id e185so22202224vkb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tOgxzjiy6ly4FYJXLvOoiNUStW8hOVBmHy0Iw7azuoE=;
        b=qCNlHrKRDXfT2bWg25NO+HSZTkMTjJW+xHphb9ok4gzQNcmTjXi/uv6OuMRU2cP48K
         hX8+DR3DCVJ2AKEGvAUt9zGHw6jBRaXCngUTDZi44TsLrQ71hyO22Z4Veex/g7WFxARS
         576ggLhY/T6vWekvGZFE79AUmLWKm4/uCy30Y1PhSZ2/KYUkb8aeA1esL8nAEk4hq8bo
         PlzEYLGuFwaloU4JE9ltxjej7SJWz0krycHE04bhK/rCIaba3WA8lZyarD9W9q+uzGg1
         kgCplGosEH2eBEibVMBJ4m7LIVUuubxC5EDBlK/QX++VpPeN2WVgMmbdJerWXuPTV6sI
         hKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tOgxzjiy6ly4FYJXLvOoiNUStW8hOVBmHy0Iw7azuoE=;
        b=a5L+A0v/2qI3+QWpwaZpTeKAdVmnRbVv8uG7CpTTjHP0cnRpG4HKGl8nmcMA4Ejqyb
         cSv81K7gdrthPMdiBtFf8TFirhdX2OHZ9IhYNWo278Im353fVw6JYV4dSLxPB87eLfEV
         TC5545dFzb0j04ojJc6/Picz3zK3QHbb40kfN7WXgS0XAIFlPYnWV/0EWlnpx+UHaKgM
         HTIGLmBKyM4rmNW7piY4/j9MpYnx5UTgha0fL19A+abqhpLFD+cy0JJtHQtYZrcwfgm1
         2Nh4cBP/vMSlt5aHeKI+opDRPMIeMRpyYf5zS1Ci8sffNNjPbVhsbOPxnsnfivygQMRL
         8SpA==
X-Gm-Message-State: AG10YORJDhn837XckTE5yNFzkdXT3SWNiXcZQT5SGbpa+nt/9nKOzswzMPetelyH+lmsllZVn1c/L51bfsPSAA==
X-Received: by 10.31.141.2 with SMTP id p2mr2533009vkd.37.1455733036592; Wed,
 17 Feb 2016 10:17:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 17 Feb 2016 10:17:16 -0800 (PST)
In-Reply-To: <CAOLa=ZQ4-Qwp84XgTS9joGW4rJRiw8VMTf+Y1Dzo5M-ZNPZXuA@mail.gmail.com>
X-Google-Sender-Auth: c7-h1e0Yw4ewC6f8FEHcNUA4jzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286530>

On Wed, Feb 17, 2016 at 1:07 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Feb 17, 2016 at 11:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> I reviewed the entire series again, including Peff's changes, so this
>> entire series is:
>>
>>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>>
>> Karthik, feel free to include my Reviewed-by: in all the patches
>> (including Peff's) when you post v6.
>
> Oops! I just pushed v6 before I even saw this mail.

No problem. Junio can add my Reviewed-by: if he wants when he picks up
the series.
