From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 14:44:00 +0700
Message-ID: <CACsJy8AFXJBc8awQ6uNwgzMjOn9v_+yE9t+bR2Bv9f1kwGw0Yg@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk> <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 08:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab1SX-00068c-61
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 08:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcCBHod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 02:44:33 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35091 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCBHoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 02:44:32 -0500
Received: by mail-lf0-f54.google.com with SMTP id j186so54950747lfg.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 23:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VH6L6fcr9eXw/LBO/mDZClJhvx0u3gqCumx4R1rkXBo=;
        b=U3MYqKtoUmG2d4K9oK70gX9eCd35eUQBrRBbdXUxRDcA4y7V9m0kMT/ZcKAx+B6Xt9
         2VJuR+jHnYr0z2nb2e3O6yIm2QWuaVHxWtU8iRnperM50ghXAEFUehnt+WkVK798f9qz
         yuc5sCWaahcmn8qZLjdeK+zG6PLhLu/xoirsRb8IBoQ0dr63T15jyQqqvrXAitDiIvGj
         YWtXkCp9swpwzHoVgd74CRwG5m7rI3m/lRIMOzjUwiCTkeExqSoG8RNaSu13gXYJ+wZC
         9XbpWOKXl57nYNwNfLnPhykLpdZWp/tWdxUKvBfhR6OsVwFpOr96/NMHx+5fD2m3LWeu
         v0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VH6L6fcr9eXw/LBO/mDZClJhvx0u3gqCumx4R1rkXBo=;
        b=ilLmHKUm6W0ngmhgdgPAWWmcdXoN1lFTfi3AA8hekMDPiVBWwkLSQziJo+oVcVJOWr
         Ss3OL5uhmlaKeVJlUqf6GVO4/TexnRBjLqIEyVV6w1NRRa8W1hqpIX1PNo+h49h9qhii
         niFCp0OOcfOGnmepgerrJcYuvwvFJxcjrW6cvnttAxnKdwVqVMAESqzkznvzgkT0VXI2
         7/pu8amj/Q+irzhfTYu2rFKFx++RyJtFYmT2YHEF0h/9IiArUDLi2sswz6gQeXLhrQCa
         srQRSqbZXA7QWkl9TN0Hv0QkRxMmBAfefb42GR9KFPHsgmlU4nGMPGfkIy8t+jzVNJXQ
         WLew==
X-Gm-Message-State: AD7BkJKyLxAbwZgQsHV/FwmWiqzY953MQa5FDVIApvvRd5GuNQe2X+Tcqn5oo9n7L/9CuA1e7zpZSSA4+Lr29g==
X-Received: by 10.25.159.68 with SMTP id i65mr9551888lfe.94.1456904670553;
 Tue, 01 Mar 2016 23:44:30 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Tue, 1 Mar 2016 23:44:00 -0800 (PST)
In-Reply-To: <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288100>

On Wed, Mar 2, 2016 at 2:37 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> So in order to salvage some transfer out of 2.4MB, the hypothetical
>> Al protocol would first have the upload-pack give 20*1396 = 28kB
>
> It could be 10*1396 or less....

Oops somehow I read previous mails as client sends SHA-1 to server,
not the other way around that you and Al were talking about. But the
same principle applies to the other direction, I think.
-- 
Duy
