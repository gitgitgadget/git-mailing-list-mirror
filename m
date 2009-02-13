From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading 
	mbox message
Date: Fri, 13 Feb 2009 18:39:14 -0500
Message-ID: <76718490902131539o15439f12l7d4a8113f482c6ee@mail.gmail.com>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
	 <200902140032.19922.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 00:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY7eG-0004cS-Ne
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZBMXjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbZBMXjQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:39:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:44636 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbZBMXjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:39:16 -0500
Received: by rv-out-0506.google.com with SMTP id g37so855445rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wt5OrPdgLyZmP8am6L8zNao6BO9BKFLaq05qXCwei5s=;
        b=krSmUHpU1QL5wVPMcdsyzH7BkFTgf87YA+P5XjUOdjNudK0Lq1dD7eE5/5RZ/D1gWs
         gWy88Pf7C9kkXpDaSBNPNk+gcIvHu5V88zlUKaMvX/wfFYmGm4aIDLmZVmqOaq577EBW
         1BXd+b0KgzImpQ1DjAr3yXCgU3wYaqEoHlZDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DZL2q0dffohevBw3WVBZzeNpqutvdUkuLoEgU6VdBm8bLeNcA7Ajp5Zl+tag6atNq3
         IsyTe+RiBEyFp7D1xKg8h2w/ud9xvDTXzmEOingboQo4M3p8skhLq7e4W1sUNNd6ThjS
         m362iMGZjL437t8DJlVHVUHHHOFZo3ySpYQZI=
Received: by 10.140.164.1 with SMTP id m1mr1378388rve.174.1234568354967; Fri, 
	13 Feb 2009 15:39:14 -0800 (PST)
In-Reply-To: <200902140032.19922.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109786>

On Fri, Feb 13, 2009 at 6:32 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Jay Soffian wrote:
>> -                     if (/^(Signed-off-by|Cc): (.*)$/i) {
>> -                             next if ($suppress_cc{'sob'});
> [...]
>> +             if (/^(Signed-off-by|Cc): (.*)$/i) {
>> +                     next if ($suppress_cc{'sob'});
>
> Doesn't this actually look like a long-standing send-email bug?  Since
> 6564828 (git-send-email: Generalize auto-cc recipient mechanism.,
> 2007-12-25) they should go in separate categories, but the above lines
> were just translated from the old $signed_off_cc setting.  It seems
> they should distinguish between SOB and Cc.

I think it would be nice if send-email had different settings for
extracting Cc lines and extracting SOB lines from the message body,
but I don't call that a bug, but rather an enhancement request.

And yes, I noticed it when I went to send this patch because
originally I had "Cc: ..." in the commit message on column 0, which
send-email annoyingly picked up. I just changed my commit message to
move the "Cc:" to column 1.

Nonetheless, it is independent of this patch.

j.
