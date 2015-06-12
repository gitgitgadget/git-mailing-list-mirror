From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 11/12] for-each-ref: introduce filter_refs()
Date: Fri, 12 Jun 2015 12:38:40 -0700
Message-ID: <xmqqlhfod8e7.fsf@gitster.dls.corp.google.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-11-git-send-email-karthik.188@gmail.com>
	<vpq1thixjs3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:38:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Un1-0004sc-Cw
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 21:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbFLTir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 15:38:47 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33756 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbbFLTin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 15:38:43 -0400
Received: by iebgx4 with SMTP id gx4so30448430ieb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VFdPL4KnRo7AZWe8/DK9v7uWQ+RW4gN9tA98Qz/xKq4=;
        b=HiBoP+ie/Bh56kA7VLZ3BDzdY7SgdeiqAZ38a+zWTqDxCSdeFUleY+FM7ivhh9nTvT
         3q19O5KOIqlGVoJ85GI4LI9IjAZFUUaCVktT6x+GFwB8IsBJW5btGGuc/62UO2+7An4h
         QjADS/M4jD8kjQsKl9ftBmZZEEtehBIR1hExebDNnjsIfxA1H7VmN2URGmjZLFSDWIZY
         csrhxcY8zgtT6TnX3mRyFmXWWN7CFxRLKL5EQzrtFJyD66vko/cdWJievum+jos+VtC2
         dZphs/IZR3xtJL5R8lBfp6cOHeZ/tvTvk2m7X6KZbd99Tn0f5uEpoaKGRBcKGLzSFrJb
         CU9g==
X-Received: by 10.50.136.134 with SMTP id qa6mr6489827igb.26.1434137922552;
        Fri, 12 Jun 2015 12:38:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id rr5sm1784023igb.7.2015.06.12.12.38.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 12:38:41 -0700 (PDT)
In-Reply-To: <vpq1thixjs3.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	11 Jun 2015 19:00:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271515>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +	filter_refs(&array, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN, &filter);
>
> I think it is more common to have options at the end, so I'd write it as
>
> filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
>
> (changing the declaration too, obviously)

Good point.

>
> I really like the way cmd_for_each_ref looks like now.

Likewise.
