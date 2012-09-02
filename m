From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Aw: Re: git blame shows wrong "Not commited yet" entries
Date: Sat, 1 Sep 2012 21:23:01 -0700
Message-ID: <CANiSa6g9Yo5xduqyY7pY-RKhqnLGDPXk6-5c68Hq39=jZFxTqQ@mail.gmail.com>
References: <7v7gsgqd4w.fsf@alter.siamese.dyndns.org>
	<1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
	<303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
	<1672779223.499907.1346418462641.JavaMail.ngmail@webmail08.arcor-online.net>
	<7vmx1bndt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 06:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T81j2-0007km-39
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 06:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833Ab2IBEXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 00:23:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60743 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2IBEXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 00:23:02 -0400
Received: by iahk25 with SMTP id k25so3010925iah.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TgaUlGLSaBf2Pjv2IiNZqVlpEEtzvxPSbv47Mp+lcCE=;
        b=z0nmCgiTMuirDDY8WTTVa2E1YCuTKKP61phH+xqpaZ4Di9jN+NNUjLXxKSoBRE+Ym2
         TTBiaA/QphXi5CJkgC3cfV+lzHd1m0kJa8LmdHDxWHHb9JTvdNObDUurHRtBuwYVQ9Gw
         YhX0xXbGolrZ/q58hDas/3PZx10opr4h2Mng57C4dJ5uobIds0WTIt7gwLbKzhF2wBPF
         CicqzVvwO9Tc9GBnUm682KADe0xZXYSRPinnSuXOEoviKYXBOS8+Nu/9Nm5UGmyIRgYA
         ZRlFJrWhoK+6pzhSK+5kmDf7NATbt9w06+M5vXDYSh2KBsmwaXhbLo3iO8Q6J1b+u7G2
         27aA==
Received: by 10.50.15.169 with SMTP id y9mr7379348igc.23.1346559781277; Sat,
 01 Sep 2012 21:23:01 -0700 (PDT)
Received: by 10.64.36.138 with HTTP; Sat, 1 Sep 2012 21:23:01 -0700 (PDT)
In-Reply-To: <7vmx1bndt9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204663>

On Fri, Aug 31, 2012 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> And "git blame $path" probably should expect $path is something that
> appear in the tree of HEAD; apparently it does not.

That probably makes sense. For anyone deciding to implement that, note
that "git blame -C [-C [-C]] $path" should probably not expect the
same, so the following still works.

cp COPYING COPY
git blame -C -C -C COPY

Btw, why isn't "-C -C -C" the same as "-CCC"? Should it?
