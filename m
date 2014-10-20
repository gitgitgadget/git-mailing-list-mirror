From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 20:23:48 +0200
Message-ID: <54455334.8000503@gmail.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>	<xmqq7fzu4rve.fsf@gitster.dls.corp.google.com> <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Olivier Croquette <ocroquette@free.fr>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgHcc-0004uY-0M
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 20:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbaJTSXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 14:23:54 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46555 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaJTSXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 14:23:53 -0400
Received: by mail-lb0-f172.google.com with SMTP id b6so4393931lbj.31
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fy1A/QAa1jDqFlXvDIb2JL5NvctclmRpN8q/q4oynck=;
        b=nUtQ48Feg1UzNqH372B49hoe/18SK+obbmdaAWMW+/yNaaGIoU0RhNb5VNrPhwCcdW
         lU9LD+gwj4sFMzFL1G0ZaL8Az86LcwOq19OzI1pvQFKUSL7q/b322ej77oSvM0X1m760
         jVyXHma0IyGQShEeIJRD45jKltBOUown9wssSnSSqP8NMc7GSsytNw0CxfG4KVXsGr+9
         u/VFPRHVMTtjR0OAHZWxILPy5tmB8GZ1hJarKaDg6LSmPS8+5U5/rLuxOJftxfaJrc8S
         yH9KdxzW7MxLyNCeMeO48o8XfSUtNzkhwtWNKhWT75EbRnwuheYCMvoZpqaRs6EAoWTM
         Pevg==
X-Received: by 10.112.137.202 with SMTP id qk10mr29286716lbb.0.1413829431917;
        Mon, 20 Oct 2014 11:23:51 -0700 (PDT)
Received: from [192.168.188.20] (p57A24087.dip0.t-ipconnect.de. [87.162.64.135])
        by mx.google.com with ESMTPSA id z2sm3551986laa.15.2014.10.20.11.23.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 11:23:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.10.2014 19:32, Junio C Hamano wrote:

>>> Beyond compare 4 is out since september 2014. The CLI interface
>>> doesn't seem to have changed compared to the version 3.
>>
>> Hmph, if this is identical to mergetools/bc3, why is the patch even
>> needed?  Do we auto-detect something and try to use bc4 which does
>> not exist and fail, and we must supply a copy as bc4 to prevent it?

The patch is indeed not needed, which is why I haven't cared to provide it so far although I'm now using Beyond Compare 4 instead of version 3 myself.

>> It may feel somewhat strange to have to say "mergetool --tool=bc3"
>> when you know what you have is version 4 and not version 3, but in

That's exactly the only reason I could think of why it could be nice to have a "bc4".

>> that case, I wonder if there are reasons why calling both versions
>> just "bc" is a bad idea.  And assuming that version 5 and later

IMHO, the only reason not to just have a single "bc" is to maintain backward compatibility for users already using "bc3". But for the sake of cleaner code, personally I'd be fine with that minor backward compatibility breakage.

>> Perhaps version 2 and before are unusable as a mergetool backend or
>> something?
> 
> It seems that ffe6dc08 (mergetool--lib: Add Beyond Compare 3 as a
> tool, 2011-02-27) is the first mention of "Beyond Compare" and it
> only was interested in version 3 and nothing else.

Beyond Compare versions prior to 3 do not run on Linux, but only on Windows, which is why I did not care to submit a patch.

> Perhaps something like this, so that existing users can still use
> "bc3" and other people can use "bc" if it bothers them that they
> have to say "3" when the backend driver works with both 3 and 4?

That indeed sounds like the best approach.

> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -250,7 +250,7 @@ list_merge_tool_candidates () {
>   			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>   		fi
>   		tools="$tools gvimdiff diffuse diffmerge ecmerge"
> -		tools="$tools p4merge araxis bc3 codecompare"
> +		tools="$tools p4merge araxis bc bc3 codecompare"

Why keep bc3 here?

And shouldn't we update git-gui/lib/mergetool.tcl, too?

-- 
Sebastian Schuberth
