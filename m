From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Sun, 13 Jul 2008 17:53:13 -0400
Message-ID: <487A7949.9050800@gmail.com>
References: <1213462668-424-1-git-send-email-mlevedahl@gmail.com> <487A6780.7030500@gmail.com> <7vfxqdqxh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, git@vger.kernel.org, Eric Blake <ebb9@byu.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9WK-0007cF-JG
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbYGMVxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYGMVxR
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:53:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35448 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYGMVxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:53:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2277515ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZvGtBWwCMNSLLVJ5B5kaoqbNWE0exWuBlNkVs/ybXo4=;
        b=wn54im2mINlWl1kriJecsvODU8TUdpBvd6567nfPoAE2uMlPn3IV5rTmB0UgLXMgh5
         VLM1YS8IXwIVmoYe8Jb2g4uvCA8CDltgIKGXwV/igdZGNU1g2xS7WDBsJqDgH8qoiXwr
         z+6jtNnlauPmdPDhqGGhibrabk6Ak3yw+Fk3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SxvUj7woGgZQm0Zbq5I6TsTw5yog/leoY6uwKLrSdS5a8lSJMn0g2lYbI6067q4t/X
         Nycq418THaYXhbI2o+SiovHpMRe5dWQ/+Ip8DZQDyk0oufPE7QiTh0OYyqep0WXKNRks
         lFFwFE2uBlycAD3aWBMVQnmP/6IZc3qeqEmq4=
Received: by 10.151.111.15 with SMTP id o15mr4297756ybm.93.1215985995535;
        Sun, 13 Jul 2008 14:53:15 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.191.242.168])
        by mx.google.com with ESMTPS id 9sm4560156yxs.5.2008.07.13.14.53.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 14:53:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vfxqdqxh7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88348>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>   
>> Mark Levedahl wrote:
>>     
>>> Cygwin is *still* shipping with antiquated Tcl 8.4.1, and will continue
>>> to do so for the indefinite future. This version does not understand
>>> the "2>@1" redirection syntax, so such redirection of stderr must be
>>> done using sh.
>>>       
>> Ping. This bug is in 1.5.6.x, and thus also in the current Cygwin git
>> release: as a result, several gitk context menu items cause
>> errors. (Let me know if I should resend the patch).
>>     
>
> In the meantime, is it an option to apply this as a port specific patch
> when Cygwin and whichever distribution ship with old Tcl package their
> binary releases?
>
> Just checking how urgent this issue is (8.4.1 was from Oct 2002 if I am
> not mistaken) for maintainers of Cygwin port, and I am suspecting that
> kernel folks are somewhat busy near/around OLS/KS timeframe (but not me).
>
>   
(I didn't trim the message as I've copied the Cygwin git maintainer).

I certainly have this patch in my tree so the folks I supply git to who 
use Cygwin have this patch. The question of whether to maintain this out 
of tree for the official Cygwin release is up to Eric.

Mark
