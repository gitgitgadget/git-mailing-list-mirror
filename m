From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Sun, 14 Jul 2013 11:38:01 -0400
Message-ID: <51E2C5D9.1040405@gmail.com>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com> <20130707005558.GI30132@google.com> <51DB3A9F.6020504@gmail.com> <20130714005730.GA21033@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 17:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyONS-0006E4-A3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 17:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab3GNPiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 11:38:08 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:63939 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3GNPiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 11:38:07 -0400
Received: by mail-qa0-f41.google.com with SMTP id f14so1183005qak.14
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jjci34foCZl3VZnMTZW4WgPwxroyrKaHvWYBE5a+HFA=;
        b=p++AnrclN7jFiX0auIZWJTw0UoMbkkEDYUcgAfjtGMM4FuqJLaH99pkHo/36Nt9nU5
         oD3C3kkGeiPSuMp2clPR/hHY0VNlC8LjCtHPhO+1jDH/eE0nSUt5NUCrqFKgkv12cCPK
         NP9r1zHFojwDE7HDHXy4Q6f4SlUofs6nMIW1p2PSEeT0Nzk10UUUq8QjLiPu6oaAndP3
         DM09vWIkHx2dTZ/58WQ9CnIv2vrDpPZJUxyhdSMOTZ5AC0shheathRiz5Olpr8VPBXm8
         c5SqWlVFTmCfF77l4CTZMQ0juqzssdyaEheBnNd9Iz/EyCcOE5f5eXYC92VXwTgnP9Eh
         B08w==
X-Received: by 10.224.180.10 with SMTP id bs10mr47834787qab.85.1373816284788;
        Sun, 14 Jul 2013 08:38:04 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id l2sm48615410qez.2.2013.07.14.08.38.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 08:38:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <20130714005730.GA21033@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230367>

On 07/13/2013 08:57 PM, Jonathan Nieder wrote:
> I'm not sure I follow. Are you saying Windows users would never want 
> to access Subversion repositories? Thanks, Jonathan 
Quite the contrary. SVN and git both work on Windows without having 
POSIX FIFOs  - Windows does have FIFOS, but the semantics are different 
than POSIX and this is why Cygwin's do not work as needed. There is no 
problem having a subprocess with stdin and stdout redirected via 
anonymous pipes to the parent: this is how git runs sub commands and 
works fine. I'm just questioning why this same construct cannot be used 
for the test harness.

Mark
