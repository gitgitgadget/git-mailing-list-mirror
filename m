From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: git rebase --committer-date-is-author-date with -i/-p
Date: Wed, 9 May 2012 14:36:56 +0200
Message-ID: <CAGK7Mr7S42r_Xx0qygRCp+EujuuBF1MT1Y0vqCY+=EBT5++Urw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 14:37:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS696-00010B-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 14:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716Ab2EIMh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 08:37:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51241 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2EIMh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 08:37:27 -0400
Received: by dady13 with SMTP id y13so255677dad.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=MpNlwuGeUMIOYEuCacT99NyJMWSOGNWiadNt2O1F7iM=;
        b=zau5eoH1z0bG267Le+k4O2k7PivcWhb4KidqU3w0aNdcp+GS6KRCha2KN+mNqRgTIU
         8sDTOuD0m7uW8P0riC3HIn2dvxGgnZ45aAY/k6otmQmSmrYuiufIwx+rkM1FTMqGhOgc
         oY7vlE/gUbN22yojla1AmXFxDekngzy/lkW7nYzHK9I1Ds7gxDGm2cNZuHH2S7OxPqTD
         Rgi9PDzsUkWIACjI30GTh5T2TVdK9G1gbK97qVpRmWDH8/1FkL1h3rDAdxadKN0ZEPGz
         wlvg5Oi6cxG4FiaglEzl11r/64ZOLlwTXGLYOkP9bJnobWzPYVVYF0szmytj68ExUEtA
         GYgQ==
Received: by 10.50.191.200 with SMTP id ha8mr1413954igc.45.1336567046900; Wed,
 09 May 2012 05:37:26 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Wed, 9 May 2012 05:36:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197469>

Hi,

Why doesn't git rebase support --committer-date-is-author-date with
the -i or -p flag?

The only workaround I found so far was to rebase anyway then use `git
filter-branch` to set GIT_COMMITER_DATE to GIT_AUTHOR_DATE for all
commits, but this is far from optimal as it completely loses the
original GIT_COMMITER_DATE.

The use case for this is heavy history rewriting for very ancient
commits, squashing a range of old commits togethers. The commit date
being modified leads to trouble with tools that rely on it.

Is there a better workaround?

Thanks,
Philippe
