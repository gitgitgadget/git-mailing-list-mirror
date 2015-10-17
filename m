From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line parsing
Date: Sat, 17 Oct 2015 14:24:13 -0700
Message-ID: <xmqq6125choi.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-3-git-send-email-tklauser@distanz.ch>
	<xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
	<xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
	<20151017103134.GD2468@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 17 23:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnYxh-0007OV-OP
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 23:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbbJQVYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 17:24:17 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36192 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbJQVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 17:24:16 -0400
Received: by pacfv9 with SMTP id fv9so54939690pac.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QP8AjVBKA3zAKOsZIIqKqFc+/p1MK6D+0O8djYIy9t4=;
        b=nbaix4RkUZ7NJx1sZDTOUT+NUCUyBisBRhNaMOa1ZDxdVx/nH1X3Q2bCyEwG1f6rLL
         OED82MOWhk8wpLjD7OWJ6qBoeahtCQbzE7Uw2w0zFhr4QdFApRh8Xy3mHC4Exvne7HJ4
         iqPFmb5enoXTSj3wrW3FwOH/w7kxBBKkXFsLGN4cyLTjdEvtKkZ3Xlo7fVNDnBLKGWB9
         Qee1Bqu1ZKXcdgMY2dkEs58ABPrNMuIHe5a7Xl/VG6A2zEiDKm12Hp7sgNUDLzMX/y/r
         Zp7UPORdWwbHAtqBFhvnf0AZM8hP5shkhLdObwowV5/+qg6Q8gDe16KAj21RMKIscBMD
         PEBg==
X-Received: by 10.68.197.168 with SMTP id iv8mr24595497pbc.81.1445117056239;
        Sat, 17 Oct 2015 14:24:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id dz2sm16790649pad.46.2015.10.17.14.24.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 17 Oct 2015 14:24:14 -0700 (PDT)
In-Reply-To: <20151017103134.GD2468@distanz.ch> (Tobias Klauser's message of
	"Sat, 17 Oct 2015 12:31:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279794>

Tobias Klauser <tklauser@distanz.ch> writes:

> On 2015-10-16 at 19:29:35 +0200, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> >> -	if (mode == INVAL)
>> >> -		usage(usage_msg);
>> >
>> > When given "git stripspace -s blorg", we used to set mode to INVAL
>> > and then showed the correct usage.  But we no longer have a check
>> > that corresponds to the old INVAL thing, do we?  Perhaps check argc
>> > to detect presence of an otherwise ignored non-option argument
>> > immediately after parse_options() returns?
>> 
>> Perhaps like this.
>
> Thanks. I'll fold it into v3.

Before starting v3, please fetch from me and check what is queued on
'pu'.  It may turn out that the fix-ups I did while queuing this
round is sufficient, in which case you can just say that instead ;-)

Thanks.
