From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: zsh: improve bash script loading
Date: Wed, 29 May 2013 14:30:42 -0500
Message-ID: <CAMP44s0VjXwOXhUvniui+yVJiH4Dwxtx=0431G2KrEdHtrGTDw@mail.gmail.com>
References: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
	<51A59D8E.1040502@viscovery.net>
	<CAMP44s1UwYxS_sZSKTyEj5rhmrJ4gFkPc9z+eCL6WAaHXkY8eQ@mail.gmail.com>
	<7vr4gpu15c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:30:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhm59-0008CT-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966310Ab3E2Tao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:30:44 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:45232 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966195Ab3E2Tan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:30:43 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so3815767wgh.18
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rKE4GtOgteQjYMj2y3tG8dGhjN84QDyEubZv6cYAjTM=;
        b=f1U2AQjU1P42ViIsET5zh7T33dXg7uoUYSTt0P0w1rpybf2fWgBC2ZzhkYonQoDLMt
         /su3ROE8VMZrkE91/fdphayCO8ih2panOEZIFS/9/ct9MWoZvXCwq/xU979tmmp5dc2/
         Nwd6D2A62E1OnCl4dW30EavUODovcQGG67fhI4OdFqKpwom0KZp7TvwaU3iA6vSyhNiC
         N3ENmMpqXXUthDhdb3taEb1UHz3wOWjDPBuPeDpMK/Z30IiVZssfkLFk0a6qLxWJ9pT6
         tpz7bjz/JpI0cusEZ1GCV2xE4A/7F9N8HQdNMVqsVuozB9Ygq6qQ92gGx8mlGusV/fAf
         odBQ==
X-Received: by 10.180.189.41 with SMTP id gf9mr2191006wic.32.1369855842128;
 Wed, 29 May 2013 12:30:42 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 12:30:42 -0700 (PDT)
In-Reply-To: <7vr4gpu15c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225873>

On Wed, May 29, 2013 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 29, 2013 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 5/29/2013 5:24, schrieb Felipe Contreras:
>>>> +if [ -z "$script" ]; then
>>>> +     local -a locations
>>>> +     locations=(
>>>> +             '/etc/bash_completion.d/git' # fedora, old debian
>>>> +             '/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
>>>> +             '/usr/share/bash-completion/git' # gentoo
>>>> +             $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>>> +             )
>>>
>>> Won't you need
>>>
>>>         local e
>>>
>>> here, or does it not matter?
>>
>> You are right, otherwise it would be in the user's shell.
>
> Has this changed since 0a04e187e669 (completion: zsh: improve bash
> script loading, 2013-05-24) which I have on 'pu'?

Other than this change, nope.

> If not, I can do this locally to save a roundtrip, if you want.

Great, let's do that.

-- 
Felipe Contreras
