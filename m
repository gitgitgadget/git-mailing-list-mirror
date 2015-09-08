From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Tue, 08 Sep 2015 11:20:55 -0700
Message-ID: <xmqq8u8g93i0.fsf@gitster.mtv.corp.google.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:21:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNVt-0000jW-T3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbbIHSU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:20:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35292 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbbIHSU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:20:58 -0400
Received: by pacfv12 with SMTP id fv12so133706997pac.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8fbklrvww/GKQ3E4+ecK5L+40jZmXPkGlpEaXEIlVVc=;
        b=DRThGUMlaJmVUb2ionuMmsWfAEQsUEBcqy/uJHg5aId3cIFwAK/lfFa3hRbZLx75fa
         iD6szh1qIlPqW57s6NiK738sEx6Gc85yQezY5hzysmLHwr8vC9fvSDI+YgPxXR32K/4Q
         J+1fzpaK7N6IKAFGFDaFy/41pMHyShBr2rdpa1njj1CwmwyuSAeg1x/tNHS/pQiiPA7i
         /f0R5pfeaCX2G7C1eGbDKM3Vd7CstGXBCjij/MzvbU/71bfzrsnjX4/mvrWYBBZrekgA
         GKyBr/o9FXAKGUoZY2KzsPj+7XoucnIf3DmUrIe4v0+5zPh99oaY8gbeRdIEnztPtsEY
         XBNw==
X-Received: by 10.66.102.74 with SMTP id fm10mr1483582pab.137.1441736457867;
        Tue, 08 Sep 2015 11:20:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id zf5sm4201984pbc.36.2015.09.08.11.20.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:20:56 -0700 (PDT)
In-Reply-To: <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 7 Sep 2015 19:26:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277513>

Karthik Nayak <karthik.188@gmail.com> writes:

>> I am flexible with the terminology, but the point is that I think
>> the quoting rules are better be specified _outside_ the description
>> of a particular atom, but as a general rule.
>
> I definitely agree, but like Matthieu said, corrently we have only
> one such atom and it makes sense to note this behaviour under that.
> When we get %(if) to work we could move this over to a more general
> section?

Sure.
