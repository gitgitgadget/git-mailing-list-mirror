From: Tomas Cohen Arazi <tomascohen@gmail.com>
Subject: Content-Type handling
Date: Mon, 17 Sep 2012 13:34:13 -0300
Message-ID: <CABZfb=UhKRREMG_XNJHDJHwbwroi5TKWwgQH-Ge1BDJETizG2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 18:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDeHd-0003ov-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 18:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab2IQQep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 12:34:45 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59424 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab2IQQeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 12:34:44 -0400
Received: by vcbfo13 with SMTP id fo13so6480506vcb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=IAGEHbBCIb1yY+NMQVhUiT3u9tI0U7J7dxVByux1f2Y=;
        b=jfM/m9QaUN97D0LjjyAOtIM7T7mt82HSOZAVKwvDpgRMuwUo2Qvy2JP6k1MbXOhUGf
         rNrAa6Yq5xAAPDH9x6ysKqmqLN/d8/yaSnCJH9YmpYerX2CiSZaWa1ETtC0PzlUiY+sp
         m/BI5E1Lw03u5kxnmDJssRGP0kRE9xKXyfKepprhxiUNGhqCMb0NOOyyBOe6kgfpu5sd
         lgnx7819c6MymUClnLBk/HuphtG5lHZw1jYAZtHFwvB/Z/4KE39Jc3J/thdo6CSjiXc/
         CDblxXfStn6hHyGxOzXWHNRcr9g4Htq5KIzYFOO2GYZcBXubdAhzjy57bBQ5IQOJ7M1I
         uHOw==
Received: by 10.220.209.3 with SMTP id ge3mr1039588vcb.43.1347899684065; Mon,
 17 Sep 2012 09:34:44 -0700 (PDT)
Received: by 10.58.179.10 with HTTP; Mon, 17 Sep 2012 09:34:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205706>

Hi, I'm not sure it is a bug, but we used:

git config --global format.headers "Content-Type: text/plain; charset=\"utf-8\""

and recently (perhaps an Ubuntu default setup issue) the content-type
is being automatically set, the result is that patches contain this:

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

This might not be the problem, but when I apply the patch I get this:

fatal: cannot convert from UTF-8utf-8 to UTF-8

which looks like a bug. Not sure it hasn't been reported before, but I
think it should take one of the content-type specifications and not
append both. I couldn't find a place to looks for previous bug reports
to check, so forgive me if this is not the right place to report it.

Regards
To+
