From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 20:06:46 -0400
Message-ID: <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
References: <4BC6EECE.6060408@gestiweb.com> <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com> 
	<7vr5mggt9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?David_Mart=EDnez_Mart=ED?= <desarrollo@gestiweb.com>,
	git@vger.kernel.org, deavidsedice@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:07:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Z5Y-0002k9-6R
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab0DPAHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 20:07:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:50280 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758172Ab0DPAHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 20:07:07 -0400
Received: by ywh32 with SMTP id 32so1013975ywh.33
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=ycz02zKT8AaguEZ5plaRTq/Sb8oNEBgZjXOEk9U30Bw=;
        b=q3MHTf3MxDML2/qqfPHCcu/Eu3hldwtDlL4uaOsIMcJhLDpPWl9Owr5BX6c5PPLDcs
         4P8Ln8d5KMKxNPuwAOdLB9w1jVtXVxLYr/KnDS/Ka8AnO+QYJBJkBUZD0u0NAhUZFFa3
         pOD55PCQSuHVmQvC6KvSpO6Xo8qHNCBxsyTNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=r0lgdEmzTE27GDGX8qfR26layqj9sgDFCqjvgvy9PJVyXQqVEFwowNTOvBa5qTqrcg
         brwkaPy14jnsZkfKk57UdEKJz7llV14h5/X7VDSXWi49oGcVLbm50qftQr07jko9uEQ/
         2zHEhyfpmKY/TgovnejhTPMoyJQIEGRPu8pwE=
Received: by 10.151.143.6 with HTTP; Thu, 15 Apr 2010 17:06:46 -0700 (PDT)
In-Reply-To: <7vr5mggt9a.fsf@alter.siamese.dyndns.org>
Received: by 10.151.124.1 with SMTP id b1mr972183ybn.106.1271376426344; Thu, 
	15 Apr 2010 17:07:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145037>

On Thu, Apr 15, 2010 at 8:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>
>> So what git tries to do is reduce the diff output of a merge commit
>> down to just the "unexpected" parts: the parts that are different from
>> what you'd get if you just merged in the individual changes in the
>> obvious way.
>
> This (and everything you said after this paragraph) is not quite correct.
> What is shown is the pieces that do not match either of the parent.
>
> So if you have a conflicted merge and resolve it by taking what one side
> did literally (think: "merge -X ours"), that hunk becomes uninteresting
> because the end result matches what one of the parents had.

Hmm, but David also said:

>>> git show commit:path shows empty file:
>>> $ git show dac6a95f5:facturacion/facturacion/scripts/lineasfacturascli.qs | wc
>>>     0       0       0

The output seems to match neither parent in any way, and yet the
simplification has resulted in no diff at all.  Strange, no?

Avery
