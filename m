From: Eugene Sajine <euguess@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 16:07:26 -0400
Message-ID: <g2l76c5b8581004261307g39f96c6en36588bfea6640ac5@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
	 <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
	 <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
	 <p2y76c5b8581004261122g8e2950fci507cc9090a865843@mail.gmail.com>
	 <p2v81b0412b1004261157pf26db339t7d27b1b317a99b5e@mail.gmail.com>
	 <y2n81b0412b1004261237w1c9221dn1ac75a29f50cb74d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 22:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Uak-0004Pn-8g
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 22:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab0DZUHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 16:07:30 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:49506 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab0DZUH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 16:07:29 -0400
Received: by qyk9 with SMTP id 9so17940191qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=d7q5+0HyFcDQzaof6zeRurkeJBAaFfihVTYlMNgiWiA=;
        b=geqTsc1qcdxoFQjMyS9mc4Vu3ngTzQKCK6wDiE2Si/f/aO92f0sI/SgidaFPwH8qKo
         BWwVxa+YtAZboBDj4EK0E85U8rNC1Bf4SHRhFqRpT4C7PFZ+W3SRGAhyjNwP1m3Njj34
         Ozwe/F98OyzWiDrM55zKP8ssjSZ3j5w5BPlV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K25QMS+8fOE2irAkyi2ffAGFi3MT32CA3yddCnKUdPbqYdCCXx7HxaToKA7FreMN+Q
         9svqYd8RhNAaRJHgmjU9Hm1tRUSB0jlzvAxmhJn+TutFFOofmzLFcdcWrA6fdUD2tSE7
         688Leh6Seduh53p+gwQ/bVhk3P+fxbLsCp/nM=
Received: by 10.224.36.15 with SMTP id r15mr1409046qad.129.1272312446874; Mon, 
	26 Apr 2010 13:07:26 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Mon, 26 Apr 2010 13:07:26 -0700 (PDT)
In-Reply-To: <y2n81b0412b1004261237w1c9221dn1ac75a29f50cb74d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145854>

On Mon, Apr 26, 2010 at 3:37 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Mon, Apr 26, 2010 at 20:57, Alex Riesen <raa.lkml@gmail.com> wrote:
>> On Mon, Apr 26, 2010 at 20:22, Eugene Sajine <euguess@gmail.com> wrote:
>>> Well thank you for that, but that gives me what i already know - the content.
>>> I need to "reverse engineer" the history by having only the content
>>> and its SHA-1 in order to indentify the last commitID and get all
>>> relevant info (author, date etc. )
>>
>> Hmm. In that case, your using of git log look like a good way to get the
>> information. If you wanted an output format which is better suited for
>> automated parsing, you can look at "git rev-list --pretty=format:...",
>> let it output only commit and tree hashes, and grep the output of
>> "git ls-tree" for your hash...
>
> Actually, "git log --no-abbrev --raw --oneline" looks very simple to parse.
> By the way, you may get ambiguous results: any file any time could have
> had the given hash. IOW, by looking at the whole history you may see different
> files having the same hash. It does mean the same content, so maybe its
> OK for your purposes.
>

Yes this looks a bit better, but still not "grep"-able easily as grep
SHA-1 cuts off the commit ID.
I'm wondering why this "simple"  feature which actually solves
(almost) the problem of "keyword expansion" substitution for git once
and for all is not yet there...:(

While i do realize that i might have ambiguous results and first of
all because the same blob can exist in creation commits, modification
and move, but mostly people are interested in the last commit of this
particular file/blob. So, i would say, it is very rare that at any
given point of time there will be two objects with the same hash in
repo.

It is a feature request than:)

Please, somebody take a look at the possibility to develop a variant
of "git log" or rev-list which would show the commits in which the
given blob SHA-1 has participated.

Thanks,
Eugene
