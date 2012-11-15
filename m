From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 02:15:07 +0100
Message-ID: <CALZVapmBM78UtjAiNm2VoeWuetCiyxN70mTxbG14SQh5a5RCeQ@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
 <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
 <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
 <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com> <CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYo3U-0007Uo-FB
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992494Ab2KOBPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:15:30 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35432 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992491Ab2KOBP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:15:29 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1148112vcb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JCFOk0JlnnaOA/+fEB9yMuRztpBKQ64kBBeZ2CCVgI4=;
        b=xWA/qGoiya8CXCW7+Tv2jdd5f5otVoVBsOf2eHcaSVQbg5wa2cr3aksl5P5wyN+gow
         v63QYOKzUBsS6xv3vhGEvcuHFZtr1DOUa3Y5V+h2fy3cwLSosB8/4klElmoZZgwaCDE8
         6dClhLmduFrdO8ct0V3YgC54E6QXJIKqeDD09zmduqSY4XqdWDByTC9k3OkIv4IFSad8
         W2IXYXId8jhWgVh30HQfwjoaauNiH8Fal641cul1bDD3PoKiwpGgIR9aOKbo4kldnZTC
         MD6l4vCzv9VonxLNhPYxd/whDxg054jzt/8PdEWLCaT3MjszzHfEuLVM76+ckECm5tVO
         jPqA==
Received: by 10.52.71.44 with SMTP id r12mr4309617vdu.41.1352942128173; Wed,
 14 Nov 2012 17:15:28 -0800 (PST)
Received: by 10.58.33.200 with HTTP; Wed, 14 Nov 2012 17:15:07 -0800 (PST)
In-Reply-To: <CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209777>

Hi Andrew,

Doing this would require I got tracked which one comes from which. So
it would imply some logic (and db) over it. With the hardlinking way,
it wouldn't require anything. The idea is that you don't have to do
anything else in the server.

I understand that it would be imposible to do it for windows users
(but using cygwin), but for *nix ones yes...
Javier Domingo


2012/11/15 Andrew Ardill <andrew.ardill@gmail.com>:
> On 15 November 2012 11:40, Javier Domingo <javierdo1@gmail.com> wrote:
>> Hi Andrew,
>>
>> The problem about that, is that if I want to delete the first repo, I
>> will loose objects... Or does that repack also hard-link the objects
>> in other repos? I don't want to accidentally loose data, so it would
>> be nice that althought avoided to repack things, it would also
>> hardlink them.
>
> Hi Javier, check out the section below the one I linked earlier:
>
>> How to stop sharing objects between repositories?
>>
>> To copy the shared objects into the local repository, repack without the -l flag
>>
>> git repack -a
>>
>> Then remove the pointer to the alternate object store
>>
>> rm .git/objects/info/alternates
>>
>> (If the repository is edited between the two steps, it could become corrupted
>> when the alternates file is removed. If you're unsure, you can use git fsck to
>> check for corruption. If things go wrong, you can always recover by replacing
>> the alternates file and starting over).
>
> Regards,
>
> Andrew Ardill
