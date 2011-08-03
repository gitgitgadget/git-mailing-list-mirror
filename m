From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 07:27:03 +0200
Message-ID: <201108030727.04246.chriscool@tuxfamily.org>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com> <CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com> <CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoTzC-0001vd-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab1HCF1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 01:27:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46528 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab1HCF1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 01:27:13 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0724FA6225;
	Wed,  3 Aug 2011 07:27:05 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178542>

On Tuesday 02 August 2011 16:41:13 Jon Seymour wrote:
> On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
> 
> <christian.couder@gmail.com> wrote:
> > On Tue, Aug 2, 2011 at 1:29 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> >> @@ -34,6 +34,8 @@ require_work_tree
> >>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> >>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> >> 
> >> +BISECT_MODE=$(test -f "$GIT_DIR/BISECT_MODE" && cat
> >> "$GIT_DIR/BISECT_MODE")
> > 
> > Could you put this line just where it is needed, that is in
> > bisect_next() and bisect_reset()?
> 
> Ultimately, it is also needed in paths that call bisect_state(), such
> as bisect_run() and bisect_skip() so I am not keen to do this.
>
> If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
> call to a function bisect_mode() that does the same thing.

Yeah, I think it would be a good idea to have a bisect_mode() function.
I don't like very much to blindly call some code when we might not need it.

Thanks,
Christian.
