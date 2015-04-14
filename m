From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Tue, 14 Apr 2015 15:34:12 -0700
Message-ID: <CAGZ79kZvTdmGpoQozNjNefB4CWm31C05S1JoEBASFofxpYUXYg@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<xmqqzj6a1m3c.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaO_1QMMTY0ni9k3hrkrt_PhqRDRzXkhZEiYuJ0EsE9Tw@mail.gmail.com>
	<xmqqd2361gx8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:34:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9PP-000060-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbbDNWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:34:16 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35207 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbbDNWeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:34:14 -0400
Received: by lbbuc2 with SMTP id uc2so20387844lbb.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YkvX7SFyxVM8FdlDTqFSey42oCpLnU7mUWmBmegMOQ4=;
        b=MDdX4Ia4J+ygK9JSH59M6TYIHuGkBcFQIAudAGEkSmrK8rSwKAfzD/evzDtEITKLnZ
         dvUYfdvbBSREGxv6LyrOV7P8N8swSrKr68JZxwM98J1LyCKQOA1d7CAT8GOE1FrTCjos
         9gyz5O1ziR92eoMC0d/AUgM44aV5KEvKZbgEgCNvfYNiuk6r5xCN/hZjKc/WuHaivwZp
         w+jKop0vgoc0WTXWKvuoZKW5G/nM5UXbJGy1O/vJtgcDU/2CtKxVKQ457oNSy26JYILs
         dCinQEdVMv21FNkDlTGu3SBJ8ernq0BlFxlN5KMPoC3qY35VaSfevZJBjjJnp+HOGyUO
         7Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YkvX7SFyxVM8FdlDTqFSey42oCpLnU7mUWmBmegMOQ4=;
        b=cq6DDTao2iqnLhTTG4q23G66yrfktkXScjCfGu5SoJ0efKPyl2+fXw4N7mzhfmIji1
         E0VyedNU+P8E0rgmpSGbu0PnHajohwQ9fA/6rvZIlhy6iZ0uzGgZGgrm2enMUJAvBj8w
         LqIIWbXSSjzlC7xeeKBPgMF7Ma05R4gvrIllyhrzAcUNbpFm6s1RXRJZigAtJlnzKfkX
         iutqcFHj33J8wGB9VNxG0td5kyYh8LsZu7GnGQJFq5aU0LHAWdaiZkl+zGtqbptRcMl0
         t/2W69KaB6ZyfXZ3zl8kOByLUkoEF5ho7yOSJ4fUipUX/n0R46mRS9JXFBmFejWeaayu
         h7kg==
X-Gm-Message-State: ALoCoQl4N/DzE76A+EUrEfZOwzk073PXHTgnZFTyaB0w6KCDaeSuNRVuKMF+btwnRqzODftjzsWj
X-Received: by 10.152.25.167 with SMTP id d7mr21128650lag.108.1429050853015;
 Tue, 14 Apr 2015 15:34:13 -0700 (PDT)
Received: by 10.25.43.210 with HTTP; Tue, 14 Apr 2015 15:34:12 -0700 (PDT)
In-Reply-To: <xmqqd2361gx8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267173>

I need to learn to read the whole sentence. :(
Apologies.

On Tue, Apr 14, 2015 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Apr 14, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> It is OK to omit the name in the extern declaration here.
>>
>> It is OK, but I think this is bad practice.
>
> Take a special note on the word "here", meaning "in this particular
> case."  It is perfectly fine when the meaning of the parameter is
> clear from its type.
>
> I was assuming that our developers have common sense to disambiguate
> ambiguous cases, of course ;-)
