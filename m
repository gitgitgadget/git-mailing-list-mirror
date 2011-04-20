From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 14:21:11 +0000
Message-ID: <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:25:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCYLA-0000S6-Gu
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 16:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1DTOZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 10:25:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63273 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab1DTOZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 10:25:04 -0400
Received: by pwi15 with SMTP id 15so417999pwi.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=V031aGmc6Wsw8qbgRfuLaiE+Hq0pkAVHSABkPQUkFhE=;
        b=WE0D1HIzte5IaJv7FycEt0Q24j1F9rJgzYjLTzlnT0b5NpMRNlCVUaNwth3TFhCQ/F
         cyfQLMXh0eXhOZ8v15tSTAEjzltSINMPUAYfSOlOXukWol8Dl1zP0XGcJ/4IDsSG+EhH
         BxDAClc2Aa/2sprbrtQV5sHxriysVSp5bJguc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=VJqft+MDFKG4X5ln9rsEP17dwfdPmSvVE7B+J1eeehTgsNQBPSdzHwgw6YdwS6Xuzz
         jj9xytQrirCOZ5YDg0NNoxghJCFcVP7V3eM7Ikk0SmWnzHQ+DE52K8c8rIo+/IUT8Cox
         SQtrq6tUve9WE+PhUKSS/aEZSvbJXoZSevUwI=
Received: by 10.68.5.74 with SMTP id q10mr320987pbq.457.1303309504222;
        Wed, 20 Apr 2011 07:25:04 -0700 (PDT)
Received: from gmail.com (tor-exit-router45-readme.formlessnetworking.net [199.48.147.45])
        by mx.google.com with ESMTPS id k7sm661412pbh.37.2011.04.20.07.25.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 07:25:02 -0700 (PDT)
In-Reply-To: <20110420064318.GF28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171863>

On Wed, 20 Apr 2011 02:43:18 -0400, Jeff King wrote:

> On Wed, Apr 20, 2011 at 02:53:36AM +0000, Michael Witten wrote:
>
>> One of the possible values for a date format is `local', which
>> specifies that a date should be output as though the date format
>> were instead `default' but in terms of the user's time zone
>> instead of the time zone stored by git; clearly, then, `local'
>> does not really provide just another format, but rather the
>> combination of 2 specifications:
>> 
>>   * A format for the date (`default')
>>   * A time zone in which to interpret the date (`local', if you will)
>>
>> [...]
>>
>> This patch series reimplements the original purpose of `--date' by allowing
>> the time zone mode to be specified independently of the date format
>> (see the commit message for [2] and the documentation provided by [3]):
>
> I think the intent of this series is good. See also this thread from
> quite a while back:
>
>  http://article.gmane.org/gmane.comp.version-control.git/112026

I took a cursory look, but I've spent so much time on this series already
that I don't really care what it says; if there are particular concerns
that you think I might not have met, then let me know in this discussion :-)

In any case, my approach is not only infintely cleaner than some of the
stuff I saw in that thread, but it's also complete and working (and it is
extensive without being invasive).
