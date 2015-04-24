From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] fast-import: add options to enable/disable case folding
Date: Fri, 24 Apr 2015 10:42:14 +0100
Message-ID: <553A0FF6.6070700@diamand.org>
References: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com> <1429271526-31234-1-git-send-email-mh@glandium.org> <55313B4B.3030106@web.de> <xmqqwq1appcf.fsf@gitster.dls.corp.google.com> <20150418073611.GA13410@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 11:42:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yla8J-0006U0-SF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 11:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966868AbbDXJmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 05:42:47 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:32806 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966846AbbDXJmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 05:42:43 -0400
Received: by wgin8 with SMTP id n8so44711010wgi.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=31oqqbkr2fU3TK/L5/KEQJQegDvTmYRm9AqNwh0wukc=;
        b=i9T0HnCyDoNHMmo78uFdGIj/KQr9FENTXYLummTLLhtsVgW3cEY09Ch1RStw3aiNsq
         6IOoIDf/s3Otf3/p2DaUnLvfnfKuTebSz7JEC7aohMYk7uyU/4DVFATkcQuQucpDcu9V
         tW5Zsc8qTDWaqeAedmXdi4HOxxZSY+Sm1A0A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=31oqqbkr2fU3TK/L5/KEQJQegDvTmYRm9AqNwh0wukc=;
        b=ZzuWddCWDMyYQaFySkbIEU1noe7drKJsWzRMJtYywhUTwLcgfvCcQW/LEYTtG9vD1E
         GgmB7UCSCm1pcmuPt/QwwzynGy003BWWGc3dM1XR/KwbyKOKhXRhJU70f4gH7mLHjdXk
         0wfsotxR2vVC7WhtvSKaibcnTEkyADOJnyFdpZM4rsut6vmVGZDqUhtHXvauPtaXHGkU
         Af2oysxBoG25LOcsl/HqierV3qTxFjyxH5w7yewmRIOJj0otYExdy1VIJPjJrrxUBmgY
         FSayDufHHbTFrzs6ILnOb5VWtWQ1b9TBZSKSc+UV0YQ2WWiT65ZNm3oPJU2m76EvNbK4
         h4+A==
X-Gm-Message-State: ALoCoQmyzFRBjH3gk42WOO+214dIAg6Bg7jRmqELR4nJkz3VkZlhnyc7nkxt5V9CQaXb1xr/YEjo
X-Received: by 10.180.101.138 with SMTP id fg10mr2220782wib.46.1429868562517;
        Fri, 24 Apr 2015 02:42:42 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id gs7sm2812196wib.10.2015.04.24.02.42.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 02:42:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <20150418073611.GA13410@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267727>

On 18/04/15 08:36, Mike Hommey wrote:
> On Fri, Apr 17, 2015 at 11:44:00AM -0700, Junio C Hamano wrote:
>> So perhaps we should rip the case folding out altogether instead?
>> The entry for the change in the Release Notes may say:
>>
>>   * "git fast-import" incorrectly case-folded the paths recorded in
>>     the history when core.ignorease is set (i.e. the repository's
>>     working tree is incapable of expressing paths that differ only in
>>     their cases); this old bug was reported in 2012 and was finally
>>     corrected.
>>
>> or something like that?
>
> Is anything else then git-p4 known to rely on case folding? If not, I
> guess that's a reasonable plan. We could even add an option to
> fast-import that would allow to turn case folding back on, and make
> git-p4 use it, so that its expectations are fulfilled. Although at some
> point, it could (should?) do case folding itself(?)

git-p4 has a single line of code that checks if core.ignorecase is 
turned on, and uses this to decide whether to skip files that are 
outside the depot being tracked and I *think* is not really related to 
fast-import.

I don't know to what extent though git-p4 relies on the current 
behaviour of git fast-import to fold case for it.

There's a 'p4 info' command which tells you what the server thinks it's 
doing:

$ p4 info | grep Case
Case Handling: sensitive

I don't know how long that support has been present (it might not work 
on older servers that some people are still using).

It's also possible to force the server to be case-insensitive on the 
Linux version. That's useful, as it we could construct some test cases 
to see what we're likely to break without having to force people to 
install a case-insensitive OS in order to run the git regression tests.

Luke


>
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
