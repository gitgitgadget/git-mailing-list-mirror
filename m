From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 22:10:55 +0200
Message-ID: <5060BE4F.2040506@web.de>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com> <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de> <7vmx0g0xpm.fsf@alter.siamese.dyndns.org> <7v39271j3n.fsf@alter.siamese.dyndns.org> <5060A32D.1060902@web.de> <7vlifzz2vo.fsf@alter.siamese.dyndns.org> <CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com> <7vy5jzxmts.fsf@alter.siamese.dyndns.org> <CAGHpTB+0GLJJ-e1JFTXQ0Qot9An90MXxDFbP+63+pG2uA3UhmA@mail.gmail.com> <5060BADB.2000505@web.de> <CAGHpTBLs2tgUunDtFMhw7QMiuB2oXBtQJLKpLckhEyDp7Zr+Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 22:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEzo-0002bh-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 22:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab2IXULD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 16:11:03 -0400
Received: from mout.web.de ([212.227.17.12]:55132 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2IXULB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 16:11:01 -0400
Received: from [192.168.178.41] ([91.3.184.50]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LtWwK-1TQ27Q1BmW-011Gvh; Mon, 24 Sep 2012 22:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAGHpTBLs2tgUunDtFMhw7QMiuB2oXBtQJLKpLckhEyDp7Zr+Qg@mail.gmail.com>
X-Provags-ID: V02:K0:nX1v4lfm+1eoXS39RX6V414HUJki3zfHNvyl1YWl8JB
 GaPEvoxFsY/Uz8xuEfxCgaRDHG9MU+Ai5b18cdZ7kYFoq30Msm
 rve9CZRUZN7jMfiQvJx7POUtdyDo14gDa8cpOJ9xazfBJXsCqy
 l/sfn9VkKRhdlA72WiWWKfBWHkzW1L6IC5KpbqWvy91Td6g+21
 GEwaxweKeyS3bXkL6oWww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206325>

Am 24.09.2012 21:59, schrieb Orgad Shaneh:
> On Mon, Sep 24, 2012 at 9:56 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 24.09.2012 21:16, schrieb Orgad Shaneh:
>>> On Mon, Sep 24, 2012 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Orgad Shaneh <orgads@gmail.com> writes:
>>>>
>>>>> That is not correct. git-config is ignored as well for commit.
>>>>
>>>> What do you mean?  As far as I can tell, if you have
>>>>
>>>>     [submodule "var"]
>>>>         path = var
>>>>         ignore = dirty
>>>>
>>>> in $GIT_DIR/config, a work-tree-dirty submodule "var" is not
>>>> reported by "git status" and "git commit" without your patch, and
>>>> your patch does not seem to break that.  The only difference your
>>>> patch makes is that if you had the above three-line block in
>>>> the .gitmodules file and not in $GIT_DIR/config, "git status"
>>>> ignored the dirtyness in the working tree, but "git commit" did
>>>> notice and report it.
>>>>
>>>> What am I missing?
>>>>
>>>>
>>>
>>> I have:
>>> [submodule "mod"]
>>>         url = [...]
>>>         ignore = dirty
>>>
>>> in .git/config, and I removed the ignore part from .gitmodules to be even.
>>>
>>> I made a change inside mod, git status doesn't report its dirtiness,
>>> while git commit does.
>>>
>>> git status:
>>> # On branch master
>>> # Changes to be committed:
>>> #   (use "git reset HEAD <file>..." to unstage)
>>> #
>>> #       modified:   foo
>>> #
>>> # Changes not staged for commit:
>>> #   (use "git add <file>..." to update what will be committed)
>>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>>> #
>>> #       modified:   .gitmodules
>>> #
>>>
>>> git commit:
>>> # Please enter the commit message for your changes. Lines starting
>>> # with '#' will be ignored, and an empty message aborts the commit.
>>> # On branch master
>>> # Changes to be committed:
>>> #   (use "git reset HEAD <file>..." to unstage)
>>> #
>>> #       modified:   foo
>>> #
>>> # Changes not staged for commit:
>>> #   (use "git add <file>..." to update what will be committed)
>>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>>> #   (commit or discard the untracked or modified content in submodules)
>>> #
>>> #       modified:   .gitmodules
>>> #       modified:   mod (modified content)
>>> #
>>>
>>> Now I get it! That's because I don't have submodule.mod.path!
>>> config_name_for_path only gets initialized if path exists. Apparently
>>> git submodule init doesn't configure 'path', so it stays
>>> uninitialized.
>>
>> But submodule.mod.path should only be set in .gitmodules, not in
>> $GIT_DIR/config. Did you just remove the ignore setting from
>> .gitmodules or the path too?
> 
> Just the ignore, and my patch of course.
> 
> If it is not set in $GIT_DIR/config, then config_name_for_path is not
> initialized, and if it is not initialized, then
> set_diffopt_flags_from_submodule_config does nothing
> (handle_ignore_submodules_arg is not called). That is the main
> problem.

But config_name_for_path can only be set via .gitmodules. It is set in
parse_submodule_config_option() called by submodule_config() which is
called from gitmodules_config() ... but only if .gitmodules doesn't
have a merge conflict.

So either your .gitmodules has a merge conflict or the logic setting
gitmodules_is_unmerged in gitmodules_config() is buggy.
