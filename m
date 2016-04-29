From: Stefan Beller <sbeller@google.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Fri, 29 Apr 2016 10:06:31 -0700
Message-ID: <CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
	<CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jan Keromnes <janx@linux.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awBsE-0001tx-6b
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcD2RGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:06:33 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35850 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcD2RGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:06:32 -0400
Received: by mail-io0-f177.google.com with SMTP id u185so131689504iod.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RAhI4R13pwNei3u2Ndz/haI1/wlnx39yhfywCAaigEk=;
        b=AAVPYHCHytk/JyDTBlTXMFLZ+COwJjfVk0IKHmeTCB+lDq34zvfBnAwDlHN+yf6dBC
         hfMPUo5TLuSbj/eaPAsj9CGj2S8+iUdaDbhcZf2n4GzIQ5JPt+HXZ10uHylb3meyS916
         0Jx9rsIrxmw6g29LJLoD2YfvG87oBILbFOrKxcj4LFZKTpufPRSZxDAo4LAu9aycOn3t
         51q6JrD84PPTifCjnFMXE+iE6tPKm+1UJGumLhv/B1eRBOmrobJWEvrJmu1DZ/FCX3NG
         tSeacr9lPfBwq9EU3i8SvF+/EJB+lLeA7pA06Tf+0bbl10O941cDMdPpAXY90/EiZKO9
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RAhI4R13pwNei3u2Ndz/haI1/wlnx39yhfywCAaigEk=;
        b=kdmcPSEcRLBWFEis8hqftPzNJHGuYzVlpkBxJU/hVB5oo451pxYy+6lKrbiHWGk2Ru
         4GiDgu0fgD5iXyDdQxN5ZWoV6HoqtDzm5bxHPZnrF83JzDtEy2TYGgeu0TTv0pbbmIcg
         kglAh/DKTLTW9USiJgO+OmkrMVCpxj7k1rOq8tU4BEcXk9ARoHzJguRy/4cFo5p+Vjvb
         smqCBnCgbe2Sxh1DNBI5LiE5RgYjUIzGYJWEVYLy37Jr+Cr0JU6Usru5hNTDWoYS9H9S
         TwDt2pwOVAkg2qtXkTnA+Hv0gjEBoN3U1vYzpXFQ/a0m/mCuGOju1pgtjHlv1joHwXQl
         qFJg==
X-Gm-Message-State: AOPr4FUBJFarD4k8m2HCqHIKyp6Lb9rbVpdJdQTyNnjeYscd7UgUonSvsaxHpRMuXJyJJNnNt0J0qETc2BRuSQ/F
X-Received: by 10.107.53.200 with SMTP id k69mr25362716ioo.174.1461949591308;
 Fri, 29 Apr 2016 10:06:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 10:06:31 -0700 (PDT)
In-Reply-To: <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293025>

On Fri, Apr 29, 2016 at 5:53 AM, Jan Keromnes <janx@linux.com> wrote:
> Hello,
>
> I tried running a full profile build of Git 2.8.1, but it looks like
> test #32 in `t7300-clean.sh` fails:
>
> Commands:
>
>> curl https://www.kernel.org/pub/software/scm/git/git-2.8.1.tar.xz | tar xJ
>> cd git-2.8.1
>> make prefix=/usr profile-install install-man -j18
>
> Logs of test-suite that fails:
>
> *** t7300-clean.sh ***
> ok 1 - setup
> ok 2 - git clean with skip-worktree .gitignore
> ok 3 - git clean
> ok 4 - git clean src/
> ok 5 - git clean src/ src/
> ok 6 - git clean with prefix
> ok 7 - git clean with relative prefix
> ok 8 - git clean with absolute path
> ok 9 - git clean with out of work tree relative path
> ok 10 - git clean with out of work tree absolute path
> ok 11 - git clean -d with prefix and path
> ok 12 - git clean symbolic link
> ok 13 - git clean with wildcard
> ok 14 - git clean -n
> ok 15 - git clean -d
> ok 16 - git clean -d src/ examples/
> ok 17 - git clean -x
> ok 18 - git clean -d -x
> ok 19 - git clean -d -x with ignored tracked directory
> ok 20 - git clean -X
> ok 21 - git clean -d -X
> ok 22 - git clean -d -X with ignored tracked directory
> ok 23 - clean.requireForce defaults to true
> ok 24 - clean.requireForce
> ok 25 - clean.requireForce and -n
> ok 26 - clean.requireForce and -f
> ok 27 - core.excludesfile
> ok 28 # skip removal failure (missing SANITY)
> ok 29 - nested git work tree
> ok 30 - should clean things that almost look like git but are not
> ok 31 - should not clean submodules
> not ok 32 - should avoid cleaning possible submodules
> #
> #               rm -fr to_clean possible_sub1 &&
> #               mkdir to_clean possible_sub1 &&
> #               test_when_finished "rm -rf possible_sub*" &&
> #               echo "gitdir: foo" >possible_sub1/.git &&
> #               >possible_sub1/hello.world &&
> #               chmod 0 possible_sub1/.git &&
> #               >to_clean/should_clean.this &&
> #               git clean -f -d &&
> #               test_path_is_file possible_sub1/.git &&
> #               test_path_is_file possible_sub1/hello.world &&
> #               test_path_is_missing to_clean
> #
>
> Best,
> Jan

Thanks for reporting the bug!

Have a look at t/README to run the tests with command line arguments.
(I usually run tests as ./tXXXfoo.sh -d -i -v -x with these arguments,
though I cannot remember what each of that does. One of it makes the
test suite stop on a failing test, such that you can cd into the testing
directory and check the state of the file. (Which are present, which are gone?)

With these arguments it is also very verbose, and it would tell
you what is wrong (is the assertion wrong in the `test_path_is_file/missing`
or is it `git clean` segfaulting?)

As Johannes said, it makes sense that you debug into that as
no one could reproduce it thus far on their system.

Thanks,
Stefan
