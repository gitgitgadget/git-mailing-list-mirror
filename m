From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Mon, 10 Jun 2013 13:38:16 +0200
Message-ID: <CABPQNSbcAZZ_s7ow4HJ5HenSGSrHLUojqVygokgkQOgjLeDQEQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
 <20130609001845.GC29964@sigill.intra.peff.net> <7vk3m3owk2.fsf@alter.siamese.dyndns.org>
 <51B5648B.7020703@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 13:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0RB-0002Y2-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 13:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3FJLi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 07:38:57 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36131 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3FJLi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 07:38:56 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so11806762iec.23
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+njbTPP+mQRCj+voa8+H834Z/90u2wl2v/ochYDPDSs=;
        b=FCxygyXMD7S25MHMZpOoCMqvhX+IZjo3iD7kD92JSDojvmygr7HWbsyOCr6anWdsH6
         dXsaBb3dHih1ObdOI9hCYGPWrzzKiL7qDfovmhBvgXs91PvRRDZMhAWousRZ3W7R/BzL
         XYRM11p93tdte2to0GIF5Vi8fTuY4CQuNPC7V1zPBYZJchWvnp18cZdLBFz4B/8//Xcj
         q5jIN2l7qCve6+OSs0G1GxAmQxvmJbbwK1uG22brHCHAbm74UUOcxE5U8P53v7WHQ31P
         LfQHsPtaLp3IdTUmrAjyjPRA0ZWNVP/N1Y5EOyx4FTF6DLCXz6nZcruBN39hJEun/cOn
         WRPQ==
X-Received: by 10.42.27.146 with SMTP id j18mr3639622icc.54.1370864336498;
 Mon, 10 Jun 2013 04:38:56 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Mon, 10 Jun 2013 04:38:16 -0700 (PDT)
In-Reply-To: <51B5648B.7020703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227274>

On Mon, Jun 10, 2013 at 7:30 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 6/9/2013 22:31, schrieb Junio C Hamano:
>> Jeff King <peff@peff.net> writes:
>>
>>> I'm a little negative on handling just SIGTERM. That would make the test
>>> pass, but does it really address the overall issue? To me, the
>>> usefulness is having exit values with consistent meanings.
>>
>> Yes.  Unless the goal is to give Windows port pratically the same
>> signal semantics as ports on other platforms, I do not think special
>> casing SIGTERM (unless it is a very common signal on Windows and
>> others are unlikely to be useful) buys us much.
>
> I'm thinking the same. And, no, SIGTERM is not very common on Windows.
>

I have no strong feelings on SIGTERM, but my knee-jerk reaction is the
same. AFAIK, the only issue we've seen with it has been this one,
which is synthetic.
