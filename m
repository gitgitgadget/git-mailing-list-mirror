From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Thu, 28 Jan 2016 10:27:20 +0100
Message-ID: <AB5433EB-2C86-4A71-9E9F-057AC3CC150A@gmail.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com> <xmqqr3h6bgbe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:28:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOisA-0000pW-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966808AbcA1J2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:28:10 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35520 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966785AbcA1J1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:27:24 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so15624444wmr.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xTkF3EPWpBCLQRzMLbOjvOy1OTCAIgp0vysQlrXOkJs=;
        b=JrjkKeCQEJxoHTJuzmcES6IewGsFPh3qwissDML0xlsyhiR6Rl5myBxH1orw9eQF8z
         o1nZ/pzFzworWPIfQ5PM7vCgpKlH5MpaJAJIrQ2C121+48oK53Yx6jnEttHYZt1kJahh
         q/9b889H+dpMrBZUv1BgjHDyOB8EZu0R6bM+pjiBptgRWfsW91MheSkjJNdTW7lUImzS
         +/mkBoCQBE0aLGN9f0ad+MJq1PQxvNf4CnQgfsgPngILL0cT11WVV+CnoM+MDybdZict
         ZyWcSL1A21NjE71jRnBPDfd2BfI3lfG+QrVldD2g3SU4rjFfm7QX9eZnHgaRhcUesmR3
         FpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=xTkF3EPWpBCLQRzMLbOjvOy1OTCAIgp0vysQlrXOkJs=;
        b=dnxwRmHsEyh/jrkvZ+Muw5DiQxGyivH8MLZqnFl8coPK225FeFPxZTgCMFWSVLa1fu
         Opspw9g7dm/ScGhtAELzFBAO0BCmVRgdN2i0nM0Z5QXjwghikRZrniF5oKtJambCo8MT
         uH5uIgOg7YHx8+JMbSkuZQ//6IyyCAwfzRFNF5cBGAKvNlzElXqLlmUR8BAyHtRppD/B
         50XIEBN/zTOK00n84mCdBqrPYcFM4+5QCYAqj18VdBX4QOj6iYSDnxGOzYKyHmd7DsED
         iRk+1NDzteacj5RjHt7Eyfnq6TGqOgMYTHPhQGwE27SRZKlXCeAoZHw2SrjPddnnqTc/
         errA==
X-Gm-Message-State: AG10YOQYQybKvi/oGAwkd5MXt58X1sbmc7q3N1acupdShWIcP1LnI3bPt/1OgzHqCBTfnQ==
X-Received: by 10.28.182.133 with SMTP id g127mr1854399wmf.61.1453973242973;
        Thu, 28 Jan 2016 01:27:22 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA68D.dip0.t-ipconnect.de. [80.139.166.141])
        by smtp.gmail.com with ESMTPSA id qs1sm10083702wjc.2.2016.01.28.01.27.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 01:27:22 -0800 (PST)
In-Reply-To: <xmqqr3h6bgbe.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285004>


On 25 Jan 2016, at 02:25, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> A clean/smudge filter can be disabled if set to an empty string. However,
>> Git will try to run the empty string as command which results in a error
>> message per processed file.
> 
> The above two sentences do not make any sense to me.  You observe
> that the command refuses to work when the variable is set to an
> empty string--why then can you claim "filter can be disabled if set
> to an empty string"?  I'd consider that the system is not working
> with such a configuration, i.e. "filter cannot be disabled by
> setting it to empty; such a request will result in an error".

If I am not mistaken then Git exits with 0 (success) and an error message
if the filter command is empty and the filter is not required. If the filter
command is empty and the filter is required then Git will exit with 1 (error).

How about this?

If the clean/smudge command of a Git filter driver (filter.<driver>.smudge and
filter.<driver>.clean) is set to an empty string ("") and the filter driver is
not required (filter.<driver>.required=false) then Git will run successfully.
However, Git will print an error for every file that is affected by the filter.

Teach Git to consider an empty clean/smudge filter as legitimately disabled
and do not print an error message if the filter is not required.

Thanks,
Lars


> 
>> Teach Git to consider an empty clean/smudge filter as legitimately disabled
>> and do not print an error message.
> 
> On the other hand, this does make sense to me, as I do not think of
> a good way to say "earlier configuration entry said we should use
> this filter, but we actually do not want to use that one (or any)"
> because a configuration, unlike attributes entry, cannot be reset.
> The closest you can do is to set it to empty, so it may be a good
> new feature to do this.
> 
> 
