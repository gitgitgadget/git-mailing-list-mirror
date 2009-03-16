From: Tom Huybrechts <tom.huybrechts@gmail.com>
Subject: Re: git-svn: creating tags from a subdirectory of trunk
Date: Mon, 16 Mar 2009 20:02:08 +0100
Message-ID: <632a37a0903161202w23848f41g5cde3942195369cb@mail.gmail.com>
References: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
	 <20090315232105.GA21667@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:04:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjI6f-0003f8-KD
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759978AbZCPTCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 15:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761373AbZCPTCM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 15:02:12 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:35923 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759142AbZCPTCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 15:02:11 -0400
Received: by ewy25 with SMTP id 25so3593051ewy.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e0cxE/iw0D6MWMifp+phxd9yzeZpMezBNTijHGDZ7RA=;
        b=HaPnetr5ZR96PPuDf+SQMw5S+EJvv0AOw5vLVOuM82fei28zsmFYYanZuLzD+5k+iw
         I0Ky2SFQTkRnRroNez6UVZUMt5R7QjOdbYbDKiisjYPnc4lnO8Akc/kNqAwHTdj7vata
         GQ6Xj4MiOASFYm9jWZUMVePXUy3TlXvnB16Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IjTmdS+UPB8VUA/aPngRn7Z8FbNqZFNhppA+Dv23Plvj2ZlVv9o0Zo3OKqFpPvhL1C
         BV2kUiaJ0EgQjvaD2C65wWVE3z/3drdoUbblvHFW7Tse5RLa9V2k5xjDTp+5lGqSpdO1
         6SohpY9M1C0U2CAaK7htr3N6AdAniKrUML+cY=
Received: by 10.210.18.18 with SMTP id 18mr3794175ebr.11.1237230128379; Mon, 
	16 Mar 2009 12:02:08 -0700 (PDT)
In-Reply-To: <20090315232105.GA21667@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113354>

On Mon, Mar 16, 2009 at 12:21 AM, Eric Wong <normalperson@yhbt.net> wro=
te:
> Tom Huybrechts <tom.huybrechts@gmail.com> wrote:
>> Hi,
>>
>> I'm trying to setup a git mirror of a svn repository. =A0The tags in
>> this repository are not created trunk it self, but from subdirectori=
es
>> of trunk. The tags and branches are in the standard places.
>> e.g:
>> /trunk/main -> tags/main-1
>> /trunk/plugins/foo -> tags/foo-1
>> /trunk/plugins/bar -> tags/bar-1
>>
>> I run 'git svn clone -s svn-url target'. It starts going over the
>> history nicely until it reaches the first branch. It calls this bran=
ch
>> something like tags/tag-name@revision, and starts retrieving the
>> entire project history again from r1. This is repeated for every
>> branch.
>
> Hi Tom,
>
> This is a known problem with some repositories. =A0My suggestion is t=
o
> use individual "fetch" directives for each of those tags you want to
> follow.
>
> The -s/--stdlayout is only for projects that follow the SVN-recommend=
ed
> repository layout exactly and we haven't thought of a generic way to
> handle those non-standard tags in repos...
>
> --
> Eric Wong
>

Hi Eric,

The repository I'm trying to convert is that of Hudson. I did some
digging in the list archives, and found this came up earlier
(2009/01/08).
Back then you replied:

"""
Alternately, you could just clone the root and have all the branches al=
l
over the place in one tree (your eventually working copy will be huge).

  git svn clone https://svn.dev.java.net/svn/hudson


Basically this is the equivalent of:

  svn co https://svn.dev.java.net/svn/hudson

Except you'll have the full history.
"""

Is that still valid ? That is what I did, and which caused the
behaviour I described.

Tom
