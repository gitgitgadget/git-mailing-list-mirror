From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 0/2] shell: allow 'no-interactive-login' command to
 disable interactive shell
Date: Sat, 9 Mar 2013 13:52:37 -0800
Message-ID: <20130309215237.GA24777@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 22:53:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UERha-0002o8-Uo
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 22:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab3CIVws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 16:52:48 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33571 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3CIVws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 16:52:48 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so2426102pbc.37
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bzdv26oiYTqjxhE/rdoXrTnXBlWIhjItL2D6Fvo0ET4=;
        b=hXqdAzS5iL14AUBfCgPbUPs8LVLIWp0JmqCdvAxY79xgU1w/rlwH8dZ2dSVb6Qp6+g
         kMGWC6PxFlJdLvigomyKhPa8UXWyOslVIc1RF9POoktC/3CUDyAvXP+soxcA3tIpO86B
         HP3dw3o3F94Ey4Zeq0GYI80cmEyIRojnlD+Frdm1dGJHEp7kDHVa9HaJ3vE18Nn/R3KI
         RfHD4yOdBm0QLoNypdS89oGHKRBcXBLL9NZCEPVGHad7L1YPLuO/PI/rQ9lEwxP42VC8
         Qe6xUo2SFsoCV6JnzRoQVDzn2jbysvBYnLDILYhDTIx9LDKfAXdU8HQxDKD5bYUv+8Qd
         lT+w==
X-Received: by 10.68.218.201 with SMTP id pi9mr14374634pbc.127.1362865967365;
        Sat, 09 Mar 2013 13:52:47 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kl4sm12023496pbc.31.2013.03.09.13.52.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 13:52:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217766>

Hi again,

Here's a reroll along the lines described at
http://thread.gmane.org/gmane.comp.version-control.git/216229

As before, this series is meant to give users of basic 'git shell'
setups a chance to imitate some nice behaviors that GitHub and
gitolite offer in more complicated ways.  Thanks for your help on it
so far.

Jonathan Nieder (2):
  shell doc: emphasize purpose and security model
  shell: allow customization of "interactive login disabled" message

 Documentation/git-shell.txt | 86 +++++++++++++++++++++++++++++++++++++--------
 shell.c                     | 13 +++++++
 2 files changed, 84 insertions(+), 15 deletions(-)
