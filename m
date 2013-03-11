From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 20:09:50 +0100
Message-ID: <513E2BFE.3030409@gmail.com>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr> <7v38w1c3ms.fsf@alter.siamese.dyndns.org> <513E0FB4.40607@gmail.com> <7v8v5talzu.fsf@alter.siamese.dyndns.org> <vpqppz5u8te.fsf@grenoble-inp.fr> <7vwqtd95bm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF876-0001DQ-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab3CKTJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:09:58 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:60812 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3CKTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:09:57 -0400
Received: by mail-ee0-f51.google.com with SMTP id d17so2329123eek.38
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=DsBhR/69KZFxzjFj+xP98MnsAScW43ZDHZ1v7ujRX04=;
        b=Dwm+OL4pkctYRYowOkMF4xJiAGYIVnL5vd+4z2GQTBb4er+Gg0QA2yH5Fxh48dmUQs
         BqGjdiGqmxWXmMSL3BQnp1FcG63ZDtWXjcyydRqxDflDpT4/LNP9Y3HpJLGzMycZVyoZ
         57Nc3iQKTjbmdob/ZOXOG+fsPsSh7h1PJ4S74gK0IR/8kEfwj1hcMVUtdB7iCRMzB9n0
         6RdCc9T2yh0a4JzECcxAKOei+7uiOfDAmeZM5RuQXZCc08F4Tu/HT6pWwvQZPTuBLvmI
         99Z9bf10kjtsg3lxytFRzqs/bHQ84mngHOre43EA1HvqE+znJEBjXjiKiQtDuTzinI19
         pBfQ==
X-Received: by 10.15.101.204 with SMTP id bp52mr39498154eeb.31.1363028996618;
        Mon, 11 Mar 2013 12:09:56 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.200.211])
        by mx.google.com with ESMTPS id h5sm25295159eem.1.2013.03.11.12.09.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 12:09:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vwqtd95bm.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217900>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/03/2013 19:09, Junio C Hamano ha scritto:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Ahh, thanks for reminding me of this.  You are right; these two
>>> functions are broken when the user has CDPATH set, I think.
>>>
>>> Here is a reroll.
>>
>> Thanks. Even nicer that the previous since the CDPATH implied the
>> subshell anyway.
> 
> Actually, "cd", not CDPATH, is what implies that the caller must be
> calling us in a subshell, e.g.
> 
> 	result=$(__git_ls_files_helper dir/ args...)
> 
> Otherwise the user's shell would have been taken to an unexpected
> place, with or without CDPATH.
> 

Right; this is the reason I used the `{` grouping, instead of `(`.

However, since the `{` is already specified when the function is
defined, I did not add another `{}` grouping.

> [...]


Regards  Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE+K/4ACgkQscQJ24LbaUQqvwCgmReHb4VtMJDT+tv+XF9RPmXE
DlEAnjhsgXszSBVG1iW0WCLM6212+fdA
=SYzh
-----END PGP SIGNATURE-----
