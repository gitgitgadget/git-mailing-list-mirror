From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Mon, 09 May 2005 23:44:02 -0700
Message-ID: <7vpsvzpolp.fsf@assigned-by-dhcp.cox.net>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
	<428038D0.5000706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 08:37:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVOMS-0003V8-OS
	for gcvg-git@gmane.org; Tue, 10 May 2005 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEJGoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEJGoH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 02:44:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10903 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261552AbVEJGoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 02:44:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510064404.UFSY7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 02:44:04 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428038D0.5000706@zytor.com> (H. Peter Anvin's message of "Mon,
 09 May 2005 21:30:08 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:

HPA> This is just plain WRONG.  st.st_size is longer than long on many
HPA> architectures, including Linux/i386.

HPA> The easiest way to deal with it is to #include <inttypes.h>, use %jd
HPA> and cast it to (intmax_t).  That is, however, a C99-ism.

Actually the easiest way is to stop reporting the size.  Nobody
else in core GIT reports st.st_size in their error messages.

Although I agree with you that what you say about the size of
st.st_size is correct, in GIT world view, apparently "unsigned
long" is big enough to hold st.st_size all over the code.  Would
you recommend tackling that assumption as well?

