From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Fri, 5 Feb 2016 16:59:52 -0500
Message-ID: <20160205215952.GA4901@flurp.local>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
 <1454707746-18672-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:00:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRoQB-0004gW-On
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbcBEWAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:00:03 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35130 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcBEWAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:00:00 -0500
Received: by mail-io0-f196.google.com with SMTP id z135so4043611iof.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zW+B0RikGH9rOgCH9sArJ1iFQxxe3hbFTOD3zxNMkzE=;
        b=Sqpn6QqrSNU5UgpGm8uPW2PIGdeg9qVp0XawZWUjtYlkqR3LSqGE/bexdpG4TUw0Vb
         oTKo4gMZMtk/6XNP6qajTXlukfO9IKaC87/bbhzADBo30q02c3/vx3CEWR7DhvMmMjD9
         ZCZEsO41bLzVHTkbWlSW6aLdoxRrCsjUnmUjxgQgwTXjGrHXSK8p2u61fZHiloaCRDKz
         mxAYSizaebpxEGw4PJrMznwqBaOTGPRAENMRIEoWVYYRv39N/HtAcIv1A4VmF6s73jKq
         NS5sr1we2m+dXeMa3M6W2P4DL+B553/LcWJ1K0RuAjCjJOFD4a5az+xWQSyYtK69F7z7
         2HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zW+B0RikGH9rOgCH9sArJ1iFQxxe3hbFTOD3zxNMkzE=;
        b=i4kSHFtPy0dVsEPn1B7FF1lHgJVt3500m+vuoM/H7+qeGg4nXHurUo3NmpRXSC3MxM
         pzhZvaky2Y60P76ew8EARh5QDZP4acaCtH1dvPNfuYQrw/s2e5CTAD0YtMXnMVsG5QvJ
         ohQBS2utah7AGg8jVIkypDZFPvv/R6dEJSeR5MqPhR7A877NU7m2a3d7WfLvb0+C9W2r
         Yapo7I3CAPOU+20+kgQ/ySupcpXni37U7YsE9AMYxE2Kv0C+8vc/o7fFkqBTYcuSLXD+
         iTYb6Fw4Hd+J2XrDSPpAJ0VAEQVLdwGAvGMfUfPMlDOnvYyg0HiGK035a0RJr8DjpVDs
         pUTA==
X-Gm-Message-State: AG10YOSD0kf3GL+Q2Ug8i5lPTdpJ9kJukcqdJg86jQTwA5ra3zSLw/DD9Uz4nKNPF/qIqg==
X-Received: by 10.107.10.105 with SMTP id u102mr16034582ioi.85.1454709600279;
        Fri, 05 Feb 2016 14:00:00 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id oo7sm264409igb.5.2016.02.05.13.59.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 13:59:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454707746-18672-3-git-send-email-alonid@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285641>

On Fri, Feb 05, 2016 at 11:29:06PM +0200, Dan Aloni wrote:
> It used to be that:
> 
>    git config --global user.email "(none)"
> 
> was a viable way for people to force themselves to set user.email in
> each repository.  This was helpful for people with more than one
> email address, targeting different email addresses for different
> clones, as it barred git from creating commit unless the user.email

Either: s/commit/a commit/ or s/commit/commits/

> config was set in the per-repo config to the correct email address.
> 
> A recent change, 19ce497c (ident: keep a flag for bogus
> default_email, 2015-12-10), however declared that an explicitly

s/however/&,/

> configured user.email is not bogus, no matter what its value is, so
> this hack no longer works.
> 
> Provide the same functionality by adding a new configuration
> variable user.useConfigOnly; when this variable is set, the
> user must explicitly set user.email configuration.
> 
> Signed-off-by: Dan Aloni <alonid@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Cc: Eric Sunshine <sunshine@sunshineco.com>

You'd generally place your sign-off last.

> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -2821,6 +2821,16 @@ user.name::
> +user.useConfigOnly::
> +	This instructs Git to avoid trying to guess defaults for 'user.email'

Perhaps: s/This instructs/Instruct/

> +	and 'user.name' other than strictly from config. For example, if

The way this is phrased, it sounds almost as if Git also "guesses"
the value from config. Perhaps rephrase like this:

    Instruct Git to avoid trying to guess defaults for 'user.email'
    and 'user.name', and instead retrieve the values only from
    configuration.

> +	you have multiple email addresses and would like to use a different
> +	one for each repository, then with this configuration option set
> +	to `true` in the global config along with a name, Git would prompt

s/would/will/

> +	for you for setting up an email upon making new commits in a newly

s/for you for setting/you to set/

More below...

> +	cloned repository.
> +	Defaults to `false`.
> diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Dan Aloni
> +#
> +
> +test_description='per-repo forced setting of email address'
> +
> +. ./test-lib.sh
> +
> +reprepare () {
> +	git reset --hard initial
> +}
> +
> +test_expect_success setup '
> +	# Initial repo state
> +	echo "Initial" >foo &&
> +	git add foo &&
> +	git commit -m foo &&
> +	git tag initial &&
> +
> +	# Setup a likely user.useConfigOnly use case
> +	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
> +	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
> +	git config user.name "test" &&
> +	git config --global user.useConfigOnly true &&
> +
> +	reprepare
> +'
> +
> +test_expect_success 'fails committing if clone email is not set' '
> +	test_when_finished reprepare &&
> +
> +	test_must_fail git commit --allow-empty -m msg
> +'
> +
> +test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
> +	test_when_finished reprepare &&
> +
> +	test_must_fail env EMAIL=test@fail.com git commit --allow-empty -m msg
> +'
> +
> +test_expect_success 'succeeds committing if clone email is set' '
> +	test_when_finished reprepare &&
> +
> +	test_config user.email "test@ok.com" &&
> +	git commit --allow-empty -m msg
> +'
> +
> +test_expect_success 'succeeds cloning if global email is not set' '
> +	test_when_finished reprepare &&
> +
> +	git clone . clone
> +'
> +
> +test_done

This test script still has a fair amount of unnecessary cruft in it
which obscures the important bits showing what you are really
testing. Below is a more concise version with the unnecessary stuff
removed:

--- 8< ---
#!/bin/sh
#
# Copyright (c) 2016 Dan Aloni
#

test_description='per-repo forced setting of email address'

. ./test-lib.sh

test_expect_success setup '
	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
	git config user.name "test" &&
	git config --global user.useConfigOnly true
'

test_expect_success 'fails committing if clone email is not set' '
	test_must_fail git commit --allow-empty -m msg
'

test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
	test_must_fail env EMAIL=test@fail.com git commit --allow-empty -m msg
'

test_expect_success 'succeeds committing if clone email is set' '
	git -c user.email=test@ok.com commit --allow-empty -m msg
'

test_expect_success 'succeeds cloning if global email is not set' '
	git clone . clone
'

test_done
--- 8< ---
