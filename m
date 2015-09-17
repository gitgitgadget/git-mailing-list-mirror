From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 09:49:58 -0700
Message-ID: <xmqqeghxj8i1.fsf@gitster.mtv.corp.google.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	<vpqpp1hqgcd.fsf@anie.imag.fr>
	<xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
	<vpqio79oxva.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:50:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccNp-0001Mt-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbbIQQuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:50:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35331 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbIQQuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:50:00 -0400
Received: by pacfv12 with SMTP id fv12so24720850pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q3HpH7s/qt9XVmX9gFxcM/j4AVbANl6D7MCv/fUi2pI=;
        b=OlaOL6NcxxYlpIKWjCRDoNDVvjMXl36Kcl7BVrmmO78rBdKGRarK+j4qcGMV94e5Mf
         8ujkdT+DwJ3khwX3WDOlNBcJN1YhldBvG3Hi6GDTX2g7b8jj06tQGaehleSkMn6IQBMB
         p2NgT0JGJUGBYweGp4AjFiF9QhgeDhhuTmZvm/IpzgpuJnN7KJcs+Oeli8Np7ocy/R6K
         SRljmjguEnIwJ+sl1AtCw0ppkypUAt/+mlqZyVjRs6QQLLO5EIzBSp+huCA6eidGqf5B
         +OgkatCNHIGFDk5eD3fDCcA0MRgLMn1Th6fbSQargohLuUzoelWKN/mj1BQ7rbS27/U8
         Lh6A==
X-Received: by 10.68.244.137 with SMTP id xg9mr187662pbc.27.1442508599661;
        Thu, 17 Sep 2015 09:49:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id uy4sm4383378pbc.69.2015.09.17.09.49.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:49:58 -0700 (PDT)
In-Reply-To: <vpqio79oxva.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Sep 2015 17:43:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278136>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But that's still workable: struct ref_sorting could contain a flag
> "head_first" that would be set by ref_default_sorting() and only it, and
> then read by cmp_ref_sorting.

Hmm, I am still puzzled.  "refname" atom would expand to things like
"HEAD", "refs/heads/master", etc., so I still do not see a need for
head_first option at all.  "HEAD" will sort before "refs/anything"
always, no?
