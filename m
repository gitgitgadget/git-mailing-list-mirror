From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] Prettify log decorations even more
Date: Fri, 8 May 2009 10:49:41 +0300
Message-ID: <94a0d4530905080049g28b7aaafn3b8137341c2948dd@mail.gmail.com>
References: <1241649948-11765-1-git-send-email-felipe.contreras@gmail.com>
	 <20090508074507.GF12989@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 09:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Kq7-00054v-1W
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbZEHHtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbZEHHtn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:49:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:63329 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbZEHHtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 03:49:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so68497fga.17
        for <git@vger.kernel.org>; Fri, 08 May 2009 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K6EtA/TI9+YFU8Ff8XD2fk2YwcVxzSWupWG8qgs/wVc=;
        b=MzNhWbpxLE0dyD+vG1syXXPp+R6JABYscEp3dUmjnJrtD4K3sDKglR5j2bmP8alhoB
         Rwfu8O4a8auD75/Os29hDjhmokfrju/BnNdYSqWyw+BIs074S5RRzeb9kC6j3NPbtp5g
         3cOlfKkylq6TIe1tR/3XGiNy6sFKv4VjdT/iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eKuPrG0Tqd39d0HoCc196FUq3POG0XwEhxVQ9AQN18sUtYTa3vBknSAqjWQ4hvnWZ5
         kVgHktNuSiDswIaXfWyesWD9HozCppMKTS9X/SZ2xTf2AWiN4AzZzbQZ+GFg5FGfSIis
         VPABcWoZ6Z2PX4AuqVOn2YU5sY7tmSAK9Z5+c=
Received: by 10.86.29.8 with SMTP id c8mr3343241fgc.70.1241768981810; Fri, 08 
	May 2009 00:49:41 -0700 (PDT)
In-Reply-To: <20090508074507.GF12989@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118578>

On Fri, May 8, 2009 at 10:45 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 07, 2009 at 01:45:48AM +0300, Felipe Contreras wrote:
>
>> -extern const char *prettify_ref(const struct ref *ref);
>> +extern const char *prettify_refname(const char *refname);
>> +#define prettify_ref(ref) prettify_refname((ref)->name)
>
> I think it is an improvement for this function to take just the name,
> but I don't see much point in keeping the crufty #define compatibility.
> I would just fix up the few callers, as it really is just
> s/ref/ref->name/.

Good, I started doing that but I thought it would create a big diff
and perhaps it was best to send some RFC before.

Will do that.

-- 
Felipe Contreras
