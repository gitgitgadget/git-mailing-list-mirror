From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch: introduce format.outputDirectory configuration
Date: Mon, 21 Sep 2015 15:41:34 -0700
Message-ID: <xmqqk2rj8kf5.fsf@gitster.mtv.corp.google.com>
References: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9mJ-0000o4-1K
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbbIUWlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:39 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33121 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbIUWlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:36 -0400
Received: by pacex6 with SMTP id ex6so128734519pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1ODPFneDbmAQP1Pyj2fuCsti/3BsHSFOQc9h3yKxn+w=;
        b=sUYP4KhNgHGAJRoP1BuuV9HSbzampC0+hyamqvdEGV7MVHvJUgEmyTgpEsnGRsexfE
         9VH2hQi7WcqTuhCycjF9pcJdKtpNH5m56kSisRAuLPG0drygJ3Pw/aL+DNqO31BACBUs
         gP6SqQESFQ84t7Yw4LnAylNDgiys/CCG+Jagiig7GtXHC8JeWTEl5jFgSH+q02D2BYt4
         UDaPViayoIqrLI8wdZcU8zfFmwaJuDwOSRPY6Oyxu/JOUPnfYfV5Pfy5/VNTRhGllDdn
         iYFb3r4RpC5nkcjfesqB2lgwQfOQa2Kvk1XvvsKkecpBO06O459ZhrXMnnw6wN7U+6hA
         jOCQ==
X-Received: by 10.68.192.9 with SMTP id hc9mr27645909pbc.57.1442875296341;
        Mon, 21 Sep 2015 15:41:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id o3sm26661456pap.37.2015.09.21.15.41.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 15:41:35 -0700 (PDT)
In-Reply-To: <CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 19 Jun 2015 16:34:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278354>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 19, 2015 at 2:28 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> We can pass -o/--output-directory to the format-patch command to
>> store patches not in the working directory. This patch introduces
>> format.outputDirectory configuration option for same purpose.
>>
>> The case of usage of this configuration option can be convinience
>
> s/convinience/convenience/
>
>> to not pass everytime -o/--output-directory if an user has pattern
>
> s/everytime/every time/
>
>> to store all patches in the /patches directory for example.
>>
>> The format.outputDirectory has lower priority than command line
>> option, so if user will set format.outputDirectory and pass the
>> command line option, a result will be stored in a directory that
>> passed to command line option.
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---

Looks like there were mostly editorial niggles and no fundamental
flaws in the design of the patch; it is somewhat a shame to make all
the efforts go to waste.  Will we be seeing an update soon?

We are deep in the pre-release feature freeze, so unless you are
participating in regression fixes it is a good time to plan for the
next cycle.

Thanks.

>> +static const char *config_output_directory = NULL;

s/ = NULL;/;/ (do rely on BSS clearing the static variables).
