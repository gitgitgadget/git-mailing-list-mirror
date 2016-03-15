From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 15/15] branch: implement '--format' option
Date: Tue, 15 Mar 2016 22:08:22 +0530
Message-ID: <CAOLa=ZRk3Tjo1=EEt+9WkZpE1gPkujNrh2guHdYAd63Gk9bmyg@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-16-git-send-email-Karthik.188@gmail.com> <CA+P7+xouB+C+pKMGhJavB+e0jadFUGEDcgcmWWot1AYTxKMY1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:38:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afrzm-0002v0-1v
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934711AbcCOQiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:38:54 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34509 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbcCOQiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:38:52 -0400
Received: by mail-vk0-f43.google.com with SMTP id e185so27877550vkb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mwLZaBQy5I06XpWtYSTcWoXLSBezxDlKQIutl/o72bE=;
        b=P+HHR2vKv1yC+wDFGiZWaHK31N+kj1FFDOKwn/bs1xetO9zXsJpIQOnCsTTBbFbCm4
         NyM10auFsA9buEF36U5JyFCIbzCF8l7FA5F0l8U14jTVmQ2wzAm2jR8AXPSMaInCO8zl
         EFYXnjZvGC5dRWNbks9baJucSOHrWkEjIomO5rtuzepuzxKuRe16yImT8CWlVESL7yrV
         /OE8R95uCMFl0FW04+iF3D++cThWJwpjA2rF27xblZCmP2IdskdpJMDmgARzNSKDq6k2
         n7vn1GFiXAjaGNy5PWkpCM5fzBRiSG5YsGJHZotRkVapSZwxux6TQdPN61yDQWm5BB1Y
         HC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mwLZaBQy5I06XpWtYSTcWoXLSBezxDlKQIutl/o72bE=;
        b=PQUq1lwq/JEpwf15ePyyRTCpOXpvftw+HS7/zfxwbRfRuu/n5SrXy2art+6hKbE5lq
         /sqNV0dQ48kRxXTWim6h0Vn9FuPwWR+M48CA/SlNe8u/kv3nOp3UVfjQx/p2DwL/lY03
         HltIVHxH+ZoO2Hh+2Z7PpeEDuUGTr4SDWplVTcOcyXmZtP3l8TunYR22BKnxQRJz/9FC
         Zn/OLl2qx593Cmrdtv+aYHLmcc+1EmKHTKIb8Vl1pGHpw0TDxhN+gcL2xOlN4DjNFrHM
         navpNXEHJJ8mSfhi3nutNS29YT6vWfQWOxlwMJZEsR63z0z0Qs0VWAwGhjYj+7a7TCPo
         od2g==
X-Gm-Message-State: AD7BkJI2QpWm5/ma2QYtBEo5E3wlGSmkuirQp/EqPXqHaTiGG2P7Sy43EfiFyZC4KGSPNyb5MpUZHHt86DJoQw==
X-Received: by 10.31.8.205 with SMTP id 196mr32406863vki.144.1458059931544;
 Tue, 15 Mar 2016 09:38:51 -0700 (PDT)
Received: by 10.103.112.68 with HTTP; Tue, 15 Mar 2016 09:38:22 -0700 (PDT)
In-Reply-To: <CA+P7+xouB+C+pKMGhJavB+e0jadFUGEDcgcmWWot1AYTxKMY1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288860>

On Tue, Mar 8, 2016 at 7:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Mar 6, 2016 at 4:05 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement the '--format' option provided by 'ref-filter'.
>> This lets the user list tags as per desired format similar
>> to the implementation in 'git for-each-ref'.
>>
>
> s/tags/branches/ maybe?
>
> Thanks,
> Jake

Copy-Paste error, will fix. Thank you.

-- 
Regards,
Karthik Nayak
