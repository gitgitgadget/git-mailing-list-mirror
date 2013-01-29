From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 12:27:44 +0700
Message-ID: <CACsJy8BPhHJseDghWjCe1xK_KqSZOz1cfoOfPnTdex94qqrCzw@mail.gmail.com>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal> <7vpq0otw7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:28:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U03kO-0001eO-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 06:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab3A2F2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 00:28:16 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37940 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3A2F2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 00:28:15 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so56997oag.0
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 21:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f8/7iWkobuZ6h9Qx91OaiZS/fppT3M3fV0O3TXvw3ko=;
        b=U/Gi98ljjGzmMAn6PbqPd+jiGW6MoIJU2AHIqg/gQODEDJU9WWTazRAvF3fefC8hHu
         NwhiJWuR8g20EA9nXxgsel6REo6Mn3s6BuWrblFaU3vBuyQ2AQbBpJRQkZYtStZZBGkF
         e38Oyy/KSj/TZCkUSZQPVbiKzm8UjYy8XB2fxqAeB6D3oDOvHmfBj47+9b+/FsOT/Nvp
         ImXknKWT5dV2pEaOaITFMpKP3qr0PsiuexouCvJZ4ayIcdxk8LPPB/FdYD7+sH3LfvUu
         weLnoz8eEc3b0ixzmlfAXSSDSuD8PkVo0+D9h4T6ZttGGnMTSK7g7wmlywz9U8Ge9Oo0
         yvDQ==
X-Received: by 10.60.154.169 with SMTP id vp9mr179305oeb.109.1359437294660;
 Mon, 28 Jan 2013 21:28:14 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Mon, 28 Jan 2013 21:27:44 -0800 (PST)
In-Reply-To: <7vpq0otw7y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214903>

On Tue, Jan 29, 2013 at 12:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> New way to specify long pathspec magic
>> ======================================
>>
>> While testing the pathspec magic code, I grow tired of quoting :(glob)
>> every time because '(' is the start of a new shell. Which is one of
>> the reasons I introduce --[no]glob-pathspecs. Still I'd like a way to
>> specify long pathspec magic without quoting.
>
> Is this a real issue, though?  Often interesting pathspecs do have
> shell globs in them and we have to quote them anyway.

:(icase) often won't (unless you combine with :(glob)). If we turn
grep's --max-depth feature into pathspec magic (feasible, just not
sure if it's actually useful), it won't need quoting either.

Even with :(glob), because of the complexity of the pathspec, it's
less likely to match anything and be expanded by bash, so no quoting
required.

>> How about making ":q/xxx/" an equivalence of ":(xxx)"?
>
> A moderately strong no from here.
-- 
Duy
