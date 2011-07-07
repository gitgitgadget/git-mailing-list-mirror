From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: generation numbers
Date: Thu, 07 Jul 2011 16:52:51 -0400
Message-ID: <4E161CA3.2050001@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com> <20110707185908.GB12044@sigill.intra.peff.net> <7vliw9hoky.fsf@alter.siamese.dyndns.org> <201107072231.13181.jnareb@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBC?= =?UTF-8?B?amFybWFzb24=?= 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 22:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QevZN-0007pw-6E
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 22:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab1GGUxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 16:53:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34646 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1GGUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 16:53:01 -0400
Received: by vws1 with SMTP id 1so1007369vws.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mT6lrI39iYR3SG/QWe1833jHNx7C1E/bZw4IYsW0kR0=;
        b=nhKHAoigbmvGegms53o7Aa8cax8dYtGIHUa6DpjJ/7DtLU/fxMn2v722HrFmKLVJy5
         AGwDk4DLDg8tIQNBYfg38N3HZoqJ2IrjIdOUMExj149ehWt9dAyE5lJBDlaapXOCvakO
         7TXTf/b/CqPzCzbjrFUE8PFIAhVdjwGLHoY6c=
Received: by 10.52.161.7 with SMTP id xo7mr288654vdb.159.1310071980693;
        Thu, 07 Jul 2011 13:53:00 -0700 (PDT)
Received: from [10.0.1.130] (cpe-67-248-162-240.nycap.res.rr.com [67.248.162.240])
        by mx.google.com with ESMTPS id q1sm3425510vdt.23.2011.07.07.13.52.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 13:53:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110505 Icedove/3.0.11
In-Reply-To: <201107072231.13181.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176781>

On 07/07/2011 04:31 PM, Jakub Narebski wrote:
> On Thu, 7 Jul 2011, Junio C Hamano wrote:
>> Jeff King<peff@peff.net>  writes:
>>
>>> You could "cheat" and instead of storing the sha1 of a blob object in
>>> the notes tree, use the lower 32 bits to store an actual value. I don't
>>> think that currently breaks any assumptions in the notes code, but it
>>> definitely is against the intent of it.
>>
>> I highly suspect that it would break fsck rather badly.  You may not even
>> be able to repack a repository with such a notes tree.
>
> Well, we could (ab)use file mode to mark that what would be sha1 actually
> stores fixed-width content of a file, like we do with submodules.
>
> This technique is I think quite similar in idea to filesystems storing
> contents of small files in file inode, isn't it?
>

Are the benefits really worth all these hacks?
