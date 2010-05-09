From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 22:25:39 +0200
Message-ID: <2AC4CFCB-F715-46B1-9F62-0ED190281A5F@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <7v632x9dfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 09 22:25:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBD4P-0007we-LA
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab0EIUZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:25:44 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:37836 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0EIUZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 16:25:43 -0400
Received: by ewy20 with SMTP id 20so729745ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=hnWwMlO3p4NAfCIrJnwVqKYAiQgMc6RhBTDrNQ2jxcc=;
        b=wGo7fs4oztd84XKscfazkF2FUQt7RUogOmKXVg/KonEN+B1wFSxv5AomK6zK4YS4/K
         2fXAuvsHhb768eeApabwPsYEsvveoHuOi1dFVCVTwxqMCqZQsz3P18eFadAl/n7c3hl4
         TKrmHZV1VNoUT9tv5HAjPDnsRVUh/3Nv8uELo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=Agm54WeRyzmoFdMgeLxY1+13etA/uG5TC4XE2uBI85Yaiw12cCY0qtx0bnu/OWeP3B
         enPzGYQr+8FG6uO/t8LV1ehnv5syDpaFbk/CA27l8CWnmB0UlUF1QxTloYr7Vz+322co
         1GlVqA4dQNDLGa0EHrZlwGNyh/WH3EF8uO1aU=
Received: by 10.213.42.19 with SMTP id q19mr917934ebe.50.1273436742336;
        Sun, 09 May 2010 13:25:42 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm2191016ewy.0.2010.05.09.13.25.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 13:25:41 -0700 (PDT)
In-Reply-To: <7v632x9dfk.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146745>

On 9. mai 2010, at 19.45, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
>> My user interface would have been:
>> 
>> - an attribute "eolconv" that enables or disables line ending conversion
>> - a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
>> - a config variable "core.localeol" that decides whether LF or CRLF is preferred
> 
> I am puzzled about this second item; what is its type and what is its
> purpose?  If it is to allow project-wide default to be specified, then
> isn't having "* eolconv=true" in .gitattributes a much better option and
> is already supported by the first item?

Yes, but if the repository maintainers don't want to make that change (for whatever reason), it might be nice for the user to be able to enable normalization locally.  It would be a boolean, and setting it would mean the equivalent of "crlf=auto" on all files where "crlf" is not explicitly set.
-- 
Eyvind
