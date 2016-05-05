From: Shin Kojima <shin@kojima.org>
Subject: Re: [PATCH v2] gitweb: apply fallback encoding before highlight
Date: Thu, 5 May 2016 19:22:08 +0900
Message-ID: <20160505102203.GA53576@skmba.local>
References: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
 <1462280451-43388-1-git-send-email-shin@kojima.org>
 <xmqq7ffbng8p.fsf@gitster.mtv.corp.google.com>
 <20160504083449.GA46041@skmba.local>
 <xmqqeg9hhb1e.fsf@gitster.mtv.corp.google.com>
Reply-To: shin@kojima.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Shin Kojima <shin@kojima.org>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 12:22:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayGQL-0001ww-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 12:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbcEEKWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 06:22:19 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35335 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527AbcEEKWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 06:22:16 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so8889082pac.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3GDvYL6DitnjViR6pBvtCDXfSEo6nxWBSlzdakWsXkE=;
        b=C5IA+nxmKXxOSPqTguinlgkk4Dyqt95YyWcm9IroK++WXqfnOxZdVLtOV9dHGqf4We
         jqZ4LYmomVfokkXwIsUTFKyW9napiiz9NXMVQ4d7Xy2ynorSH2r2fxm0T5IDUORAGQkD
         Yb1VOOct9z4xW7yxHl43iC1MiL3eVshubi9pyCmuSYgEDQs5D+4+CRaR/6UDRH9RtzDm
         quGrfElSUVOjJ+Ax+vKtoG5H10nJMdfIXFBgXQ8OSPUY6CzmOVV1ZKkYG6X6wVQGxjNr
         ptpIh3Ts8Ap5cTVfyE86RVj0WBOKw5CQcV+LTRiM/XZOiBuAKPWRStpkV+G+49WJ4VWO
         mOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3GDvYL6DitnjViR6pBvtCDXfSEo6nxWBSlzdakWsXkE=;
        b=cyvffwlAFzOFTooWfRPeHELWSA+Jd9iEOgEhWriThc/32oI05qurwcEJU9/YbBraIl
         N3VUeQkhLBEBlJhFsIijs50EfbYaRktWQbMC3dKXyfL84UNyZMe0kUrOE72yjgS6RWwC
         fqm5Zlz389AhLPQPiSv2KgvA3NDGAiwK2Cbj3YKIKYxAqXegnJXeXkObn4MDuasLZ/hn
         0RB6zSftgDH3R0KTOnqWFBMxuUQGeDOf+SnjNF5PnwjixS18c7Gfk/BtOeZIw2R2So60
         /vHMFVBZlP35V10BVk6Opd9mFKIpnNzN5OgAB5NiTYP8gmDkwC+HizKsWnjIs6Nn1gre
         4ySw==
X-Gm-Message-State: AOPr4FXYulFNTHA5rzpFylDyc17ph3tL6FhygsX0D3YfsJ+UIss1UWAl2ya1HXYJcOUOGQ==
X-Received: by 10.66.148.2 with SMTP id to2mr19446016pab.72.1462443735841;
        Thu, 05 May 2016 03:22:15 -0700 (PDT)
Received: from skmba.local (156.230.214.202.rev.vmobile.jp. [202.214.230.156])
        by smtp.gmail.com with ESMTPSA id h6sm12509568paf.23.2016.05.05.03.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 May 2016 03:22:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqeg9hhb1e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293644>

> Oh, don't get me wrong. I do think what the patch does is very
> sensible and have no intention of rejecting it.

I'm sorry for making you worry, my poor English had caused some
misunderstanding.  I raised this Shift_JIS related problem (a.k.a
"ダメ文字" in Japanese) might attract your interest knowingly.

I would like to hear frank opinions from engineers who have high
abilities like you. ;)

> As I said, the question was "Just out of curiosity", since it's been
> so long since I was in any part of software work done in Japan.

Having said that, many people in Japan are still suffering from these
character encoding barriers.  This was a huge shock for me, since
I was studying information science in China as a Japanese foreign
student.
