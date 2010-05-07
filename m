From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 17:26:25 -0400
Message-ID: <x2j32541b131005071426tb875cc1dtcc26e86d868d2e8b@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071529050.14468@xanadu.home> <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com> 
	<alpine.LFD.2.00.1005071626040.14468@xanadu.home> <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com> 
	<alpine.LFD.2.00.1005071708090.14468@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri May 07 23:26:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAV4R-0005Wg-Cn
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561Ab0EGV0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 17:26:47 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:64980 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508Ab0EGV0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 17:26:46 -0400
Received: by yxe1 with SMTP id 1so1066778yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kO3LweRAK3KJTP89jLRWc+XGteDncWWwwubQuJOBLxk=;
        b=l+HDo57i4rjK7DbpQhhPHYbJrgIT8Tkuedvto0KMvDTAZPDHiEPU74qqz3fVsFim7d
         KdvGPMBUT48koYXYkbu447Qpi2sdoFZ20xdvqfElprEt75Jvj8vHo3aJOyWdtvvGySOv
         2dyVzX1M1YF/El+PNeQWy1XYkIP+Zdq9PgLWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i0c+PJlGy7sTdzjFZTmcQQyxKS2CKUTFyuul5BXhre1wFq6/8BIWl6y0CyONtjC2Ce
         th56X3pfPapv0xza01BTpHGGR3cXv1aLt0qzgz7DIY5AHzw29hiiGi9qVEUsyucYCnXx
         eMCiqfzGtg0D2fSEegctb79XViXyv5DsK6PTU=
Received: by 10.150.47.4 with SMTP id u4mr4168780ybu.179.1273267605717; Fri, 
	07 May 2010 14:26:45 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 14:26:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071708090.14468@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146603>

On Fri, May 7, 2010 at 5:12 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> It has exactly the same syntax as ~/.gitconfig, and the options it
>> does support can all be carried over literally to ~/.gitconfig.
>
> Absolutely not.
>
> Most options for ~/.gitconfig simply make no sense in a distributed
> .gitconfig file.

No, that's the converse of what I said.

Try this in your head:

    cp .gitconfig .git/config

Perfectly valid.  Copying the other way might (or might not) result in
invalid options in .gitconfig, which probably ought to be warned
about.  But the syntax is obviously identical.

>> Calling it something else would imply that it deserves its own man
>> page, which would need to repeat all the options that are already
>> documented for ~/.gitconfig.
>
> No because most of those options don't and can't apply to a distribut=
ed
> option file.

But the ones that *do* apply all have the same meanings.

>> I'd say something that's syntactically identical, and in some cases
>> actually interchangeable, should have the same name.
>
> Indeed. =A0But this is not the case here.

Hmm, how to name the file is most a matter of opinion, but this last
bit is just factual ;)  They're syntactically identical.  And in some
cases, they're interchangeable.  I don't see how one could argue
otherwise.

Have fun,

Avery
