From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 17:31:07 +0200
Message-ID: <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
	 <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65pW-00042P-1z
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbYFJPbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYFJPbN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:31:13 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:38053 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYFJPbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:31:11 -0400
Received: by yx-out-2324.google.com with SMTP id 31so258021yxl.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YL7eJnps84yL59qc5EbK5YDj0CcjqhGp+Y6mJALh1Wk=;
        b=m0Uppk0Yj+CUjGerpybwkoP10R/rLrDxoF8au7tnH57QxfEvivDA7dbZSZRT0/MSOU
         v7vAy/67dup0GzkfnHDDXXfyAKKQHb+Cg7HB+6zMwvbhMuYffDNvn3RtD5tE/ZYe9Fy+
         bLkH/mImz6pXrzl29U7NnYTuFLAgNUCr3Q4N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=IkjNM3dwb2iMC0eXMvaZjI6Ny9otFZh0RhbgEJGx28IShxndm4VrealXCViF6NKr4y
         5bf6aVL1LtCJUc3N4Mzd/MAhqOc22d46OVff0vt1MXS/CRecsV/0sqc5mWc8LqXE9498
         4o5kGeGowqOaVA7cKUO841xKYY9g/SF89AB10=
Received: by 10.143.42.3 with SMTP id u3mr2113884wfj.148.1213111867840;
        Tue, 10 Jun 2008 08:31:07 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 08:31:07 -0700 (PDT)
In-Reply-To: <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84519>

On Tue, Jun 10, 2008 at 5:10 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Take a look at match_multi_number in date.c
> European ordering is preferred when the separator is '.'

Ok, then I'll use . in the future, that's nice :).

> The timezone didn't change. One date is in daylight saving time, the other
> is not. The offset from GMT is different to reflect this.

As Hannes said, no bug there, my mistake.

>> What does the list think about this? Is this "normal"
>> behavior? If not, what (if anything) should we do about it?
>
> There will be flaws in any system that tries to automatically guess the
> format. If there is not already one, perhaps a statement should be added
> to the appropriate documentation describing how to ensure that european
> ordering is used to parse the date.

I think that it should bail out when it encounters "20-01-2008"
instead of automagically going for european notation. Even more
helpfull would be to inform the user that "20.01.2008" is the proper
notation.

-- 
Cheers,

Sverre Rabbelier
