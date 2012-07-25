From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/7] i18n: rebase: mark strings for translation
Date: Tue, 24 Jul 2012 23:21:34 -0500
Message-ID: <20120725042134.GA3055@burratino>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 06:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stt7D-0007cG-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 06:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2GYEVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 00:21:44 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48334 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab2GYEVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 00:21:44 -0400
Received: by gglu4 with SMTP id u4so286855ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jeZL2pw5u2L4MJbxVM3w00ZMUXUZUWmSXVc8sFNQMPY=;
        b=SWpmkcUM/EKt2TshX4a5Sl3W/neZkRBT6vNVliomC95JBQ0vgEPrd33EgESV8zXIuM
         WV9jn4QVoTald72gZiOom8UjAmxh97da5df3GQfB+brW7gwD2PNU6a2tM7KtOj5tSNSJ
         YdPKkiuyhc3e1gyYpc+z7yu+af78ddNxhXOW6SZWTJ4MAtFBtz5x6OtA56wAg2EyoifK
         aMXHaWPPRgeaXbeECn2GQf5Xvqhbw47j10FmeVUgfHS+QBHuz3twTDm9tnOsg+Gqvg0V
         uV4Yz6Ehffuto+rDO3d/4Otx40hKIvqv/uhHTDtovlo12yFpF4I/62ntLWlLFhrzN+73
         AOlA==
Received: by 10.43.110.197 with SMTP id el5mr21071282icc.1.1343190103133;
        Tue, 24 Jul 2012 21:21:43 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dc7sm302410igc.13.2012.07.24.21.21.41
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 21:21:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202117>

(cc-ing Duy because of a mention of his nice GETTEXT_POISON tweak[*])
Hi,

Jiang Xin wrote:

> Mark strings in git-rebase.sh for translation. Jonathan offers a help
> for reorgnization of the resolvemsg variable in 'git-rebase.sh', since
> there is a likely message in git-am.sh, I update it in this commit for
> consistency. And so does to 't/t0201-gettext-fallbacks.sh'.

Ah.  Looks like I tweaked the comma usage and sentence structure a
little.  Sorry, force of habit --- I shouldn't have.

> Some test scripts are affected by this update, and would fail if tested
> with GETTEXT_POISON switch turned on. Using i18n-specific test
> functions, such as test_i18ngrep, in the related test scripts will fix
> these issues.

If we're going to keep the changes together, here's how I would phrase
the commit message:

	Mark messages in git-rebase.sh for translation.  While doing this
	it was noticed that the comma usage and sentence structure of the
	resolvemsg was not quite right, so correct that and its cousins in
	git-am.sh and t/t0201-gettext-fallbacks.sh at the same time.

	Some tests would start to fail with GETTEXT_POISON turned on after
	this update.  Use test_i18ncmp and test_i18ngrep where
	appropriate to mark strings that should only be checked in the C
	locale output to avoid such issues.

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I haven't tested or reviewed this patch in detail, so even though it
looks good, I'd prefer it not to have my Reviewed-by.  (See
Documentation/SubmittingPatches: '"Reviewed-by:", unlike the other
extra tags, can only be offered by the reviewer'.)  If you'd like to
credit my help, something like "With advice from Jonathan." would be
fine.

[...]
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -64,7 +64,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
>  
>  test_expect_success 'rebase --onto outputs the invalid ref' '
>  	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
> -	grep "invalid-ref" err
> +	test_i18ngrep "invalid-ref" err
>  '

Could we add a comment so others do not have to wonder what
human-readable message prompts the test_i18ngrep here?  e.g

	# "Does not point to a valid commit: invalid-ref"
	#
	# NEEDSWORK: This "grep" is fine in real non-C locales, but
	# GETTEXT_POISON poisons the refname along with the enclosing
	# error message.
	test_i18ngrep invalid-ref err

In the long run we may be able to turn this back to a "grep" again,
since any reasonable translation will keep the $onto_name somewhere
in the message.  But changing it to test_i18ngrep for now is the
right thing to do, until something like Duy's more sophisticated
version of GETTEXT_POISON arrives. (<-- [*])

Thanks,
Jonathan
