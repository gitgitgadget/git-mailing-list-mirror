From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug with help.autocorrect.
Date: Sun, 23 Aug 2015 23:36:21 -0700
Message-ID: <xmqqpp2d5h22.fsf@gitster.dls.corp.google.com>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
	<xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
	<20150821162347.GA4828@sigill.intra.peff.net>
	<xmqqmvxk47e5.fsf@gitster.dls.corp.google.com>
	<20150824054327.GB14403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTlMq-0005iq-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 08:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbbHXGgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 02:36:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36097 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbHXGgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 02:36:23 -0400
Received: by padfa11 with SMTP id fa11so2268777pad.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3AwG0ORZI+wY9XD8E+bZGITS0lKGPPGqJ+SzB5jXLo4=;
        b=ODg39DdIU1HQrbFW0oZXOryhFeej4iaN4M2dwuMqUl1jkxaZK47jPqRIspwMdh6DhW
         R48w7Q/8KhvqJcgrA/0oKXljK3DF0OgQp985JJQJLS1OOFjig0NLnHirZvehGICXpoei
         v4ZbI5GG0YbN+4Jf9HFqHSjn8aNy2/iRp91WlnPpbdtDcT4DEQnTTfLCazme3zWeX+V5
         HWriKkbZekKybpg2V6duA34MJOA2zrzXWvmioPnzTHpGDJmuXl4SJ0xa0uz+o6zITOrc
         60lEkB6u9ZVcr24Vxso3uPose8bSw9loXRQ2DMxpI98OCTffoev9FnBloMgGbaPUnSJ4
         LcQQ==
X-Received: by 10.66.190.168 with SMTP id gr8mr42598606pac.22.1440398182813;
        Sun, 23 Aug 2015 23:36:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e53a:1155:f7f9:400e])
        by smtp.gmail.com with ESMTPSA id j4sm4128916pdk.9.2015.08.23.23.36.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 23:36:22 -0700 (PDT)
In-Reply-To: <20150824054327.GB14403@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2015 01:43:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276436>

Jeff King <peff@peff.net> writes:

> Yeah, I agree these are the only two sane fixes. Plumbing the quiet flag
> through does seem really invasive; every "git_config_get_foo" variant
> would have to learn it. Probably it's too gross to have a global like:
>
>   config_lax_mode = 1;
>   git_config_get_string(key.buf, &v);
>   config_lax_mode = 0;
>
> That makes a nice tidy patch, but I have a feeling we would regret it
> later. :)

Yeah, I do think the double-checking the patch in your follow-up
does is not so bad.  Thanks for following it through (now I must
remember not to drop these patches ;-).
