From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Wed, 14 Oct 2009 17:26:39 +0300
Message-ID: <94a0d4530910140726i4465e919h77045904aa33c61a@mail.gmail.com>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
	 <4AD32024.6020005@drmicha.warpmail.net>
	 <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>
	 <4AD42A1C.1080709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4ws-0000pr-9A
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369AbZJNO23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbZJNO23
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:28:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:34499 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933116AbZJNO21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:28:27 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1411592fgg.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cChHzgdydbTq7Q4RTWQUFG88oDb/NUSn7mFkpg8gU/M=;
        b=u+eIg/Ie7WYAacNVfmWsHM/AGGfVKJTNImlKYmEYE0sSiSt3pmM/d75UbZfULgv1ZE
         frYi6Z4hDRlwYbpeArp0nmDXbJhDSxJ1vinWgbW3ur8AKd+v5joqkPTByr7sjTkoklJx
         N8yP5ZRCBrwF7tbL56z7g08NW07iZitDaOaa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dUZi30lr1OQJ8Dm0g9xEsU6cn/r+6Qe0yeG+CgXUjtXXcD9XVUCcmISxtNZGx5VGQQ
         7z3eirAppAvI2+m4FXoTO9iZeOseRYwgUDR+sey1eNWnW6CL97ZvQnbMsSxiIdPOLClZ
         vgaXJ0uA4heEhet/iZ0VCWkyyd97abuVNch4g=
Received: by 10.86.18.34 with SMTP id 34mr7735876fgr.2.1255530399472; Wed, 14 
	Oct 2009 07:26:39 -0700 (PDT)
In-Reply-To: <4AD42A1C.1080709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130292>

On Tue, Oct 13, 2009 at 10:19 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 12.10.2009 19:09:
>> On Mon, Oct 12, 2009 at 3:25 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Well, you do talk about "system" below, and that's about it. Also, the
>>> configuration is not really distributed among different locations. Most
>>> newbies interested in a *D*VCS will misunderstand this (as git having
>>> distributed configuration).
>>>
>>> Alternative:
>>>
>>> Git's default configuration can be changed on a system wide, global (per
>>> user) and local (per repository) level, in the order of increasing
>>> precedence.
>>
>> When I read that it's not clear if the local level discards the global
>> level completely or it's aggregated. If we specify that it's only the
>> variables that take precedence it might be clearer:
>>
>> Git's configuration is composed of variables that are stored in
>> multiple locations: 'system' (all users), 'global' (for the user), and
>> 'repository' -- in decreasing order of precedence.
>
> Yep, although established lingo is "options" (not "variables"), and it's
> really increasing order, not decreasing.

Really? I remember clearly Junio stating otherwise:
http://marc.info/?l=git&m=123460371724873&w=2

----
> +	OPT_BOOLEAN(0, "unset", &do_unset, "removes an option: name [value-regex]"),

Please don't introduce a new noun "option" that has never been used to
mean a "configuration variable" in git documentation.  It unnecessarily
confuses everybody.
----

>> I disagree. Most useful configurations (color.ui, user.email) should
>> be global. The complete newbie might think: cool, now I have my git
>> properly configured (with 'git config -e'), and then when cloning a
>> new repo (s)he would think: ok, git just forgot what I told him. When
>> that happens (s)he would have to re-learn and re-configure git.
>>
>> When users think about configuration, it's usually a 'global'
>> configuration, so that's what we should teach from the beginning and
>> make sure they understand the difference between 'global' and
>> 'repository' configurations.
>
> Sure. What I meant are the file locations, the actual paths. First
> timers should use "git config -e" and "git config --global -e" if they
> really want to edit their local and global config files. Better yet,
> they should use "git config" and "git config --global" in their set and
> get modes, because they make sure that there's no total garbage in the
> config. The locations of the files are an implementation detail.

Oh, in that case I agree.

>> Looks better, except s/configuration options/configuration variables/
>>
>
> Uhm, no, for the reason mentioned above. While the man page of git
> config is not completely consistent either, we're really talking about
> configuration options. An "option" can be set to a "value", and the
> thing you pass in order to do that can be called a "variable". For the
> most part this is how git-config[1] uses this terminology.

Yeah, but not everything in there is an option. Personally I would
prefer the "option" term, but as I said, Junio disagreed some time
ago.

-- 
Felipe Contreras
