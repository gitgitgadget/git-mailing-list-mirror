From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 28 Sep 2013 17:56:26 -0500
Message-ID: <CAMP44s3xqcxanLaNkowXyXEFejdr4QFkkks4FkA_TxwjE0mjAA@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
	<524085ba39049_3a6f81e84193b3@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 00:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ3RI-0002iU-Jo
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab3I1W4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:56:30 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52328 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3I1W41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:56:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so3264645lbi.25
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O39Sg+6JUYfIs1ppE6jz3bAUnxfAdTqTjGYDAypeX/w=;
        b=Iw2Jy+RI678BfRXpxr0yMsteQHopbO9dDW2+NAwwvhwFLCRYrDy3Gd/fpDOHkf4Q04
         AtVklLxjt+v6U0VVPZPQaEMbhmV3Ku3yHhhg4Uqw/2tIX72UbNoDoXD2/hV43rGdu/My
         +7o/rpJu8ppnHHPGAR8iw92XNn2XEwFwIrEJ+Ke+8W+TBRsUpxmMXCEGePgMOYJbu+lz
         TsoMquPxcyG/oImNHB4dJvXJvuMY5pqsj4RrL8g4w8u5iPwHU38H5CTuAlov5rSAyTVM
         zfwOZZbZJy1fJ9XUTo//uBzPXOCCOA63zlAHfhfKgp59x8ObgLnnjp+mjkMlTtVPfHni
         cV+A==
X-Received: by 10.112.168.170 with SMTP id zx10mr14982528lbb.0.1380408986221;
 Sat, 28 Sep 2013 15:56:26 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 15:56:26 -0700 (PDT)
In-Reply-To: <524085ba39049_3a6f81e84193b3@nysa.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235566>

On Mon, Sep 23, 2013 at 1:17 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:

>> In other words, now the Git user and developer community are strong
>> and thriving,
>> we should strive to make the core smaller, not larger, and encourage people to
>> form more third party communities that specialise in the areas the
>> participant of
>> these communities are stronger than those who are involved in the core
>> (e.g. like
>> myself, Peff, Nico, Jonathan, etc.). For programs that talk remote-helper or
>> credential-helper protocols, for example, it is wasteful to have them
>> in our contrib/
>> and have the changes to them go through my tree, with the same coding style
>> standard applied to the core, which would in the longer term only add
>> unnecessary overhead to what they want to do and what their effort supply the
>> users with.
>
> Of course, we can make the core smaller, by replacing all the perl/shell
> scripts with ruby ones.
>
> Sure, it would be better if all the scripts were rewritten in C, but that has
> been going on for years, and there's no end in sight, and not that much
> progress at all.
>
> So, it's fair to say that the rewrite to C is just not going to happen any time
> soon, and if we accept that, we should accept that an interim solution is
> needed, because Windows users are important and they are hurting right now, and
> that solution could definitely be Ruby.
>
> Rewriting scripts to C is hard, rewriting them to Ruby is easy, and one of the
> advantages of rewriting to Ruby, is that having the C->Ruby bindings available
> would make it easy to replace part of the scripts chunk by chunk, so we could
> have a half Ruby, half C script, and eventually 100% C.
>
> This is a practical solution, it's a realistic path to move forward, not one
> based on wishful thinking and intentions that never get realized.
>
> Once again, the perfect being the enemy of the good in the Git project, even
> when the good leads to perfect.

I think I've pretty much demonstrated that Ruby would be an excellent
tool to make the code smaller with my 44 patch series.

-- 
Felipe Contreras
