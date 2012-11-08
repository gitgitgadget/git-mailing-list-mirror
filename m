From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 8 Nov 2012 12:39:34 +0100
Message-ID: <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
 <509B7E6B.1030407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 12:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWQSx-0005Qh-7E
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 12:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab2KHLj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 06:39:56 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65494 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab2KHLjz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 06:39:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2724666oag.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 03:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EJRl+zqrYMs3U+PxQ4mCMmXzrIWdWxF0xqhG6ZJOD30=;
        b=NA+nqkQ7KCcwqFo55wVYDoKyDtAlub747iNJv4K+crL4EqDqRD9qvS+FWaQEVrOaqX
         SHLu+DVy0RyYyGJv/8ySvo16Ewx9N2EdAYtuoply+sTuxO65b/isHboLWtGHvxYBNT3H
         qQ4604GLhCdh2kHEV21SnwZuvIMQJ3RdMRjM7bdBhRfw6Fna0JVhYuCn4fWildtZnW4x
         6ZSn4s8+WrqTM42uMbGwYXFFZjYpEvmiSiuPE+bedGZt/MIudMN1xoZnZ3VvUVQqY/7z
         W50+MfYQTHRZd5QevRm2a8pIV6sLWnW+piYqFKT3/J9NlmQbehRAttFTjtigAwinKJoB
         KnoQ==
Received: by 10.60.171.80 with SMTP id as16mr4530363oec.49.1352374795006; Thu,
 08 Nov 2012 03:39:55 -0800 (PST)
Received: by 10.60.93.225 with HTTP; Thu, 8 Nov 2012 03:39:34 -0800 (PST)
In-Reply-To: <509B7E6B.1030407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209153>

On Thu, Nov 8, 2012 at 10:42 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 11/07/2012 10:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I'm curious as to whether you got around to this? I'd be interested =
in
>> updates on this script.
>
> Thanks for asking.  I have made many of the changes that were request=
ed
> and/or I had planned:

I was playing around with it for some work repos last night.

> * Tentatively renamed the system to git-multimail
>
> * Store the configuration in namespace "multimailhook.*" instead of
> "hooks.*".

Great, I had made this change locally myself, makes it much easier to
keep the configuration separate, and I think doing and having a
migration script is better than using the original config variables.

> * Reinstated (optional) support for including shortlogs since the las=
t
> tag in announce emails.
>
> * Script to migrate post-receive-email configuration to the equivalen=
t
> git-multimail config.
>
> * Better documentation (including of the migration process).
>
> * Made it easier to use Python code to customize the script's behavio=
r
> (by allowing it to be imported as a Python module), plus a demo scrip=
t
> showing this usage.

That's very nice, I was monkeypatching the script to overwrite some
templates. This makes that easy.

> * Some primitive testing tools to generate a test git repository and
> generate many kinds of notification emails (though the emails still h=
ave
> to be checked manually for correctness).
>
> Nevertheless I think that the script is quite usable as it is and it
> would be great if other people could try it out, give feedback, and e=
ven
> submit patches.

I'll test it out some more, the issues I've had with it so far in
migrating from the existing script + some custom hacks we have to it
have been:

 * Overly verbose default templates, easy to overwrite now. Might send
   patches for some of them.
 * No ability to link to a custom gitweb, probably easy now.
 * If someone only pushes one commit I'd like to only have one e-mail
   with the diff, but if they push multiple commits I'd like to have a
   summary e-mail and replies to that which have the patches.

   It only seemed to support the latter mode, so you send out two
   e-mails for pushing one commit.
 * Ability to limit the number of lines, but not line length, that's
   handy for some template repositories. Should be easy to add
 * I wanted a hook to override the options passed to sendmail in some
   cases, looks easier now with the modular design.

But in addition to that we have our own custom E-Mail notification
scripts for:

 * People can subscribe to changes to certain files. I.e. if you
   modify very_important.c we'll send an E-Mail to a more widely seen
   review list.

 * Invididuals can also edit a config file to watch individual files /
   glob patterns of files, e.g. src/main.c or src/crypto*

I think a good way to support that would be to have either a path to a
config file with those watch specs, or a command so you could run "git
show ..." on some repo users can push to.

But overall it's very nice. I'll make some time to test it in my
organization (with lots of commits and people reading commit e-mails).
