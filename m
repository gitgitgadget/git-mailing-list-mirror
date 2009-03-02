From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 17:07:31 -0500
Message-ID: <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
	 <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
	 <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
	 <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeGJq-00029s-UI
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZCBWHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZCBWHe
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:07:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:38122 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbZCBWHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 17:07:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2460297rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wraMbUQjbzOI3StcawjsbLqlr3FbAoy6h2x56b9rybw=;
        b=xxTj4iHAd5ik7rh0SDLEosO1L2a7xiMlkGgRZFXptPRksfoYV5yCVfDEpxw77d+3PI
         D5Yss1l4Vp5eO3wNaoSMTvXT6Pwn2/MjniTu0jqRikzhpyhfiXXQNKuyV/TnPpwmi0xT
         2cZGXgCpKOfQSHPf7QuStKDCtCRndlH1U70xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F4/vq8WKstYh4zdCBLsoksPBdYN1oGPEh+lJm/slYtlMqeJFQ26Hm2DFZ23Oq0VjuL
         SVUS909s7jjdNKLnGRAhESbqPZUdezg9pxWeb3W7XT3U89qIH+XmYsLyI535JIC6d376
         GLCcKMPg0Kb2NtQV3khFFY7wjy+WQ7c2ohLIM=
Received: by 10.141.82.20 with SMTP id j20mr3110811rvl.54.1236031651956; Mon, 
	02 Mar 2009 14:07:31 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111966>

On Mon, Mar 2, 2009 at 1:25 PM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
>> But the following is not:
>>
>> =C2=A0- foo/bar*/baz
>>
>> IOW, '*' can only appear as a non-terminating symbol if it is bounde=
d
>> by '/' on each side.
>
> You have my criterion right, but I want that to be valid, but only ma=
tch
> things like "foo/bar-something/baz", not "foo/bar-a/b/baz".

Ah, that makes sense. Perhaps use "**" to mean matching across path
components which is what rsync does:

 o  a '*' matches any non-empty path component (it stops at slashes).
 o  use '**' to match anything, including slashes.

?

j.
