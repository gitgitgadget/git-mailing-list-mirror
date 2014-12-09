From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system changes
Date: Wed, 10 Dec 2014 05:53:09 +0700
Message-ID: <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
 <1418047507-22892-25-git-send-email-pclouds@gmail.com> <20141209100430.GC76457@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyTfb-0001VA-J1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 23:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbaLIWyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 17:54:09 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41089 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbaLIWxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 17:53:40 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1573985ieb.35
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=jEcC24RPVPe1nDfN4hsEz6CCeBIrxpVt0zGwDnq9MSI=;
        b=k9KWzfwXvfDd8EWzKJbOWei7FwN88ZxqSFvKpAav3PZMBk4MsHR6T14rPhIK/rnGFA
         j+rLwk3YPOqdh8OVtHHoHhw9AOn23Y4cIgClxkNTV379RjOejL331wPRGX4QyqoHOHwC
         8GEZ+ccTADG4MIFtYKKPmWNTIeuGHNz3LCtmh1R8IbP8vULWYVqJ4aMPOTAeX4MB181B
         cLf6kzZHT/2WAcU9p+G3tZdFtbdTHVIAlvrF4CmU0xdHPsVJAbzkmC/0SOxPjr6jbIE4
         nyne9Oey3q6P6JPBPGoNOQAAwMvHfICHWWTB7y/JsGkujoj4gkNfIPdGrG79WrAATWDW
         rzDQ==
X-Received: by 10.107.134.39 with SMTP id i39mr877503iod.53.1418165620173;
 Tue, 09 Dec 2014 14:53:40 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 9 Dec 2014 14:53:09 -0800 (PST)
In-Reply-To: <20141209100430.GC76457@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261173>

On Tue, Dec 9, 2014 at 5:04 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Dec 08, 2014 at 09:05:07PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> If the user enables untracked cache, then
>>
>>  - move worktree to an unsupported filesystem
>>  - or simply upgrade OS
>>  - or move the whole (portable) disk from one machine to another
>>  - or access a shared fs from another machine
>>
>> there's no guarantee that untracked cache can still function properl=
y.
>> Record the worktree location and OS footprint in the cache. If it
>> changes, err on the safe side and disable the cache. The user can
>> 'update-index --untracked-cache' again to make sure all conditions a=
re
>> met.
>
> My use case for untracked cache is where I have one machine with a
> repository and which is also mounted via sshfs on another machine.  I=
t
> looks like this will disable the cache every time I change the machin=
e I
> access it on.  Would you be willing to accept a patch for a configura=
tion
> option to disable this?

Torsten also does not like this patch. Maybe I'm just too paranoid.
Maybe we can drop this patch.
--=20
Duy
