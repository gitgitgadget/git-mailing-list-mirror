From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 18:27:55 +0100
Message-ID: <4B549A1B.9060306@isy.liu.se>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com> 	<4B549254.5090206@isy.liu.se> <8c9a061001180914v42074056o3a5d077ac4cea70f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 18:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvQJ-000454-Io
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 18:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611Ab0ARR1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 12:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755615Ab0ARR1j
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 12:27:39 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:48698 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab0ARR1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 12:27:37 -0500
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id o0IHRY1v022691;
	Mon, 18 Jan 2010 18:27:34 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o0IHRYL9003489;
	Mon, 18 Jan 2010 18:27:34 +0100 (CET)
Received: from [192.168.21.153] (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o0IHRYOQ001686;
	Mon, 18 Jan 2010 18:27:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <8c9a061001180914v42074056o3a5d077ac4cea70f@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137393>

Jacob Helwig wrote:
> On Mon, Jan 18, 2010 at 08:54, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>> Jacob Helwig wrote:
>>> On Mon, Jan 18, 2010 at 07:30, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>>>> Hi!
>>>>
>>>> I have been using submodules for a while, and been quite happy with
>>>> them.  Just updating to the latest next (1.6.6.443.gd7346), a strange
>>>> problem has occurred.  All my submodules (which are in fact unmodified)
>>>> show as modified and dirty
>>>>
>>>> diff --git a/extern/utils b/extern/utils
>>>> --- a/extern/utils
>>>> +++ b/extern/utils
>>>> @@ -1 +1 @@
>>>> -Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1
>>>> +Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1-dirty
>>>>
>>>>
>>> Do you have any untracked files in the submodule?  git status is
>>> working as I would expect with the same version (1.6.6.443.gd7346).
>> Yes, I do.
>>
>>> If there is no output from git status in the submodule, then git
>>> status in the superproject shows the submodule as being clean.
>>> However, if there is _any_ output from git status (untracked files,
>>> modified files, deleted files, new files), then the superproject shows
>>> the submodule as being dirty.
>>>
>> I have the following use case, which is affected.  I have with in a
>> submodule some code that needs to be compiled, and hence generate some
>> object files and other files in the process.  I don't want to include
>> these files in a .gitignore as they are named differently on different
>> systems.  Hence, I include them in my .git/info/exclude file, where I am
>> developing the module.  So now, unless I do the same thing for all
>> places I checkout the repo as submodule, I end up with the module
>> indicated as dirty after I compile it.  This is a bit inconvenient.
> 
> That being said:
> The .gitignore file supports shell globs.  Are the generated files
> created with names that are so different that some simple shell globs
> used in one or more .gitignore files couldn't cover them?

Under Linux I for example get .o files whereas under Windows I get .obj
files.  Of course I could put both in .gitignore, but I don't like to
have to exclude more files than necessary it gives me a bad feeling of
accidentally one day exclude something important, which has at occasions
happened before.  (For the same reason i don't usually put *~ in
.gitignore, as I don't want to impose emacs on others, that might prefer
a different editor, but that is a bit different from the case we have
here.)  Furthermore, list could start to grow with more systems and
build chains with more intermediate files.

/Gustaf
