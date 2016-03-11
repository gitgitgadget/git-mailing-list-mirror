From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 00:44:12 -0500
Message-ID: <20160311054412.GA10841@flurp.local>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
 <CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
 <CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Roberto Tyley <robertotyley@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 06:44:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeFs8-0007V6-7t
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 06:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbcCKFoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 00:44:19 -0500
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35779 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbcCKFoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 00:44:17 -0500
Received: by mail-ig0-f193.google.com with SMTP id ww10so286784igb.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 21:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ft4Or2VeyD9sNlbyENWs1Nr36iGJXMOdZwlEtMaVVVM=;
        b=qvgn72Rc6OwUQLGLFV4Anjw+yk+KUkAhIPnNhNhxNXeLIeWOL3pRTpD/7FScIy+Vcu
         0dpawBNtdijzu8GM66o5G3kdjRzJFEcaTPMQbxahza2m/3VmjPgyZ0H9V0Y2S/As4lkI
         EsItKQcEQcRVtkLKf5W/YjE24nBYJr5Kgewo0JJbf89OxjZUI+Q7D3p0CIhRwu67wqdM
         yuMKTIoQO9I6vl2R8DsCg0Woy9/uPk+5H7UMfD8dvYYDsE5HuyqcH4+UQJwMlO2TLPdv
         tkqTfd0v9U5VKueZXWK2YFgV+B8RxgnKmGWsQvJ4RCYSlLQaczSbUB6XYo2ZYi4OjsS+
         xwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ft4Or2VeyD9sNlbyENWs1Nr36iGJXMOdZwlEtMaVVVM=;
        b=G+YyFNDLuzimaFMCvKkdx2RpWBd85YUDJW33CC4sBTaqRLK5SseV3xQ+zKFr3obYID
         yLoos3HocqmrJqw2rJhPeAMVM4sKjva8buatouPC4Jbc+NsnG6A7h7PQ8hjxipAUoF8H
         gkcVc7PPzoRCprV6AmXA7S53Ko2QPGNIxQ8JxqYovgyq8o8Tw5nviKgxkQXnbYkiOpJG
         CpdHLhVDWa2Oo6ADU83NmSp8pyTyfXD3Fd1VCIIBR0qsYCQ1hAXAQuS+IwOLqmKUfmYa
         yIiM4meWbYbjmfpdfPMCsDUEneySu9shXLlbvB2LSvnMHnJlM4MDxbUKE2K6FOdIaRAw
         qXag==
X-Gm-Message-State: AD7BkJKmsVip2ZUiZ+mIv1C/TfWjxhUEEHug2IdEOVUht1WC65sOqR3KqVkcRFm+vZd0dA==
X-Received: by 10.50.118.67 with SMTP id kk3mr723190igb.64.1457675056716;
        Thu, 10 Mar 2016 21:44:16 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id i187sm2954976ioi.33.2016.03.10.21.44.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 21:44:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288674>

[+cc:Roberto Tyley]

On Fri, Mar 11, 2016 at 05:45:27AM +0530, Pranit Bauva wrote:
> On Fri, Mar 11, 2016 at 4:31 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > As a convenience to reviewers, please use this area below the "---"
> > line to provide links and explain what changed since the previous
> > round rather than doing so in a separate email.
> 
> Actually I am sending the patches with submitGit herokuapp because my
> institute proxy does not allow IMAP/POP3 connections.

That's unfortunate. Your separate "cover letter" often arrives hours
later than the patch itself. Perhaps Roberto can comment on submitGit
and per-patch commentary.

> >> +       echo content >file &&
> >> +       git add file &&
> >> +       test_config commit.verbose true &&
> >> +       (
> >> +               GIT_EDITOR=cat &&
> >> +               export GIT_EDITOR &&
> >> +               test_must_fail git commit >output
> >> +       ) &&
> >> +       test_i18ngrep "diff --git" output
> >> +'
> >
> > Making git-commit fail unconditionally with "aborting due to empty
> > commit message" is a rather sneaky way to perform this test. I would
> > have expected to see these new tests re-use the existing machinery
> > provided by this script (the check-for-diff "editor") rather than
> > inventing an entirely new and unintuitive mechanism. Doing so would
> > also reduce the size of each new test.
> 
> I agree on the fact that making git-commit fail unconditionally is not
> a good way to perform the test. "check-for-diff" is not really an
> "editor" and it checks for the commit message after it has been
> written to the history. The verbose output is stripped when it is
> written to the history so we won't be able to test whether this patch
> works.

It's a bit tricky if you're not used to it, but check-for-diff
actually does what you want, and does so in a more direct way. While
it's true that it's not an "editor" per se, it does get access to the
entire block of text that would normally appear in your editor during
an interactive commit. And, this is happening before the commit has
been written to history. So, check-for-diff gets a chance to look at
the full text that would appear in your editor, and can therefore
check if it contains the expected "diff --git" string.

> This is where purposely breaking the code is required as when
> the commit fails, it gives the output of the contents present at that
> time (which will contain the verbose output). More over the
> 'check-for-diff' uses grep which is not preferred. Many tests are now
> using test_i18ngrep (eg. f79ce8db).

'test_i18ngrep' is intended for strings which may be translated,
however, since the expected "diff --git" string should never be
translated, check-for-diff's use of 'grep' is correct, whereas
'test_i18ngrep' would be misleading (if not actively wrong).

> I had planned on using
> 'check-for-diff' before but it took me some time to figure out this
> behavior and thus I began searching for another mechanism (breaking
> code).

As an experiment, I rewrote the four new tests in terms of
check-for-diff (with "test_set_editor check-for-diff" already in
effect). Here's what they look like, and they function as expected:

    test_expect_success 'commit.verbose true and --verbose omitted' '
        git -c commit.verbose=true commit --amend
    '

    test_expect_success 'commit.verbose true and --no-verbose' '
        test_must_fail git -c commit.verbose=true commit --amend --no-verbose
    '

    test_expect_success 'commit.verbose false and --verbose' '
        git -c commit.verbose=false commit --amend --verbose
    '

    test_expect_success 'commit.verbose false and --verbose omitted' '
        test_must_fail git -c commit.verbose=false commit --amend
    '

These are modeled after the "initial commit shows verbose diff" test
earlier in the script.
