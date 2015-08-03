From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/11] Port tag.c over to use ref-filter APIs
Date: Mon, 03 Aug 2015 15:08:03 -0700
Message-ID: <xmqq7fpc6n5o.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
	<xmqq8u9s86n3.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZSRLaRjyif_7auUWfX6DmtA_g2MonumDf-3cMZvvrRXGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNtz-0001fK-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbbHCWIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:08:06 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35307 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbHCWIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:08:04 -0400
Received: by pdrg1 with SMTP id g1so79271931pdr.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lTB3ULT/5ayjayL3sk31LtgPIh2L117CVege9zWilVI=;
        b=iEdXa/RQ9hSrV9guTPw91d1YBocxgEMvw9SioqhDnnjTZu/dIyEvaOozFJVhYv9edG
         2lq3xF8rvkoZrUflLI1bfn60PADGMsG79qBIffd9ZZNN/nSOkge/PisF1YSA/OxwK6Tt
         byMHjKnCXH1MqkqZWGBsApS90i1kJytaHVJ/MI4nBDvgsNzQ5LKnYOxJWTCugau9E/a0
         d95XoN0Ise9Wtr9mRKecxJgAvvjD+380+pOXD7bAvS273bHPOhDVhPazAQ8bjk8cXvfh
         uXw8jqg6GeoWtB8Vu0FPNsT6qcKcW7RmxpP/XRcQ/MQkIa/ZjoQXiE5kRO0cswMhkBs7
         s3xQ==
X-Received: by 10.70.100.37 with SMTP id ev5mr490107pdb.81.1438639684480;
        Mon, 03 Aug 2015 15:08:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id bd5sm8969451pbb.85.2015.08.03.15.08.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 15:08:03 -0700 (PDT)
In-Reply-To: <CAOLa=ZSRLaRjyif_7auUWfX6DmtA_g2MonumDf-3cMZvvrRXGg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 4 Aug 2015 02:52:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275216>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Aug 4, 2015 at 1:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> It is very very dissapointing to allow the "next atom only"
>> implementation to squat on a good name "align:<type>,<width>",
>> especially when I thought that the list agreed
>>
>>   %(align:<type>,<width>) any string with or without %(atom) %(end)
>>
>> would be the way to go.
>
> From what I read, I thought we wanted the next atom or string to be
> aligned, if we need to align everything within the %(end) atom.

Is that a serious comment?

Did I read too much into your $gmane/275119, expecting that you
understood everything you are saying "That's a good way to go" to?

> I could do that :)

Sure ;-)
