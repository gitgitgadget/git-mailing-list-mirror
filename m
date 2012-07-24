From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 16:25:06 -0500
Message-ID: <20120724212506.GA15798@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com>
 <20120724182700.GI2939@burratino>
 <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stmbb-0007Q0-7M
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 23:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab2GXVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 17:25:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40476 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab2GXVZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 17:25:14 -0400
Received: by yenl2 with SMTP id l2so35680yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eXRF+9Smq6/QqbBODCdc0kQJzokL4rSRGI4Cd54jMOY=;
        b=aVP1WjqkH3OhBowImuUgN+1ocSDn1pHJ+L0ckl3SANg39lPmjYmUgj0X8cb4/ItdQs
         vQ1XjBTkMMRkTpCYtI05ykW5ikuxDuSQNbH0+2CZG4FQ2o8yNsyWQTfdvJ5On5T8MUO2
         qgufjVmcXdx6nQzLPH7mDKJ2K4im86JRCAeYcpt095Sjgf/HdkkQj+BRQnqHRyud3M1G
         JTXXkGE18tHlJ+1uLrZ3x5FafAQRmryALMdI26DmKcZXjq6RopYgHlQr9NbEnkqLsRiN
         xSxNR6upK+bfBh2v/Gm2mOdxt03p3zWOpUIYMXJBiY5945WZ7jtWhlziRYXDK4vZ+jHT
         t+0w==
Received: by 10.42.155.200 with SMTP id v8mr18289122icw.12.1343165113897;
        Tue, 24 Jul 2012 14:25:13 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id s4sm2962111igb.1.2012.07.24.14.25.12
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 14:25:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202073>

Martin von Zweigbergk wrote:
> On Tue, Jul 24, 2012 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jiang Xin wrote:

>>> Gettext message should not start with '-' nor '--'. Since the '-d' and
>>> '--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
>>> remove the block.
>>
>> The above justification is not a sufficient reason to stop giving
>> helpful advice when someone uses an option that was historically
>> supported:
>
> I think Jiang is saying that "git am --dotest=..." already errors out
> because "dotest" is not in the OPTIONS_SPEC. See 98ef23b (git-am:
> minor cleanups, 2009-01-28).

Oh, I see now.

I guess that means the intended justification is the following?

	The git am -d/--dotest option has errored out with a message
	since e72c7406 (am: remove support for -d .dotest, 2008-03-04).
	The error message about lack of support was eliminated along
	with other cleanups (probably by mistake) a year later by
	removing the option from the option table in 98ef23b3 (git-am:
	minor cleanups, 2009-01-28).

	But the code to handle -d and --dotest stayed around even though
	ever since then it could not be tripped.  Remove this dead code.

	Noticed because the error message starts with a '-' and
	xgettext does not cope well with that.
