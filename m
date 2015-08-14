From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 16:31:50 -0400
Message-ID: <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com> <xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLeB-0006jq-KX
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbbHNUcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:32:11 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33899 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbHNUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:32:10 -0400
Received: by igui7 with SMTP id i7so20592381igu.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H8N5lPkikBQJjZb9ax7Z56mFJRj2degucqlVyHLkOaA=;
        b=kFYeeHejOCKWYVFLJo1fgCQ9GfFGhyEEiX0mYOH73E8IuzRz+Q4Czt4FTxdnd3LLqk
         5XUbkWn/ZJveMxSckKgPOXyihAJjCGbLSsSXRnRbKrB0r9SSzKFithC5Mv8wduFMxYk+
         UIu3pQ2cbLgFaHjpmQAQZK4LXl7OlcEavIzE48ONR5s2tciATRPGxGKBwp8ooF8xi8Zg
         +mmpCcQRtF714TArISCgYwrs4raG0NQwLxBmPfcuVsbL5sjxUdQdUSW3hWIGg8YYHc1k
         E2/EpS9PVV6uublhl8zjEzVP//uaOBb9H6j8k8AtgImg98fillybfnwwVLs2G5IAq2x3
         E93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=H8N5lPkikBQJjZb9ax7Z56mFJRj2degucqlVyHLkOaA=;
        b=X4d6PhcghhcEu2KvX+IsawPICjhiZnhBwPO0oNYZs6Xdn+Z48p5ExtKjrDZJ392s16
         9uTQe26Shb9HndtkUOhpINyjfdpQ792r4sVHL57ok8btlu4sCBotFS6dwPSbQcvtCJYy
         5vpd0Tz16jPPBUbCdW0MVHAhb7Z+W1gOB2OlJbIQckS26WMQ0ggzuyNYt4elhiJIx4HF
         ciuP6DSrmWzmkKKQWyIfxjGm9sADWYz3nb7XcO7yo4lt7kszAckiWYZAi6fYf4boOFJ3
         LN8iZL3gBe283vwu0IZRfbsm4tfZkwa9wpYAeiGR2bveiCi9LaqPOamXh+Tb/TcQNCgC
         8Ymw==
X-Gm-Message-State: ALoCoQlpjOL8tmBlJNQb++XD9CU4orBAcb+xsCiv6bZEBwr8Uz2plEVEB6jqZB8MIukWUBLSX+/c
X-Received: by 10.50.132.70 with SMTP id os6mr4392864igb.27.1439584329663;
 Fri, 14 Aug 2015 13:32:09 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Fri, 14 Aug 2015 13:31:50 -0700 (PDT)
In-Reply-To: <xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275940>

On Fri, Aug 14, 2015 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The "if-possible" name and weird tri-state boolean is basically a straw man,
>> and I am happy to change if someone has a clearer suggestion.
>
> Yes, it looks somewhat strange.  Let me go on a slight tangent to
> explain why I think it is OK for "push --signed".

I think we agree that there are three possible behaviors for push and
we should allow the user to specify any of the three. The straw-man
strangeness is that two of them are the traditional boolean values
"true/false" and the third is "file not found^W^W^Wif-possible" :)
