From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Mon, 17 Nov 2014 17:00:18 +0100
Message-ID: <546A1B92.90900@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>	<1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>	<xmqqvbmfyo8w.fsf@gitster.dls.corp.google.com>	<5469B134.1050306@alum.mit.edu> <xmqqfvdhzvsp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:00:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqOjI-0007Sy-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 17:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbaKQQAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 11:00:37 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55230 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983AbaKQQAg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 11:00:36 -0500
X-AuditID: 12074411-f795a6d000005d31-42-546a1b951fe8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 50.00.23857.59B1A645; Mon, 17 Nov 2014 11:00:21 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAHG0JZ7011479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 11:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqqfvdhzvsp.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqDtVOivEYNVhEYuuK91MFg29V5gt
	Fv47ym6xvynJgcVj56y77B4XLyl7fN4k59E85TxrAEsUt01SYklZcGZ6nr5dAnfG/F9rGAtm
	81b0fPdvYNzM1cXIwSEhYCLxaH1pFyMnkCkmceHeerYuRi4OIYHLjBKNn3pZIJxzTBKvDv5j
	BqniFdCUuLH/AzuIzSKgKtE3by4biM0moCuxqKeZCcQWFQiSOLnnOjtEvaDEyZlPWEBsEQE1
	iYlth8BsZoEciQcfIeYIC4RJTJ9wEmrzT0aJO+emMIIkOAWsJSY/3MQG0aAnseP6L1YIW16i
	eets5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3
	MUKCWXAH44yTcocYBTgYlXh4d2RnhgixJpYVV+YeYpTkYFIS5V0vmhUixJeUn1KZkVicEV9U
	mpNafIhRgoNZSYQ35iJQOW9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJ
	gjdDCmioYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS4gHaqwXSzltc
	kJgLFIVoPcWoKCXOGwmSEABJZJTmwY2FpahXjOJAXwrzsgATlhAPML3Bdb8CGswENHjOBpCH
	iksSEVJSDYzLtun6961ev2C6S0mwWXnTuwPG4lXhRYrZKok+FTY7+lWs0kVa5L8lJ0zgqk7V
	Nf0c0PVslcPZZcu+v81JXPjq5gQXLpHiOW9cTk4vnnrt7sFp65dXephod2qV5Qne 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 04:33 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 11/16/2014 07:49 PM, Junio C Hamano wrote:
>> ...
>>> So I would suggest not to spend any cycle or any code complexity to
>>> "repair" existing repositories.  Having that bit on does not hurt
>>> anybody.  Those who found it curious can flip that bit off and then
>>> Git with "preserve existing permissions" fix will keep that bit off
>>> from then on.
>>
>> I disagree. The point of "preserve existing permissions" was to allow
>> people to make their config files more readable/writable than the
>> default,...
> 
> s/more/less/, I think, was the original motivation. Having to limit
> more tightly than usual was what made the "config" unusual among
> files under $GIT_DIR.  If it were to loosen, Eric's change should
> not have been done in the first place. The sharedRepository setting
> to defeat the default umask is there for that kind of thing.

Oops, you are right. I actually meant to type "less or more", but I see
that "more" would be pretty useless.

>> That being said, I still believe that executable config files are not a
>> significant risk ...
> 
> It is merely an annoyance, to the same degree of annoyance we find
> when we see all files appear executable on a FAT floppy mounted on
> Linux ;-)  I do not think it is a risk at all, and I do not see a
> point in going into people's repository and actively "fixing" it.
> People who notice can fix, and people who do not care do not care
> and are not harmed.

OK, then, I'll send a new copy of patch 1/2 and drop 2/2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
