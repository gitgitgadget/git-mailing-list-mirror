From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Tue, 24 Jul 2012 08:43:25 -0400
Message-ID: <CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SteSZ-0004sV-SC
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 14:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab2GXMn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 08:43:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46825 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2GXMn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 08:43:26 -0400
Received: by yhmm54 with SMTP id m54so6571660yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aGuP+WmkXn5IWONnf+yQSIzlAmkOVTh0fPDd4OZ4lU0=;
        b=kc0GwfgIPoevrBUbljtbpDJqCRia362UYnKrq+nrpR0P6p/WczKTw2iqbA7Mg6bBv+
         vDW8Xxnau6LVaexh/jGQ7GvcOkk9gkS21iyZqmHpFaIpwwxXmFWr7o9YDI3M67io0Jwf
         gkFGE+R/LdCcZhKtUN4VLiDZXlJjBcqhu+rimrD03NfdxBIp7JFCJc7rinYrSmygNave
         R8ns5bMDug1yqBZpfqN3msxfO13gWBg+hNS3cK1TcI9UVIMoxu9XEcYNEtr74hxOGHjw
         cNfIMu0KUi9EeKAFY+tPSGIxMpMI8RkUGDVpPljFwX//GMIjYEqpj5u/vIgJkcwN/VGE
         Q7Pg==
Received: by 10.43.85.69 with SMTP id an5mr14948177icc.37.1343133805160; Tue,
 24 Jul 2012 05:43:25 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Tue, 24 Jul 2012 05:43:25 -0700 (PDT)
In-Reply-To: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202036>

On Sun, Jul 22, 2012 at 11:42 PM, David Aguilar <davvid@gmail.com> wrote:
> Eliminate a global variable and File::Find usage by building upon
> basename() and glob() instead.

glob was used in an early revision of the patch that led to bf73fc2
(difftool: print list of valid tools with '--tool-help') as well [1].
However, if the path to git or the path under 'mergetools' includes
spaces, glob fails.  To work around the problem, File::Find was used
instead [2].

Does this implementation handle that case?  I'm sorry, but I haven't
had time to apply and test myself.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/193233/focus=193925
[2]: http://thread.gmane.org/gmane.comp.version-control.git/194158
