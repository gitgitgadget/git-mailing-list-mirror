From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: overriding/removing inherited credential.helper
Date: Sat, 10 Nov 2012 23:12:50 +0800
Message-ID: <CAHtLG6QaHOOYgVFPyOWo44-jTX__cd0dCyu+vs+Uf4_U-HxySw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 16:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXCkQ-0000x9-9Z
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 16:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab2KJPMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 10:12:53 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60054 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab2KJPMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 10:12:52 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so3711507lbo.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 07:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1WRHECOZmU/2NX8Dm53RnoUS7RT+KIm/Vc2SzFcuKPI=;
        b=pk14XVch25i5XF/krckTC6OhP23YR69kJwpsln2YcoqJzgB4gowXF6u5gMrM/e4tjK
         cmDHMwwGKHj7FUhj1+79sIK0SnhyE3/zmf7BnQm+jtJjbxZ49YK/DHNxv4bROghjvrSj
         dLw2YmZ7AVPhwpIXINxb5qcqxE5csdU+lO1e7b8DcUvRSLuEZKFHFxv44LsLNjcJOgSP
         i3j4uSqu8wCm37T6kh/UxCHyYzqVzO3JNdAYfP3yU1rI13F74Ds78wIatiqhzMBUDtwg
         ZIPKZhA2rekHmXBFI0I5yqQLa8xHFgdAPdvo6v38q9TID+5jZvd1dHmcV+0/fiVOtRW7
         DX0Q==
Received: by 10.112.50.205 with SMTP id e13mr5973460lbo.63.1352560370949; Sat,
 10 Nov 2012 07:12:50 -0800 (PST)
Received: by 10.112.47.71 with HTTP; Sat, 10 Nov 2012 07:12:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209278>

In credential.c, line 67:

    if (!strcmp(key, "helper"))
        string_list_append(&c->helpers, value);

In global config, I add one credential helper.
But I do not want to use any credential helper in a specific repository.
Currently there is no way in local config to override and remove
inherited credential helper.
Of course, I do not want to change global config.

Could you suggest a patch?
