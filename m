From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: git alias quoting help
Date: Fri, 1 Apr 2016 06:30:44 -0400
Message-ID: <CAH_OBie81uJASgVs7y=J1iAhpFPW6FFK1RgHp+AyohuPLye07Q@mail.gmail.com>
References: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
 <CAH_OBie1Bc==wPByestESHz-K8ezC7f5A1D=t1SsP9=Sd-y-eg@mail.gmail.com> <CAH_OBifdLkszB7ZnKWBuZv8AFmKC9-RLZhxK_tmC9+bNJzXrXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:31:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwMA-0006CL-TM
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbcDAKbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:31:06 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36708 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbcDAKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:31:05 -0400
Received: by mail-pf0-f173.google.com with SMTP id e128so70394448pfe.3
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=At0agNOe+ttm9dVKeIob+GNrunYj/kmk5i6j2JlsUEQ=;
        b=KF+0sdjswNeHCTmsCuvEfEVmx+yiOALUtaolqaXC75enep91Jt7NaF2CrZyQUGPFfz
         5byRPGC80gZgNsVWw97sScmJACBXN09iiCJ/srAHouJzWyR2VBxl4P37c5XePq4u7Sn3
         KGUnikCffkyVqsEgqVgne2Cs4K9M91MwHrqhXzdBA2Cs5biqkRwkNAZnLJbkxaeOd0Xy
         5WfyS9RXWCQEwI3QUDMC5i9cdeiSa2UzZiXyhIpe/wFYn1o5excQSguYVL1TK1IsrmNB
         eMdI6w1FOM3s+uhEP92GCbJRi+nN5CQ9KG6Kdp5hGSsDApH2tZHpmvnf6QK0MCH+neo9
         Or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=At0agNOe+ttm9dVKeIob+GNrunYj/kmk5i6j2JlsUEQ=;
        b=TPHCVTqntDvbhftSzHN8jyrgdd2SN2+xcrBiVise1esSTasVAobZUbmJ23EPPPforb
         MC7CM+8I0fKgMoUJk/rP7NyllCgiAMvPfII8SRKch0R1ToFLvhK9LsmZdznR9WjpE14G
         kTgH33bI0aiRTvH2NuGGmFvRcuWfekBfyQkQJsvYnWFTwxIktM/bivlQEir7WsysRGsm
         +jP+YlwVe1gBolMb/wL8jUe8u1U4N8jH1P+OgbbeauN0Hx5TvjIUvU2ID8JmmK8R187Z
         BwqzyYabRP+ElQ4NZ4XMVfH6clH9DoG6kx08kMwg6gywCRrpBJ5GZaCL/lKx6JqUD1c8
         NhHQ==
X-Gm-Message-State: AD7BkJJjoXOBslOXHFy5DCHO5sNlv791/45J7Zl+talD/SsKxG2MxBKmBaHo5moVfIRr60Ug0rf9DYDIuD7EsQ==
X-Received: by 10.98.71.156 with SMTP id p28mr29610099pfi.139.1459506663672;
 Fri, 01 Apr 2016 03:31:03 -0700 (PDT)
Received: by 10.66.5.163 with HTTP; Fri, 1 Apr 2016 03:30:44 -0700 (PDT)
In-Reply-To: <CAH_OBifdLkszB7ZnKWBuZv8AFmKC9-RLZhxK_tmC9+bNJzXrXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290517>

I think I finally figured out how I want to do this:

git remote add temp ../<temp repo>/
git fetch temp
git merge -s ours --no-commit temp/master
git read-tree --prefix=<wanted directory> -u temp/master:<wanted directory>
git commit -m "foo"

However, when I do this, I've got all of the commits from the original
(temp) repo. How do I prune these out? None of the files show up, but
I do see reference to them in: git log --stat. And nothing I do with
gc or prune seem to have any affect.

On Fri, Apr 1, 2016 at 2:10 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
> FWIW, I (finally) found two projects that like they'll do what I want:
> git-splits and git_filter
> The later was lacking in documentation and after the build I couldn't
> figure it out at a glance and I think git-splits will DWIW.
>
> On Thu, Mar 31, 2016 at 10:27 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
>> BTW, just trying to get filter-branch to interpret the bash script
>> string correctly now and it still isn't working:
>>
>> git filter-branch -f --prune-empty --index-filter "\
>>   git ls-files -s | \
>>   sed \"s-\\t\\\"*-&${1}-\" | \
>>   GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
>>   git update-index --index-info && \
>>     mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE \
>> " HEAD
>>
>>  I'm guessing bash is grabbing my actual bash shell is grabbing the
>> GIT_INDEX_FILE declaration for itself. If this is the case, I'm not
>> sure how to stop it - tried var\=\$var.new and that passes the '\='
>> which totally messes things up.
>>
>> Rewrite ef54b77e59c7f4e18f00168ba88a8d2fee795802 (1/76)mv: cannot stat
>> `/<repo path>/.git-rewrite/t/../index.new': No such file or directory
>> index filter failed:   git ls-files -s |   sed
>> "s-\t\"*-&cookbooks/adjoin/-" |   GIT_INDEX_FILE=$GIT_INDEX_FILE.new
>> git update-index --index-info &&     mv $GIT_INDEX_FILE.new
>> $GIT_INDEX_FILE
>>
>> On Wed, Mar 30, 2016 at 12:13 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
>>> I've also tried to make this a plain bash script (w/o the function or
>>> if statements and am failing at the same place). The issue seems to be
>>> with the quoting in the filter-branch | ls-files bit. Also, the end
>>> goal here is to be able to move a directory from one repo and keep the
>>> history. While this works if I do it at the command line, it's just
>>> too many steps (is tedious). Also, if there's a way to do the same
>>> thing with multiple directories in one shot, (or make this work with
>>> something like: cookbooks/{a,b,c} # as a parameter) that'd be perfect.
>>>
>>>   reapdir = "!f() { \
>>>     if [ -d "$1" ] ; then \
>>>       git filter-branch --prune-empty --subdirectory-filter "$1" -- --all && \
>>>       git gc --aggressive && \
>>>       git prune && \
>>>       git filter-branch -f --prune-empty --index-filter '\
>>>         git ls-files -s \
>>>           | sed \"s-\\t-&$1-\" \
>>>           | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index
>>> --index-info && \
>>>             mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'; \
>>>     else \
>>>       echo "No directory $1"; \
>>>     fi; }; \
>>>   f"
