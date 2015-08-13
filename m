From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Thu, 13 Aug 2015 17:05:21 +0530
Message-ID: <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 13:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPqnj-0001eR-NS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 13:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbbHMLfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 07:35:54 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33333 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbHMLfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 07:35:51 -0400
Received: by obbhe7 with SMTP id he7so34629615obb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nQEb1Q4Rbp3tPOpE7Bp04pH0FoTbtPNOax+1spQmA04=;
        b=ADt83ZEgNrlU0U1TrHapQH6ldptMdNFIxeJ2teVurOeq9QJY2j6SJST3ts2Ye2qigT
         h1Mv9woe3wR3hphxKSn3aIllcngRjKeNbM78lfN2qPyHsLoo+lCOS5JMZ0r2xfq42IYc
         VZcZrUMRZcv5L7bL2NcFhWbKvcwjqQcc3YR0ancRtyKFVsl7FUJq7nJKtjV1yI7BK9Cy
         Dea/IC6U+imyzuwD4Pd5LCsUtVqcPibNTB6K9u//rcOCwdFJ1ULlsFcXAflm3621o1JC
         DvNVl7izkZD1nk7iKlLWM8I5oNjasoxWqLgB1MrS0DgnffxCCdUZUCXhMhAOu7TzQ7Tx
         0fLA==
X-Received: by 10.182.153.161 with SMTP id vh1mr33942134obb.34.1439465750321;
 Thu, 13 Aug 2015 04:35:50 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 04:35:21 -0700 (PDT)
In-Reply-To: <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275842>

On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> This was taken from branch.c, I thought of using an enum instead but that
> would again require most of branch.c, hence it's been carried over
> without changing
> I'm thinking of changing it, any suggestions?
>

What I was thinking was of having:

#define FILTER_REFS_INCLUDE_BROKEN 0x1
#define FILTER_REFS_TAGS 0x2
#define FILTER_REFS_BRANCHES 0x4
#define FILTER_REFS_REMOTES 0x8
#define FILTER_REFS_DETACHED_HEAD 0x16

and using these for showing ref kind also instead of separately
having 'REF_DETACHED_HEAD' and so on.

-- 
Regards,
Karthik Nayak
