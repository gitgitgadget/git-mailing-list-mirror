From: Marco Schulze <marco.c.schulze@gmail.com>
Subject: Re: [RFC 0/2] svn-fetch|push - an alternate approach
Date: Sun, 19 Aug 2012 07:21:39 -0300
Message-ID: <5030BE33.9000007@gmail.com>
References: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James R. McKaskill" <james@foobar.co.nz>
X-From: git-owner@vger.kernel.org Sun Aug 19 12:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T32e1-0004G4-Ts
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 12:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab2HSKVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 06:21:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39682 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab2HSKVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 06:21:43 -0400
Received: by yhmm54 with SMTP id m54so4700623yhm.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eZOSK5eojAY7WMdGUeVPD1CJH2T5g55336QUKTW3M4E=;
        b=dDlcCEZ4i8Y58OgJw1Mqxi2IrwtZiES2yLzPfKtY0/z+yy1XS/eAgv9hWNeIgiAz1p
         hqv1SfiqUlCag1L31ASXapxVIH4547SxMG++ssJHUqxpyM9+2kprPQa2GJFIwShYSdK6
         Gc+teH4wceu7NJieC+gKooJ7UjvLXsbidkqhk/T1oayPxRL0qBxfWkhP3UE3gJKbBzK8
         QRevenBcp6l+9d3dsG7sLC7rEEG1VZybHUmrMaUGFScB2rl9XG/WNmiLxGoiZoxRSczw
         XJoEKfNjEqpn4BLoeU9nlCTRhShDw5mjXkB3/dc2LLfodJjMOn402ng9c/7kEdzG4G5E
         Ppvw==
Received: by 10.236.149.174 with SMTP id x34mr16669251yhj.119.1345371702500;
        Sun, 19 Aug 2012 03:21:42 -0700 (PDT)
Received: from [192.168.25.100] ([187.115.179.252])
        by mx.google.com with ESMTPS id t63sm23578923yhd.7.2012.08.19.03.21.41
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 03:21:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203716>


On 18-08-2012 14:39, James R. McKaskill wrote:
> As a twist the code does not use the svn library, but rather talks the
> svn protocol directly. I actually found it much easier to go this route
> then trying to bend everything to how the svn library understands
> things. It also has the advantage of not depending on libsvn. A number
> of distributions currently distribute the svn specific parts of git
> seperately to avoid this dependency.
It is a bit of a pain to work with libsvn, but I think it is worth using 
it, not only due to protocol support, but also due to ready-to-use 
support for SVN deltas and dumps.  Pipelining could be implemented by 
maintaining a set of connections (svn_ra_session_t structures) and 
manually distributing work between them.
