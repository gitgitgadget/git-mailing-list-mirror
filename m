From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 21:59:42 +0200
Message-ID: <CAGHpTBLs2tgUunDtFMhw7QMiuB2oXBtQJLKpLckhEyDp7Zr+Qg@mail.gmail.com>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
	<7vr4pt16ep.fsf@alter.siamese.dyndns.org>
	<505F5151.2080208@web.de>
	<7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
	<7v39271j3n.fsf@alter.siamese.dyndns.org>
	<5060A32D.1060902@web.de>
	<7vlifzz2vo.fsf@alter.siamese.dyndns.org>
	<CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com>
	<7vy5jzxmts.fsf@alter.siamese.dyndns.org>
	<CAGHpTB+0GLJJ-e1JFTXQ0Qot9An90MXxDFbP+63+pG2uA3UhmA@mail.gmail.com>
	<5060BADB.2000505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEor-00059x-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab2IXT7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:59:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41728 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab2IXT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:59:43 -0400
Received: by weyt9 with SMTP id t9so445460wey.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kf4xt7O1jqiUf9rhe9MVnA7j31S3ApFXp9uZhdkDNRo=;
        b=ktuSKRa7bKzeOQeNc1Yqx1GnWFGvMkKqQNJi9Z6k9dAXl8b/eslcEzRsiIR+TGKvlz
         9ftGKUBrHxXKw+C03yZkQGJmzjPc+atVDf8oKGzV2/CSTj3ssSUyuIRMkl0UPbePwlbL
         CsJqLHZvELxhbXooXH1BkWbXoxd1teHVOmfemxafnPjepvSZ26nGU84bvEhluKzsEIb2
         hXyhMMgPrC4njLHw9QqapaYhBHz4DJHZiC9vk8j0SUjeuxaoqd2wwi8PWJBq8t0Cy1H9
         pYXT6Gn+MT785ZBKhBrkG/O0XQpUrNdHb3qa+fYX0WGPzUL50c9Febt1OY2d6hlEPQsl
         PxAw==
Received: by 10.180.86.106 with SMTP id o10mr16460048wiz.22.1348516782212;
 Mon, 24 Sep 2012 12:59:42 -0700 (PDT)
Received: by 10.194.54.166 with HTTP; Mon, 24 Sep 2012 12:59:42 -0700 (PDT)
In-Reply-To: <5060BADB.2000505@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206323>

On Mon, Sep 24, 2012 at 9:56 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 24.09.2012 21:16, schrieb Orgad Shaneh:
>> On Mon, Sep 24, 2012 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Orgad Shaneh <orgads@gmail.com> writes:
>>>
>>>> That is not correct. git-config is ignored as well for commit.
>>>
>>> What do you mean?  As far as I can tell, if you have
>>>
>>>     [submodule "var"]
>>>         path = var
>>>         ignore = dirty
>>>
>>> in $GIT_DIR/config, a work-tree-dirty submodule "var" is not
>>> reported by "git status" and "git commit" without your patch, and
>>> your patch does not seem to break that.  The only difference your
>>> patch makes is that if you had the above three-line block in
>>> the .gitmodules file and not in $GIT_DIR/config, "git status"
>>> ignored the dirtyness in the working tree, but "git commit" did
>>> notice and report it.
>>>
>>> What am I missing?
>>>
>>>
>>
>> I have:
>> [submodule "mod"]
>>         url = [...]
>>         ignore = dirty
>>
>> in .git/config, and I removed the ignore part from .gitmodules to be even.
>>
>> I made a change inside mod, git status doesn't report its dirtiness,
>> while git commit does.
>>
>> git status:
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #       modified:   foo
>> #
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> #       modified:   .gitmodules
>> #
>>
>> git commit:
>> # Please enter the commit message for your changes. Lines starting
>> # with '#' will be ignored, and an empty message aborts the commit.
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #       modified:   foo
>> #
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #   (commit or discard the untracked or modified content in submodules)
>> #
>> #       modified:   .gitmodules
>> #       modified:   mod (modified content)
>> #
>>
>> Now I get it! That's because I don't have submodule.mod.path!
>> config_name_for_path only gets initialized if path exists. Apparently
>> git submodule init doesn't configure 'path', so it stays
>> uninitialized.
>
> But submodule.mod.path should only be set in .gitmodules, not in
> $GIT_DIR/config. Did you just remove the ignore setting from
> .gitmodules or the path too?

Just the ignore, and my patch of course.

If it is not set in $GIT_DIR/config, then config_name_for_path is not
initialized, and if it is not initialized, then
set_diffopt_flags_from_submodule_config does nothing
(handle_ignore_submodules_arg is not called). That is the main
problem.

- Orgad
