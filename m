From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 19:23:12 +0200
Message-ID: <op.wbxzwyre0aolir@keputer>
References: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino> <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328215704.GB10795@sigill.intra.peff.net>
 <CAH6sp9OcWUks_n1bD2n1KbePHeUX+FSY0+wLFu+zPik1Pwj3Aw@mail.gmail.com>
 <20120329172033.GC12318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"James Pickens" <jepicken@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:23:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJ4D-0003h8-RM
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609Ab2C2RXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 13:23:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63925 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757666Ab2C2RXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 13:23:16 -0400
Received: by eaaq12 with SMTP id q12so1150925eaa.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=dWIlwr24Z9ubcoWjG5mYqpZXtLe8dyLDTURlmYbOlSk=;
        b=ML4I+WbBq+PLDDc7aFypRZNUh9VWbPaaykboaVoopm1vzsgQ/qoWnFt/k2hHxz8ynV
         GIAqLMfIZi6wmG/1HqJtF7+DmMZ1Vu4hORSwR2f/6COHv+DXLHqK/YF+0N2YeBBgKzwh
         XDk8ifvDl2zmrKd98eOy4Koczm4VabPsIGIKZ0KaLawWAqoKDy0E7Zqx1ueyhYZjsns4
         uDnxkjeLUnHS/+uFMYy3JEdx9uF13ELdyHnzXINNHSA7HljXzz4kUwC3OI7eVHRAOnKD
         hWzsOb4a2TTm2NUYYYxk1X0vGNrRqq51Z4OLZzkrY2HvQ1o4Jo184A2l7GJBc+gyF1dG
         HcQg==
Received: by 10.14.187.134 with SMTP id y6mr1961020eem.44.1333041795318;
        Thu, 29 Mar 2012 10:23:15 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id r44sm23727123eef.2.2012.03.29.10.23.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:23:14 -0700 (PDT)
In-Reply-To: <20120329172033.GC12318@sigill.intra.peff.net>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194275>

On Thu, 29 Mar 2012 19:20:33 +0200, Jeff King <peff@peff.net> wrote:

> On Thu, Mar 29, 2012 at 01:31:09PM +0200, Frans Klaver wrote:
>
>> On Wed, Mar 28, 2012 at 11:57 PM, Jeff King <peff@peff.net> wrote:
>>
>> > +static int exists_in_PATH(const char *file)
>> [...]
>>
>> I expect that if more post-mortem checking is done, this function is
>> going to need a sibling that provides you with the first found entry
>> in PATH, so you can do more checks on it.
>
> It should be easy to write it that way. I'm not personally planning on
> adding more checks, but I think it's worth considering future additions.

I have some similar code lying around. It shouldn't be too hard to rebase  
that on top of this.


>> One of the things I ran into while working on [1] is that quite some
>> errors that are produced can also be caused by the interpreter.
>
> Yeah, they can be confusing and hard to track down. I'll leave that
> topic out of this round, and you can build on it if you like.

I was planning to do that, yea.
