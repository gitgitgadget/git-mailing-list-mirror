From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 14:00:02 -0700
Message-ID: <20140422210002.GC15516@google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
 <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
 <20140422185829.GB15516@google.com>
 <xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:00:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wchnd-0003eu-P8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 23:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371AbaDVVAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 17:00:09 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55083 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174AbaDVVAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 17:00:06 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so20416pab.34
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PgAliG96zqP9WS9paLte4SvJZhN8x4qUi536JEYwLvA=;
        b=vInfyxPo+NV6wznYlZxuas+QPUsNlFKtwIPzyfeV5NkPHSW3chp2zxGM6OhCe2aqRv
         5wtVSGAxa9k7G7CFx2JwAFPUHSkwB9o1Jh+/lpg8VSw8NUIHYV6tafguF4C9Ugm3q5aw
         o5R9oR34OY9f765SzRoiqGLOS20jq6wnOBC7Bo1w5mYe4OYHEo6lP9WcIXpJZ4P/jxur
         ZdPMafmEBvImTSbMo0B9f0mg4EfJWorQVD/obhz7GnxMsIIhDQ607pRLiSWkeAkRmQTO
         vH8urSaArAcP4XYl9IA7EziDL06h4iqF+5vwHeA0lS/0STCTjOjGxotbiWBjRjKc+xaK
         Dfzw==
X-Received: by 10.68.229.68 with SMTP id so4mr46950281pbc.110.1398200405354;
        Tue, 22 Apr 2014 14:00:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm86896310pbd.48.2014.04.22.14.00.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 14:00:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246784>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Hm, perhaps we should introduce a 'no-prefix' option to work around
>> this.
[...]
>> That way, normal usage of --prefix would still be consistent with
>> other git commands that prefer the form with argument attached
>> (--prefix=foo, not --prefix foo; see gitcli(7)).
>>
>> Thoughts?
>
> I do not think that it is a good idea to use "--no-anything" for
> something that is not a boolean.

Do you mean it is a bad idea to support or a bad idea to make use of
such support?

I suggested --no- for consistency with current git commands that use
parseopt.  But on second thought, I agree that it be confusing for

	--prefix=foo --no-prefix

to mean something different from no --prefix parameter at all.

The documentation says

	--prefix=<prefix>

		...

		Before Git 2.0, the default prefix was "" (no prefix).
		This meant that ...

which suggests that I can use --prefix="" to mean no prefix.  Perhaps
it needs a note to suggest using '--prefix ""' instead?

Thanks,
Jonathan
