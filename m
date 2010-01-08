From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Add "ls", which is basically ls-files with 
	user-friendly settings
Date: Fri, 8 Jan 2010 21:16:15 +0700
Message-ID: <fcaeb9bf1001080616r5835f504t14e51231afb03709@mail.gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
	 <1262884076-12293-4-git-send-email-pclouds@gmail.com>
	 <7vfx6h4ww3.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1001071009m11a7adfehdad485a4baeeb958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 15:16:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFdb-00018Y-Ff
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 15:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab0AHOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815Ab0AHOQR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 09:16:17 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:42071 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab0AHOQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 09:16:16 -0500
Received: by pxi4 with SMTP id 4so2076929pxi.33
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 06:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tMM/Mmnq4wCB3WMloiIPD8ExXa4w8N3dOyJMF0eHbh0=;
        b=Sp5errHpwrLOYjDzVebEyYi+bLvF46G8wwZT3zWGqbN7XvgDryMCO/R9jFfa7qZrY2
         cPs5Aq5uR5KPrB+vhU86Qyr5k9X6JuUbvLx2Dnw5qmvF8NKrxZ6zP7aPm6Q21SebODKG
         pEBWQFa+i1h/xGoUV4rWqCW9FJu4bl5O+jdhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QBllEZYhOT21o90Yy98OMELvhgHkprsBMhcwIqpSRjtBaINnhyKT7iKFfGDlnd3Uok
         lkPny7AOioykyoU9Swqh8k9yNtBeiwWIxMXCovHkjpUl/zcTLhHXC4KRovTOTwIa0vuZ
         jbePw0koVKG/OOnU2AqDoiBuUF+0b3ZbZ1dpg=
Received: by 10.114.86.7 with SMTP id j7mr1077124wab.209.1262960175832; Fri, 
	08 Jan 2010 06:16:15 -0800 (PST)
In-Reply-To: <fcaeb9bf1001071009m11a7adfehdad485a4baeeb958@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136440>

On 1/8/10, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 1/8/10, Junio C Hamano <gitster@pobox.com> wrote:
>  > I think the code for columnar output used in producing "git help -a"
>  >  output should be reusable (if not, should be made reusable and reused
>  >  here).
>
>
> I saw that and even exported term_columns() but was too lazy to make
>  pretty_print_string_list() something reusable. Will think of it again
>  when I see this command is worth pushing forward.

I think again. There are a few places that may benefit from column
display: git tag -l, git grep -l, git branch (if you have lots of
branches) and probably untracked part of "git status". Moreover, I
have to implement it anyway because Solaris does not have command
"column". How about an external "git-column"? This way we don't have
to modify lots of code for columnized output. We may want to name it
"git-pager" if we want an internal pager someday ;)
-- 
Duy
