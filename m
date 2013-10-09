From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv2 1/3] Documentation/git-svn: Promote the use of
 --prefix in docs + examples
Date: Wed, 9 Oct 2013 14:06:51 +0200
Message-ID: <CALKQrgf1CHm7Wnxh6iyF4yieSCcKa8_mfUPxw+mY1OTDja7ing@mail.gmail.com>
References: <20131003190139.GA8710@dcvr.yhbt.net>
	<1381015833-696-1-git-send-email-johan@herland.net>
	<CAPig+cQfWSY=NdynKOcrVrjoncjz_sNsJ40EpTMmp4FbyLZKmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 14:07:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTsXn-0004fa-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 14:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab3JIMHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 08:07:00 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:37163 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab3JIMG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 08:06:57 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VTsXY-000083-Bf
	for git@vger.kernel.org; Wed, 09 Oct 2013 14:06:56 +0200
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VTsXY-000111-3k
	for git@vger.kernel.org; Wed, 09 Oct 2013 14:06:56 +0200
Received: by mail-pb0-f53.google.com with SMTP id up15so805004pbc.26
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 05:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z4M3z44hQgCyOIz2wWos9p889zzw4VOlT/Xg8zRSXtY=;
        b=Zv1mo4MhnFIKHKLAV09enuipJx2OZZ7WoH+k7uc5TAY+FlHpgHPXnd82kn6A+C25Tc
         OmIIL0x6PlnW05HNO+DmxD5NXPvT3UfdDeuO5MTvZnX1z7XDWzGNcqeDpm6TvCcyKzZC
         3Bn6dNAs15C3F3AQeYy/z96taDryXR8JqrRMvDKYjtC9KgOLtMppqX9q1fS9YEOBHDVg
         51rutmoYYpInN63IGLKAaM8RJfBbwYXcGbOcfG8Iq8NCRZL0PajDH1GQSe2E5tP+kbJS
         JOFlLvSy9hRYpw5WZ/bFSG0fm6SLbM5TIpW1BKTXFygK9fOatJrfPW3AggehPBu8XGwe
         YQXA==
X-Received: by 10.68.191.193 with SMTP id ha1mr2784407pbc.166.1381320411993;
 Wed, 09 Oct 2013 05:06:51 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Wed, 9 Oct 2013 05:06:51 -0700 (PDT)
In-Reply-To: <CAPig+cQfWSY=NdynKOcrVrjoncjz_sNsJ40EpTMmp4FbyLZKmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235809>

On Wed, Oct 9, 2013 at 3:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 5, 2013 at 7:30 PM, Johan Herland <johan@herland.net> wrote:
>> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
>> index 4dd3bcb..da00671 100644
>> --- a/Documentation/git-svn.txt
>> +++ b/Documentation/git-svn.txt
>> @@ -973,6 +979,15 @@ without giving any repository layout options.  If the full history with
>>  branches and tags is required, the options '--trunk' / '--branches' /
>>  '--tags' must be used.
>>
>> +When using the options for describing the repository layout (--trunk,
>> +--tags, --branches, --stdlayout), please also specify the --prefix
>> +option (e.g. '--prefix=origin/') to cause your SVN-tracking refs to be
>> +placed at refs/remotes/origin/* rather than the default refs/remotes/*.
>> +The former is more compatible with the layout of Git's "regular"
>> +remote-tracking refs (refs/remotes/$remote/*), and may potentially
>> +prevent similarly named SVN branches and Git remotes from clobbering
>> +eachother.
>
> s/eachother/each other/

Thanks, will fix.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
