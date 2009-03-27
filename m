From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [RFC] Interactive difftool
Date: Fri, 27 Mar 2009 23:23:15 +0800
Message-ID: <46dff0320903270823v5e8e9c80w506d8a85440588f5@mail.gmail.com>
References: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com>
	 <20090327145122.GA944@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 16:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDvh-000432-Ba
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 16:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbZC0PXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZC0PXS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 11:23:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:1540 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbZC0PXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 11:23:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1304507rvb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V4J/SCCaAvdzGevVhLBJUCN+Ez2IMYmR7QCpN/Oy8yw=;
        b=GcU7ZyiTkS04nXuuKYqwtlHQ6sMu36h+dNotL239Xns4ZJcsXKtfogDNjt7ggnbubX
         85rvtSx6PGY69T+D7OWnxhOPMqURdwq3qp8K+/uHZ6c135LKdfx+bgRl7ksUgCONkwCR
         XaAa2z4IcQrUKVI8lw8ajP85lfshK1g7K01OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QIN6MYPopsAnbP3PprpGPWgEIEwiVZbtJ8Yp1q94ZQT8Zqza+947zVzNEjhi8oysju
         LTk8GHJUApAF5uJXID6HGlAHxjBRX8u3QyulM8X0c3YuUGq7pOG+ctOy4Xm2N+S6Z+jW
         DvkZt0uzbS0KllE9lbxmiVbJP7PQXaszPq3ZI=
Received: by 10.114.211.2 with SMTP id j2mr1504287wag.74.1238167395525; Fri, 
	27 Mar 2009 08:23:15 -0700 (PDT)
In-Reply-To: <20090327145122.GA944@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114904>

On Fri, Mar 27, 2009 at 10:51 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On =C2=A00, Ping Yin <pkufranky@gmail.com> wrote:
>> Before git-difftool goes to master, i want to propose a new feature =
to
>> add to or replace the current behaviour of difftool. With current
>> difftool, we can only see the diff one by one. However, sometimes wh=
at
>> we want is to see the diff of selected files, or in a different orde=
r,
>> just like what we can do in the gui. So here is what i propose
>>
>> $ git difftool --interactive [options]
>> [1] diff.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 10 +++++++++-
>> [2] t/t4020-diff-external.sh | =C2=A0 =C2=A08 ++++++++
>> Choose the file you want to see the diff of: 2
>>
>> When the user types 2 and then <enter>, the external diff program is=
 called
>>
>> Further more, instead of just type a number, a letter can be prepend=
ed
>> to the number to represent different ways of diff. For example
>>
>> t2 (tool 2): see the diff for file 2 with the configured diff tool
>> p2 (patch 2): see the diff for file 2 in the patch format
>>
>> What do you think?
>>
>> Ping Yin
>
> That would be pretty cool. =C2=A0I don't know about the
> merge-to-master timing and whether we'd want to include new
> features before the move.
>
> I guess most of the work would have to be done in
> git-difftool-helper.sh. =C2=A0I had a co-worker that asked for this
> exact feature just the other day (and ditto for mergetool).
>
> Patches are welcome if you have an idea for how it could work.
> Right now we get called indirectly by git-diff so I
> don't know if there's an easy way to hook into it like that.
> It might be a matter of changing git-difftool.perl so that it
> does more of the dispatching itself.
>

We can just change git-difftool.perl

The easiest way is first parsing the output of git diff --stat,
adding the number at the beginning, for example
[1] diff.c                   |   10 +++++++++-
[2] t/t4020-diff-external.sh |    8 ++++++++

When the user types a number,  git-difftool-helper is launched to show
the diff for the corresponding file.
