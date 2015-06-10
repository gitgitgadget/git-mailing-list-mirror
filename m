From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On undoing a forced push
Date: Wed, 10 Jun 2015 09:43:34 +0700
Message-ID: <CACsJy8D32vjn=GuJj60hFKMwgqbV6L1G9OyEBguCD4c0Nb_kjQ@mail.gmail.com>
References: <20150609121221.GA14126@lanh> <20150609150035.GA102463@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 04:44:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Vzv-0005Va-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 04:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbFJCoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 22:44:07 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36426 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbFJCoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 22:44:05 -0400
Received: by igbpi8 with SMTP id pi8so25681615igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=nW4rFvSpUKGcwpmmvZUZhvdpoFXfzPvM6Fy8EGPwjN4=;
        b=l2c1KyVzYpe3qlZZyRYCg9hxVZa3MZwnm3APcQruw11YAuG4fcIOYpD3mFTTk2x+uQ
         MjrmfUulTbgrBiRbhB2CVOb1yL6u59KcAGPJMMaAtIAVTmik9a+wA9GAUoaNtT//wiSH
         jMrn4aFrWvieqCOHjkA7MOAT3/XOdsgf7SbJNpkDPSN+GgUiYHICFGXqcEXZ20Jm8utj
         /5q4JWl+fPB+KJXL4tmUbqU7AGW1c3q+TbhHuEG83SeHO6whZjq9VvtM5VXOA1iQxsus
         hgUVIzdUNdpTQlxH6r4sC43EGDKVJnLYAQd91z3UDfi/0F0/rRPapU7FDJ1/CvsH40K2
         mjBw==
X-Received: by 10.50.142.68 with SMTP id ru4mr2572631igb.41.1433904245244;
 Tue, 09 Jun 2015 19:44:05 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 9 Jun 2015 19:43:34 -0700 (PDT)
In-Reply-To: <20150609150035.GA102463@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271253>

On Tue, Jun 9, 2015 at 10:00 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Jun 09, 2015 at 07:12:21PM +0700, Duy Nguyen wrote:
>> diff --git a/transport.c b/transport.c
>> index f080e93..6bd6a64 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -657,16 +657,17 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
>>                       "[new branch]"),
>>                       ref, ref->peer_ref, NULL, porcelain);
>>       else {
>> -             char quickref[84];
>> +             char quickref[104];
>
> You've increased this by 20, but you're adding 40 characters to the
> strcpy.  Are you sure that's enough?
>
> Also, you might consider writing this in terms of GIT_SHA1_HEXSZ, as it
> will be more obvious that this depends on that value.  If you don't now,
> I will later.

It's a demonstration patch and I didn't pay much attention. I think
converting this quickref to strbuf may be better though, when you
convert this file to object_id.
-- 
Duy
