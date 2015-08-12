From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Wed, 12 Aug 2015 09:29:00 -0700
Message-ID: <xmqq7fp0mpwz.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-3-git-send-email-Karthik.188@gmail.com>
	<xmqqlhdhso8i.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZSo9wXj_2wPCfZ=kEYhnFHzqT2AUFKvoDoKh_BD9v+1Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPYto-00062Y-SX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933777AbbHLQ3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:29:04 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32835 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbbHLQ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:29:02 -0400
Received: by pabyb7 with SMTP id yb7so17713876pab.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ELHBmqxjqa6j1kNJi8//doi1SGAnLk79oGKqEP5RSGg=;
        b=dDAz3Ho4d/Kt4KMQiW+BeFM25Yabrrbqe1YxkS3Aao+zX1VYvjEkbHXJ3YHEqkoIzU
         lcwBtbScq4dqE8T7qawb5dqukM6GmdvFDf5EmmSTgT7HVK5BQDjUJc6GCgOTCR5klDxi
         TFSOgqIy1UkL+3zt7lj+FnRx/S36Cy1m2+pV20de/XsrFDS0lFjeVolg5NJb3qJnccDc
         /SBh4GakK08Ya6u+qovG1jz7PAWr2s/Npmhkz+k/ktsIE/UXY8shb51fi6YSq+bPsCTI
         J+paQu9DtF3W3LPXP7a7KME1jH77CTjddpRuWaFveOFlMsFLI5PZ1KVPgkqfTvf/mDJ6
         ZkfA==
X-Received: by 10.68.250.5 with SMTP id yy5mr68910196pbc.34.1439396941779;
        Wed, 12 Aug 2015 09:29:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id y2sm6992649pdc.91.2015.08.12.09.29.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:29:00 -0700 (PDT)
In-Reply-To: <CAOLa=ZSo9wXj_2wPCfZ=kEYhnFHzqT2AUFKvoDoKh_BD9v+1Hw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 12 Aug 2015 18:52:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275780>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +             format_quote_value(atomv, quote_style, &output);
>>
>> If the one to add a literal string (with %hex escaping) is called "append_",
>> then this should be called append_quoted_atom() or something, no?
>
> Although it does append like "append_non_atom" this is more of formatting based
> on the quote given hence the name.

Appending formatted values is still appending, no?
