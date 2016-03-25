From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 21:22:33 -0400
Message-ID: <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
	<CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
	<CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zhang Lei <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 02:22:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajGSX-0005we-Km
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 02:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbcCYBWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 21:22:35 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34785 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCYBWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 21:22:34 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so6747025vkh.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 18:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=cuB+1XxqDmKAUU21gdYiopMSXdA7F/Nw/bo9jhj5QGc=;
        b=R5ScKcdR9KKanET+Vkmlo/RKvfIpjOLPn3ff8IzzCRaP6lnYRGH+MCdW/naSniHAiY
         kZJyTlfOKnz2CHX/LqlrR13xa/ZTkWmZOQCdRxeC0AoTR6lTdbHKeNbBqsodM/j1nTcg
         z+fgHFsdQ9T0G8/XiFPmI3R+FowR/Hu0nFPv00mURBCWqDbdvaPke6hflUyXPWkSXoDF
         Jc7F4YrM9OjLHEAGvld2a0vtEvV/Zd5dSNXOGu4OnHnICAtdUb1MUpdnlH9YBhuxNMR2
         bW8C/6DMBKiChaIYk33mqcZEE6cBON7ys3IqqNGtZpWNLDaSrF6UIuyIdM+8wUe/mttK
         Kdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cuB+1XxqDmKAUU21gdYiopMSXdA7F/Nw/bo9jhj5QGc=;
        b=htXL8WeG24ZkDgDphNrX4Wx3eu+t+0gXEfpDRKV/iBnoSprTss1bhqTmKMoLln/5bi
         8vmxLr8m4xFyWGVrXkfx5bNNIaIBXSOvxBrnxKrn2Rlb0KbUFOmsExZj7nzvG1cxqxq5
         RPMTpTVVVjY4lhGt9N96ip6grPAfF6/RLOJAUiMBIRdCqauLvKaZN7bPdwLe8Xbl7YfT
         egiW+L3v4xqq5z4JniR9HSAkvqIpj7ICMedJwUwBNxk8lGt56Y3+zz0BFNq2Fx1MKIME
         +cqmPWncV/b4A9B8I0Nkk8agMYRKa9dOWApoTQfVZIcwpkGfX43uJOTQgl+0xfUHwh/g
         0Dgw==
X-Gm-Message-State: AD7BkJISGFnQA3nCm3i1txoio61iK+Ht3Evpx4OPTIHLLT9FDE+s2X67Ib7O+QhVkGmki7fy6qsOvAMnP7Op8A==
X-Received: by 10.159.33.206 with SMTP id 72mr81857uac.14.1458868953276; Thu,
 24 Mar 2016 18:22:33 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 18:22:33 -0700 (PDT)
In-Reply-To: <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
X-Google-Sender-Auth: l0kw9vx13tUohWq_aA7XoRNoqIM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289841>

[please respond inline rather than top-posting]

On Thu, Mar 24, 2016 at 5:52 AM, Zhang Lei <zhanglei002@gmail.com> wrote:
> 2016-03-24 17:16 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>> I think we can follow git-clone and use '-n' for this. [...]
>
> My PATCH v1 did follow git-clone -n, however, Junio C Hamano and Eric Sunshine
> suggested that we should avoid doing so , as --no-no-checkout could be
> confusing.

My impression was that Duy was suggesting only that -n be recognized
as shorthand for --no-checkout, however, git-worktree already
recognizes -n as shorthand for --dry-run (as a consequence of using
OPT__DRY_RUN), so -n as shorthand for --no-checkout is a no-go.
