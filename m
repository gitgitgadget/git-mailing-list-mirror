From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Sun, 18 Oct 2015 21:44:12 -0700
Message-ID: <xmqqzizfa2n7.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	<xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
	<vpq7fms9cjs.fsf@grenoble-inp.fr>
	<xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
	<vpq612bzz0o.fsf@grenoble-inp.fr>
	<CAOLa=ZQ5dCx4XheMvaFo1u-fR=uaR-LU-n7KHR3xNJ7TuF-zww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 06:44:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo2J2-0002Jp-4T
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 06:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbbJSEoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 00:44:16 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33933 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbJSEoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 00:44:15 -0400
Received: by padhk11 with SMTP id hk11so17420009pad.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jUZ/TbQqXvDeJsuaVQ5cjJoYPtG8pYKA3bX53O3mwgg=;
        b=VkQaZ9EoUGp4mChJZzfG0Zy8vJMKudvp8RvU2L/jBrLi3ml10MMJXhx8H0Vv2ayVB6
         +lASsKUYlqspjEc3Z0VPGJdjdpwENkQQA9iEVDjgAzWyFlBYwuY3l2PAvNLtXHEzjgCa
         ZRMoWMFNj8J7VR4BRffJhGA1WUV81Hetlkme30ge6pPlpdYwXf8WmM+zcCZVe9DrFPH1
         BvmlO8zWMYZaRPGj9E8e7RpL/SSPYQJ44CWzRPsBGwuaNsdV13yAbWr0YpDHOUY0wyDd
         ERTVqw5DXYnG0k1tcy5PJHp8lEasR6Z6ZtzL9gPcylxf5Rikza0DW/QVEg9FEp46cj2j
         AJug==
X-Received: by 10.67.23.165 with SMTP id ib5mr31653683pad.26.1445229854859;
        Sun, 18 Oct 2015 21:44:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id yz3sm33548696pbb.37.2015.10.18.21.44.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 21:44:13 -0700 (PDT)
In-Reply-To: <CAOLa=ZQ5dCx4XheMvaFo1u-fR=uaR-LU-n7KHR3xNJ7TuF-zww@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 19 Oct 2015 00:37:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279826>

Karthik Nayak <karthik.188@gmail.com> writes:

> ... While doing so I realized I was moving a lot of code around
> and this had me thinking it's perhaps easier to do the cleaning up
> first as Junio suggested.
> 
> Maybe then it'd be simpler to do implement this rather than move
> code around now and then move code around when we implement the
> parsing methods we spoke about earlier?

When I suggested the approach, I hadn't have done any of what you
actually did, so I was primarily talking out of "hunch" (perhaps
that is what some people call "taste") but I expected something like
that may happen ;-).

Right now, you practically own the topic, in the sense that nobody
seems to be in a very urgent need to compete with you in parallel to
implement what we have discussed before you do, so I personally
would suggest whichever order you feel more comfortable and less
error-prone.

Thanks.
