From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Wed, 13 May 2015 11:39:41 +0200
Message-ID: <CAP8UFD14LuyaVcoNHxR00ZeGgHWXbuW_QdVf4YqZWzgMdufUjQ@mail.gmail.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
	<xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
	<20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
	<20150513013637.GB3066@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 11:39:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsT8n-0007VY-0k
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546AbbEMJjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:39:45 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36050 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933372AbbEMJjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:39:42 -0400
Received: by wgbhc8 with SMTP id hc8so3730216wgb.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XO2DJtD7FFuHV3+pbzB0y31PN2YMe16DJ53uOYRvO+Y=;
        b=pbPNGtQQWKFV50lt2s3SU8mNoljaanxpjpdQnCRAyD876sjZEqGdeCRH0QyF3RComB
         hUd879uZ/uaQw7jE9AEtBbXP6PTw83M/ECjPMPqd2xC8NrFyeVJmP+jD8pY9CQwqlH7l
         g7zM33zXsIu0j5zim7ItvMIt9SRZl6Gxt81rAWJlWWlBoWgDpJGb9XJI1XRb0zFISWV4
         UqA0ZStg9V7NYxSwfcLKkNBBAXCrfo8zK0ilWOmURPWwXBHd1uP+TeJSxYHPkmlBrZGH
         vnvDsGynpacCqLQxVUD496OZgIVU47pCkNJSyGUoSpekx308Nfnz7c3RMHZRHuPXgDqL
         eXcw==
X-Received: by 10.180.95.10 with SMTP id dg10mr7758525wib.41.1431509981443;
 Wed, 13 May 2015 02:39:41 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Wed, 13 May 2015 02:39:41 -0700 (PDT)
In-Reply-To: <20150513013637.GB3066@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268967>

On Wed, May 13, 2015 at 3:36 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 12, 2015 at 06:13:48PM -0700, Junio C Hamano wrote:
>
>> >> See $gmane/268881
>> >
>> > Well, technically he just said it might be that people are parsing the
>> > output and could be broken, but if you'd rather not take that risk then
>> > I guess we just have to leave things the way they are.
>>
>> FWIW.
>>
>>  - I personally do not agree that those who scripted around "git
>>    bisect" (as opposed to those who wrote scripts to be driven by
>>    the "bisect run" interface) are worth worrying about.  But I am
>>    not the whole of the Git world ;-)
>
> It is not clear to me that people are actually scripting around the
> output. Between the exit code and the stable output in BISECT_LOG, that
> seems like a much more preferable way for scripted uses to find out what
> happened.
>
> Of course, that is not a guarantee that nobody scraped stderr, but at
> least it makes me feel better that they're Doing It Wrong. :)

Aren't we sending the "XXXX is the first bad commit" and the diff-tree
to stdout?
