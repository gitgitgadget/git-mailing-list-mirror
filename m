From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Tue, 24 Nov 2009 09:35:51 +0800
Message-ID: <be6fef0d0911231735g416d028al1821668be295fe6a@mail.gmail.com>
References: <20091123110338.2b230359.rctay89@gmail.com>
	 <20091123210415.GH11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 02:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCkJy-0004kj-4a
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 02:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760AbZKXBfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 20:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757686AbZKXBfq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 20:35:46 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55148 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594AbZKXBfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 20:35:45 -0500
Received: by iwn1 with SMTP id 1so139084iwn.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mguKs1vvl6JTy9IFXA9EWrU76TUexstuoeMjpawCapU=;
        b=Ls4UJ4RqjOvt4PgTm2fD2rnyzOBQU4tTKB/nm3oVUsQuAZ0QJJMMbHDcSOlBZOa6N9
         suIMsb/B1AH9akACCcpKv8YsZ/AqChkx/kniBV/uMpjcPbiV4FcAr/okcAZn9BNN4LpR
         RACLIf2eFSbtkDbEqEZleJwsVGDqzFkhNMLqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wshKsiJYavYDa05CaUvruLAlQJvwr+FFb+6fSZ6G80o90NM4ArHEBFMekjDOhdMYRx
         XKRPwBY6nOn8u7ErV6QWCbx0EH4rmghwaDo/0HmjHFQ8c11o1RxB1Ob3CiJyLXAJb6QR
         juGD769dklvXWBV3m3t69KJ37pS+pfqCnjgK0=
Received: by 10.231.125.28 with SMTP id w28mr240997ibr.50.1259026551761; Mon, 
	23 Nov 2009 17:35:51 -0800 (PST)
In-Reply-To: <20091123210415.GH11919@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133552>

Hi,

On Tue, Nov 24, 2009 at 5:04 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> If I understand the change right, the only thing that really matters
> here is removing the extra ';' in the if (max < avail) condition.
>
> That bug was the only reason why rpc->len < rpc->pos, and is thus
> the only reason why avail would "go negative" (which it can't do
> since its unsigned, it just wrapped around to a massive value).
> [snip]
> Right.  This bug is really bad and should be fixed.  But the message
> above make this some little after-thought and doesn't explain what
> was wrong with this being here.

point noted.

-- 
Cheers,
Ray Chuan
