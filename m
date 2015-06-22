From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Mon, 22 Jun 2015 12:51:56 -0700
Message-ID: <xmqqy4jbfrmr.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-4-git-send-email-karthik.188@gmail.com>
	<CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
	<CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
	<vpqpp4nblc2.fsf@anie.imag.fr>
	<xmqq7fqvh7g6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:52:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z77lD-0005Jp-1Q
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbbFVTv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:51:59 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35247 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbFVTv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:51:58 -0400
Received: by igblr2 with SMTP id lr2so39156253igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kV0O+ABa5jyVDUoc2e5Ze8APPiA2HLW9anjgzNnzNTE=;
        b=asvrEhJBYARur5dtDZv8kpz+PiJ4NkIiM6SpJE1ExM/PjEJBOzMu/pA2WI3YeJvKgJ
         Pvjsz6qUzhzGFk7SaR1BktlV5G5ZheODlro+XFYTbawooiU3sNadeRNkCmApqmvZ2RW5
         w3XqQsmJmLASJJ9gw2Y05ytBc45D8FC/goOxZsh2TsH7lGzklqORt3QP3Fkwqd0iT2X2
         wS6zLyJfd8eZhoW8dlka5N7ExivJgJvPFexEtq9dq5Fe0LIfOPc+XslvLZCm/Vmkp7yx
         /XZv3zAYcLmeeb4gUuKlFzXmIKp/j8cbnvQhQ3tf0Gb93McDZH4QzVBTGSIHFyl2yaKr
         lLhQ==
X-Received: by 10.42.213.136 with SMTP id gw8mr27674597icb.95.1435002718292;
        Mon, 22 Jun 2015 12:51:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id d4sm13424989iod.17.2015.06.22.12.51.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 12:51:57 -0700 (PDT)
In-Reply-To: <xmqq7fqvh7g6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 22 Jun 2015 12:24:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272408>

Junio C Hamano <gitster@pobox.com> writes:

>> I have a slight preference for keeping the pairs not squashed. This way,
>> we have a clear separation "write reusable library code" / "use it". But
>> I'm fine with squashing if others prefer.
>
> As I cannot firmly say that "copy & paste first and then later
> clean-up" is bad and we should split them in different way, I
> am fine with leaving them separate as they are.

Having said that, I have a slight preference that a split does not
break my build in the middle of the series by introducing an
unused function, which is noticed by the compiler as a warning, and
turned into an error with -Werror.
