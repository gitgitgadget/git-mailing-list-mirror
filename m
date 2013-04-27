From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] complete: zsh: use zsh completion for the main cmd
Date: Sat, 27 Apr 2013 16:53:49 -0500
Message-ID: <CAMP44s1dEydqNWH+dFTCj13dfOCVym9XHCYnx12E5hosYNF9Rg@mail.gmail.com>
References: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
	<1367094846-9830-3-git-send-email-felipe.contreras@gmail.com>
	<7vtxmrsleq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWD48-0000Ej-2j
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab3D0Vxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:53:52 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:38252 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3D0Vxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:53:51 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so4456854lab.21
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 14:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Dp8qM/fS/DxZfjYgpBMmnrd6/0EKiqerwVDMQ8VVnbs=;
        b=tUJqjzqsjBMnUfHAwyZI9UyMeFX/XWQIeRRUYEj7Ubu7alaVlfEZ7E/qiXRfC6UBJY
         fljM0t15gDlZhUl5bhAnWG+JghMxKqPYXEyKA53DuLbO2qlFWtwvYdjZiWl2SQEwLbnt
         TNZFXF/OVUNf13i/wjcRnDA8unWJVIPth24IyafU07swpX06axdwDRWpG3xKnX+XauI5
         62d9zSvu80kVXMxB152kTEGfzsYYJqst/c037/bUnNbsA/IXE+KE91OsInpiZJ9fsVwG
         UHFR5jR0+uZ4GAUiN4AIU0JrYIODdD0h2AOv3r5MJBbB74DnhmU7VXwFCyfOXdITUgb0
         A6LQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr22808549lbb.8.1367099629804;
 Sat, 27 Apr 2013 14:53:49 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 14:53:49 -0700 (PDT)
In-Reply-To: <7vtxmrsleq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222707>

On Sat, Apr 27, 2013 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +__git_zsh_cmd_common ()
>> +{
>> +     local -a list
>> +     list=(
>> +     add:'add file contents to the index'
>> +     bisect:'find by binary search the change that introduced a bug'
>> +     branch:'list, create, or delete branches'
>> +     checkout:'checkout a branch or paths to the working tree'
>> +     clone:'clone a repository into a new directory'
>> +     commit:'record changes to the repository'
>> +     diff:'show changes between commits, commit and working tree, etc'
>> +     fetch:'download objects and refs from another repository'
>> +     grep:'print lines matching a pattern'
>> +     init:'create an empty Git repository or reinitialize an existing one'
>> +     log:'show commit logs'
>> +     merge:'join two or more development histories together'
>> +     mv:'move or rename a file, a directory, or a symlink'
>> +     pull:'fetch from and merge with another repository or a local branch'
>> +     push:'update remote refs along with associated objects'
>> +     rebase:'forward-port local commits to the updated upstream head'
>> +     reset:'reset current HEAD to the specified state'
>> +     rm:'remove files from the working tree and from the index'
>> +     show:'show various types of objects'
>> +     status:'show the working tree status'
>> +     tag:'create, list, delete or verify a tag object signed with GPG')
>
> Maintaining this list feels somewhat painful.  Isn't this something
> we can help by tweaking "git help"?

Yes, that's the way Bazaar does it (bzr shell-complete), but for now
this does the trick.

Also, I've been carrying around the patches from Stephen Boyd that add
--dump-raw-long-options. I think it would be better if somehow 'git
help' learned how to throw this output for both commands and
arguments, and then use the first part for bash, or specify bash
format somehow. Of course, we would need to add support for
descriptions in the option parser.

It's the big world-domination plan for completions, but I haven't had
time to work on that.

Cheers.

-- 
Felipe Contreras
