From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add testcase for needless objects during a shallow fetch
Date: Sat, 31 Aug 2013 08:25:42 +0700
Message-ID: <CACsJy8Dv7tVG_oWcPvNTy-zxD7axZxoXHcE1=TFwTv9+wGFCOQ@mail.gmail.com>
References: <20130828153638.GF10217@login.drsnuggles.stderr.nl>
 <1377705722-17053-1-git-send-email-matthijs@stdin.nl> <CACsJy8BDxkpFG=nfVENeAHMyhdokwvbpxu26m0RtHou_WK2Mkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Sat Aug 31 03:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFZxC-0003Oz-5r
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 03:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab3HaB0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 21:26:13 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35499 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab3HaB0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 21:26:13 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2550600obp.22
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4cHRiDdUdHxbG/M0F2TrsXCWPeiMfzKORt5ygDT/MAw=;
        b=aSbgKA5xmoOlp818YgcL+U1ilhhXyfphmE0nhWeC4ZoHId2LYBTZW1jGgByIK10Pt2
         daBZ+yVKYQTv6O4sAAi204oYuauEixYB2TqMpcG+vVoefa09Iec2myQFftEEZ9kxq7wq
         CM43adG8rruwV0DZze/rkAdkiKqMHXa0eI7SGTbTzTu0T6CEZkUehkelnePNyNjXiA3M
         dgFWjTNTaUA7cmdsOghmelJj03FQMF6F3QMhzCBm6uzZknlCIDvL2+NF+8bA+ne0j0gA
         doxWXPv3XIkN9SbiWN7M9v1PwvH6iypIgLM9LsvjNt0/lD6Joo08ZjqNJN/cNr6bwsbQ
         5pjA==
X-Received: by 10.182.134.229 with SMTP id pn5mr8537315obb.88.1377912372409;
 Fri, 30 Aug 2013 18:26:12 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 30 Aug 2013 18:25:42 -0700 (PDT)
In-Reply-To: <CACsJy8BDxkpFG=nfVENeAHMyhdokwvbpxu26m0RtHou_WK2Mkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233490>

On Thu, Aug 29, 2013 at 4:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Aug 28, 2013 at 11:02 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
>> This is a testcase that checks for a problem where, during a specific
>> shallow fetch where the client does not have any commits that are a
>> successor of the new shallow root (i.e., the fetch creates a new
>> detached piece of history), the server would simply send over _all_
>> objects, instead of taking into account the objects already present in
>> the client.
>
> Thanks. This reminds me I should add a test case in the 4/6 to
> demonstrate the regression and let it verify again in 6/6 that the
> temporary regression is gone. Will reroll the series with your patch
> included.

No. It's too hard. The difference is what base a delta object use and
checking that might not be entirely reliable because the algorithm in
pack-objects might change some day.
-- 
Duy
