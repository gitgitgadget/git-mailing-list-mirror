From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 10:32:37 +0100
Message-ID: <9b18b3110902070132h2401a2f1w7abefa1c9906a567@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902070934.50555.jnareb@gmail.com>
	 <7v7i42y6ms.fsf@gitster.siamese.dyndns.org>
	 <200902071025.02491.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 10:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVjaI-0003gR-Oz
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 10:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZBGJck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 04:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbZBGJcj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 04:32:39 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:4894 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZBGJcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 04:32:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so652669qwe.37
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nbkE/sVqIePlSeijxHmMq8mp5+39DvHEoMH7vlSCvt4=;
        b=YRNCS5EqUhT5yb4MACbfy/Vw6Q+J9yNXU7hmZPWgnhKiUgxqPm7qZvo6/lLoXL+QMU
         SmDWWu13oj2DTLgR+lFtfSRsEXfGwxcNa35Io1tozjyY4Asrvuc+RTWjNbNw3OCLV8dc
         cBVE7zzCLvUgxflNrhWHyICV8qzLg+RU5OG2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iPeRgJN52fwl/v/htSwrDxTx0TXoFs4zhNum1XBYWvw/oS3GqBteN524Vke4uH1L88
         Hd30/oomaiJS5UjHrbnW1K7tEh92ARFFrJAULBO00jRNmYepJ97KNTJG2W/Sx+lkXQV9
         l3OpSoaEoKBok8k6KfEanoR5xvnZBGOCf/VDc=
Received: by 10.214.116.17 with SMTP id o17mr3987884qac.79.1233999157890; Sat, 
	07 Feb 2009 01:32:37 -0800 (PST)
In-Reply-To: <200902071025.02491.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108836>

2009/2/7 Jakub Narebski <jnareb@gmail.com>:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>> > It would unfortunately falsely match... but we cannot eliminate this
>> > case (well, at least not checking if hexnumber is followed by dot),
>> > because of totally legitimate
>> >
>> >    ... at commit 8457bb9e.
>> >
>> > So even with that we would have still false matches...
>>
>> Yeah, so what's the value in v2 over v1?  It is still wrong but it is less
>> wrong than it used to be?  I think the word-boundary one made a good
>> sense.  I do not see the @lookahead adding much value at all.
>
> Right. So v2 is less useful that I thought it to be; and adding further
> "exceptions" doesn't seem like a good idea.  The 'msgid' committag
> when/if it gets implemented would help there...
>
> So please take v1, as it is sane improvement and generic enough.

If you make it configurable then everybody can be happy right?

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
