From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] git-svn.perl should check GIT_ASKPASS environment
Date: Fri, 11 Feb 2011 11:28:34 +0100
Message-ID: <AANLkTinWLTfU_WmxTCvz+P=rcXY=2u25Eo2QZWmDMdSh@mail.gmail.com>
References: <1c47e93c-5b7c-4aed-8a78-807d3aff2700@n36g2000pre.googlegroups.com>
 <AANLkTinkv0dNxNxehud0Byuu9tpqxp1kBMJ1OyEcfVQ_@mail.gmail.com> <AANLkTik9mFNsqFQn5SEZkYd_uxDeoY-9nqgV_PJ+nNsi@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jose Roberto Garcia Chico <jose@toro-asia.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 11:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnqFW-0008N4-V0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 11:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab1BKK26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 05:28:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56099 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab1BKK25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 05:28:57 -0500
Received: by fxm20 with SMTP id 20so2518805fxm.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Xse+aGdoKM4aZho7keC69X6ZRchelgvv/rWRFgiHc7k=;
        b=ANQGroWYXXzIKGKCSdHfCgOBNswf0lAdnIeokXYAF2VUaB1x7ceWU/C5bg6PYoi63r
         jb+n3trzp5ENz2ZWnOjCfvTqxRoTDgCaHs0ylSXcb3vI9ggKDB+l3hJXAGHujj71cRQW
         dQpH4h+6wx8+BU7gHo1GiJlSVr09I6mQPbkB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=CHkOU2Yp8N/Q+qvU0iy+sDTwvih+YEhxA0Tz08J5N4MvWl2C78wGNpnDYCY55WBil0
         NhY4sAU6V93WJe96AtFBqJdEoFnC+8QOG+lRaHNVauQAGMUoJWeakbtvrYBkcHjXweNo
         tsEgZ+Zth4BAlzpOtoELHB+YfTtm0pTC8ciXo=
Received: by 10.223.87.80 with SMTP id v16mr344383fal.128.1297420136246; Fri,
 11 Feb 2011 02:28:56 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Fri, 11 Feb 2011 02:28:34 -0800 (PST)
In-Reply-To: <AANLkTik9mFNsqFQn5SEZkYd_uxDeoY-9nqgV_PJ+nNsi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166549>

On Fri, Feb 11, 2011 at 10:37 AM, Frank Li <lznuaa@gmail.com> wrote:
>> But I don't think it should check GIT_ASKPASS, GIT_ASKPASS isn't a
>> general-purpose dialog-box hook, it's a hook for getting *passwords*.
>> To allow git-svn to query the user of a non-terminal user, another
>> mechanism would probably be created. But in any case, I we should do
>> something other than just waiting if we're not connected to a TTY. I
>> don't really know Perl that well, but perhaps something like this does
>> the trick?
>>
>
> SSH_ASKPASS is used to accept "Enter your OpenSSH passphrase".
> refer to git-gui/git-gui--askpass
>

git-gui--askpass can ask for a password, or yes/no questions. But this
is neither, it's a reject/accept temporary/accept permanently
question.

Perhaps the prompt could be rewritten as two yes/no questions, though?
Something like "Accept certificate? (yes/no)" and if the answer is
"yes", query with something like "Store certificate? (yes/no)".
Dunno...
