From: Jonathan Nieder <jrnieder@gmail.com>
Subject: gitk: not all colours are configurable (so grey on black scheme is
 not possible)
Date: Thu, 4 Feb 2010 17:32:42 -0600
Message-ID: <20100204233242.GA5441@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org, 568470-forwarded@bugs.debian.org
X-From: git-owner@vger.kernel.org Fri Feb 05 00:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdBCn-0007zu-6M
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 00:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195Ab0BDXcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 18:32:55 -0500
Received: from mail-yx0-f204.google.com ([209.85.210.204]:33490 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933362Ab0BDXcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 18:32:47 -0500
Received: by yxe42 with SMTP id 42so2607017yxe.22
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 15:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=+qNTp+85PVc9RZ0IsnXasN05LSytXddWsKkCNJPMM4I=;
        b=WEKGmg6CiI+SswDkNPGnDKotpMoJCSBUzqLRFW+4UTxpgvvlZnrBV2TwkUxld2uy0m
         TCowBvOms7eocibANGjQs6FYHKSQhDxrLcFKe7QrXteo9FEKO8j8pFjW0UOOhdEqsh8b
         KEl5A/PriLfTpKisppKHx+abjL9a694l2qh2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=H+wDsiJOiKeajBDW0d1PZMcSFlemOn9o8iq2/sk/Sgy+1wyXfkPXPfjNnWzm899KbF
         fEKcsA4jd4EDHkZHmYqStAVLH7//MxM0Bx5PFP4RdlO4PmsPraBE0LNZa+5JH3ps9vrP
         PHnP71AdJYj9mCwctcTgpkytK3sc/EqAOsMdg=
Received: by 10.101.146.30 with SMTP id y30mr2735367ann.20.1265326365614;
        Thu, 04 Feb 2010 15:32:45 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm201701ywh.17.2010.02.04.15.32.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 15:32:45 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139011>

Hi gitsters,

The following request was submitted against the Debian gitk package.
Sounds sensible to me; anyone interested?

From: Matthijs Kooijman <matthijs@stdin.nl>
Package: gitk
Version: 1:1.6.6-1
Severity: wishlist

gitk allows configuration of the colours used in the interface, by using
the edit -> preferences dialogs. I've used this feature to set the
background colour to black and the foreground colour to grey. However,
some colours in the interface are not configurable, which makes this
scheme very uncomfortable to work with.

In particular, I'm having the following issues:
 * The foreground text color of the interface. The setting "interface
   colour" allows me to set the background of most interface parts.
   (except for the areas in the interface showing the list, diff, etc.
   which are controllable with the "background colour" setting).
   However, I can't set the "interface colour" to a dark tone, since I
   can't control the text.

   This should be solved by adding an "interface text colour" setting.
 * The background text of some of the interface elements (in particular
   some textboxes in the new view / edit view dialogs) are controlled by
   the "background colour" setting instead of the "interface colour".
   However, the text color is not controlled by the "foregrond colour"
   (and, as noted in the previous point, is not configurable anywhere),
   so I get unreadable text if I set "background colour" to black.

   This should be solved by making all text boxes listen to the
   "interface colour" setting, or by making the text in these text boxes
   listen to the "foreground colour" setting.
 * In the diff view, the two header lines of every file (containing the
   filename and git hashes) has a fixed grey background. The text
   colour, however, is controlled by the "foreground colour" setting, so
   setting that to grey leaves you with unreadable headers.
   
   This should be solved by making a "Diff headers background colour"
   setting, or something similar.

Gr.

Matthijs
-- System Information:
Debian Release: squeeze/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'stable'), (1, 'experimental')
Architecture: amd64 (x86_64)

Kernel: Linux 2.6.32.7 (PREEMPT)
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/bash

Versions of packages gitk depends on:
ii  git-core                      1:1.6.6-1  fast, scalable, distributed revisi
ii  tk                            8.4.16-2   The Tk toolkit for Tcl and X11 (de
