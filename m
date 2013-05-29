From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 08:46:50 -0500
Message-ID: <CAMP44s0vaPUmvS8OzZ_4UR5XmKK-fyU4nE47Djjr215zkgpRFg@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com>
	<CAMP44s0cpAkAUzo0nS55yv+6=cCBsBhgNiYxpEd8Hzk=3mfNhw@mail.gmail.com>
	<CACsJy8Do-djwjVP1YvGnvsbdiWjE47KTK4pZZ3Qdnubvd-r3Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgiP-0003bw-23
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966249Ab3E2Nqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:46:52 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36534 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966049Ab3E2Nqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:46:51 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so8521528lab.8
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xQX7x1DH/aUgNr99D38ZR4nSd0DEay5wWHEcTLDDnzg=;
        b=DvC4FHObwz/k2mFJGcreypo517PLFgTBfTmVI5z6yXi59x1wCYanI/SCyKSCeLC524
         L6T7ODVoaFLrUI7302HnNXiemJ+z9IsocN+Kme37xfab3XN4d8gg09sOh9p21I0hkl+C
         2ruulp/YlY2DTlLWHE7/PPH4wqAJkDKbsy74d07SGohWmyhWg1Z8/eAmNQTlr3vVzKpN
         lf9O6GaRAe2kQdlwC9Rjo7vK+da5R79WNC9PSrxuCuVmdnty93SRFNnvGDIVwjgr43jC
         6Tq6XxeMf7hoapk1Zge6088MSi9ypflgk3NKPjkqCNNRq/515UqVprPnj6x8WK4SdemD
         yBPg==
X-Received: by 10.112.167.72 with SMTP id zm8mr1683093lbb.11.1369835210134;
 Wed, 29 May 2013 06:46:50 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:46:50 -0700 (PDT)
In-Reply-To: <CACsJy8Do-djwjVP1YvGnvsbdiWjE47KTK4pZZ3Qdnubvd-r3Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225825>

On Wed, May 29, 2013 at 8:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 29, 2013 at 8:34 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, May 29, 2013 at 8:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Mon, May 27, 2013 at 11:52 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> We should free objects before leaving.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>
>>> Micronit: perhaps you should move the "free obejcts before leaving"
>>> (in do_pick_commit) to the subject instead of "trivial fix", which
>>> adds no value to the patch.
>>
>> Perhaps. I prefer it this way because it's really a trivial fix not
>> really worth much time thinking about it. So when somebody is browsing
>> the history they can happily skip this one. The time save by not
>> reading I think adds more value than any succinct description that
>> would force each and every patch-reviewer/history-reader to read it.
>
> Some time from now, assume a ridiculus case when this function grows
> more complex and somebody wonders what the "leave" label is for, "git
> log --oneline -Slabel:" showing "trivial fix" would not help much.

Fortunately that's not the main use-case, and for that single instance
that probably will never happen, I think it's not too much to ask to
this hypothetical developer to remove the --oneline, or copy-paste the
SHA-1 and take a peek. He would probably need to do that anyway.

-- 
Felipe Contreras
