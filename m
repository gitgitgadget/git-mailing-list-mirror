From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 13:12:58 -0700
Message-ID: <xmqqh9p350ad.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
	<xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
	<CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFpWk-00050i-Je
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbbGPUNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:13:01 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35434 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbGPUNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:13:00 -0400
Received: by igcqs7 with SMTP id qs7so1813581igc.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zo5wW8rcxBxhlTM4iA7SXXpLlYCCxg6XEVcGRkF6sh8=;
        b=Rtm2UcvXxc4oUi8yu84KarsnPOQ7JvBJayA0VqTTI9fePMMdYB5phZzLt3ygYAEF49
         Bl1G1m211+likWR81EJpg9s+fC8Zzd7SRCxSX3X+3+b3GyNwjxySV6h/KdDujyEhAhna
         wsmR7Wt494jAgbOu92xe6yUOFKvz46kpgBfpZ8LjLnyWf6F6eOkT2GQeK/3hBQj1Czhm
         1hEV7SPAihXg/FJTcEvwLSijQ+dZqyfV85RyH9975ICwfpRcwE0rDjAC8o8QO2XAfpMU
         QJQVm5s88tIJgnjrOdEQKshRNv7tfwX/JkaxpDzwOxSb41FJgT104m5jrT3URKNALciH
         +PWA==
X-Received: by 10.107.155.12 with SMTP id d12mr5501346ioe.131.1437077580251;
        Thu, 16 Jul 2015 13:13:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id rr5sm2029336igb.7.2015.07.16.13.12.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 13:12:59 -0700 (PDT)
In-Reply-To: <CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
	(Dave Borowitz's message of "Thu, 16 Jul 2015 13:08:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274041>

Dave Borowitz <dborowitz@google.com> writes:

> On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Perhaps something like this?
>
> Seems like it should work.
>
> Jonathan had suggested there might be some principled reason why
> send-pack does not respect config options, and suggested passing it in
> as a flag. But that would be more work, certainly, as it would also
> have to get passed through git-remote-http somehow.

I actually was wondering about exactly the same thing as Jonathan,
and that is where my "Perhaps" came from.
