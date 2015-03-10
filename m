From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] versionsort: support reorder prerelease suffixes
Date: Tue, 10 Mar 2015 04:03:13 -0400
Message-ID: <CAPig+cRVSFfmEYAEq0EVS_N5TxxoMrXaLuk7rN63iFO5p9CUYw@mail.gmail.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
	<1424947441-19134-1-git-send-email-pclouds@gmail.com>
	<xmqqvbinhw7l.fsf@gitster.dls.corp.google.com>
	<xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
	<CACsJy8Bpta0rw1rjN8ROcUykPK508bvH_bvAJzLQQa6L6OmH7w@mail.gmail.com>
	<xmqqvbi91e84.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVF8L-0001H6-W0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 09:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbbCJIDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 04:03:17 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35562 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbCJIDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 04:03:14 -0400
Received: by yhnv1 with SMTP id v1so22058549yhn.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nHldPHiOtNmS+IajpMSPc1Far3odSxSdz5hI8uQNkKM=;
        b=tZHi4bmlSaTwfqAYd8f+u/r73tyGZiPktY+G7GFMAcqmmVj4uvZReiXdHB5vWHqeWL
         rtr41ApO/h5sFLleDSIampyteQFMdRIDzeZ6tKy10PZXYFv6A0xqgW8r/sjet6VBLxIy
         9OQYveMJLoCF3CKFQbJOt9pHyb9Jhlf7b1WRAqW1FAPkG4ItLaYfxhHDPaTqIklu5uJj
         nAy+aQU0EeLwDuhXv5iF2y/lCFUhPt+P6HUKlhK0pDw3KyBWf2SLVowoeLLxdPRxl8V7
         NrpKp9EGXo42TPxqEB4uiQYUcA2MwGGGlICl+rdHIkU7XRDTqY/WLUTFEgYx9UiW7MlT
         PlJg==
X-Received: by 10.170.194.7 with SMTP id l7mr901948yke.91.1425974593543; Tue,
 10 Mar 2015 01:03:13 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 01:03:13 -0700 (PDT)
In-Reply-To: <xmqqvbi91e84.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 2SmGMjvu75s6Lka2Itx9hN1JviA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265218>

On Tue, Mar 10, 2015 at 3:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>> How about..
>>
>> ".. "1.0-rc1" will appear before "1.0".  This key can be specified
>> multiple times, one for each suffix. The order of suffixes in the

Minor bike-shedding: s/one for each suffix/once per suffix/

>> config file determines the sorting order (e.g. if "-pre" appears
>> before "-rc" in the config file then 1.0-preXX is sorted before
>> 1.0-rcXX). The sorting order between different suffixes is undefined
>> if they are in multiple config files"
>
> OK. Later we might resurrect that "How would we spell 'reset this
> variable' in our configuration file? Is that even a good idea in
> the first place?" topic and at that time the last sentence may have
> to change to make it more useful, but because we are not there yet,
> the above would be a reasonable description.
