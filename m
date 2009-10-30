From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 22:21:44 -0400
Message-ID: <117f2cc80910291921u6fc5e6e6j12c8433a67852ec0@mail.gmail.com>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
	 <4AE98175.504@viscovery.net> <7viqdy6ii1.fsf@alter.siamese.dyndns.org>
	 <200910292157.37474.j.sixt@viscovery.net>
	 <7vfx916ea6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 03:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3h7e-0003GI-7V
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 03:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbZJ3CVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 22:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbZJ3CVk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 22:21:40 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:58957 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbZJ3CVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 22:21:39 -0400
Received: by qyk4 with SMTP id 4so1474237qyk.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=oqM3i5oPpOKUBgIoXZR3ashtIJ/bVjpp2jOvkPNgB4s=;
        b=A+b3WiJeby9HuTPZT22kgAA/NQkMjmQVKMbQhec4lDzHye+YXMEN59GeEjlacV/hMw
         PZd73ggV3Pu7W4lOqM7uerN42OvQPmJSFyktACJ/HWQzDcPqTZLmkO5FKjgx4Q5cMAD/
         eKJAzqc+uJiaoWyGnLpjhGIozvhdVAniv7PC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=IZau/rEK11ycUE5r3qj0lRUZ/65X665wwXtPWkL/MjxTBlrNpaE9DSvW2faU7OIGlG
         d6zhYUESn+mWP8fdLySUr2LqqEq4s+22kXFkEo8AS+bbXp7cW33tx8CDPMuTE3/OIMpY
         K7kzMGGz+PtCzZJa4Wvz3hW2tGWbvtqeJ8w28=
Received: by 10.224.96.202 with SMTP id i10mr512654qan.311.1256869304121; Thu, 
	29 Oct 2009 19:21:44 -0700 (PDT)
In-Reply-To: <7vfx916ea6.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 896ff4de8cb465df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131670>

On Thu, Oct 29, 2009 at 6:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Yeah, whatever, I didn't take the time to think it through. But this may be an
>> opportunity to give some life back to the zombie that git-var currently is,
>> that is, to make it the plumbing that does value discovery for variables like
>> GIT_AUTHOR_INDENT, GIT_COMMITTER_IDENT, GIT_EDITOR, and perhaps also
>> GIT_PAGER.
>
> Hmm, wouldn't it make even more sense to "run" them for the calling
> Porcelain script?

That was what I had been thinking.  That way the caller doesn't need
to know whether it may be a space-containing absolute path or an
executable with flags, as long as git knows what to do.

David
