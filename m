From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Fri, 19 Jun 2015 17:51:32 +0700
Message-ID: <CACsJy8AJdjh_XjdEhhykBDMRPogMcV3LLCQpR2o1T3P1GkVKfw@mail.gmail.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
 <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
 <20150617191235.GB25304@peff.net> <20150618101353.GA6525@lanh>
 <xmqqioalezhq.fsf@gitster.dls.corp.google.com> <20150619103946.GA20493@lanh> <319721281.628788.1434711025325.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tu4-0005U6-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbbFSKwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:52:05 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33237 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbbFSKwD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:52:03 -0400
Received: by igbqq3 with SMTP id qq3so12854059igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eOG//b76ICBSiu04d9DCZZ2ZXj8C0gRrgkdCF18QUgk=;
        b=LVTbxYdJfq0wFM5eDrXGBsfNUAtwMErhvV21p4F8VnNo9iKFtUDeI6fZN2XiW2YtY0
         Xl09DXyPTYwlN2+AEkH128aq8amR/E4SakgMTM5s7me1myoIGEjDdsjLRprqIddg1GJD
         deHTxMeCu7R41CGiBl0ylKbwCT5fUbO6f379xCr3bR7EPkH1sU3srtFbSkuI/FlYHU/8
         s552akDXFQLN4M3fTlY4Oacx0fzBqiEhlZlTIKyZKiimy5b7OehP406b+kBp94PVu7/L
         lmvLEzuslZHLmQlvJm2+0Oe+KWtlIPbxPGtCzvbHn5Yyfw0OQXxF7gJEz6btspu3Lt85
         38AQ==
X-Received: by 10.107.47.224 with SMTP id v93mr20964102iov.86.1434711122286;
 Fri, 19 Jun 2015 03:52:02 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 19 Jun 2015 03:51:32 -0700 (PDT)
In-Reply-To: <319721281.628788.1434711025325.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272125>

On Fri, Jun 19, 2015 at 5:50 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> + sb.buf[0] = 'Z';
>> + printf("%c\n", strbuf_slopbuf[0]);
>> + return 0;
>> startup_info = &git_startup_info;
>
> I might be wrong, but I definitely think that this
> printf and return 0 are some debug lines that you
> forgot to remove.

Yes it's debug code. I hoped that if I made a mistake forcing the
segfault, people would notice.
-- 
Duy
