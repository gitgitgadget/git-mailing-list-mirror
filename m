From: David Turner <dturner@twopensource.com>
Subject: [PATCH 0/6] refs backend preamble
Date: Wed, 24 Jun 2015 15:16:22 -0400
Message-ID: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAM-0000AF-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbbFXTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:16:55 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35633 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbFXTQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:16:53 -0400
Received: by igblr2 with SMTP id lr2so82280364igb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=IEmVRzdK8WtjB/h+S6fvWjp/C85UBGBf5SYQfB8q90M=;
        b=eQkRkst2PY+vg4fuP4He7FTfg2HpadbN3BSB+QH+nOe3aMBgRBDbdTm8RQIVSu3OfU
         uOie92Vc7zgcTTjADg6kR0q3LvdtzIqW1yIJd6vI/VEcnUnAa1GYy0NmVWRwG3NbTk4v
         CuVhokkWio0bHIXKR8QNrIsmbEna+KwT1159nUV9ZD5Ke6l9hUmVzDjHrISf5xIFVXCz
         gorxEzl3HmHi3fymHNE/xv2F9hP+u0zPaeYX6yfmP7PEOi8V/u0UnOAFLnABrPoMnJLT
         ObjYHUv7myzWdZ+1bM7ybNa26SYEx4NKiqfODq+B/9bKYUalKHiO0YbstbWg4zUCgmgr
         CBqg==
X-Gm-Message-State: ALoCoQl+hI8vuzEntEekwuGCVQjGtDzY/pJR7k9NYcIliMyALijyw+VnYAg2e3/zSbhF+VtwRjdj
X-Received: by 10.107.6.29 with SMTP id 29mr8657765iog.54.1435173413153;
        Wed, 24 Jun 2015 12:16:53 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.16.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:16:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272580>

This set of patches is a preamble to pluggable ref backends.  The
intent is to use the ref infrastructure for special refs like
CHERRY_PICK_HEAD where possible, and to use git plumbing commands to
access refs and reflogs instead of directly writing files to the .git
directory.

This series is on top of pu at 9039c98c.
