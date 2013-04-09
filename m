From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 8 Apr 2013 17:18:17 -0700
Message-ID: <20130409001817.GV30308@google.com>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
 <1365461200-13509-2-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 02:18:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPMGd-0003Uf-Gs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 02:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936556Ab3DIASX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 20:18:23 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:39761 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100Ab3DIASX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 20:18:23 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so2814724dan.38
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2dZdgPgSG8xlfYOTvzqUY8WMZiKrSO81KgOcdAwlCGI=;
        b=KVSPqbrUQBnIwKbmP+0EV5Jr98Vb1Kr0A9AnzcaDKKmAXRXNFXV6JdUre9MoIo+mRf
         oVh86FlKzlGRFZ2oXm4XYzjiBx1BNQMIqS106v1zkOnjBAxz5wWqaUlJdakz7h4dO3zJ
         hlq3u9QAcaoor9CulFpOR08N8QzE6W8vi88ZKbkVrkwNhRFtER+ryDAN6Nc0PUET6ehX
         YRtubKM5KOSqb8AWi3nvS+8VntCa46EpkbQaWozJFQvc/C8+l7FhH/th9oEV3AnkMp9k
         FlJlEc/StsXw2VKjeG2CVgQTLY9sfZMtJycpNua6WuKnSgWNMVBhCMquojH93y19ZHTD
         Vkhg==
X-Received: by 10.66.233.9 with SMTP id ts9mr41699434pac.15.1365466702018;
        Mon, 08 Apr 2013 17:18:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id fb7sm28133284pab.16.2013.04.08.17.18.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 17:18:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365461200-13509-2-git-send-email-aaron@schrab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220542>

Aaron Schrab wrote:

> Do not report that an argument to clone's --reference option is not a
> local directory.  Nothing checks for the existence or type of the path
> as supplied by the user; checks are only done for particular contents of
> the supposed directory, so we have no way to know the status of the
> supplied path.

Yes, makes sense.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

My only remaining qualm is that a person could be confused by the
message after trying to pass in --reference=file:///path/to/repo, but
I guess that trial and error would eventually lead such a person in
the right direction.
