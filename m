From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] revert: move replay_action, replay_subcommand to
 header
Date: Sun, 8 Jan 2012 13:31:10 -0600
Message-ID: <20120108193110.GF1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:26:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyNd-0006ET-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2AHT0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:26:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52072 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2AHT0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:26:02 -0500
Received: by iaeh11 with SMTP id h11so5649594iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0IZr6pHMDM/ZOk9p9QS37H8sMf4RT1U9T/LXHm8FbL4=;
        b=bqrrwn3oWkHtTSVyRQ+EcI0ldTiZyKlxYdckAONj912cKVobLPwk+tHMi5M0vIut+c
         p/I00/yaVHyNa9kAnIHtc/CaAk+4B7kCvm0Vi3e0DxrAgGoRmLBbMmUUfJas9MyTIS0j
         1EpiSZAzN3Cq18GYumfPfoOpCwfU+adur5FrI=
Received: by 10.50.47.228 with SMTP id g4mr16217884ign.14.1326050762114;
        Sun, 08 Jan 2012 11:26:02 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id va6sm44768835igc.6.2012.01.08.11.26.01
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 11:26:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188116>

Ramkumar Ramachandra wrote:

> Our plan to build a sequencer involves leaving the revert builtin with
> just argument parsing work.  Since the enums replay_action and
> replay_subcommand have nothing to do with this argument parsing, move
> them to sequencer.h in advance.
>
> "REVERT" and "CHERRY_PICK" are unsuitable variable names for exposing
> publicly, as their purpose is unclear in the global context: rename
> them to "REPLAY_REVERT" and "REPLAY_PICK" respectively.

My first reaction: this probably would be more self-explanatory if
squashed with the patch the moves the rest of the code to sequencer.[ch].

Second reaction: ah, but the s/REVERT/REPLAY_REVERT/ and
s/CHERRY_PICK/REPLAY_PICK/ changes would be lost in the noise of the move.
Maybe it would be possible to make those changes but keep the enum in
builtin/revert.c, explaining that this is a preparatory step and they
will be moving in a few moments?

Hope that helps,
Jonathan
