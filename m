From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] git-send-email: Add auto-cc to all body signatures
Date: Wed, 02 Dec 2015 11:04:02 +0100
Organization: D03
Message-ID: <87mvtti2ul.fsf@rasmusvillemoes.dk>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	<1311903782.20837.42.camel@jtkirshe-mobl>
	<1323313119.1762.58.camel@joe2Laptop>
	<7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
	<1323377486.1762.71.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:09:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a44MB-0003AP-A4
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 11:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbbLBKJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 05:09:46 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35354 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbbLBKEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 05:04:07 -0500
Received: by lfdl133 with SMTP id l133so43417951lfd.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=R05XzWLnY7kk4wYkc4jSJzGLfBXYecsYjchm4wmokXA=;
        b=PagkMFxlYgsx1OMo3oxkbtI8V1rXxDRAe1+avkncUHmQLi/TPLMBTZ2S1fHmUQHoV6
         ji90piT14CUdy3et9hcjX8eWBcIcQPnE4PRXNEswSofpYnbCmxM7fOx5gZzQZ2ByumEc
         yZMzKAP7o72yUCNGoB7sCNEiT11dT7dfU1O4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=R05XzWLnY7kk4wYkc4jSJzGLfBXYecsYjchm4wmokXA=;
        b=cOOgZ85Va1rW4HVbZCt+OJXKe9S/oMX8/eWyR0bGNeRTLN/fJ0y6kpAqmAovmKyhjP
         33iVPwT2N4JI/WQkOIdizSiObZIW9t3ohNQ1diLqeRzPRoYpznz3RQXWIAAOdGV2tWgm
         tjsmmdwBQ56IT29eo44DfqjJEhCmP6qOEFoGRiRjDzTcwNpi8jpsicRTpnNdzNCY/NTL
         7Tm9b0sXhAuOAjS9pZJvvAwsnaqegwHvhGtZ23WzIOiF4qlLt+C0tTY+9F9+erbrkFm/
         v57B+0+b7+zthKyrnZW/fWukxIGVolgV9BmHAfWMgl8GHMjNOpQOJtkEgndzACUFbz4O
         Tp8w==
X-Gm-Message-State: ALoCoQnL25Kt6tXlyqWr89z/TTHt8uIZwzd03upeI6WAuLEtbYG5kKd182DXQq3iNB6wuQEkq2Ix
X-Received: by 10.25.15.150 with SMTP id 22mr1514377lfp.19.1449050646123;
        Wed, 02 Dec 2015 02:04:06 -0800 (PST)
Received: from morgan.rasmusvillemoes.dk ([130.225.20.51])
        by smtp.gmail.com with ESMTPSA id tm7sm338043lbb.38.2015.12.02.02.04.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 02:04:05 -0800 (PST)
X-Hashcash: 1:20:151202:joe@perches.com::0/31epZmmdetPXBi:000X+i
X-Hashcash: 1:20:151202:jeffrey.t.kirsher@intel.com::C9tq5w6sgySPPaib:00000000000000000000000000000000000gAz
X-Hashcash: 1:20:151202:git@vger.kernel.org::dLdOx18zWqe/M0g3:00000000000000000000000000000000000000000027nV
X-Hashcash: 1:20:151202:gitster@pobox.com::phE0evjl810/WkZu:000000000000000000000000000000000000000000002EEs
In-Reply-To: <1323377486.1762.71.camel@joe2Laptop> (Joe Perches's message of
	"Thu, 08 Dec 2011 12:51:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281885>

On Thu, Dec 08 2011, Joe Perches <joe@perches.com> wrote:

> On Thu, 2011-12-08 at 11:37 -0800, Junio C Hamano wrote:
>> Joe Perches <joe@perches.com> writes:
>> > Many types of signatures are used by various projects.
>> > The most common type is formatted:
>> > 	"[some_signature_type]-by: First Last <email@domain.tld>"
>> > e.g:
>> > 	"Reported-by: First Last <email@domain.tld>" (no quotes are used)
>> This is just a phrasing issue, but I am a bit reluctant about the name
>> "signature".
>
> I've called all these markings signatures.
> Maybe email-address-tags or another name could be used.
> I'm not bothered one way or another by any chosen name.

It's been four years, but I recently ran into this. I mistakenly thought
that git would actually pick up cc addresses also from Reported-by, so
the reporter ended up not being cc'ed. Is there any chance this could be
revisited, or should I use a --cc-cmd to do what I want?

Rasmus
