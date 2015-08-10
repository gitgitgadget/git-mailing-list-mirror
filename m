From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/17] remove hold_lock_file_for_append
Date: Mon, 10 Aug 2015 15:36:14 -0700
Message-ID: <xmqqk2t2u5y9.fsf@gitster.dls.corp.google.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
	<20150810093514.GE30981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jim Hill <gjthill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvg5-0004CU-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbHJWgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:36:17 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35762 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbHJWgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:36:16 -0400
Received: by pacgr6 with SMTP id gr6so35735590pac.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Pl6pyqV+u87VvE9L4+X7WgKyM2Fd42GQDfRm9Pi59kk=;
        b=PPJP2m6CyELBz2MrV2brJvE2lWuZJCE0E4JQOPRW8JgywX5KUQu5tw1UY2NF+JQm5w
         Zi2x75nwBW5RIHrbhqPt8gmyrJ/gq2AnjtTa/drZZTo9sZX+OdEGG7q59L2erzXy3SwE
         9O93kkt4Jnn/aqN2LqQjrR7popkF2P5TKgJ8naMJkOFHjWcuCPqQAbDFYchGzwm2puud
         cLTKBSMBv2Nsd/PeWa1lfuyKx7Ei5yzd6oCVTUeiKWfDY1cO0+OKGjifoiCkkOiIVZ7n
         eWE0rsTn4wxxREV2667CwQnmJZQOUYs+SvxtesiYqyPMpAcP05N6c/xrSLyI7yRrMhp1
         2pAQ==
X-Received: by 10.66.55.3 with SMTP id n3mr48478575pap.58.1439246175870;
        Mon, 10 Aug 2015 15:36:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id dr4sm21132402pbc.61.2015.08.10.15.36.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 15:36:14 -0700 (PDT)
In-Reply-To: <20150810093514.GE30981@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Aug 2015 05:35:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275658>

Jeff King <peff@peff.net> writes:

> No users of hold_lock_file_for_append remain, so remove it.

This does not seem to have anything to do with rotating static buffers
used in get_pathname(); the only effect it has is to conflict heavily
with Michael's tempfile topic X-<.

Perhaps this should be part of Michael's tempfile topic?
