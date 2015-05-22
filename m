From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 07:44:20 -0700
Message-ID: <xmqqlhggfz97.fsf@gitster.dls.corp.google.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:44:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvoBe-0005ot-62
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbbEVOo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:44:29 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34735 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbbEVOo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:44:26 -0400
Received: by igbhj9 with SMTP id hj9so38054622igb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+eH2YGh+dLhqYib3JNHB8gXlBVNIsnkcd/s8JINS11U=;
        b=ULDlhC85aokh/18WH7d0dy4DTQVg5LQeLFEtVr7DMK9UChuIsD7zdWmN6+/ELrwSvJ
         Ks3kVfw69B4FDvIu+cGGAXha03vk+AA0IoOLlGcnFWQpQvU/2HtKPyfkXt8ZILRvRQNL
         ua2meym0Wk2Skhsg/uHz0/iu3hlhab2suGixfKiMV55ZtruMDqgbJCb1ZFhuzWtyXReg
         vCIveEQxkPYU6aXyWStqilzFwtDYxn0M/2/L0VnxNQNm7AoOCu3dPYA2BWCZ0zYJajp1
         dpCwgq0DVihYDEPVrDuH+jsRQcDOGkWkDkSt3tQ+taWbQIHDxj7TT+mRXIpGJUyGjcxp
         GQFg==
X-Received: by 10.50.61.130 with SMTP id p2mr6206306igr.9.1432305865925;
        Fri, 22 May 2015 07:44:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id b8sm1923235ioe.23.2015.05.22.07.44.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 07:44:25 -0700 (PDT)
In-Reply-To: <CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
	(Allen Hubbe's message of "Fri, 22 May 2015 08:12:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269725>

Allen Hubbe <allenbh@gmail.com> writes:

> It depends what we want to do with this parser: accept existing
> sendmail aliases files in git, or enforce that git alias files are
> usable for sendmail.  I really don't expect the second to ever happen.
> The first, maybe, but only if the alias file is edited to remove
> aliases of pipes and maildirs etc.  The second may not work if we have
> comments to the right, or aliases of aliases, which sendmail does not
> claim to support.

Let me step back a bit.  Earlier you said your aim is not to use an
alias file you already have and use with the MUA/MTA, but to have a
collection of aliases to use with git-send-email only.  Is there a
reason to add support for a new format (whether it is compatible to
or subset of postfix/sendmail format, or a totally new one) for that
goal?  What makes the existing formats unsuitable?
