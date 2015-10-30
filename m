From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 2/8] submodule config: keep update strategy around
Date: Fri, 30 Oct 2015 10:38:38 -0700
Message-ID: <CAGZ79kZ1usWVutWwyFQKeujyyTPVRtSQM6dvkU9gWUDSTNpB6w@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-3-git-send-email-sbeller@google.com>
	<CAPig+cRTa35B5aHcopaWOtCLxN6BhGJKTcVeDUf0hrZE_nfCKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsDdT-0000mP-Nv
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921AbbJ3Rij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:38:39 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36499 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759823AbbJ3Rii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:38:38 -0400
Received: by ykba4 with SMTP id a4so82912678ykb.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ne3Rur9MMzeecS+MKpU1Ne5EuZ+q4jGI5KJrS6SF++I=;
        b=Go6flJhoKHZbpLlok97pLZe0TdTS24U0Ct49bd83HCDpCBYrxn0uBO4fkFSiSqzADv
         RKQqIxpW5Mpzu95tmY3Cm00UmgDNZU8aJ8fruuCH5QajF4/+L+kZ+viVdi58328ddh7D
         5b6CHhcHMzdTrkxEgRYzUdrxhQAnmgFLEbt+QgJHcITmf5H+0bonmN4TjoOdibIdVlSR
         zznJn76FomFKcG90UEPGP1HSsDaT19sDTvfDZIiHFwVivDbsWOH0k4oKaMYPMYKvWG8/
         6alBbzY8zw0S5YK+ltzeBj7e5Ffig1LLdFUjZlCeGIPGhqqNKj3rxtlUsKImC4jTop8F
         HFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ne3Rur9MMzeecS+MKpU1Ne5EuZ+q4jGI5KJrS6SF++I=;
        b=I/Uq9Mg8ys1qFr4RG8XJVHDeskyzYhBZS98Ml/TC7nontmUhe3RwNz9KEClyYGDLbP
         /2TIytsMyqKA0rqGcTH+UQJq2UYH1pfe0pZl4w4Xz0tUx4hpUfXy8MEsQmdDweKzFpRh
         CHct7uqI7FldG1e550LY8xKsmSsEtIH1nFcmhsI56RX1MqbJ8T4owU/qbjAG/WEuwDdx
         THCILT1+d5f3xlG85Z9pqxPiauiw8gq63B6wNHoWtSuiVCBynNJKOBg5KzpG2IqoK/45
         FOVpNtPPUiXSHuUt7hjBxM7aCmDbabHQobax9iKeGumdPHGsmVJYae+7TKdrTvCQcLus
         Zd5w==
X-Gm-Message-State: ALoCoQlEe1+lIx4RbeIziSkPFGehdQxRdFLhI4d6G3jRIqmF3s4xBifUvGDorPE1E2d39XKAM3UA
X-Received: by 10.129.29.8 with SMTP id d8mr7300635ywd.63.1446226718095; Fri,
 30 Oct 2015 10:38:38 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 30 Oct 2015 10:38:38 -0700 (PDT)
In-Reply-To: <CAPig+cRTa35B5aHcopaWOtCLxN6BhGJKTcVeDUf0hrZE_nfCKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280500>

On Thu, Oct 29, 2015 at 6:14 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
>> +               else if (!me->overwrite && submodule->update != NULL)
>
> Although "foo != NULL" is unusual in this code-base, it is used
> elsewhere in this file, including just outside the context seen above.
> Okay.

ok, I'll clean that up as we go.

>> +                       free((void *)submodule->update);
>
> Minor: Every other 'free((void *) foo)' in this file has a space after
> "(void *)", one of which can be seen in the context just above.

done
