From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 08:39:45 +0100
Message-ID: <CAFXTnz7O_nGu9AAFs_u0o+Ne4WtQT03QP6-fix7YGwpoSY+zWw@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
	<CAJDDKr6exXh14m08HTihxREjSFgyPT0bN1cF8eUryXJHOgFL1A@mail.gmail.com>
	<7vy5fkiek0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 08:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxuwJ-0004Cc-UX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 08:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab3AWHjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 02:39:47 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:43289 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab3AWHjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 02:39:46 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so4182820bkc.8
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RI/mqpIrdOleQ1C+iKcXRs5k3t2LUwqHa9VsiXXO0LA=;
        b=v44Hc5Ox66NzB83KINlLHZx3WZDPGcuCl7W7p9sAwAqqIvAWJkD4Pud34tCKZ1ZLAi
         x8MQWgY6OhJJ2FDgxNI6OWnbDr3IoF1XcPSHgjmVMJwuByEbuqtQ3zAmPclRlAK3RACi
         LVLFt3qThF4gYV1j1wwAdCgoj8MEL66sfFdtfsKn3cN1w/AUJE1Z/7ezjexNQTnumRuv
         V9Kju7HVbPDWmg6pjussbiH0voc5ytOkt+yLSPJTltXwrL08COvw+JHnGzJIpU2yVanj
         QCNr6cxxjj27CntTp21njbn2Q+SQJL/BKfx4XM+6p/sNUgARjv7HaXXhcf4or0YbsSxz
         5csg==
X-Received: by 10.204.8.17 with SMTP id f17mr81240bkf.110.1358926785274; Tue,
 22 Jan 2013 23:39:45 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Tue, 22 Jan 2013 23:39:45 -0800 (PST)
In-Reply-To: <7vy5fkiek0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214296>

On Wed, Jan 23, 2013 at 7:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> But I do not think the loop structure of this function is right.  If
> $D has ".git" in it, should it even try to feed other subdirectories
> of $D (say "$D/a") to itself in recursion to see if $D/a/.git exists?

Yes, this is needed to meet one of the goals for git-all:  to be an
alternative to git-submodule when submodules doesn't fit (the other
goal is to manage a collection of unrelated (not nested) repos).

-- 
larsh
