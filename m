From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Fri, 18 Mar 2016 14:15:45 -0400
Message-ID: <CAPig+cQ7pf2S_bB6tgbe2BazLNv9JpN=35XYGopYViNr3YqgmQ@mail.gmail.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
	<xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
	<20160318170255.GA9846@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:15:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agywB-0005Pr-Nv
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbcCRSPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:15:48 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34069 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbcCRSPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:15:47 -0400
Received: by mail-vk0-f49.google.com with SMTP id e185so151328399vkb.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PUFW2Z5qC4Wrcap+H1QXFB854FScWCsOezpYBZFc9Pc=;
        b=nh/m+S1GffZVEqt37HuxjDoMI756XtCbItekcM2zu3KjaAtCbuD/UjnkVlNvUN00CW
         CM/aMeRX0afRQMHMQhFijjQA4ajJPC3qPFgNutKSOQYgZBB2YOM0+bDieSXxpZ0mJ7aP
         qS/5uxsPT88jHgwtS01LI2bgH9IPkHP70dK+CxlHVBuwrE7sFaiv/nVC5cJ/0blsT6FN
         Z/+jRyL+hdcrf2l5Al3M3kmXziG2JfoBIo8nVQQJ/banghRfKPOv7sqz+cb4wsyHHlk6
         oZiuVtQtdis60nDVwaDJhJgLWew5rnAGM+bXq/XyxMUANbUgs6c1E95/dLdpNRgtO8KP
         FPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PUFW2Z5qC4Wrcap+H1QXFB854FScWCsOezpYBZFc9Pc=;
        b=HR08jfikhKt6IsKd8J97jEfd1wBuAmaRgqgW0hVejxN5/nNY3lPP5GMesKQUFHmMz/
         SReRsWe0HkogCq2uzVGpwoqgjX3+XOUjpmY1cXB+dKu6aFPuTuFC1/BKvfihTa+PuM2u
         7OGsEuPE3NbLlh049miilaxcaHi6m21ySwiwMLzdZglo/nNKSdXA63nYOEwn7VlW0IV9
         Ik/yfZ9ZFySJE8korCvNeoyz5V8BfoBQcAVWGazdMmjt6x/sPCs9dpRrRzR4plWT+a9w
         iKxdXVl8kZrKbYrw4dWP8wH0W8xi/5ZvP3naN0/fwC0E9+TtliwxWskSva7FnnNonZG9
         2u7g==
X-Gm-Message-State: AD7BkJKRIlRm09/d0WeAM3VHT7kkolTcjCVtSpmoLTatOo5Nc+JE7kKZ/Z6T39evy1HiuK0BNlqjXN8VcoVbxw==
X-Received: by 10.31.150.76 with SMTP id y73mr18751442vkd.84.1458324946022;
 Fri, 18 Mar 2016 11:15:46 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 18 Mar 2016 11:15:45 -0700 (PDT)
In-Reply-To: <20160318170255.GA9846@glandium.org>
X-Google-Sender-Auth: TGOYYBTpSDTo3ZWL5_WumkrjouY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289239>

On Fri, Mar 18, 2016 at 1:02 PM, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Mar 18, 2016 at 09:10:37AM -0700, Junio C Hamano wrote:
>>  * We forbid declaration-after-statement in our codebase.
>
> By the way, why not enforce it with -Werror=declaration-after-statement?
> If people patching git get an error when they do it, they won't submit
> a patch with it, and you won't have to tell them about it :)

See 658df95 (add DEVELOPER makefile knob to check for acknowledged
warnings, 2016-02-25), which is already in 'master'.
