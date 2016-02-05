From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v6 2/3] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Fri, 5 Feb 2016 23:14:35 +0200
Message-ID: <20160205211435.GB7245@gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
 <1454658148-3031-3-git-send-email-alonid@gmail.com>
 <xmqqio23c5t5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRniJ-0003KT-AQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbcBEVOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:14:41 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35218 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbcBEVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:14:38 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so43721088wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OI2QWxM9glptAETZgnVrx3mRJ/FNMhN3YPIiI3Bj0Og=;
        b=uzGlFpHTWsbMk2jINjMPgCsfisEmNC2KiRlVAFwl5BB3e3jyx0Z8+XPyLqqFOKfDe2
         P6HPjb7JJuX6Xb0R339JlgtAFQs69gptXrXjoTALk/dy+lUXZuok5hJR4OwBtJFjZn5U
         CBrqj5Hwnrw5EuKtxkosytxlNxt0h/KCq/01p/K+cyR0rhOCtI/HaWdp7ALxWEJc6peD
         f2mqelm0NChxr/fPDOND4W5WIiOFevN8l9vdHT/FU2LGNPUZ/gd2k8SmsbxuLdDNPLg7
         oWkIYBfSVQhvhAsKFPevU36z87ywIAe0B3KaS7GmuJCcR3zDcJB6VzFqb3Q/ORNPckiC
         u0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OI2QWxM9glptAETZgnVrx3mRJ/FNMhN3YPIiI3Bj0Og=;
        b=S4fSUQ7s99lBwsWDAdshF57ffmNLmImV3zN3gN8dRtDDM7EYHmuRqta3QjkKd/9ubA
         iWa+wuoPwmkzyw9LN46Yi1kGpeld7qgUF/UyVl2c+01Wq0k+FpnDY8AcXluH0d55brjP
         /1+9UF+BBTe4ktnmkQ/x6TNFKycRiQaMCHTw1MxhLZhEUYVeg+UaDvl3wGHPo2frfIcR
         lLnnNv2Mh4pCmqd7gEvhRIBCO8a92c1Gmkn6i8HqJcBWIJrxTCQLPdLNN1ifiwZQEXIC
         Mn7YjMELTMFbYIQnSkSk2BHjjtCsbk7Npmrxc6gSl2nyJ8kwg35b+fmqK+UvawVQnno5
         oo3g==
X-Gm-Message-State: AG10YORgEWUm6xtYYRALraIzHPzz6UksRNuCiknqmhpFAeUYR53yux9xngS9BtbMXzV0RQ==
X-Received: by 10.194.59.200 with SMTP id b8mr465408wjr.99.1454706877415;
        Fri, 05 Feb 2016 13:14:37 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id ko2sm17494058wjc.9.2016.02.05.13.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 13:14:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqio23c5t5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285634>

On Fri, Feb 05, 2016 at 11:31:34AM -0800, Junio C Hamano wrote:
> > +	If you have multiple email addresses that you would like to set
> > +	up per repository, you may want to set this to 'true' in the global
> > +	config, and then Git would prompt you to set user.email separately,
> > +	in each of the cloned repositories.
> 
> The first sentence mentioned both name and email, but here the
> example is only about email.  A first time reader might be led into
> thinking this is only about email and not name, but I am assuming
> that is not the intention (i.e. this is merely showing just one use
> case).
>[..]

Going to revise per yours and Jeff's suggestions.

>[..]
> I can read the split expression either with && hanging at the end of
> line or && leading the next line just fine, but you'd want to be
> consistent especially when you are writing two almost identical
> things.

Sure.

>[..]
> 	test_expect_success 'suceed with config' '
>         	test_when_finished reprepare &&
> 		test_config user.email test@ok.com &&
>                 test_must_fail git commit -m msg
> 	'
> 
> Note that you do not need "test_unconfig user.email" in reprepare,
> as the variable is set in one test with test_config, which uses
> test_when_finished to arrange the variable to be removed after
> running the test.

Alright. It was worth to understand the differing behavior between
'test_config' and 'git config'.

-- 
Dan Aloni
