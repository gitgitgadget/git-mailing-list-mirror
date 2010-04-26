From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 20:57:38 +0200
Message-ID: <p2v81b0412b1004261157pf26db339t7d27b1b317a99b5e@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
	 <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
	 <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
	 <p2y76c5b8581004261122g8e2950fci507cc9090a865843@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:57:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6TV4-0001kn-EP
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0DZS5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:57:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65298 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0DZS5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:57:39 -0400
Received: by gwj19 with SMTP id 19so3990839gwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=W3V3Ly2Qyf3x2VAMF5fJPMflnCkqfgB3oBYxnnArb9E=;
        b=C3PDqnw85Ld5cHgluNcTiM7wqVAIxmBnkrVrYzIBn12ckZ8A6Hwmru4EPv6WJtNPxz
         vUeQuOONkFxoLkGXB5hxjMVGLDUPJJ71vg8Lj0I5houfxgdBt+mjQBmWvmOc0ysDf4+u
         jBNBfJI+tlZUb/HOXx725USJaBwFIFoDuQRQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Mk3EmRyZ96xAiDQDxmnItvFt9vp7DStTpAS4Ff6CTr6JtkIibhEnzp2rAgFp0I7Q2n
         UPzMtF1ApcKjWDgXKfQQ7u4W5uhGMK0RqhgwP+mu7nwFSI+Z5X7c1RXKvXaURA53II+l
         kDcIS/TexyzIHH3NFuNZEqr+05rN2ek3/gAVw=
Received: by 10.101.18.6 with SMTP id v6mr38468ani.42.1272308258548; Mon, 26 
	Apr 2010 11:57:38 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Mon, 26 Apr 2010 11:57:38 -0700 (PDT)
In-Reply-To: <p2y76c5b8581004261122g8e2950fci507cc9090a865843@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145846>

On Mon, Apr 26, 2010 at 20:22, Eugene Sajine <euguess@gmail.com> wrote:
> On Mon, Apr 26, 2010 at 2:08 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> On Mon, Apr 26, 2010 at 19:56, Eugene Sajine <euguess@gmail.com> wrote:
>>> On Mon, Apr 26, 2010 at 1:54 PM, Eugene Sajine <euguess@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I'm wondering if there is a way to get some repo information if the
>>>> only thing i know is SHA-1 (no full path to the file)
>>>
>>> I mean of course the SHA-1 of the blob, i.e. the result of git
>>> hash-object some_file
>>
>> Try 'git cat-file -t <sha>'. It prints what object type is under the hash.
>> Than you can use either 'git cat-file <type> <sha>' (the most precise version,
>> which shall fail if anything is wrong), 'git cat-file -p <sha>' or plain
>> 'git show <sha>' (which always works, unless repo's broken).
>>
>
> Well thank you for that, but that gives me what i already know - the content.
> I need to "reverse engineer" the history by having only the content
> and its SHA-1 in order to indentify the last commitID and get all
> relevant info (author, date etc. )

Hmm. In that case, your using of git log look like a good way to get the
information. If you wanted an output format which is better suited for
automated parsing, you can look at "git rev-list --pretty=format:...",
let it output only commit and tree hashes, and grep the output of
"git ls-tree" for your hash...

> This is all about avoiding using keyword expansion (thanks CVS for bad habbits)
>
> Thanks,
> Eugene
>
