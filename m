From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 19:30:31 -0500
Message-ID: <4B0DCC27.4030702@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com> <7vd436p339.fsf@alter.siamese.dyndns.org> <4B0DC8F7.1000509@gmail.com> <7v4ooinnkx.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSFr-0004Dh-Nk
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbZKZAa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760011AbZKZAa2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:30:28 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:65193 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760003AbZKZAa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:30:27 -0500
Received: by gxk26 with SMTP id 26so247340gxk.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Qd4trCffMeyzLpZE6JV+QvGt8TZtygX38yagV+VPmUM=;
        b=CUwl2ECGzhEBhUeIuBNLuKc/w4QVo7kckKb3S4f71aicHlnOgJDqlQ6eYZ4xCOTsHb
         stZip5WM/ZaqjvKB7iAjzT/NP8FUKxLa80+o236YH7FjGyXDwvEuTlv8s0DL759nKJPG
         kYb3WCPmlUSnQhKm5f36jsjYIjiaqMVVQxvW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Y1LF+2kUN92NQwK0aatIFprBakiXD4hIIkrXpFXH3e0KIptwEb9o0B2irfxrpR9vLC
         8b1+4/GbMSuAZ/Ya8I54VIxkf1sPkYwXhK3LkSMVlMPS1eYNypmnQmGVoRnhtDncTQDx
         zH9Y/DwcblCV0JL/W/8QSXen4yht1HcidpXNY=
Received: by 10.150.89.3 with SMTP id m3mr14780614ybb.186.1259195433008;
        Wed, 25 Nov 2009 16:30:33 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 4sm73118ywg.28.2009.11.25.16.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:30:32 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7v4ooinnkx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133715>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> But the users are almost always dealing with things (objects) that
>> started as files, act like files and may be files again. Why should
>> they not expect filesystem semantics.
> 
> Do you truly want to see this?
> 
>     diff --git a/var/tmp/git/Makefile b/var/tmp/git/Makefile
>     index 5a0b3d4..e9b03a8 100644
>     --- a/var/tmp/git/Makefile
>     +++ b/var/tmp/git/Makefile
>     @@ -1985,3 +1985,4 @@ coverage-report:
>     ...
> 
> As long as you are talking about paths you communicate with git, your
> root _is_ the root of the work tree, and it shouldn't matter where you
> have your work tree.
> 
> That is what I meant by "the root _in the context_".
> 

Nice example for a command output. But what did the user specify on the 
command line?
