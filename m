From: Jeremy Scott <jeremy@great-scotts.org>
Subject: Re: files deleted with no record?
Date: Fri, 27 Jun 2014 07:00:57 +1000
Message-ID: <CAFDwLfzVX_A-6dEVpJccjfrQD7266dzgG9t-KeC4p15dvN1gyQ@mail.gmail.com>
References: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com>
	<CABURp0p6amKmhMhOUzdKy0a8TY7bmPoSLM0sUnZfGErhyfLsEQ@mail.gmail.com>
	<7298A047128B405F94F5E73903089107@PhilipOakley>
	<CAFDwLfyB+TAFQbU==YVX3W1wbpuBdigyFo5AZsk7CGAqtH4LpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:01:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Gn1-00047T-E6
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 23:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaFZVA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 17:00:59 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:50154 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaFZVA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 17:00:58 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so3660649qcv.40
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=squq8lEU/EqH0m0VkpvtjcPOwRl3UD/7c8izc1xT5eM=;
        b=Cxc/GstwJwVdKpeW13Brg0DOuOwuwLF/4IECAgJiFB6zBs+xn9WOx6p9slxc0mJZ7r
         AGGEP3qg3LqD8JVQ9DsUKG3ywCm/4xeuDeM+WsYHgXrU05Vq6ZcPIi7gBc7yjUwYAw9G
         TXi4rdY9UYZbmH+GIYNkJ1ctPV6Y9kZOLmE6ffPOGjCkmSPODQ/47+iwWBpAKhtgxulj
         DJaeVagdy34WuWmj7ptHmSLxaxRgOZ+SXPTzu20yBT4/unLWmZDWsltaRdhx6oUmWMhA
         0mWiQo2j8hryDIUJrSLBpmyHFkaUVkF7F9a+xsOlvTn5Yv/H3hrrKCJgka1iVuB4bOB0
         QOPQ==
X-Received: by 10.224.49.71 with SMTP id u7mr26734726qaf.58.1403816457940;
 Thu, 26 Jun 2014 14:00:57 -0700 (PDT)
Received: by 10.140.34.146 with HTTP; Thu, 26 Jun 2014 14:00:57 -0700 (PDT)
In-Reply-To: <CAFDwLfyB+TAFQbU==YVX3W1wbpuBdigyFo5AZsk7CGAqtH4LpA@mail.gmail.com>
X-Google-Sender-Auth: 1C_l6_wxGw5ymGVnG92kVf40FSU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252526>

we're all using source tree. I'm really interested to try and
reproduce this so I'll find some time today to do it.

Thanks again

On Fri, Jun 27, 2014 at 6:56 AM, Jeremy Scott <jeremy@great-scotts.org> wrote:
> Hi. Thanks for getting back to me.
>
> here is a screenshot from source tree to visualise the scenario:
>
> https://drive.google.com/file/d/0B-Wn7DfHsuhyTEVkRHAzeGVZelpMWjFxZW1kbVBKVlNab3pR/edit?usp=sharing
>
> I will attempt a script to reproduce this later today.
>
> Thanks
>
>
>
>
>
>
>
>
>
> On Fri, Jun 27, 2014 at 5:53 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>
>> From: "Phil Hord" <phil.hord@gmail.com>
>>
>>> On Mon, Jun 23, 2014 at 9:15 PM, Jeremy Scott <jeremy@great-scotts.org>
>>> wrote:
>>>>
>>>> I just encountered a situation where a merge was made, with no
>>>> apparent changes in files (ie no log), but the result was that some
>>>> files were deleted.
>>>>
>>>> person A adds some files
>>>> person B adds some files from the same point
>>>
>>>
>>> You mean from the same point in history, right?  Not files with the
>>> same filename or path?
>>>
>>>> person B commits and pushes.
>>>> person A commits -- now merge is required
>>>> a few more commits on top of person B's commit
>>>
>>>
>>> I don't understand this step.  Who adds a few more commits on top of B
>>> and why?
>>>
>>>> person A merges - this removes the files that B added. There is no log
>>>> of the files being deleted
>>
>>
>> A similar issue, by reference, just came up on the [git-users] list. The
>> reference was:
>> 1. http://randyfay.com/content/avoiding-git-disasters-gory-story
>>
>> In that case the problem was a mixture of tools and  misunderstandings.
>>
>> It may not be the same as your case, but could give insights into what's
>> happening between different developers.
>>
>> Which Tools are You, person A and Person B using, with --version?
>>
>>>
>>> This sounds like an "evil merge" (see man gitglossary, and google),
>>> but it's not clear to me how you arrived here.
>>>
>>> When I tried to reproduce your issue with this script, it did not
>>> remove any files unexpectedly:
>>> ------------------->8-----------------------
>>> #!/bin/sh
>>>
>>> set -e
>>> mkdir foo && cd foo && git init
>>> echo foo > foo && git add foo && git commit -mfoo
>>>
>>> git checkout -b PersonA master
>>> echo bar > bar && git add bar
>>> git commit -m"PersonA: bar"
>>>
>>> git checkout -b PersonB master
>>> echo baz > baz && git add baz
>>> git commit -m"PersonB: baz"
>>>
>>> echo foo-conflict >> foo && git add foo
>>> git commit -m"PersonB: foo"
>>>
>>> git checkout PersonA
>>> echo foo-different >> foo && git add foo
>>> git commit -m"PersonA: foo (conflicts with PersonB)"
>>>
>>> git log --oneline --all --stat
>>>
>>> if ! git merge PersonB ; then
>>>  git checkout PersonA foo
>>>  git commit --no-edit
>>> fi
>>> git log --oneline --graph --stat
>>> ------------------->8-----------------------
>>>
>>> A sneaky issue with merges is that they do not have a clear way to
>>> show patch information -- the diff between the commit and its ancestor
>>> -- because they have multiple ancestors.  You can show diffs for a
>>> merge relative to each of its parents, but it is not usually done for
>>> you automatically.  This is why making changes in a merge which are
>>> not actually required for the merge is bad ("evil").
>>>
>>>> Clearly this is possible - was this a user error?
>>>
>>>
>>> Probably, but we'd need to see how the user got there.
>>> --
>>
>> Philip
>
>
