From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 11:56:24 -0700
Message-ID: <xmqqmvyhig4n.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
	<vpq3809aho9.fsf@anie.imag.fr>
	<xmqqr3ntioyh.fsf@gitster.dls.corp.google.com>
	<vpqk2tl4mvx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:56:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJnZt-0007po-3i
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 20:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbbG0S4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 14:56:35 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34746 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbbG0S4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 14:56:32 -0400
Received: by pdbbh15 with SMTP id bh15so56421116pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PnVx/ncPh04dExLtxbyyyeeeZUpOkyOtrgUKsj7GkIg=;
        b=BI018j/5QgAZ4gq1Hk9sopTD57R8TbwkJ+/Pi7Ingiw7zp4pYvCuq1yQsx6YdD0ejF
         cpORNPv3bxLsx23fMsg00ILucyDDtDynln3+xJ7BL0J6krt08/ZQ8B+EskG+we2dhmTV
         peHAx2IQqgsGAUvHHp+wpSRpKNI5kUB9yXMXWUT+qQ3GtUd/gLEwzeKvrDnOUQXX5One
         OSHmuYiH80K2HBi7qPCsGbceJea+lJivIEhUyHru5n6mJlrvF1MmYuZdUNlKBh9kE2J5
         CxN3yGN3fdnPjAGHczzBpee1pLlwl1Fcai6uV1L/qU6YfMqyNv8QEt1Z+MKStWwXOLNg
         JUrg==
X-Received: by 10.70.41.176 with SMTP id g16mr61510779pdl.25.1438023392256;
        Mon, 27 Jul 2015 11:56:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id nh3sm16989989pdb.72.2015.07.27.11.56.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 11:56:25 -0700 (PDT)
In-Reply-To: <vpqk2tl4mvx.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Jul 2015 17:54:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274699>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Yes, but on the other hand we already have:
>
>   git log --format='%<|(50)A very long irrevlevancy|%an|'
>
> that pads/truncate %an. So, consistancy would dictate that Karthik's
> version is the right one.

Interesting.  Although that %<(50) looks simply a bug to me which we
may want to fix.

I wonder if there is a good reason why the above should not be
spelled as --format="A very long irrelevancy%<(50)%an".
