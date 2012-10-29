From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Mon, 29 Oct 2012 10:42:55 +0900
Message-ID: <4c48983e-83a1-4a8f-8dee-114039779a47@email.android.com>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org> <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 02:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSeNu-0000XU-6n
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 02:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab2J2BnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 21:43:09 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:42056 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab2J2BnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 21:43:08 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2168545dak.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 18:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=imf9vKlIfMdxDcZYHr8ftb5BbkFvvCP6cHzv8z0TNhw=;
        b=ydYHyBKliy0V0wXPUPtb+TrLr1FczE+orLmU7p1Lx3MVXLakoR1szvUKHjMtaYJD7S
         1bngU6DU1WlcJNqqlhPiMJOYlYL8XAGndPlqpO5F0lqqJvrpfH+YaPDW66qddqv5xJf5
         e42qCBCLA8S6HrwPXuJYCV9ElnyeT3Xe+DRM2ecC1sRTQY9wE8LIAEBXk/VexsvguycU
         3L1rrOwkvxsQ18hPPCjzywfiPECApzAEB37LsQMJselgIDIvrMqOYhSuCe5uLOitjoXc
         zm/rEnXIAPsViJPI5gnN6L6Cs8VCpqG+pX/IaV2QyOhmwXfC0WN+2YmHplkMsJakD6Um
         JAuw==
Received: by 10.68.204.132 with SMTP id ky4mr88023252pbc.164.1351474986897;
        Sun, 28 Oct 2012 18:43:06 -0700 (PDT)
Received: from [192.168.0.3] (123.230.55.28.er.eaccess.ne.jp. [123.230.55.28])
        by mx.google.com with ESMTPS id yi9sm5087824pbc.39.2012.10.28.18.43.03
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 18:43:05 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208580>



David Aguilar <davvid@gmail.com> wrote:

>Is there another way to accomplish this without the performance hit?

Perhaps not canonicalize elements on the CEILING list ourselves? If we make it a user error to put symlinked alias in the variable, and document it clearly, wouldn't it suffice?
