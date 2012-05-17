From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit path vs rebase path
Date: Thu, 17 May 2012 12:19:33 -0700
Message-ID: <xmqqfwayobsq.fsf@junio.mtv.corp.google.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>
	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>
	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
	<4FAC047A.4010001@ramsay1.demon.co.uk>
	<CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com>
	<4FB03CA1.4030703@ramsay1.demon.co.uk> <4FB09FF2.70309@viscovery.net>
	<4FB2931A.1080504@ramsay1.demon.co.uk> <4FB340A9.60607@viscovery.net>
	<4FB543B7.6000506@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Steven Penny <svnpenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu May 17 21:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV6Ei-0004GP-VK
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 21:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967648Ab2EQTTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 15:19:39 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:61300 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab2EQTTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 15:19:38 -0400
Received: by faaa25 with SMTP id a25so112156faa.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 12:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=U7dPTZ81C4bP6vNKhWMQr0Q9NG+kzfIjuOgw4oR06QU=;
        b=CELaMrMofpVZODSwTfsPbZ3sN2y8IDu3mV4bcGHJZp+/pAZPhCTgwLaxSRN015ZCSQ
         Gblm5/OZC6JZ2b4fQtiqYjPUA8Dz3kcM6pYyn0q0/xJK1mcSda5vFtobg961QARNkR71
         ame9JMzfJLnHZ8B24/gPl7+PIKNR++BJbc5NjRStn8TDRSkD73V56c56n6vL5xU2haQ6
         0wPwAqlQR77hM1vTtOtX1EIW10x5fKI+9z9tqz/6OC2ADdJEJHyuw2mfiQ56ozusT7MG
         fxvrZJvXshOvUFCzeQ6X83ovylfx/oYgBoeUYT8i/Zr7Lu6PXzYR7BnfWza+g1FhCNbl
         aKEA==
Received: by 10.14.100.75 with SMTP id y51mr1749501eef.2.1337282374332;
        Thu, 17 May 2012 12:19:34 -0700 (PDT)
Received: by 10.14.100.75 with SMTP id y51mr1749490eef.2.1337282374234;
        Thu, 17 May 2012 12:19:34 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b15si5990888een.0.2012.05.17.12.19.34
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 17 May 2012 12:19:34 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 0B79020004E;
	Thu, 17 May 2012 12:19:34 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4FAFBE25F4; Thu, 17 May 2012 12:19:33 -0700 (PDT)
In-Reply-To: <4FB543B7.6000506@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 17 May 2012 19:30:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlhc6L0xhXpPjfjIvv6VVMvq/nEUqbZW31ehuvTs7/FRIcN2cOy8QHrSFXlWwHiewYanrhtu3Ck+ChSbvoJzkSmSiXRx+oXwo2R7bVAC2XlLYWWlMpE+AWSYZjcXfAzVQwpgsnbIFgdUjM/admG07upYvdBFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197926>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> As you surmised, cygwin does not have this feature. On cygwin you are
> encouraged to use the cygpath utility in scripts. (Also, cygwin does
> provide an API to convert to/from POSIX/win32 paths from your own
> programs. eg. cygwin_conv_to_[full]_win32_path() and cygwin_conv_to_\
> [full]_posix_path().)
> ...
> Just as an exercise, I created a script to use the windows PSPad editor
> (included below), using it to create a commit and also run this rebase:
>
>     GIT_EDITOR=pspad git rebase -i master uname
>
> Both git commands launched the editor (and completed their task) just fine.

So where does the above leave us?

Your message showed a way to "solve" it without changing git, but the
presense of workaround alone is not a good reason not to change git, if
the change makes things better without breaking other things.  I'd like
to know if Steven's patch breaks Cygwin users in other ways.

Steven's message showed that spawning Cygwin programs and feeding paths
in $GIT_DIR to them would not be broken if we start giving GIT_DIR as a
Windows style path inside shell scripted Porcelains.  But will there be
other things that get broken by the change?  An example of what would
worry me is that we define has_drive_prefix() only for compat/mingw.h,
so if somebody exports GIT_DIR back to call the binaries from scripted
Porcelains, it is likely that it would break git running on Cygwin,
where it expects only posix-style paths.  Upon seeing C:/foo/bar.txt, it
will start saying "Ah, that is a relative path" and may end up adding
the $(pwd) in front when it needs to know its absolute path.
