From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Reading remote reflogs
Date: Sat, 30 Mar 2013 01:02:56 +0100
Message-ID: <1364601776.30202.10.camel@localhost>
References: <1364595928.30202.4.camel@localhost>
	 <7vd2uhn7u1.fsf@alter.siamese.dyndns.org>
	 <1364597780.30202.7.camel@localhost>
	 <7v8v55n790.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 01:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULjGk-0001EX-3G
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 01:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab3C3ADB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 20:03:01 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:53659 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281Ab3C3ADA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 20:03:00 -0400
Received: by mail-ee0-f54.google.com with SMTP id e51so391698eek.27
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 17:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=p97B9dRe1PH3A61yWMj8QTHchz+uLa9hSRutGXPjqto=;
        b=fANP5rAWfSH8qv0DFzCiBYQ1RIhnctjr+qsRaXePlKlbHHGtDtXZ9bAtaXR5urSJ7J
         Gw6FqE8f/PVRzdVIrH3Jv0sSTnyTSukE5ZDcC6quj7aKc5t7zvL+uw9a8hJEzY/g/Myb
         W9Y01gEJJA/JoWSL6YPt3/EH9tKXpE0SM4p4g5ETPh0mf3n4vcIOkt4vX2LaYdS5++m9
         cJdeY2bv3ee3cqav6YN8RzYoh2NAduv33Z0dvuY5/lma2oxrJDQ8nDyx7h6n9SY5xpaB
         8B3UVKVt0tTe4ALbdff7ZjBxf5mn7kZ8Jq3ITd7aJKBE++6pB11cwf7dV5/x1DLx/MX1
         DCmw==
X-Received: by 10.14.210.132 with SMTP id u4mr12563521eeo.19.1364601778741;
        Fri, 29 Mar 2013 17:02:58 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPS id 3sm7021449eej.6.2013.03.29.17.02.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 17:02:58 -0700 (PDT)
In-Reply-To: <7v8v55n790.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQmHv40mQSDmHjNhmHn5ZWpgLrdXkcPHf+SU+458osQQVilk32so4F+xRyUX+eapAVmEgmks
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219539>

On vr, 2013-03-29 at 15:58 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On vr, 2013-03-29 at 15:45 -0700, Junio C Hamano wrote:
> >> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> >> 
> >> > ... Mirrored repositories don't
> >> > maintain a reflog, even with core.logAllRefUpdates = true,...
> >> 
> >> Are you sure about this?  When log_all_ref_updates is not set, by
> >> default we do not log for bare repositories, but other than that, we
> >> do not do anything special with respect to reflogs.
> >
> > I was, as I tried the recipe below, though with a different repo. Must
> > have goofed something up, as it works now. Thanks for the braincheck :)
> >
> > That gives me a reasonable approximation of distinct pushes if I pull
> > the mirror often enough.
> 
> Instead of polling, why not "git push --mirror" whenever the
> original gets updated?

I considered that, but it has two downsides:
- Slows down the push as it needs to wait for this to complete
- Only works if you control the master, so it won't work with e.g. 
  github hosted repositories
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
