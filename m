From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 18 May 2015 10:06:32 -0500
Message-ID: <CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 17:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMcp-0003mI-BI
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbbERPGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:06:35 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35965 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbERPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:06:33 -0400
Received: by iepj10 with SMTP id j10so24646175iep.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3qhAmj97EC8zBYBQMbau3cjcNMHaeOVwJTJ5s4iz00s=;
        b=IzYJHwDlHXg+8IH29MmFVe1XbMTvu+51fQ3BLWctute4AsMb5KoO3YypyJH7u4grhh
         wOK0vMVrMkIajP+Mk+RAyBqXGpR/Qiz2Cslfx/osDCHsleyBE0jUQuqaQ0TVKqIzZQs1
         CGVePA1NCHdPpxb2Cv36X/TRfI/fIuqHFVSujWI4gS0YMr3QPSegzXlgpHVJRo6BE/MC
         IHBQlAzK/k7fkw8ye/BPLJ1JxfQYnrCCC40cCpbSSD6Pwf9YEm/0Vyln2qENNlYHtGxT
         EucjBycxfg2UbCTjFM2Vog8On197xOhEiCch11q/Hed7o9yc2UcX60RFgeOD5B74xc0L
         mXJw==
X-Received: by 10.50.64.147 with SMTP id o19mr14822768igs.33.1431961593066;
 Mon, 18 May 2015 08:06:33 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Mon, 18 May 2015 08:06:32 -0700 (PDT)
In-Reply-To: <20150518123036.GB16841@book.hvoigt.net>
X-Google-Sender-Auth: YF4xhRlIPm2Uv-TSxMJ_1MijNrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269257>

On Mon, May 18, 2015 at 7:30 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Fri, May 15, 2015 at 03:33:07PM -0500, Robert Dailey wrote:
>> On Tue, May 5, 2015 at 12:49 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > Hi Robert,
>> >
>> > On 2015-05-04 22:21, Robert Dailey wrote:
>> >
>> >> Since I am not a linux user, I have implemented this feature against
>> >> the Git for Windows fork of git. I am not able to verify changes if I
>> >> make them directly against the Git repository.
>> >
>> > That is why I worked so hard on support of Vagrant: https://github.com/msysgit/msysgit/wiki/Vagrant -- in short, it makes it dead easy for you to set up a *minimal* Linux VM inside your Git SDK and interact with it via ssh.
>> >
>> > With the Vagrant solution, you can easily test Linux Git even on Windows.
>> >
>> > Ciao,
>> > Johannes
>>
>> At the moment I have a "half-ass" patch attached. This implements the
>> feature itself. I'm able to test this and it seems to be working.
>> Please note I'm a C++ developer and straight C / Bash are not my
>> strong suits. I apologize in advance for any mistakes. I am open to
>> taking recommendations for corrections.
>
> Please inline the patch, so people can easily comment. Have a look at
> Documentation/SubmittingPatches and patches on this list for an example.
> I have inlined your patch below for comments.
>
>> I'm not sure how I can verify the feature in a unit test. In addition
>> to learning bash scripting well enough to write the test, I am not
>> sure how to use git to check for the additional commits. Plus the repo
>> for the test will need to handle a submodule change to a merge commit
>> as well. Any advice on setting up a good test case for this? What
>> conditions should I check for, as far as log output goes?
>
> The testsuite can be found in t/ the README there describes most of it.
> Have a look at t4041-diff-submodule-option.sh and imitate the tests for
> the existing log option. What they basically do is: Write a file with
> the expected output of the diff and then compare the actual output with
> it. That should also be possible for your option.
>
> As for the merge commit: If there is no merge commit in the submodule
> that is used for testing you can simply add a sequence of git commands
> that manufactures the situation in the test repository as you need it.
>
> 'test_pause' is a helpful command to interactively debug/develop tests.
> Run the test with the -v -i switches (maybe -d) when developing.
>
> Comments for your patch please see below.
>
> <snip>

Unfortunately I find it unintuitive and counter productive to perform
inline patches or do anything on a mailing list. Especially on
Windows, it's a pain to setup git to effectively do this. Also I read
mailing lists through Gmail which does not offer a proper monospace
font view or syntax coloring to effectively review patches and
comments pertaining to them.

Since I am not willing to properly follow your process, I will
withdraw my patch. However it is here if someone else wishes to take
it over. Really wish you guys used github's amazing features but I
understand that Linus has already made his decision in that matter.

I'm sorry I couldn't be more agreeable on the matter. Thanks for the
time you spent reviewing my patch.
