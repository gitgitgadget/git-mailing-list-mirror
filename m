From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Wed, 07 Aug 2013 14:32:55 +0200
Message-ID: <52023E77.4080909@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net> <20130726193643.GH14690@google.com> <51F6AE1F.7080607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 14:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V72vN-0004ln-BE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 14:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804Ab3HGMdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 08:33:04 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:40633 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699Ab3HGMdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 08:33:03 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so810369eak.15
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Xaj1W/MzTX0BaSKGhyaMFed+uAljGRUXPjPgeps7XwU=;
        b=Z9gKSBXfL01UlVMVDw7sQIpMWxLqW9K4vDPcwOr0Xt/KAMA04mkaxeMfViNTl/iEKT
         iNSq3UR9roFy1H4NlDUXin3nqSrwQ6HB0VrecM8UxM+M/dmF9SMGW4ZgHxfLNl9ChiZr
         QDoym5IqbgNaJQDo34FvuV2/HWnVvGO/7RIfyISosW4Ja0VkAClLIsxpobmcQ5im3Wy+
         rrSu9mfQROBgJA+/fbwjLfGNbAqJElS2CvkXINR9DejHMFO56lz89hk/8pJwVvwOwYY4
         UDixixjC4E5Xrbo6vOlyZYYlPQ1PyBmOhYGz1z1P+OUnAEFll+U9xN88pJopIlVepf0Z
         tWRw==
X-Received: by 10.15.23.129 with SMTP id h1mr2866023eeu.127.1375878781461;
        Wed, 07 Aug 2013 05:33:01 -0700 (PDT)
Received: from [192.168.1.16] (host40-69-dynamic.1-79-r.retail.telecomitalia.it. [79.1.69.40])
        by mx.google.com with ESMTPSA id bq1sm9285794eeb.9.2013.08.07.05.32.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 05:33:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F6AE1F.7080607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231820>

On 07/29/2013 08:02 PM, Daniele Segato wrote:
> On 07/26/2013 09:36 PM, Jonathan Nieder wrote:
>> Eventually the description section should probably be tweaked to start
>> by explaining what the command is actually for. ;-)
>
> Elaborating from this suggestion you gave me I tried to
> rewrite/rearrange the description moving things around a little.
>
> Here's what I've come out with, what do you think about it?
>
>
>
> DESCRIPTION
> -----------
>
> A tag is a non-mutable reference name (in `refs/tags/`) to an object
> (usually a commit).
>
> If one of `-d/-l/-v` options is given the command will delete, list or
> verify tags.
>
> If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
> creates both the reference and a 'tag' object containing a creation
> date, the tagger name and e-mail, a tag message and an optional GnuPG
> signature.  Unless
> `-m <msg>` or `-F <file>` is given, an editor is started for the user to
> type in the tag message.
>
> Otherwise just a tag reference for the SHA-1 object name of the commit
> object is created (i.e. a lightweight tag).
>
> Unless `-f` is given, the named tag must not yet exist.
>
> If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
> are absent, `-a` is implied.
>
> A GnuPG signed tag object will be created when `-s` or `-u
> <key-id>` is used.  When `-u <key-id>` is not used, the
> committer identity for the current user is used to find the
> GnuPG key for signing.  The configuration variable `gpg.program`
> is used to specify custom GnuPG binary.
>
> Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
> tags; whereas a "lightweight" tag is simply a name for an object
> (usually a commit object).
>
> Annotated tags are meant for release while lightweight tags are meant
> for private or temporary object labels. For this reason, some git
> commands for naming objects (like `git describe`) will ignore
> lightweight tags by default.

I suppose there's no interest in this anymore

thanks anyway,
Regards,
Daniele Segato
