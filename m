From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: [PATCH] Document escaping of special characters in gitignore
 files
Date: Wed, 05 Jan 2011 12:12:59 -0800
Message-ID: <4D24D0CB.3030004@gmail.com>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com> <7vwrmjchuu.fsf@alter.siamese.dyndns.org> <201101052027.24640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaZjP-0001ck-1W
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1AEUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:13:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48739 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab1AEUNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:13:08 -0500
Received: by gxk9 with SMTP id 9so3472424gxk.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2kjhmLLlBVwHgz+J+x9fdc3yhXGWT+7gsimAmdShEw8=;
        b=XPxFgV03mV5iNqJWUIQkmot0FuQ0RpP8yp+j2p82t4qKJx16oXJazR9nhJBg4eA2AH
         XkdU+VfixLNHtOACddedhWV7jAvYZi9lhBjg0yIrQJ0f/XpTY+PLdPknmgOkamVyNCpX
         v1D4RyQu99uRgF9K8BLPzbYx+ZCFOWTPXoA3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EXsiFb/s0QK1rBQu1ZaPzGqaUKR7YM2EVY9UUOP/sk6oEn6fnhg3b1/qs+Hj4Z+VVE
         7ooh8Xxqt4R3CYUwXHlXk944Vy7/7YE/g3yQT6UFpU0MfY05HXvWYxXQTYoaB4xtZ9GN
         biEUIc9X+DwXG4MD1na1ODhPhw/As3Y5GIAeo=
Received: by 10.90.118.2 with SMTP id q2mr1120784agc.11.1294258387274;
        Wed, 05 Jan 2011 12:13:07 -0800 (PST)
Received: from [10.10.1.101] (adsl-75-2-133-184.dsl.pltn13.sbcglobal.net [75.2.133.184])
        by mx.google.com with ESMTPS id c30sm31236844anc.0.2011.01.05.12.13.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 12:13:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <201101052027.24640.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164589>

On 01/05/11 11:27, Jakub Narebski wrote:
>>> +++ b/templates/info--exclude
>>> @@ -4,3 +4,4 @@
>>>  # exclude patterns (uncomment them if you want to use them):
>>>  # *.[oa]
>>>  # *~
>>> +# \#*#
>>
>> Do we need this?  Without explanation it is somewhat hard to realize that
>> this last line is also an example of a pattern that excludes any filename
>> that begins and ends with a pound.
> 
> Well, perhaps not.  Note though that this exclude pattern is actually
> useful for me, as GNU Emacs uses this convention ("#<filename>#") for
> auto-save files.

As the source of this thread, I, too, use emacs and it is exactly
the problem of trying to figure out how to get git to ignore these
auto save files that got me down this path.  It was too hard to figure out.
So I suggested some doc changes and the addition of the "exclude
emacs auto save files" pattern to the sample text.  People who do not
use emacs would not understand the \#*# line and folks who do would.
They see files like that all the time.  For the sake of vi users, you
might want to explain them, but I don't think it is crucial.
It *is* important to have an example of a needs-to-be-escaped file name.
