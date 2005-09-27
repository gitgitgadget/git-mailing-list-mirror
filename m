From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Parallelize building rpm
Date: Mon, 26 Sep 2005 21:21:34 -0700
Message-ID: <7voe6f6sz5.fsf@assigned-by-dhcp.cox.net>
References: <4338B307.7010405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK6ym-0006Oe-2S
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 06:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVI0EVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 00:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVI0EVi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 00:21:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43192 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932223AbVI0EVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 00:21:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927042135.NIZN2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 00:21:35 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4338B307.7010405@zytor.com> (H. Peter Anvin's message of "Mon,
	26 Sep 2005 19:48:39 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9365>

"H. Peter Anvin" <hpa@zytor.com> writes:

Could you also fix COPTS while you are at it, please?  I think
it is caleld CFLAGS these days.

>  %build
> -make COPTS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
> +make %{_smp_mflags} COPTS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
>       prefix=%{_prefix} all %{!?_without_docs: doc}
