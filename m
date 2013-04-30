From: John Tapsell <johnflux@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 20:31:03 +0100
Message-ID: <CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
 <20130421102150.GJ10429@elie.Belkin> <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
 <20130421160939.GA29341@elie.Belkin> <7vli8bu3ne.fsf@alter.siamese.dyndns.org>
 <CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
 <7va9ogezzx.fsf@alter.siamese.dyndns.org> <vpqy5c0oson.fsf@grenoble-inp.fr> <CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGGv-0004PX-9K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801Ab3D3TbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:31:24 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34500 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab3D3TbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:31:23 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so1100920iee.6
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=jaKrs0eh5bXEWg2E9tAq+L55wAQw5CZP4lHzUNs7Kn4=;
        b=A3Zbi7Eg3eLWXrvVEPFljTuBe+rYrwM7x1TIg++naAgMnTnfThARVHSsiQZnhpu9Ix
         2HylpwOigbXPC9eCjOTxHYxtf+30iCmTfSO3/A1vbzQZE5m22VhmntFlSDXkihED+yew
         ARVct6W02jAdjugEEIvJxHJHblNEicGWipqSPy9cueNfRBF2LeecaFdPIbLGkf5EvmZx
         kwNypARLD7k79IgJKlMdmMF8hZRNnQDocAKZUKeRbeYo0dlAp0EpSmB1hdrzBiRh7bXx
         ML7R4aJ1b8f2Ip0YmKbir6EyHEcwSDvHWl44EFL+WwjvEkkZYpeM6vz79M3lE+ZNxll5
         ZuUg==
X-Received: by 10.42.66.140 with SMTP id p12mr32377767ici.15.1367350283193;
 Tue, 30 Apr 2013 12:31:23 -0700 (PDT)
Received: by 10.64.8.235 with HTTP; Tue, 30 Apr 2013 12:31:03 -0700 (PDT)
In-Reply-To: <CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222994>

On 30 April 2013 18:58, John Szakmeister <john@szakmeister.net> wrote:
> On Tue, Apr 30, 2013 at 1:05 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> By the way, these options are _not_ about "showing merge commits
>>> that introduce code", and they do not help your kind of "security".
>>> As I repeatedly said, you would need "-p -m" for that.
>>
>> Actually, while defaulting to --cc may be convenient, it would indeed
>> increase the security risk: currently, "git log -p" shows nothing for
>> merges, so it's rather clear that _everything_ is omitted. With --cc,
>> the user would see a diff, and could hardly guess that not everything is
>> shown without reading the doc very carefully.
>
> I don't believe it's that clear.  I bet people assume there's nothing
> to show, and unless you dig in and discover that `-p` doesn't include
> merges.  In git 1.8.2, `git help log` doesn't seem to make any mention
> of `-p` not showing a diff for merges.
>
> Just to see, I asked several people around here whether they knew `-p`
> didn't show diffs for merges, and they were all surprised that diffs
> were being omitted for merge commits.

Is there no way to fix --cc to work even in the edge cases?

John
