From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Wed, 22 May 2013 20:13:37 +0530
Message-ID: <CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
 <7v38tgno2k.fsf@alter.siamese.dyndns.org> <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
 <7vppwkm682.fsf@alter.siamese.dyndns.org> <CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
 <7v7girks4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 16:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfAH9-00013G-B8
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab3EVOoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:44:19 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39223 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab3EVOoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:44:18 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so5306315ieb.38
        for <git@vger.kernel.org>; Wed, 22 May 2013 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tM6n/J3ot9tAXeue1KOuQjns6EQCqj4nxQzZ9Re6gQI=;
        b=iVZaTVjlckS2PrcT7Lxr8vmg4WWqau8rZZLNc591Fi7foQENBRrOednYoFKbUrU2R1
         K/fWnuBFA0oINdhxO4FLdqL02QajI1yYQW+L3pbLc1hRIL4PTjuVfkZpCC2t/ydlgYHQ
         4Ja7yy+vJm+J6MPXCmA9h962kRSQzpYTKDjIMOYN92DYSFmlWJTumxBc6py5LbxNZnFL
         tC1/nJBYehSLWUR/xP8T8Eoqhj87KpPR93aPwEP20LdZu8YldOddQRcInwpDoFaCik8U
         1CmkC8HON+ZI6OuwUrKlpiIfBB+amv9hWAbUJT7qlc95Sbwp4iqEYuI7T68C3ADGWMO4
         o8Xw==
X-Received: by 10.43.169.202 with SMTP id nn10mr6169373icc.4.1369233858143;
 Wed, 22 May 2013 07:44:18 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 22 May 2013 07:43:37 -0700 (PDT)
In-Reply-To: <7v7girks4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225164>

Junio C Hamano wrote:
> The patch may have been done by a wrong motivation, in that it does
> not fundamentally "fix" the itch.  The particular "itch" is not
> something we are going to promise to the end users, ever, anyway.

Just out of curiosity, is it possible to write a correct fix at all?
Even if the first statement in do_push() locks the HEAD ref, it's not
enough: the program may be wading around in git.c/setup.c when I
switch terminals and change HEAD, right?

So, our position on the matter is: no git command makes any guarantees
with respect to races, correct?
