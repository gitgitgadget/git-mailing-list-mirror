From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 05:27:34 -0500
Message-ID: <CAMP44s03C2Wi5Bwma2wK5jMisBCyBaOVQ8UXuPaec9f27A0RvQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
	<CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
	<CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
	<CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
	<CALkWK0kwia-OQj_=B7A3k6_DxCJShqoJehNQu8eApgdo=OzQwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvPQ-0002fi-Si
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3EPK1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:27:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65295 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3EPK1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:27:36 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so890292lbi.5
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fb7GRDkWImtwzJrK81lLVhE/HjrqplbzszfHQWUprC8=;
        b=mCKpn9du0CD7Tj6acRRBN1Zq4q0Zb4KdJlpbVzWKRRRwgUhgu//xirWdGVjDBl593r
         aLYnpUOwGgwDF2uhvxlV/E6fWBTkPy2A7sU8bhgzknjLnpWY7yKWGZRAdYTPQLTDKkRV
         NiW1YbClRDW/SYfTx5cPXuSuAKUK8LB+efE4l9hJ6HtasB1vHSflypj9seN80Mv9q1ig
         MhK0a/hJ7ajaOmdpnEanHriikRSURbWQithlYRtCtOHncqvqHiI+tF7QLy61yZt1rcPU
         fG6ltzoDV4uACMW2z1KDogYu96N6mJWBYdCh7y3q3D8A5OGbQqx3XAgtYeTOUH/KZln+
         Punw==
X-Received: by 10.112.135.70 with SMTP id pq6mr19825904lbb.82.1368700054392;
 Thu, 16 May 2013 03:27:34 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 03:27:34 -0700 (PDT)
In-Reply-To: <CALkWK0kwia-OQj_=B7A3k6_DxCJShqoJehNQu8eApgdo=OzQwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224551>

On Thu, May 16, 2013 at 4:58 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Why would I do that? When I do 'git rebase' I want to rebase on top of
>> 'master', not 'origin/master' (or whatever the upstream of 'master'
>> is).
>
> Ah, so you want @{u} to point to refs/heads/master, but want to modify
> fetch to act on the hard-coded "origin", not @{u} (wouldn't you like
> to be able to configure this?).

No. What's the point of 'git fetch .'? What does 'git fetch' does when
there's no configured upstream branch? Why doesn't 'git fetch' default
to 'git fetch .' in those cases?

Answer: because 'git fetch .' doesn't make any sense. So if
'branch.HEAD.remote' is '.' it doesn't make sense to do 'git fetch .'.

> Seems a bit yuck overall; I wonder if
> there's some other way to achieve what you want.

Yeah, add 'branch.A.base' that would be used only by 'git rebase',
which I already suggested before, but I changed my mind.

Fixing 'git fetch' makes much more sense.

-- 
Felipe Contreras
